Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 08318DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 05:01:07 +1100 (EST)
Message-ID: <45D9E5E2.1080008@smiths-aerospace.com>
Date: Mon, 19 Feb 2007 13:01:06 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/2] libfdt: Make the test values fdt endian
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make the values in the tests "fdt-endian" rather than being 
native-endian (allows use of the dtc to generate blobs).

Signed-off-by: Jerry Van Baren <vanbaren@cideas.com>
---
  tests/del_node.c        |   10 +++++-----
  tests/del_property.c    |    2 +-
  tests/find_property.c   |    2 +-
  tests/getprop.c         |    2 +-
  tests/nop_node.c        |   10 +++++-----
  tests/nop_property.c    |    2 +-
  tests/rw_tree1.c        |   10 +++++-----
  tests/setprop.c         |    2 +-
  tests/setprop_inplace.c |    8 ++++----
  tests/subnode_offset.c  |    8 ++++----
  tests/sw_tree1.c        |   10 +++++-----
  tests/trees.S           |    3 +--
  12 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/tests/del_node.c b/tests/del_node.c
index 56f7cf5..ba79c3c 100644
--- a/tests/del_node.c
+++ b/tests/del_node.c
@@ -45,19 +45,19 @@ int main(int argc, char *argv[])
  	if (subnode1_offset < 0)
  		FAIL("Couldn't find \"/subnode1\": %s",
  		     fdt_strerror(subnode1_offset));
-	check_getprop_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
+	check_getprop_typed(fdt, subnode1_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));

  	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
  	if (subnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2\": %s",
  		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
  	if (subsubnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
  		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	err = fdt_del_node(fdt, subnode1_offset);
  	if (err)
@@ -73,13 +73,13 @@ int main(int argc, char *argv[])
  	if (subnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2\": %s",
  		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
  	if (subsubnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
  		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	err = fdt_del_node(fdt, subnode2_offset);
  	if (err)
diff --git a/tests/del_property.c b/tests/del_property.c
index cc0de98..a55f7f7 100644
--- a/tests/del_property.c
+++ b/tests/del_property.c
@@ -42,7 +42,7 @@ int main(int argc, char *argv[])

  	oldsize = fdt_totalsize(fdt);

-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_typed(fdt, 0, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));
  	verbose_printf("int value was 0x%08x\n", *intp);

  	err = fdt_delprop(fdt, 0, "prop-int");
diff --git a/tests/find_property.c b/tests/find_property.c
index 8a8e9aa..cd57ebe 100644
--- a/tests/find_property.c
+++ b/tests/find_property.c
@@ -34,7 +34,7 @@ int main(int argc, char *argv[])
  	test_init(argc, argv);
  	fdt = load_blob_arg(argc, argv);

-	check_property_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	check_property_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
  	check_property(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1, 
TEST_STRING_1);

  	PASS();
diff --git a/tests/getprop.c b/tests/getprop.c
index 22dc03b..819842b 100644
--- a/tests/getprop.c
+++ b/tests/getprop.c
@@ -35,7 +35,7 @@ int main(int argc, char *argv[])
  	test_init(argc, argv);
  	fdt = load_blob_arg(argc, argv);

-	check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
  	check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1, 
TEST_STRING_1);

  	PASS();
diff --git a/tests/nop_node.c b/tests/nop_node.c
index d09d9df..03f7116 100644
--- a/tests/nop_node.c
+++ b/tests/nop_node.c
@@ -42,19 +42,19 @@ int main(int argc, char *argv[])
  	if (subnode1_offset < 0)
  		FAIL("Couldn't find \"/subnode1\": %s",
  		     fdt_strerror(subnode1_offset));
-	check_getprop_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
+	check_getprop_typed(fdt, subnode1_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));

  	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
  	if (subnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2\": %s",
  		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
  	if (subsubnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
  		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	err = fdt_nop_node(fdt, subnode1_offset);
  	if (err)
@@ -70,13 +70,13 @@ int main(int argc, char *argv[])
  	if (subnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2\": %s",
  		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
  	if (subsubnode2_offset < 0)
  		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
  		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	err = fdt_nop_node(fdt, subnode2_offset);
  	if (err)
diff --git a/tests/nop_property.c b/tests/nop_property.c
index 858527d..465ea7a 100644
--- a/tests/nop_property.c
+++ b/tests/nop_property.c
@@ -40,7 +40,7 @@ int main(int argc, char *argv[])
  	test_init(argc, argv);
  	fdt = load_blob_arg(argc, argv);

-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_typed(fdt, 0, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));
  	verbose_printf("int value was 0x%08x\n", *intp);

  	err = fdt_nop_property(fdt, 0, "prop-int");
diff --git a/tests/rw_tree1.c b/tests/rw_tree1.c
index ffd2c3a..fc473e1 100644
--- a/tests/rw_tree1.c
+++ b/tests/rw_tree1.c
@@ -68,19 +68,19 @@ int main(int argc, char *argv[])

  	CHECK(fdt_open_into(fdt, fdt, SPACE));

-	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
  	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));

  	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode1"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1)));
  	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1)));

  	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode2"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2)));
  	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));

