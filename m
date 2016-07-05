Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rk69f4LZWzDqpH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 11:43:50 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id ib6so948474pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 18:43:50 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au, Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v2] powerpc/mm: Add a parameter to disable 1TB segs
Date: Tue,  5 Jul 2016 11:43:21 +1000
Message-Id: <1467683001-32280-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the kernel command line parameter "no_tb_segs" which
forces the kernel to use 256MB rather than 1TB segments. Forcing the use
of 256MB segments makes it considerably easier to test code that depends
on an SLB miss occurring.

Suggested-by: Michael Neuling <mikey@neuling.org>
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
Changes in from v1:
	Renamed parameter from "no_tb_segs" to "disable_1tb_segments"
	Added kernel-parameters.txt entry

 Documentation/kernel-parameters.txt |  6 ++++++
 arch/powerpc/mm/hash_utils_64.c     | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 4640ea2dce9b..3be08fda82dd 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -920,6 +920,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	dhash_entries=	[KNL]
 			Set number of hash buckets for dentry cache.
 
+	disable_1tb_segments [PPC]
+			Disables the use of 1TB hash page table segments. This
+			causes the kernel to fall back to 256MB segments which
+			can be useful when debugging issues that require an SLB
+			miss to occur.
+
 	disable=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5b22ba0b58bc..7e6d38e01645 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -321,6 +321,15 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 	return ret;
 }
 
+static bool disable_1tb_segments = false;
+
+static int __init parse_disable_1tb_segments(char *p)
+{
+	disable_1tb_segments = true;
+	return 0;
+}
+early_param("disable_1tb_segments", parse_disable_1tb_segments);
+
 static int __init htab_dt_scan_seg_sizes(unsigned long node,
 					 const char *uname, int depth,
 					 void *data)
@@ -339,6 +348,12 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 	for (; size >= 4; size -= 4, ++prop) {
 		if (be32_to_cpu(prop[0]) == 40) {
 			DBG("1T segment support detected\n");
+
+			if (disable_1tb_segments) {
+				DBG("1T segments disabled by command line\n");
+				break;
+			}
+
 			cur_cpu_spec->mmu_features |= MMU_FTR_1T_SEGMENT;
 			return 1;
 		}
-- 
2.5.5
