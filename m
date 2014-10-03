Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5561D1A19B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 10:54:06 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 2 Oct 2014 18:54:04 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E2B4C3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 18:54:01 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s930s1aX54657242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 02:54:01 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s930wadE029924
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Oct 2014 18:58:37 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org
Subject: [PATCH 2/3] tools/perf: Rename variables for clarity
Date: Thu,  2 Oct 2014 17:53:35 -0700
Message-Id: <1412297616-14179-2-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1412297616-14179-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1412297616-14179-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The dso__load* functions return the number symbols they were able
to load or -1 in case of error.

But it is a bit confusing to determine 'if (err > 0)' indicates success
or failure and we have to step several functions deep to find that out.

Rename the variable 'err' so it is hopefully easier to understand.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/symbol.c | 50 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index be84f7a..9b66e27 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1467,7 +1467,7 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated,
 		      symbol_filter_t filter)
 {
-	int err = -1;
+	int nsyms = -1;
 	struct symsrc ss;
 	char symfs_vmlinux[PATH_MAX];
 	enum dso_binary_type symtab_type;
@@ -1485,10 +1485,10 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
 		return -1;
 
-	err = dso__load_sym(dso, map, &ss, &ss, filter, 0);
+	nsyms = dso__load_sym(dso, map, &ss, &ss, filter, 0);
 	symsrc__destroy(&ss);
 
-	if (err > 0) {
+	if (nsyms > 0) {
 		if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
 			dso->binary_type = DSO_BINARY_TYPE__GUEST_VMLINUX;
 		else
@@ -1498,13 +1498,13 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 		pr_debug("Using %s for symbols\n", symfs_vmlinux);
 	}
 
-	return err;
+	return nsyms;
 }
 
 int dso__load_vmlinux_path(struct dso *dso, struct map *map,
 			   symbol_filter_t filter)
 {
-	int i, err = 0;
+	int i, nsyms = 0;
 	char *filename;
 
 	pr_debug("Looking at the vmlinux_path (%d entries long)\n",
@@ -1512,19 +1512,19 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map,
 
 	filename = dso__build_id_filename(dso, NULL, 0);
 	if (filename != NULL) {
-		err = dso__load_vmlinux(dso, map, filename, true, filter);
-		if (err > 0)
+		nsyms = dso__load_vmlinux(dso, map, filename, true, filter);
+		if (nsyms > 0)
 			goto out;
 		free(filename);
 	}
 
 	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
-		err = dso__load_vmlinux(dso, map, vmlinux_path[i], false, filter);
-		if (err > 0)
+		nsyms = dso__load_vmlinux(dso, map, vmlinux_path[i], false, filter);
+		if (nsyms > 0)
 			break;
 	}
 out:
-	return err;
+	return nsyms;
 }
 
 static int find_matching_kcore(struct map *map, char *dir, size_t dir_sz)
@@ -1634,7 +1634,7 @@ proc_kallsyms:
 static int dso__load_kernel_sym(struct dso *dso, struct map *map,
 				symbol_filter_t filter)
 {
-	int err;
+	int nsyms;
 	const char *kallsyms_filename = NULL;
 	char *kallsyms_allocated_filename = NULL;
 	/*
@@ -1663,9 +1663,9 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map,
 	}
 
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
-		err = dso__load_vmlinux_path(dso, map, filter);
-		if (err > 0)
-			return err;
+		nsyms = dso__load_vmlinux_path(dso, map, filter);
+		if (nsyms > 0)
+			return nsyms;
 	}
 
 	/* do not try local files if a symfs was given */
@@ -1679,25 +1679,25 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map,
 	kallsyms_filename = kallsyms_allocated_filename;
 
 do_kallsyms:
-	err = dso__load_kallsyms(dso, kallsyms_filename, map, filter);
-	if (err > 0)
+	nsyms = dso__load_kallsyms(dso, kallsyms_filename, map, filter);
+	if (nsyms > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	free(kallsyms_allocated_filename);
 
-	if (err > 0 && !dso__is_kcore(dso)) {
+	if (nsyms > 0 && !dso__is_kcore(dso)) {
 		dso->binary_type = DSO_BINARY_TYPE__KALLSYMS;
 		dso__set_long_name(dso, "[kernel.kallsyms]", false);
 		map__fixup_start(map);
 		map__fixup_end(map);
 	}
 
-	return err;
+	return nsyms;
 }
 
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map,
 				      symbol_filter_t filter)
 {
-	int err;
+	int nsyms;
 	const char *kallsyms_filename = NULL;
 	struct machine *machine;
 	char path[PATH_MAX];
@@ -1715,10 +1715,10 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map,
 		 * Or use file guest_kallsyms inputted by user on commandline
 		 */
 		if (symbol_conf.default_guest_vmlinux_name != NULL) {
-			err = dso__load_vmlinux(dso, map,
+			nsyms = dso__load_vmlinux(dso, map,
 						symbol_conf.default_guest_vmlinux_name,
 						false, filter);
-			return err;
+			return nsyms;
 		}
 
 		kallsyms_filename = symbol_conf.default_guest_kallsyms;
@@ -1729,10 +1729,10 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map,
 		kallsyms_filename = path;
 	}
 
-	err = dso__load_kallsyms(dso, kallsyms_filename, map, filter);
-	if (err > 0)
+	nsyms = dso__load_kallsyms(dso, kallsyms_filename, map, filter);
+	if (nsyms > 0)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
-	if (err > 0 && !dso__is_kcore(dso)) {
+	if (nsyms > 0 && !dso__is_kcore(dso)) {
 		dso->binary_type = DSO_BINARY_TYPE__GUEST_KALLSYMS;
 		machine__mmap_name(machine, path, sizeof(path));
 		dso__set_long_name(dso, strdup(path), true);
@@ -1740,7 +1740,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map,
 		map__fixup_end(map);
 	}
 
-	return err;
+	return nsyms;
 }
 
 static void vmlinux_path__exit(void)
-- 
1.8.3.1
