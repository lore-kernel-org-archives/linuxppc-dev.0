Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id A4931DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 23:59:23 +1100 (EST)
Message-ID: <45DEE524.6010704@smiths-aerospace.com>
Date: Fri, 23 Feb 2007 07:59:16 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,  linuxppc-dev@ozlabs.org
Subject: Re: libfdt: a fix but still broken
References: <45DD9A41.7060900@smiths-aerospace.com>
	<20070223034734.GA18698@localhost.localdomain>
In-Reply-To: <20070223034734.GA18698@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------040805030505010409030605"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040805030505010409030605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Gibson wrote:
> On Thu, Feb 22, 2007 at 08:27:29AM -0500, Jerry Van Baren wrote:
>> Hi Dave,
>>
>> I have good news and bad news. ;-)  The good news is that the 
>> incompatibility between libfdt and jdl's dtc is that libfdt has the name 
>> offset and the length of the name switched.  booting_without_of.txt says 
>> the length comes first, so libfdt is in the wrong.
> 
> Ouch.  That's.. a very embarrassing bug.  Actually, I know where it
> came from: I was looking at flat_dt.h from dtc, which also gets this
> wrong (but the declaration in question is unused).  Of course, I also
> wrote flat_dt.h ...
> 
>> The bad news is that, when I fix this, nearly all of the tests fail (but 
>> they fail the same way for both tree.S and jdl's dtc).  I have not 
>> started on that layer of the onion yet.
> 
> Found it, there was a direct use of the position of the length in
> _fdt_next_tag().  Just pushed out a fix for this in the libfdt tree,
> along with some other small fixes which I found while tracking this
> one down.
> 
> Oh, incidentally, I applied your patch by eye rather than with
> patch(1), which was handy, because it appears to have been whitespace
> damaged.

Hi David,

Sorry about the whitespace, I actually generated it at home, emailed it 
to my day job, and edited and forwarded it from there (I'm not 
subscribed at home - probably should be).

It sounds like we found and fixed the same bug last night.

I went quite a bit further (before finding and fixing the real bug).  I 
was looking at the *_type "function like" #defines that generate a 
temporary variable of indeterminate (until compile time) type.  An example:

#define fdt_setprop_inplace_typed(fdt, nodeoffset, name, val) \
	({ \
		typeof(val) x = val; \
		fdt_setprop_inplace(fdt, nodeoffset, name, &x, sizeof(x)); \
	})

IMHO this is borderline evil and unnecessary, and I removed all of them 
by replacing the call of the *_type macros with the equivalent actual 
function.  What I was suspicious of is when I changed all the calls to 
use proper endian by calling cpu_to_fdt32(), the parameter "val" is no 
longer a simple constant or variable but is, instead, a function call or 
macro or nothing at all, depending on the host endian and compiler 
implementation.  It turns out that this apparently wasn't a problem, but 
I'm still of the opinion that those #defines have minimal value and 
makes the code baroque. ;-)

I've attached a patch file that shouldn't be whitespace damaged this 
time.  :-/  I can also make my git repository accessible if that is helpful.

Best regards,
gvb

--------------040805030505010409030605
Content-Type: text/plain;
 name="libfdt-070222.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libfdt-070222.patch"

Tests are working again.  Most tests work with dtc, but a couple of
  tests fail with the dtc-generated blob due to the version being 16
  instead of 17.

Signed-off-by: Jerry Van Baren <vanbaren@cideas.com>
---
 fdt.c                   |    2 +-
 fdt_ro.c                |    4 ++--
 libfdt.h                |   23 -----------------------
 tests/del_node.c        |   16 +++++++++++-----
 tests/del_property.c    |    4 +++-
 tests/find_property.c   |    4 +++-
 tests/getprop.c         |    4 +++-
 tests/nop_node.c        |   16 +++++++++++-----
 tests/nop_property.c    |    4 +++-
 tests/path_offset.c     |    2 +-
 tests/root_node.c       |    2 +-
 tests/rw_tree1.c        |   18 ++++++++++++------
 tests/setprop.c         |    8 +++++---
 tests/setprop_inplace.c |   11 ++++++++---
 tests/subnode_offset.c  |   17 ++++++++++++-----
 tests/sw_tree1.c        |   18 ++++++++++++------
 tests/test_tree1.dts    |   12 ++++++------
 tests/tests.h           |   13 -------------
 18 files changed, 94 insertions(+), 84 deletions(-)

