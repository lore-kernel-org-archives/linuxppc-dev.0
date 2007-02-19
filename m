Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 3AD52DDFCB
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 05:01:13 +1100 (EST)
Message-ID: <45D9E5E8.8080200@smiths-aerospace.com>
Date: Mon, 19 Feb 2007 13:01:12 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 2/2] libfdt: Use Jon's fdc for testing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use jdl's flattened device tree compiler (dtc) to generate the test tree.


Signed-off-by: Jerry Van Baren <vanbaren@cideas.com>
---
  tests/Makefile       |   11 ++++++++---
  tests/test_tree1.dts |   23 +++++++++++++++++++++++
  2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index 533c98e..7f7ed9b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -41,15 +41,20 @@ all:	$(TESTS) $(TREES)
  	@$(VECHO) LD $@
  	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

+%.dtb: %.dts
+	@$(VECHO) NOTE: It is normal to have errors and warnings here.
+	dtc -b 0 -f -O dtb -V 16 $^ > $@
+
+
  $(LIB_TESTS): %: testutils.o $(LIBFDT)

  $(LIBTREE_TESTS): %: testutils.o trees.o $(LIBFDT)

  dumptrees: %: trees.o

-$(TREES): dumptrees
-	@$(VECHO) DUMPTREES
-	./dumptrees >/dev/null
+#$(TREES): dumptrees
+#	@$(VECHO) DUMPTREES
+#	./dumptrees >/dev/null

  clean:
  	@$(VECHO) CLEAN "(tests)"
diff --git a/tests/test_tree1.dts b/tests/test_tree1.dts
new file mode 100644
index 0000000..ab62772
--- /dev/null
+++ b/tests/test_tree1.dts
@@ -0,0 +1,23 @@
+/*
+ * libfdt test tree source
+ */
+
+/ {
+	/*
+	 * Test nodes and values...
+	 */
+	prop_int = <deadbeef>;
+	prop_str = "hello world";
+	subnode1 {
+		prop_int = <deadbeef>;
+		subsubnode {
+			prop_int = <deadbeef>;
+		};
+	};
+	subnode2 {
+		prop_int = <abcd1234>;
+		subsubnode {
+			prop_int = <abcd1234>;
+		};
+	};
+};
-- 
1.4.4.4


______________________________________________________________________
CAUTION: This message was sent via the Public Internet and its 
authenticity cannot be guaranteed.

______________________________________________________
