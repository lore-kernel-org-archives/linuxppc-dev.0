Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Fix sw_tree1 testcase 
In-Reply-To: Your message of "Mon, 05 Nov 2007 16:38:44 +1100."
	<20071105053844.GC21064@localhost.localdomain>
References: <20071105053844.GC21064@localhost.localdomain> 
Date: Mon, 05 Nov 2007 09:11:25 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ip3bp-000260-Of@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> There is a bug in the sw_tree1 testcase / utility which puts two
> "compatible" properties in one node in the output tree.  This patch
> fixes the bug, and also adds a new test checking that the sw_tree1
> output is equal to test_tree1.dtb as its supposed to be, which should
> catch future errors of this type.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

This change appears to cause a test to fail.
I've not looked into it beyond "make check failed":

Thanks,
jdl

----------------------------------------------------------------

[ snip ]

nop_node rw_tree1.test.dtb:     PASS
setprop rw_tree1.test.dtb:      PASS
del_property rw_tree1.test.dtb: PASS
del_node rw_tree1.test.dtb:     PASS
dtbs_equal_ordered test_tree1.dtb rw_tree1.test.dtb:    FAIL    Property name mismatch "compatible" != "prop-str" at (8, 8)
truncated_property:     PASS
dtc.sh -I dts -O dtb -o dtc_tree1.test.dtb test_tree1.dts:      PASS
get_mem_rsv dtc_tree1.test.dtb: PASS
root_node dtc_tree1.test.dtb:   PASS

[ snip ]

del_node dtc_tree1.test.dtb:    PASS
dtbs_equal_ordered dtc_tree1.test.dtb test_tree1.dtb:   PASS
dtc.sh -I dts -O dtb -o dtc_escapes.test.dtb escapes.dts:       PASS
string_escapes dtc_escapes.test.dtb:    PASS
********** TEST SUMMARY
*     Total testcases:  1216
*                PASS:  1215
*                FAIL:  1
*   Bad configuration:  0
* Strange test result:  0
**********
