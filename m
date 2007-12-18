Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 14:54:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove remaining old-style checks
Message-ID: <20071218035438.GA10348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The remaining old-style tree checking code: check_root(), check_cpus()
and check_memory() really aren't that useful.  They mostly check for
the presence of particular nodes and properties.  That's inherently
prone to false-positives, because we could be dealing with an
artificial tree (like many of the testcases) or it could be expected
that the missing properties are filled in by a bootloader or other
agent.

If any of these checks really turns out to be useful, we can
reimplement them later in a better conceived way on top of the new
checking infrastructure.  For now, just get rid of them, removing the
last vestiges of the old-style checking code (hoorah).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-11 13:51:06.000000000 +1100
+++ dtc/checks.c	2007-12-11 14:11:40.000000000 +1100
@@ -511,10 +511,7 @@ static struct check *check_table[] = {
 	&obsolete_chosen_interrupt_controller,
 };
 
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys);
-
-void process_checks(int force, struct boot_info *bi,
-		    int checkflag, int outversion, int boot_cpuid_phys)
+void process_checks(int force, struct boot_info *bi)
 {
 	struct node *dt = bi->dt;
 	int i;
@@ -537,214 +534,4 @@ void process_checks(int force, struct bo
 				"output forced\n");
 		}
 	}
-
-	if (checkflag) {
-		if (error) {
-			fprintf(stderr, "Warning: Skipping semantic checks due to structural errors\n");
-		} else {
-			if (!check_semantics(bi->dt, outversion,
-					     boot_cpuid_phys))
-				fprintf(stderr, "Warning: Input tree has semantic errors\n");
-		}
-	}
-}
-
-/*
- * Semantic check functions
- */
-
-#define ERRMSG(...) if (quiet < 2) fprintf(stderr, "ERROR: " __VA_ARGS__)
-#define WARNMSG(...) if (quiet < 1) fprintf(stderr, "Warning: " __VA_ARGS__)
-
-#define DO_ERR(...) do {ERRMSG(__VA_ARGS__); ok = 0; } while (0)
-
-#define CHECK_HAVE(node, propname) \
-	do { \
-		if (! (prop = get_property((node), (propname)))) \
-			DO_ERR("Missing \"%s\" property in %s\n", (propname), \
-				(node)->fullpath); \
-	} while (0);
-
-#define CHECK_HAVE_WARN(node, propname) \
-	do { \
-		if (! (prop  = get_property((node), (propname)))) \
-			WARNMSG("%s has no \"%s\" property\n", \
-				(node)->fullpath, (propname)); \
-	} while (0)
-
-#define CHECK_HAVE_STRING(node, propname) \
-	do { \
-		CHECK_HAVE((node), (propname)); \
-		if (prop && !data_is_one_string(prop->val)) \
-			DO_ERR("\"%s\" property in %s is not a string\n", \
-				(propname), (node)->fullpath); \
-	} while (0)
-
-#define CHECK_HAVE_STREQ(node, propname, value) \
-	do { \
-		CHECK_HAVE_STRING((node), (propname)); \
-		if (prop && !streq(prop->val.val, (value))) \
-			DO_ERR("%s has wrong %s, %s (should be %s\n", \
-				(node)->fullpath, (propname), \
-				prop->val.val, (value)); \
-	} while (0)
-
-#define CHECK_HAVE_ONECELL(node, propname) \
-	do { \
-		CHECK_HAVE((node), (propname)); \
-		if (prop && (prop->val.len != sizeof(cell_t))) \
-			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
-	} while (0)
-
-#define CHECK_HAVE_WARN_ONECELL(node, propname) \
-	do { \
-		CHECK_HAVE_WARN((node), (propname)); \
-		if (prop && (prop->val.len != sizeof(cell_t))) \
-			DO_ERR("\"%s\" property in %s has wrong size %d (should be 1 cell)\n", (propname), (node)->fullpath, prop->val.len); \
-	} while (0)
-
-#define CHECK_HAVE_WARN_PHANDLE(xnode, propname, root) \
-	do { \
-		struct node *ref; \
-		CHECK_HAVE_WARN_ONECELL((xnode), (propname)); \
-		if (prop) {\
-			cell_t phandle = propval_cell(prop); \
-			if ((phandle == 0) || (phandle == -1)) { \
-				DO_ERR("\"%s\" property in %s contains an invalid phandle %x\n", (propname), (xnode)->fullpath, phandle); \
-			} else { \
-				ref = get_node_by_phandle((root), propval_cell(prop)); \
-				if (! ref) \
-					DO_ERR("\"%s\" property in %s refers to non-existant phandle %x\n", (propname), (xnode)->fullpath, propval_cell(prop)); \
-			} \
-		} \
-	} while (0)
-
-#define CHECK_HAVE_WARN_STRING(node, propname) \
-	do { \
-		CHECK_HAVE_WARN((node), (propname)); \
-		if (prop && !data_is_one_string(prop->val)) \
-			DO_ERR("\"%s\" property in %s is not a string\n", \
-				(propname), (node)->fullpath); \
-	} while (0)
-
-static int check_root(struct node *root)
-{
-	struct property *prop;
-	int ok = 1;
-
-	CHECK_HAVE_STRING(root, "model");
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
-	if (cpus->addr_cells != 1)
-		DO_ERR("%s has bad #address-cells value %d (should be 1)\n",
-		       cpus->fullpath, cpus->addr_cells);
-	if (cpus->size_cells != 0)
-		DO_ERR("%s has bad #size-cells value %d (should be 0)\n",
-		       cpus->fullpath, cpus->size_cells);
-
-	for_each_child(cpus, cpu) {
-		CHECK_HAVE_STREQ(cpu, "device_type", "cpu");
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
-int check_semantics(struct node *dt, int outversion, int boot_cpuid_phys)
-{
-	int ok = 1;
-
-	ok = ok && check_root(dt);
-	ok = ok && check_cpus(dt, outversion, boot_cpuid_phys);
-	ok = ok && check_memory(dt);
-	if (! ok)
-		return 0;
-
-	return 1;
 }
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-12-11 14:11:49.000000000 +1100
+++ dtc/dtc.h	2007-12-11 14:11:54.000000000 +1100
@@ -240,8 +240,7 @@ struct boot_info *build_boot_info(struct
 
 /* Checks */
 
-void process_checks(int force, struct boot_info *bi,
-		    int checkflag, int outversion, int boot_cpuid_phys);
+void process_checks(int force, struct boot_info *bi);
 
 /* Flattened trees */
 
Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2007-12-11 14:12:07.000000000 +1100
+++ dtc/dtc.c	2007-12-11 14:12:09.000000000 +1100
@@ -204,7 +204,7 @@ int main(int argc, char *argv[])
 	if (! bi || ! bi->dt)
 		die("Couldn't read input tree\n");
 
-	process_checks(force, bi, check, outversion, boot_cpuid_phys);
+	process_checks(force, bi);
 
 	if (streq(outname, "-")) {
 		outf = stdout;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
