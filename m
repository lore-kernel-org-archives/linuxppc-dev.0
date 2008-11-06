Return-Path: <michael@ellerman.id.au>
Subject: dtc: Add python source code output
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>, devicetree-discuss@ozlabs.org
Content-Type: text/plain
Date: Thu, 06 Nov 2008 18:55:44 +1100
Message-Id: <1225958144.25986.9.camel@localhost>
Mime-Version: 1.0
Cc: Jon Loeliger <jdl@jdl.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This commit adds an output format, which produces python
code. When run, the python produces a data structure that
can then be inspected in order to do various things.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

I'm not sure if this is generally useful (or sane) but it was for me so
I thought I'd post it.

I have a dts that I want to use to configure a simulator, and this
seemed like the nicest way to get there. dtc spits out the pythonised
device tree, and then I have a 10 line python script that does the
configuring.

cheers


 Makefile.dtc |    1 +
 dtc.c        |    3 +
 dtc.h        |    1 +
 python.c     |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 python.c

diff --git a/Makefile.dtc b/Makefile.dtc
index bece49b..92164de 100644
--- a/Makefile.dtc
+++ b/Makefile.dtc
@@ -12,6 +12,7 @@ DTC_SRCS = \
 	livetree.c \
 	srcpos.c \
 	treesource.c \
+	python.c \
 	util.c
 
 DTC_GEN_SRCS = dtc-lexer.lex.c dtc-parser.tab.c
diff --git a/dtc.c b/dtc.c
index 84bee2d..496aebf 100644
--- a/dtc.c
+++ b/dtc.c
@@ -92,6 +92,7 @@ static void  __attribute__ ((noreturn)) usage(void)
 	fprintf(stderr, "\t\t\tdts - device tree source text\n");
 	fprintf(stderr, "\t\t\tdtb - device tree blob\n");
 	fprintf(stderr, "\t\t\tasm - assembler source\n");
+	fprintf(stderr, "\t\t\tpy  - python source\n");
 	fprintf(stderr, "\t-V <output version>\n");
 	fprintf(stderr, "\t\tBlob version to produce, defaults to %d (relevant for dtb\n\t\tand asm output only)\n", DEFAULT_FDT_VERSION);
 	fprintf(stderr, "\t-R <number>\n");
@@ -219,6 +220,8 @@ int main(int argc, char *argv[])
 		dt_to_blob(outf, bi, outversion);
 	} else if (streq(outform, "asm")) {
 		dt_to_asm(outf, bi, outversion);
+	} else if (streq(outform, "py")) {
+		dt_to_python(outf, bi, outversion);
 	} else if (streq(outform, "null")) {
 		/* do nothing */
 	} else {
diff --git a/dtc.h b/dtc.h
index 5cb9f58..45252fe 100644
--- a/dtc.h
+++ b/dtc.h
@@ -237,6 +237,7 @@ void process_checks(int force, struct boot_info *bi);
 
 void dt_to_blob(FILE *f, struct boot_info *bi, int version);
 void dt_to_asm(FILE *f, struct boot_info *bi, int version);
+void dt_to_python(FILE *f, struct boot_info *bi, int version);
 
 struct boot_info *dt_from_blob(const char *fname);
 
diff --git a/python.c b/python.c
new file mode 100644
index 0000000..8ad0433
--- /dev/null
+++ b/python.c
@@ -0,0 +1,129 @@
+/*
+ * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
+ * (C) Copyright Michael Ellerman, IBM Corporation.  2008.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
+ *                                                                   USA
+ */
+
+#include "dtc.h"
+#include "srcpos.h"
+
+
+static void write_propval_cells(FILE *f, struct property *prop)
+{
+	cell_t *cp = (cell_t *)prop->val.val;
+	int i;
+
+	fprintf(f, "    p = Property('%s', [", prop->name);
+
+	for (i = 0; i < prop->val.len / sizeof(cell_t); i++)
+		fprintf(f, "0x%x, ", fdt32_to_cpu(cp[i]));
+
+	fprintf(f, "])\n");
+}
+
+static int isstring(char c)
+{
+	return (isprint(c)
+		|| (c == '\0')
+		|| strchr("\a\b\t\n\v\f\r", c));
+}
+
+static void write_property(FILE *f, struct property *prop)
+{
+	const char *p = prop->val.val;
+	int i, strtype, len = prop->val.len;
+
+	if (len == 0) {
+		fprintf(f, "    p = Property('%s', None)\n", prop->name);
+		goto out;
+	}
+
+	strtype = 1;
+	for (i = 0; i < len; i++) {
+		if (!isstring(p[i])) {
+			strtype = 0;
+			break;
+		}
+	}
+
+	if (strtype)
+		fprintf(f, "    p = Property('%s', '%s')\n", prop->name,
+			prop->val.val);
+	else if (len == 4)
+		fprintf(f, "    p = Property('%s', 0x%x)\n", prop->name,
+			fdt32_to_cpu(*(const cell_t *)p));
+	else
+		write_propval_cells(f, prop);
+	
+out:
+	fprintf(f, "    n.properties.append(p)\n");
+}
+
+static void write_tree_source_node(FILE *f, struct node *tree, int level)
+{
+	char name[MAX_NODENAME_LEN + 1] = "root";
+	struct property *prop;
+	struct node *child;
+
+	if (tree->name && (*tree->name))
+		strncpy(name, tree->name, MAX_NODENAME_LEN);
+
+	fprintf(f, "    n = Node('%s', parents[-1])\n", name);
+
+	if (level > 0)
+		fprintf(f, "    parents[-1].children.append(n)\n");
+	else
+		fprintf(f, "    root = n\n");
+
+	for_each_property(tree, prop)
+		write_property(f, prop);
+
+	fprintf(f, "    parents.append(n)\n");
+
+	for_each_child(tree, child) {
+		write_tree_source_node(f, child, level + 1);
+	}
+
+	fprintf(f, "    parents.pop()\n");
+}
+
+
+static char *header = "#!/usr/bin/python\n\
+\n\
+class Node(object):\n\
+    def __init__(self, name, parent, unitaddr=None):\n\
+        self.__dict__.update(locals())\n\
+        self.children = []\n\
+        self.properties = []\n\
+\n\
+class Property(object):\n\
+    def __init__(self, name, value):\n\
+        self.__dict__.update(locals())\n\
+";
+
+void dt_to_python(FILE *f, struct boot_info *bi, int version)
+{
+	fprintf(f, "%s\n", header);
+	fprintf(f, "def generate_tree():\n");
+	fprintf(f, "    parents = [None]\n");
+
+	write_tree_source_node(f, bi->dt, 0);
+
+	fprintf(f, "    root.version = %d\n", version);
+	fprintf(f, "    return root\n");
+}
-- 
1.5.6