-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2)));

  	CHECK(fdt_pack(fdt));

diff --git a/tests/setprop.c b/tests/setprop.c
index fc70910..6695edf 100644
--- a/tests/setprop.c
+++ b/tests/setprop.c
@@ -51,7 +51,7 @@ int main(int argc, char *argv[])

  	fdt = buf;

-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_typed(fdt, 0, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));

  	verbose_printf("Old int value was 0x%08x\n", *intp);
  	err = fdt_setprop_string(fdt, 0, "prop-int", NEW_STRING);
diff --git a/tests/setprop_inplace.c b/tests/setprop_inplace.c
index f674ec6..be420a9 100644
--- a/tests/setprop_inplace.c
+++ b/tests/setprop_inplace.c
@@ -40,14 +40,14 @@ int main(int argc, char *argv[])
  	test_init(argc, argv);
  	fdt = load_blob_arg(argc, argv);

-	intp = check_getprop_typed(fdt, 0, "prop-int", TEST_VALUE_1);
+	intp = check_getprop_typed(fdt, 0, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));

  	verbose_printf("Old int value was 0x%08x\n", *intp);
-	err = fdt_setprop_inplace_typed(fdt, 0, "prop-int", ~TEST_VALUE_1);
+	err = fdt_setprop_inplace_typed(fdt, 0, "prop-int", 
cpu_to_fdt32(~TEST_VALUE_1));
  	if (err)
  		FAIL("Failed to set \"prop-int\" to 0x08%x: %s",
-		     ~TEST_VALUE_1, fdt_strerror(err));
-	intp = check_getprop_typed(fdt, 0, "prop-int", ~TEST_VALUE_1);
+		     cpu_to_fdt32(~TEST_VALUE_1), fdt_strerror(err));
+	intp = check_getprop_typed(fdt, 0, "prop-int", 
cpu_to_fdt32(~TEST_VALUE_1));
  	verbose_printf("New int value is 0x%08x\n", *intp);
  	
  	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
diff --git a/tests/subnode_offset.c b/tests/subnode_offset.c
index a2b12eb..8cc2d7c 100644
--- a/tests/subnode_offset.c
+++ b/tests/subnode_offset.c
@@ -69,14 +69,14 @@ int main(int argc, char *argv[])
  	if (subnode1_offset == subnode2_offset)
  		FAIL("Different subnodes have same offset");

-	check_property_typed(fdt, subnode1_offset, "prop-int", TEST_VALUE_1);
-	check_property_typed(fdt, subnode2_offset, "prop-int", TEST_VALUE_2);
+	check_property_typed(fdt, subnode1_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));
+	check_property_typed(fdt, subnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	subsubnode1_offset = check_subnode(fdt, subnode1_offset, "subsubnode");
  	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode");

-	check_property_typed(fdt, subsubnode1_offset, "prop-int", TEST_VALUE_1);
-	check_property_typed(fdt, subsubnode2_offset, "prop-int", TEST_VALUE_2);
+	check_property_typed(fdt, subsubnode1_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_1));
+	check_property_typed(fdt, subsubnode2_offset, "prop-int", 
cpu_to_fdt32(TEST_VALUE_2));

  	PASS();
  }
diff --git a/tests/sw_tree1.c b/tests/sw_tree1.c
index 51aa4d7..198425b 100644
--- a/tests/sw_tree1.c
+++ b/tests/sw_tree1.c
@@ -50,20 +50,20 @@ int main(int argc, char *argv[])

  	CHECK(fdt_finish_reservemap(fdt));
  	CHECK(fdt_begin_node(fdt, ""));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
  	CHECK(fdt_property_string(fdt, "prop-str", TEST_STRING_1));

  	CHECK(fdt_begin_node(fdt, "subnode1"));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
  	CHECK(fdt_begin_node(fdt, "subsubnode"));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_1));
+	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
  	CHECK(fdt_end_node(fdt));
  	CHECK(fdt_end_node(fdt));

  	CHECK(fdt_begin_node(fdt, "subnode2"));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_2)));
  	CHECK(fdt_begin_node(fdt, "subsubnode"));
-	CHECK(fdt_property_typed(fdt, "prop-int", TEST_VALUE_2));
+	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_2)));
  	CHECK(fdt_end_node(fdt));
  	CHECK(fdt_end_node(fdt));

diff --git a/tests/trees.S b/tests/trees.S
index 397c151..76c0057 100644
--- a/tests/trees.S
+++ b/tests/trees.S
@@ -44,8 +44,7 @@ tree:	\

  #define PROP_INT(tree, name, val) \
  	PROPHDR(tree, name, 4) \
-	/* For ease of testing the property values go in native-endian */ \
-	.long	val
+	FDTLONG(val)

  #define PROP_STR(tree, name, str) \
  	PROPHDR(tree, name, 55f - 54f) \
-- 
1.4.4.4


______________________________________________________________________
CAUTION: This message was sent via the Public Internet and its 
authenticity cannot be guaranteed.

______________________________________________________
