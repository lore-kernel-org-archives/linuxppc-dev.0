Return-Path: <bcollins@ubuntu.com>
Received: from a34-mta01.direcway.com (a34-mta01.direcpc.com [66.82.4.90])
	by ozlabs.org (Postfix) with ESMTP id 6E0C667AC6
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Feb 2006 01:22:05 +1100 (EST)
Received: from mail.phunnypharm.org
	(dpc67142247022.direcpc.com [67.142.247.22]) by a34-mta01.direcway.com
	(iPlanet Messaging Server 5.2 HotFix 2.05 (built Mar  3 2005))
	with ESMTP id <0IUH00KZK6KN3F@a34-mta01.direcway.com> for
	linuxppc-dev@ozlabs.org; Fri, 10 Feb 2006 09:22:03 -0500 (EST)
Date: Fri, 10 Feb 2006 09:21:45 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: yaboot 1.3.14 release candidate 1
In-reply-to: <1139538538.3638.14.camel@enki.eridu>
To: Paul Nasrat <pnasrat@redhat.com>
Message-id: <1139581305.5851.7.camel@grayson>
MIME-version: 1.0
Content-type: text/plain
References: <1139538538.3638.14.camel@enki.eridu>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-02-09 at 21:28 -0500, Paul Nasrat wrote:
> It's been some time in the making but I'd like to put out what is on
> HEAD for people to test. Key features are improved netbooting on IBM
> pSeries machines (Nathan Lynch), Amiga partition support (Sven Luther),
> Software RAID support on IBM pSeries machines (Dustin Kirkland), plus
> many small fixups. Thanks to all the contributors involved. It should be
> listed in the snapshot section at http://yaboot.ozlabs.org/

Not sure if you have anything like this in your tree at the moment, but
here's a patch we use for Ubuntu. It's based in part on code in silo (I
maintain silo upstream). Since the two are very close in code, this made
sense :). Silo allows you to add an arch in the image stanza like:

image[sun4,sun4m,sun4c]=/boot/foo

image[sun4u]=/boot/foo-64

This basically allows you to do things like this for ppc:

image=/boot/vmlinux-ppc32
  name=Linux
  ...

image[macrisc4]=/boot/vmlinux-ppc64
  name=Linux
  ...

One a powerpc64 (G5 for instance), this will override the default target
of "Linux" with the 64-bit image. The name is checked against the
root /compatible node in the device tree. (e.g. on my powerbook it has
"PowerBook5,9", "MacRISC3", and "Power Macintosh" as possible values).

This seemed a lot better than just doing "32-bit" and "64-bit", since it
also allows for things like:

image[powerbook5,8|powerbook5,9]=/boot/...

and

image[macrisc|macrisc3]=/boot/...

(note, | is the entry separator, so you can have more than one match).

We only use this for 32/64 kernels, but it's really useful for more than
that.

--- yaboot-1.3.13.orig/lib/ctype.c
+++ yaboot-1.3.13/lib/ctype.c
@@ -44,3 +44,11 @@
     }
 }
 
+int strncasecmp(const char *cs,const char *ct,size_t n)
+{
+	signed char __res = 0;
+	while (n--)
+		if ((__res = tolower(*cs) - tolower(*ct++)) != 0 || !*cs++)
+			break;
+	return __res;
+}
--- yaboot-1.3.13.orig/second/cfg.c
+++ yaboot-1.3.13/second/cfg.c
@@ -28,6 +28,7 @@
 
 /* Imported functions */
 extern int strcasecmp(const char *s1, const char *s2);
+extern int strncasecmp(const char *cs, const char *ct, size_t n);
 
 typedef enum {
      cft_strg, cft_flag, cft_end
@@ -101,10 +102,12 @@
 static char *endp = NULL;
 static char *file_name = NULL;
 static CONFIG *curr_table = cf_options;
+static int ignore_entry;
 static jmp_buf env;
 
 static struct IMAGES {
      CONFIG table[sizeof (cf_image) / sizeof (cf_image[0])];
+     int obsolete;
      struct IMAGES *next;
 } *images = NULL;
 
@@ -277,6 +280,16 @@
      return 1;
 }
 
+static char *cfg_get_strg_i (CONFIG * table, char *item)
+{
+     CONFIG *walk;
+
+     for (walk = table; walk->type != cft_end; walk++)
+          if (walk->name && !strcasecmp (walk->name, item))
+               return walk->data;
+     return 0;
+}
+
 #if 0
 // The one and only call to this procedure is commented out
 // below, so we don't need this unless we decide to use it again.
@@ -287,13 +300,85 @@
 }
 #endif
 