diff --git a/fdt.c b/fdt.c
index 45568b1..772da46 100644
--- a/fdt.c
+++ b/fdt.c
@@ -83,7 +83,7 @@ uint32_t _fdt_next_tag(const void *fdt, int offset, int *nextoffset)
 			return FDT_END;
 		break;
 	case FDT_PROP:
-		lenp = fdt_offset_ptr(fdt, offset + FDT_TAGSIZE, sizeof(*lenp));
+		lenp = fdt_offset_ptr(fdt, offset, sizeof(*lenp));
 		if (! lenp)
 			return FDT_END;
 		/* skip name offset, length and value */
diff --git a/fdt_ro.c b/fdt_ro.c
index 7eebb03..935ee43 100644
--- a/fdt_ro.c
+++ b/fdt_ro.c
@@ -226,7 +226,7 @@ struct fdt_property *fdt_get_property(const void *fdt,
 				continue;

 			err = -FDT_ERR_BADSTRUCTURE;
-			prop = fdt_offset_ptr_typed(fdt, offset, prop);
+			prop = fdt_offset_ptr(fdt, offset, sizeof(fdt_property));
 			if (! prop)
 				goto fail;
 			namestroff = fdt32_to_cpu(prop->nameoff);
@@ -274,5 +274,5 @@ void *fdt_getprop(const void *fdt, int nodeoffset,
 	if (! prop)
 		return NULL;

-	return prop->data;
+	return (void *)prop->data;
 }
diff --git a/libfdt.h b/libfdt.h
index acdc72e..3c6859b 100644
--- a/libfdt.h
+++ b/libfdt.h
@@ -62,9 +62,6 @@

 void *fdt_offset_ptr(const void *fdt, int offset, int checklen);

-#define fdt_offset_ptr_typed(fdt, offset, var) \
-	((typeof(var))(fdt_offset_ptr((fdt), (offset), sizeof(*(var)))))
-
 int fdt_move(const void *fdt, void *buf, int bufsize);

 /* Read-only functions */
@@ -85,12 +82,6 @@ void *fdt_getprop(const void *fdt, int nodeoffset,
 int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
 			const void *val, int len);

-#define fdt_setprop_inplace_typed(fdt, nodeoffset, name, val) \
-	({ \
-		typeof(val) x = val; \
-		fdt_setprop_inplace(fdt, nodeoffset, name, &x, sizeof(x)); \
-	})
-
 int fdt_nop_property(void *fdt, int nodeoffset, const char *name);
 int fdt_nop_node(void *fdt, int nodeoffset);

@@ -100,13 +91,6 @@ int fdt_add_reservemap_entry(void *fdt, uint64_t addr, uint64_t size);
 int fdt_finish_reservemap(void *fdt);
 int fdt_begin_node(void *fdt, const char *name);
 int fdt_property(void *fdt, const char *name, const void *val, int len);
-#define fdt_property_typed(fdt, name, val) \
-	({ \
-		typeof(val) x = (val); \
-		fdt_property((fdt), (name), &x, sizeof(x)); \
-	})
-#define fdt_property_string(fdt, name, str) \
-	fdt_property(fdt, name, str, strlen(str)+1)
 int fdt_end_node(void *fdt);
 int fdt_finish(void *fdt);

@@ -116,13 +100,6 @@ int fdt_pack(void *fdt);

 int fdt_setprop(void *fdt, int nodeoffset, const char *name,
 		const void *val, int len);
-#define fdt_setprop_typed(fdt, nodeoffset, name, val) \
-	({ \
-		typeof(val) x = (val); \
-		fdt_setprop((fdt), (nodeoffset), (name), &x, sizeof(x)); \
-	})
-#define fdt_setprop_string(fdt, nodeoffset, name, str) \
-	fdt_setprop((fdt), (nodeoffset), (name), (str), strlen(str)+1)
 int fdt_delprop(void *fdt, int nodeoffset, const char *name);
 int fdt_add_subnode_namelen(void *fdt, int parentoffset,
 			    const char *name, int namelen);
diff --git a/tests/del_node.c b/tests/del_node.c
index ba79c3c..8f216df 100644
--- a/tests/del_node.c
+++ b/tests/del_node.c
@@ -35,6 +35,7 @@ int main(int argc, char *argv[])
 	int subnode1_offset, subnode2_offset, subsubnode2_offset;
 	int err;
 	int oldsize, delsize, newsize;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
@@ -45,19 +46,22 @@ int main(int argc, char *argv[])
 	if (subnode1_offset < 0)
 		FAIL("Couldn't find \"/subnode1\": %s",
 		     fdt_strerror(subnode1_offset));
-	check_getprop_typed(fdt, subnode1_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	check_getprop(fdt, subnode1_offset, "prop-int", sizeof(x), &x);

 	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subnode2_offset, "prop-int", sizeof(x), &x);

 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subsubnode2_offset, "prop-int", sizeof(x), &x);

 	err = fdt_del_node(fdt, subnode1_offset);
 	if (err)
