Return-Path: <dgibson@ozlabs.org>
Date: Fri, 30 May 2008 11:36:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Add a testcase for 'reg' or 'ranges' in /
Message-ID: <20080530013600.GD26816@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds an extra testcase to dtc to ensure that the
"reg_format" and "ranges_format" checks trigger as they should if a
'reg' or 'ranges' property appears in the root node.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/reg-ranges-root.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/reg-ranges-root.dts	2008-05-29 17:01:39.000000000 +1000
@@ -0,0 +1,8 @@
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x1000 0x10>;
+	ranges = <0x1000 0x2000 0x1000>;
+};
Index: dtc/tests/run_tests.sh
===================================================================
--- dtc.orig/tests/run_tests.sh	2008-05-29 17:01:36.000000000 +1000
+++ dtc/tests/run_tests.sh	2008-05-29 17:01:39.000000000 +1000
@@ -249,6 +249,7 @@ dtc_tests () {
     run_sh_test dtc-checkfails.sh device_type_is_string model_is_string status_is_string -- -I dts -O dtb bad-string-props.dts
     run_sh_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb bad-reg-ranges.dts
     run_sh_test dtc-checkfails.sh ranges_format -- -I dts -O dtb bad-empty-ranges.dts
+    run_sh_test dtc-checkfails.sh reg_format ranges_format -- -I dts -O dtb reg-ranges-root.dts
     run_sh_test dtc-checkfails.sh avoid_default_addr_size -- -I dts -O dtb default-addr-size.dts
     run_sh_test dtc-checkfails.sh obsolete_chosen_interrupt_controller -- -I dts -O dtb obsolete-chosen-interrupt-controller.dts
     run_sh_test dtc-checkfails.sh node_name_chars -- -I dtb -O dtb bad_node_char.dtb

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
