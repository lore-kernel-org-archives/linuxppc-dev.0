Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C1C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:39:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF872082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF872082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DGgw3Ww5zDqX6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 08:39:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DGdb6SM8zDqWZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 08:37:55 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBALYJSk104147
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:37:53 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9uhcn9mg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:37:53 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 10 Dec 2018 21:37:52 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 21:37:50 -0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBALbnCm22151344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 21:37:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D9046A051;
 Mon, 10 Dec 2018 21:37:49 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88B736A04F;
 Mon, 10 Dec 2018 21:37:48 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.223])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 10 Dec 2018 21:37:48 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH v03] powerpc/mobility: Fix node detach/rename problem
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Mon, 10 Dec 2018 15:37:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121021-0020-0000-0000-00000E97BF4B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010210; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129900; UDB=6.00587085; IPR=6.00910033; 
 MB=3.00024646; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 21:37:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121021-0021-0000-0000-0000640182C8
Message-Id: <a2d46622-a957-dffe-04d1-8087bbf0f8b5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100193
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The PPC mobility code receives RTAS requests to delete nodes with
platform-/hardware-specific attributes when restarting the kernel
after a migration.  My example is for migration between a P8 Alpine
and a P8 Brazos.   Nodes to be deleted include 'ibm,random-v1',
'ibm,platform-facilities', 'ibm,sym-encryption-v1', and,
'ibm,compression-v1'.

The mobility.c code calls 'of_detach_node' for the nodes and their
children.  This makes calls to detach the properties and to remove
the associated sysfs/kernfs files.

Then new copies of the same nodes are next provided by the PHYP,
local copies are built, and a pointer to the 'struct device_node'
is passed to of_attach_node.  Before the call to of_attach_node,
the phandle is initialized to 0 when the data structure is alloced.
During the call to of_attach_node, it calls __of_attach_node which
pulls the actual name and phandle from just created sub-properties
named something like 'name' and 'ibm,phandle'.

This is all fine for the first migration.  The problem occurs with
the second and subsequent migrations when the PHYP on the new system
wants to replace the same set of nodes again, referenced with the
same names and phandle values.

On the second and subsequent migrations, the PHYP tells the system
to again delete the nodes 'ibm,platform-facilities', 'ibm,random-v1',
'ibm,compression-v1', 'ibm,sym-encryption-v1'.  It specifies these
nodes by its known set of phandle values -- the same handles used
by the PHYP on the source system are known on the target system.
The mobility.c code calls of_find_node_by_phandle() with these values
and ends up locating the first instance of each node that was added
during the original boot, instead of the second instance of each node
created after the first migration.  The detach during the second
migration fails with errors like,