@@ -73,13 +77,15 @@ int main(int argc, char *argv[])
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subnode2_offset, "prop-int", sizeof(x), &x);

 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subsubnode2_offset, "prop-int", sizeof(x), &x);

 	err = fdt_del_node(fdt, subnode2_offset);
 	if (err)
diff --git a/tests/del_property.c b/tests/del_property.c
index a55f7f7..9f8e637 100644
--- a/tests/del_property.c
+++ b/tests/del_property.c
@@ -36,13 +36,15 @@ int main(int argc, char *argv[])
 	char *strp;
 	int err, lenerr;
 	int oldsize, delsize, newsize;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);

 	oldsize = fdt_totalsize(fdt);

-	intp = check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	intp = check_getprop(fdt, 0, "prop-int", sizeof(x), &x);
 	verbose_printf("int value was 0x%08x\n", *intp);

 	err = fdt_delprop(fdt, 0, "prop-int");
diff --git a/tests/find_property.c b/tests/find_property.c
index cd57ebe..27b9d2c 100644
--- a/tests/find_property.c
+++ b/tests/find_property.c
@@ -30,11 +30,13 @@
 int main(int argc, char *argv[])
 {
 	void *fdt;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);

-	check_property_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	check_property(fdt, 0, "prop-int", sizeof(x), &x);
 	check_property(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1, TEST_STRING_1);

 	PASS();
diff --git a/tests/getprop.c b/tests/getprop.c
index 819842b..a92f438 100644
--- a/tests/getprop.c
+++ b/tests/getprop.c
@@ -31,11 +31,13 @@
 int main(int argc, char *argv[])
 {
 	void *fdt;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);

-	check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	check_getprop(fdt, 0, "prop-int", sizeof(x), &x);
 	check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1, TEST_STRING_1);

 	PASS();
diff --git a/tests/nop_node.c b/tests/nop_node.c
index 03f7116..1572b4b 100644
--- a/tests/nop_node.c
+++ b/tests/nop_node.c
@@ -34,6 +34,7 @@ int main(int argc, char *argv[])
 	void *fdt;
 	int subnode1_offset, subnode2_offset, subsubnode2_offset;
 	int err;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
@@ -42,19 +43,22 @@ int main(int argc, char *argv[])
 	if (subnode1_offset < 0)
 		FAIL("Couldn't find \"/subnode1\": %s",
 		     fdt_strerror(subnode1_offset));
-	check_getprop_typed(fdt, subnode1_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	check_getprop(fdt, subnode1_offset, "prop-int", sizeof(x), &x);

 	subnode2_offset = fdt_path_offset(fdt, "/subnode2");
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subnode2_offset, "prop-int", sizeof(x), &x);

 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subsubnode2_offset, "prop-int", sizeof(x), &x);

 	err = fdt_nop_node(fdt, subnode1_offset);
 	if (err)
@@ -70,13 +74,15 @@ int main(int argc, char *argv[])
 	if (subnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2\": %s",
 		     fdt_strerror(subnode2_offset));
-	check_getprop_typed(fdt, subnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subnode2_offset, "prop-int", sizeof(x), &x);

 	subsubnode2_offset = fdt_path_offset(fdt, "/subnode2/subsubnode");
 	if (subsubnode2_offset < 0)
 		FAIL("Couldn't find \"/subnode2/subsubnode\": %s",
 		     fdt_strerror(subsubnode2_offset));