+static int match_arch(const char *name)
+{
+	static prom_handle root;
+	static char model[256], *p;
+
+	if (!root) {
+		if (!(root = prom_finddevice("/")))
+			return 0;
+	}
+
+	if (!model[0]) {
+		if (!prom_getprop(root, "compatible", model, sizeof(model)))
+			return 0;
+	}
+
+	for (p = model; *p; p += strlen(p) + 1) {
+		if (!strcasecmp(p, name))
+			return 1;
+	}
+
+	return 0;
+}
+
+static void check_for_obsolete(const char *label)
+{
+	struct IMAGES *p;
+	char *cur_label;
+
+	/* Make sure our current entry isn't obsolete (ignored) */
+	for (p = images; p; p = p->next) {
+		if (curr_table == p->table && p->obsolete)
+			return;
+	}
+
+	for (p = images; p; p = p->next) {
+		if (curr_table == p->table)
+			continue;
+
+		cur_label = cfg_get_strg_i (p->table, "label");
+		if (!cur_label)
+			cur_label = cfg_get_strg_i (p->table, "image");
+
+		if (!cur_label)
+			continue;
+
+		if (!strcasecmp(cur_label, label))
+			p->obsolete = 1;
+	}
+}
+
 static int cfg_set (char *item, char *value)
 {
      CONFIG *walk;
 
-     if (!strcasecmp (item, "image")) {
+     if (!strncasecmp (item, "image", 5)) {
 	  struct IMAGES **p = &images;
+	  int ignore = 0;
+
+	  if (item[5] == '[' && item[strlen(item) - 1] == ']') {
+		char *s, *q = item;
+
+		/* Get rid of braces */
+		item[strlen(item) - 1] = 0;
+		item[5] = 0;
+
+		for (s = item + 6; q; s = q) {
+			q = strchr(s, '|');
+			if (q)
+				*q++ = 0;
+
+			if (match_arch(s))
+				goto cfg_set_cont;
+                }
+		/* This just creates an unused table. It will get ignored */
+		ignore = 1;
+	  } else if (item[5])
+                goto cfg_set_redo;
 
+cfg_set_cont:
 	  while (*p)
 	       p = &((*p)->next);
 	  *p = (struct IMAGES *)malloc (sizeof (struct IMAGES));
@@ -302,9 +387,12 @@
 	       return -1;
 	  }
 	  (*p)->next = 0;
+	  (*p)->obsolete = ignore;
 	  curr_table = ((*p)->table);
 	  memcpy (curr_table, cf_image, sizeof (cf_image));
      }
+
+cfg_set_redo:
      for (walk = curr_table; walk->type != cft_end; walk++) {
 	  if (walk->name && !strcasecmp (walk->name, item)) {
 	       if (value && walk->type != cft_strg)
@@ -312,6 +400,8 @@
 	       else if (!value && walk->type == cft_strg)
 		    cfg_warn ("Value expected for '%s'", walk->name);
 	       else {
+		    if (!strcasecmp (item, "label"))
+			 check_for_obsolete(value);
 		    if (walk->data)
 			 cfg_warn ("Duplicate entry '%s'", walk->name);
 		    if (walk->type == cft_flag)
@@ -322,9 +412,12 @@
 	       break;
 	  }
      }
+
      if (walk->type != cft_end)
 	  return 1;
-//    cfg_return (item, value);
+
+     //cfg_return (item, value);
+
      return 0;
 }
 
@@ -369,6 +452,9 @@
      if (!image)
 	  return cfg_get_strg_i (cf_options, item);
      for (p = images; p; p = p->next) {
+	  if (p->obsolete)
+		  continue;
+
 	  label = cfg_get_strg_i (p->table, "label");
 	  if (!label) {
 	       label = cfg_get_strg_i (p->table, "image");
@@ -417,6 +503,9 @@
 
      printl_count = 0;
      for (p = images; p; p = p->next) {
+	  if (p->obsolete)
+		  continue;
+
 	  label = cfg_get_strg_i (p->table, "label");
 	  if (!label) {
 	       label = cfg_get_strg_i (p->table, "image");
@@ -439,15 +528,21 @@
 char *cfg_get_default (void)
 {
      char *label;
+     struct IMAGES *p;
      char *ret = cfg_get_strg_i (cf_options, "default");
 
      if (ret)
 	  return ret;
      if (!images)
 	  return 0;
-     ret = cfg_get_strg_i (images->table, "label");
+
+     for (p = images; p && p->obsolete; p = p->next);
+     if (!p)
+	     return 0;
+
+     ret = cfg_get_strg_i (p->table, "label");
      if (!ret) {
-	  ret = cfg_get_strg_i (images->table, "image");
+	  ret = cfg_get_strg_i (p->table, "image");
 	  label = strrchr (ret, '/');
 	  if (label)
 	       ret = label + 1;


-- 
Ben Collins
Kernel Developer - Ubuntu Linux
