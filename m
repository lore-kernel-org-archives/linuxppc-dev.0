Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AB82DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 03:56:05 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l4BHtxIG002419
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 10:56:00 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l4BHtxjO005214
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 12:55:59 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l4BHY0Mn022402
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 12:34:00 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 37C55AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 12:55:54 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l4BHtsw5014714
	for linuxppc-dev@ozlabs.org; Fri, 11 May 2007 12:55:54 -0500
Date: Fri, 11 May 2007 12:55:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [DTC PATCH] Remove overreaching semantic tests.
Message-ID: <20070511175553.GA14692@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that there are more usage models than "complete device tree in the
DTS" and "minimally device-tree aware u-boot that still needs zeroed out
properties to fill in", many of the checks that dtc performs are no
longer appropriate, since the nodes and properties in question can be
added at runtime.

Note that -f is *not* an alternative, as that suppresses all checks.  I
still want it to check for things that are present but wrong; I just
don't want it complaining about things that aren't there at all.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
I wouldn't be opposed to keeping these tests around if there were a
command line option that cleanly separates the errors/warnings into
classes such as structural, semantic-missing, semantic-broken, etc.

 livetree.c |  127 ------------------------------------------------------------
 1 files changed, 0 insertions(+), 127 deletions(-)

diff --git a/livetree.c b/livetree.c
index ce73f50..492713b 100644
--- a/livetree.c
+++ b/livetree.c
@@ -153,14 +153,6 @@ struct reserve_info *add_reserve_entry(struct reserve_info *list,
  * Tree accessor functions
  */
 
-static char *get_unitname(struct node *node)
-{
-	if (node->name[node->basenamelen] == '\0')
-		return "";
-	else
-		return node->name + node->basenamelen + 1;
-}
-
 static struct property *get_property(struct node *node, char *propname)
 {
 	struct property *prop;
@@ -465,122 +457,6 @@ static int check_structure(struct node *tree)
 				(propname), (node)->fullpath); \
 	} while (0)
 
-static int check_root(struct node *root)
-{
-	struct property *prop;
-	int ok = 1;
-
-	CHECK_HAVE_STRING(root, "model");
-
-	CHECK_HAVE(root, "#address-cells");
-	CHECK_HAVE(root, "#size-cells");
-
-	CHECK_HAVE_WARN(root, "compatible");
-
-	return ok;
-}
-
-static int check_cpus(struct node *root, int outversion, int boot_cpuid_phys)
-{
-	struct node *cpus, *cpu;
-	struct property *prop;
-	struct node *bootcpu = NULL;
-	int ok = 1;
-
-	cpus = get_subnode(root, "cpus");
-	if (! cpus) {
-		ERRMSG("Missing /cpus node\n");
-		return 0;
-	}
-
-	CHECK_HAVE_WARN(cpus, "#address-cells");
-	CHECK_HAVE_WARN(cpus, "#size-cells");
-
-	for_each_child(cpus, cpu) {
-		CHECK_HAVE_STREQ(cpu, "device_type", "cpu");
-
-		if (cpu->addr_cells != 1)
-			DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
-			       cpu->fullpath, cpu->addr_cells);
-		if (cpu->size_cells != 0)
-			DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
-			       cpu->fullpath, cpu->size_cells);
-
-		CHECK_HAVE_ONECELL(cpu, "reg");
-		if (prop) {
-			cell_t unitnum;
-			char *eptr;
-
-			unitnum = strtol(get_unitname(cpu), &eptr, 16);
-			if (*eptr) {
-				WARNMSG("%s has bad format unit name %s (should be CPU number\n",
-					cpu->fullpath, get_unitname(cpu));
-			} else if (unitnum != propval_cell(prop)) {
-				WARNMSG("%s unit name \"%s\" does not match \"reg\" property <%x>\n",
-				       cpu->fullpath, get_unitname(cpu),
-				       propval_cell(prop));
-			}
-		}
-
-/* 		CHECK_HAVE_ONECELL(cpu, "d-cache-line-size"); */
-/* 		CHECK_HAVE_ONECELL(cpu, "i-cache-line-size"); */
-		CHECK_HAVE_ONECELL(cpu, "d-cache-size");
-		CHECK_HAVE_ONECELL(cpu, "i-cache-size");
-
-		CHECK_HAVE_WARN_ONECELL(cpu, "clock-frequency");
-		CHECK_HAVE_WARN_ONECELL(cpu, "timebase-frequency");
-
-		prop = get_property(cpu, "linux,boot-cpu");
-		if (prop) {
-			if (prop->val.len)
-				WARNMSG("\"linux,boot-cpu\" property in %s is non-empty\n",
-					cpu->fullpath);
-			if (bootcpu)
-				DO_ERR("Multiple boot cpus (%s and %s)\n",
-				       bootcpu->fullpath, cpu->fullpath);
-			else
-				bootcpu = cpu;
-		}
-	}
-
-	if (outversion < 2) {
-		if (! bootcpu)
-			WARNMSG("No cpu has \"linux,boot-cpu\" property\n");
-	} else {
-		if (bootcpu)
-			WARNMSG("\"linux,boot-cpu\" property is deprecated in blob version 2 or higher\n");
-		if (boot_cpuid_phys == 0xfeedbeef)
-			WARNMSG("physical boot CPU not set.  Use -b option to set\n");
-	}
-
-	return ok;	
-}
-
-static int check_memory(struct node *root)
-{
-	struct node *mem;
-	struct property *prop;
-	int nnodes = 0;
-	int ok = 1;
-
-	for_each_child(root, mem) {
-		if (! strneq(mem->name, "memory", mem->basenamelen))
-			continue;
-
-		nnodes++;
-
-		CHECK_HAVE_STREQ(mem, "device_type", "memory");
-		CHECK_HAVE(mem, "reg");
-	}
-
-	if (nnodes == 0) {
-		ERRMSG("No memory nodes\n");
-		return 0;
-	}
-
-	return ok;	
-}
-
 static int check_chosen(struct node *root)
 {
 	struct node *chosen;
@@ -748,9 +624,6 @@ int check_device_tree(struct node *dt, int outversion, int boot_cpuid_phys)
 	if (! ok)
 		return 0;
 
-	ok = ok && check_root(dt);
-	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
-	ok = ok && check_memory(dt);
 	ok = ok && check_chosen(dt);
 	if (! ok)
 		return 0;
-- 
1.5.0.3