-	check_getprop_typed(fdt, subsubnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_getprop(fdt, subsubnode2_offset, "prop-int", sizeof(x), &x);

 	err = fdt_nop_node(fdt, subnode2_offset);
 	if (err)
diff --git a/tests/nop_property.c b/tests/nop_property.c
index 465ea7a..dd76c79 100644
--- a/tests/nop_property.c
+++ b/tests/nop_property.c
@@ -36,11 +36,13 @@ int main(int argc, char *argv[])
 	char *strp;
 	int err;
 	int lenerr;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);

-	intp = check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	intp = check_getprop(fdt, 0, "prop-int", sizeof(x), &x);
 	verbose_printf("int value was 0x%08x\n", *intp);

 	err = fdt_nop_property(fdt, 0, "prop-int");
diff --git a/tests/path_offset.c b/tests/path_offset.c
index 42e5daa..898621d 100644
--- a/tests/path_offset.c
+++ b/tests/path_offset.c
@@ -38,7 +38,7 @@ int check_subnode(void *fdt, int parent, const char *name)
 	verbose_printf("offset %d...", offset);
 	if (offset < 0)
 		FAIL("fdt_subnode_offset(\"%s\"): %s", name, fdt_strerror(offset));
-	nh = fdt_offset_ptr_typed(fdt, offset, nh);
+	nh = fdt_offset_ptr(fdt, offset, sizeof(*nh));
 	verbose_printf("pointer %p\n", nh);
 	if (! nh)
 		FAIL("NULL retrieving subnode \"%s\"", name);
diff --git a/tests/root_node.c b/tests/root_node.c
index 4258b91..685ffa3 100644
--- a/tests/root_node.c
+++ b/tests/root_node.c
@@ -36,7 +36,7 @@ int main(int argc, char *argv[])
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);

-	nh = fdt_offset_ptr_typed(fdt, 0, nh);
+	nh = fdt_offset_ptr(fdt, 0, sizeof(*nh));

 	if (! nh)
 		FAIL("NULL retrieving root node");
diff --git a/tests/rw_tree1.c b/tests/rw_tree1.c
index fc473e1..f4e74b4 100644
--- a/tests/rw_tree1.c
+++ b/tests/rw_tree1.c
@@ -50,6 +50,7 @@ int main(int argc, char *argv[])
 	void *fdt;
 	int err;
 	int offset;
+	uint32_t x;

 	test_init(argc, argv);

@@ -68,19 +69,24 @@ int main(int argc, char *argv[])

 	CHECK(fdt_open_into(fdt, fdt, SPACE));

-	CHECK(fdt_setprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
-	CHECK(fdt_setprop_string(fdt, 0, "prop-str", TEST_STRING_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	CHECK(fdt_setprop(fdt, 0, "prop-int", &x, sizeof(x)));
+	CHECK(fdt_setprop(fdt, 0, "prop-str", TEST_STRING_1, strlen(TEST_STRING_1)+1));

 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode1"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	CHECK(fdt_setprop(fdt, offset, "prop-int", &x, sizeof(x)));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	CHECK(fdt_setprop(fdt, offset, "prop-int", &x, sizeof(x)));

 	OFF_CHECK(offset, fdt_add_subnode(fdt, 0, "subnode2"));
-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2)));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	CHECK(fdt_setprop(fdt, offset, "prop-int", &x, sizeof(x)));
 	OFF_CHECK(offset, fdt_add_subnode(fdt, offset, "subsubnode"));

-	CHECK(fdt_setprop_typed(fdt, offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2)));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	CHECK(fdt_setprop(fdt, offset, "prop-int", &x, sizeof(x)));

 	CHECK(fdt_pack(fdt));

diff --git a/tests/setprop.c b/tests/setprop.c
index 6695edf..2997be0 100644
--- a/tests/setprop.c
+++ b/tests/setprop.c
@@ -39,6 +39,7 @@ int main(int argc, char *argv[])
 	uint32_t *intp;
 	char *strp;
 	int err;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
@@ -51,15 +52,16 @@ int main(int argc, char *argv[])

 	fdt = buf;

-	intp = check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	intp = check_getprop(fdt, 0, "prop-int", sizeof(x), &x);

 	verbose_printf("Old int value was 0x%08x\n", *intp);