[ 4565.030704] WARNING: CPU: 3 PID: 4787 at drivers/of/dynamic.c:252 __of_detach_node+0x8/0xa0
[ 4565.030708] Modules linked in: nfsv3 nfs_acl nfs tcp_diag udp_diag inet_diag unix_diag af_packet_diag netlink_diag lockd grace fscache sunrpc xts vmx_crypto sg pseries_rng binfmt_misc ip_tables xfs libcrc32c sd_mod ibmveth ibmvscsi scsi_transport_srp dm_mirror dm_region_hash dm_log dm_mod
[ 4565.030733] CPU: 3 PID: 4787 Comm: drmgr Tainted: G        W         4.18.0-rc1-wi107836-v05-120+ #201
[ 4565.030737] NIP:  c0000000007c1ea8 LR: c0000000007c1fb4 CTR: 0000000000655170
[ 4565.030741] REGS: c0000003f302b690 TRAP: 0700   Tainted: G        W          (4.18.0-rc1-wi107836-v05-120+)
[ 4565.030745] MSR:  800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 22288822  XER: 0000000a
[ 4565.030757] CFAR: c0000000007c1fb0 IRQMASK: 1
[ 4565.030757] GPR00: c0000000007c1fa4 c0000003f302b910 c00000000114bf00 c0000003ffff8e68
[ 4565.030757] GPR04: 0000000000000001 ffffffffffffffff 800000c008e0b4b8 ffffffffffffffff
[ 4565.030757] GPR08: 0000000000000000 0000000000000001 0000000080000003 0000000000002843
[ 4565.030757] GPR12: 0000000000008800 c00000001ec9ae00 0000000040000000 0000000000000000
[ 4565.030757] GPR16: 0000000000000000 0000000000000008 0000000000000000 00000000f6ffffff
[ 4565.030757] GPR20: 0000000000000007 0000000000000000 c0000003e9f1f034 0000000000000001
[ 4565.030757] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ 4565.030757] GPR28: c000000001549d28 c000000001134828 c0000003ffff8e68 c0000003f302b930
[ 4565.030804] NIP [c0000000007c1ea8] __of_detach_node+0x8/0xa0
[ 4565.030808] LR [c0000000007c1fb4] of_detach_node+0x74/0xd0
[ 4565.030811] Call Trace:
[ 4565.030815] [c0000003f302b910] [c0000000007c1fa4] of_detach_node+0x64/0xd0 (unreliable)
[ 4565.030821] [c0000003f302b980] [c0000000000c33c4] dlpar_detach_node+0xb4/0x150
[ 4565.030826] [c0000003f302ba10] [c0000000000c3ffc] delete_dt_node+0x3c/0x80
[ 4565.030831] [c0000003f302ba40] [c0000000000c4380] pseries_devicetree_update+0x150/0x4f0
[ 4565.030836] [c0000003f302bb70] [c0000000000c479c] post_mobility_fixup+0x7c/0xf0
[ 4565.030841] [c0000003f302bbe0] [c0000000000c4908] migration_store+0xf8/0x130
[ 4565.030847] [c0000003f302bc70] [c000000000998160] kobj_attr_store+0x30/0x60
[ 4565.030852] [c0000003f302bc90] [c000000000412f14] sysfs_kf_write+0x64/0xa0
[ 4565.030857] [c0000003f302bcb0] [c000000000411cac] kernfs_fop_write+0x16c/0x240
[ 4565.030862] [c0000003f302bd00] [c000000000355f20] __vfs_write+0x40/0x220
[ 4565.030867] [c0000003f302bd90] [c000000000356358] vfs_write+0xc8/0x240
[ 4565.030872] [c0000003f302bde0] [c0000000003566cc] ksys_write+0x5c/0x100
[ 4565.030880] [c0000003f302be30] [c00000000000b288] system_call+0x5c/0x70
[ 4565.030884] Instruction dump:
[ 4565.030887] 38210070 38600000 e8010010 eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 ebe1fff8
[ 4565.030895] 7c0803a6 4e800020 e9230098 7929f7e2 <0b090000> 2f890000 4cde0020 e9030040
[ 4565.030903] ---[ end trace 5bd54cb1df9d2976 ]---

The mobility.c code continues on during the second migration, accepts
the definitions of the new nodes from the PHYP and ends up renaming
the new properties e.g.

[ 4565.827296] Duplicate name in base, renamed to "ibm,platform-facilities#1"

There is no check like 'of_node_check_flag(np, OF_DETACHED)' within
of_find_node_by_phandle to skip nodes that are detached, but still
present due to caching or use count considerations.  Also, note that
of_find_node_by_phandle also uses a 'phandle_cache' which does not
appear to be updated when of_detach_node() is invoked.

We don't appear to have anything that invalidates the phandle_cache
when a node is removed.

The right solution may be for __of_detach_node() to invalidate
phandle_cache for the node being detached.  Alternatively, we can
manually invalidate / rebuild the phandle_cache at the point of
LPAR migration.  The latter solution is presented here.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v03:
  -- Move private prototypes of phandle cache build functions to public
     header file.
---
 arch/powerpc/platforms/pseries/mobility.c |    4 ++++
 drivers/of/of_private.h                   |    2 --
 include/linux/of.h                        |    3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 2f78890..7da222d 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -341,6 +341,8 @@ void post_mobility_fixup(void)
 	if (rc)
 		printk(KERN_ERR "Post-mobility activate-fw failed: %d\n", rc);
 
+	of_free_phandle_cache();
+
 	rc = pseries_devicetree_update(MIGRATION_SCOPE);
 	if (rc)
 		printk(KERN_ERR "Post-mobility device tree update "
@@ -349,6 +351,8 @@ void post_mobility_fixup(void)
 	/* Possibly switch to a new RFI flush type */
 	pseries_setup_rfi_flush();
 
+	of_populate_phandle_cache();
+
 	return;
 }
 
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 216175d..891d780 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -79,8 +79,6 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
 void of_overlay_mutex_unlock(void);
-int of_free_phandle_cache(void);
-void of_populate_phandle_cache(void);
 #else
 static inline void of_overlay_mutex_lock(void) {};
 static inline void of_overlay_mutex_unlock(void) {};
diff --git a/include/linux/of.h b/include/linux/of.h
index 99b0ebf..482fc52 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1441,4 +1441,7 @@ static inline int of_overlay_notifier_unregister(struct notifier_block *nb)
 
 #endif
 
+int of_free_phandle_cache(void);
+void of_populate_phandle_cache(void);
+
 #endif /* _LINUX_OF_H */