-	err = fdt_setprop_string(fdt, 0, "prop-int", NEW_STRING);
+	err = fdt_setprop(fdt, 0, "prop-int", NEW_STRING, strlen(NEW_STRING)+1);
 	if (err)
 		FAIL("Failed to set \"prop-int\" to \"%s\": %s",
 		     NEW_STRING, fdt_strerror(err));

-	strp = check_getprop_string(fdt, 0, "prop-int", NEW_STRING);
+	strp = check_getprop(fdt, 0, "prop-int", strlen(NEW_STRING)+1, NEW_STRING);
 	verbose_printf("New value is \"%s\"\n", strp);

 	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
diff --git a/tests/setprop_inplace.c b/tests/setprop_inplace.c
index be420a9..2ac7a01 100644
--- a/tests/setprop_inplace.c
+++ b/tests/setprop_inplace.c
@@ -36,18 +36,23 @@ int main(int argc, char *argv[])
 	char *strp, *xstr;
 	int xlen, i;
 	int err;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);

-	intp = check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	intp = check_getprop(fdt, 0, "prop-int", sizeof(x), &x);

 	verbose_printf("Old int value was 0x%08x\n", *intp);
-	err = fdt_setprop_inplace_typed(fdt, 0, "prop-int", cpu_to_fdt32(~TEST_VALUE_1));
+	x = cpu_to_fdt32(~TEST_VALUE_1);
+	err = fdt_setprop_inplace(fdt, 0, "prop-int", &x, sizeof(x));
+
 	if (err)
 		FAIL("Failed to set \"prop-int\" to 0x08%x: %s",
 		     cpu_to_fdt32(~TEST_VALUE_1), fdt_strerror(err));
-	intp = check_getprop_typed(fdt, 0, "prop-int", cpu_to_fdt32(~TEST_VALUE_1));
+	x = cpu_to_fdt32(~TEST_VALUE_1);
+	intp = check_getprop(fdt, 0, "prop-int", sizeof(x), &x);
 	verbose_printf("New int value is 0x%08x\n", *intp);

 	strp = check_getprop(fdt, 0, "prop-str", strlen(TEST_STRING_1)+1,
diff --git a/tests/subnode_offset.c b/tests/subnode_offset.c
index 8cc2d7c..311c5cd 100644
--- a/tests/subnode_offset.c
+++ b/tests/subnode_offset.c
@@ -38,7 +38,7 @@ int check_subnode(struct fdt_header *fdt, int parent, const char *name)
 	verbose_printf("offset %d...", offset);
 	if (offset < 0)
 		FAIL("fdt_subnode_offset(\"%s\"): %s", name, fdt_strerror(offset));
-	nh = fdt_offset_ptr_typed(fdt, offset, nh);
+	nh = fdt_offset_ptr(fdt, offset, sizeof(*nh));
 	verbose_printf("pointer %p\n", nh);
 	if (! nh)
 		FAIL("NULL retrieving subnode \"%s\"", name);
@@ -59,6 +59,7 @@ int main(int argc, char *argv[])
 	void *fdt;
 	int subnode1_offset, subnode2_offset;
 	int subsubnode1_offset, subsubnode2_offset;
+	uint32_t x;

 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
@@ -69,14 +70,20 @@ int main(int argc, char *argv[])
 	if (subnode1_offset == subnode2_offset)
 		FAIL("Different subnodes have same offset");

-	check_property_typed(fdt, subnode1_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
-	check_property_typed(fdt, subnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	check_property(fdt, subnode1_offset, "prop-int", sizeof(x), &x);
+
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_property(fdt, subnode2_offset, "prop-int", sizeof(x), &x);

 	subsubnode1_offset = check_subnode(fdt, subnode1_offset, "subsubnode");
 	subsubnode2_offset = check_subnode(fdt, subnode2_offset, "subsubnode");

-	check_property_typed(fdt, subsubnode1_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_1));
-	check_property_typed(fdt, subsubnode2_offset, "prop-int", cpu_to_fdt32(TEST_VALUE_2));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	check_property(fdt, subsubnode1_offset, "prop-int", sizeof(x), &x);
+
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	check_property(fdt, subsubnode2_offset, "prop-int", sizeof(x), &x);

 	PASS();
 }
diff --git a/tests/sw_tree1.c b/tests/sw_tree1.c
index 198425b..c539beb 100644
--- a/tests/sw_tree1.c
+++ b/tests/sw_tree1.c
@@ -42,6 +42,7 @@ int main(int argc, char *argv[])
 {
 	void *fdt;
 	int err;
+	uint32_t x;

 	test_init(argc, argv);

@@ -50,20 +51,25 @@ int main(int argc, char *argv[])

 	CHECK(fdt_finish_reservemap(fdt));
 	CHECK(fdt_begin_node(fdt, ""));
-	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
-	CHECK(fdt_property_string(fdt, "prop-str", TEST_STRING_1));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	CHECK(fdt_property(fdt, "prop-int", &x, sizeof(x)));
+	CHECK(fdt_property(fdt, "prop-str", TEST_STRING_1, strlen(TEST_STRING_1)+1));

 	CHECK(fdt_begin_node(fdt, "subnode1"));
-	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	CHECK(fdt_property(fdt, "prop-int", &x, sizeof(x)));
 	CHECK(fdt_begin_node(fdt, "subsubnode"));
-	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_1)));
+	x = cpu_to_fdt32(TEST_VALUE_1);
+	CHECK(fdt_property(fdt, "prop-int", &x, sizeof(x)));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));

 	CHECK(fdt_begin_node(fdt, "subnode2"));
-	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_2)));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	CHECK(fdt_property(fdt, "prop-int", &x, sizeof(x)));
 	CHECK(fdt_begin_node(fdt, "subsubnode"));
-	CHECK(fdt_property_typed(fdt, "prop-int", cpu_to_fdt32(TEST_VALUE_2)));
+	x = cpu_to_fdt32(TEST_VALUE_2);
+	CHECK(fdt_property(fdt, "prop-int", &x, sizeof(x)));
 	CHECK(fdt_end_node(fdt));
 	CHECK(fdt_end_node(fdt));

diff --git a/tests/test_tree1.dts b/tests/test_tree1.dts
index ab62772..87af282 100644
--- a/tests/test_tree1.dts
+++ b/tests/test_tree1.dts
@@ -6,18 +6,18 @@
 	/*
 	 * Test nodes and values...
 	 */
-	prop_int = <deadbeef>;
-	prop_str = "hello world";
+	prop-int = <deadbeef>;
+	prop-str = "hello world";
 	subnode1 {
-		prop_int = <deadbeef>;
+		prop-int = <deadbeef>;
 		subsubnode {
-			prop_int = <deadbeef>;
+			prop-int = <deadbeef>;
 		};
 	};
 	subnode2 {
-		prop_int = <abcd1234>;
+		prop-int = <abcd1234>;
 		subsubnode {
-			prop_int = <abcd1234>;
+			prop-int = <abcd1234>;
 		};
 	};
 };
diff --git a/tests/tests.h b/tests/tests.h
index b262e31..b99d6cb 100644
--- a/tests/tests.h
+++ b/tests/tests.h
@@ -110,22 +110,9 @@ static inline void *xrealloc(void *p, size_t size)

 void check_property(void *fdt, int nodeoffset, const char *name,
 		    int len, const void *val);
-#define check_property_typed(fdt, nodeoffset, name, val) \
-	({ \
-		typeof(val) x = val; \
-		check_property(fdt, nodeoffset, name, sizeof(x), &x); \
-	})
-

 void *check_getprop(void *fdt, int nodeoffset, const char *name,
 		    int len, const void *val);
-#define check_getprop_typed(fdt, nodeoffset, name, val) \
-	({ \
-		typeof(val) x = val; \
-		check_getprop(fdt, nodeoffset, name, sizeof(x), &x); \
-	})
-#define check_getprop_string(fdt, nodeoffset, name, s) \
-	check_getprop((fdt), (nodeoffset), (name), strlen(s)+1, (s))
 //void *load_blob(const char *filename);
 void *load_blob_arg(int argc, char *argv[]);
 void save_blob(const char *filename, void *blob);
--
1.4.4.4


______________________________________________________________________
CAUTION: This message was sent via the Public Internet and its authenticity cannot be guaranteed.

______________________________________________________

--------------040805030505010409030605--
