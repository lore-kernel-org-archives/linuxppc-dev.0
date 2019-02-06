Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F36C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 13:28:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2AEA20B1F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 13:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2AEA20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vj2Y5BR7zDqQl
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 00:28:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vj0Z5pLyzDqQS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 00:27:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43vj0Z4DrRz9sML; Thu,  7 Feb 2019 00:27:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43vj0Z3hDsz9sMl; Thu,  7 Feb 2019 00:27:10 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Fix memcmp reading past the end of src/dest
Date: Thu,  7 Feb 2019 00:27:05 +1100
Message-Id: <20190206132705.11331-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: chandan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Chandan reported that fstests' generic/026 test hit a crash:

  BUG: Unable to handle kernel data access at 0xc00000062ac40000
  Faulting instruction address: 0xc000000000092240
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
  CPU: 0 PID: 27828 Comm: chacl Not tainted 5.0.0-rc2-next-20190115-00001-g6de6dba64dda #1
  NIP:  c000000000092240 LR: c00000000066a55c CTR: 0000000000000000
  REGS: c00000062c0c3430 TRAP: 0300   Not tainted  (5.0.0-rc2-next-20190115-00001-g6de6dba64dda)
  MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000842  XER: 20000000
  CFAR: 00007fff7f3108ac DAR: c00000062ac40000 DSISR: 40000000 IRQMASK: 0
  GPR00: 0000000000000000 c00000062c0c36c0 c0000000017f4c00 c00000000121a660
  GPR04: c00000062ac3fff9 0000000000000004 0000000000000020 00000000275b19c4
  GPR08: 000000000000000c 46494c4500000000 5347495f41434c5f c0000000026073a0
  GPR12: 0000000000000000 c0000000027a0000 0000000000000000 0000000000000000
  GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
  GPR20: c00000062ea70020 c00000062c0c38d0 0000000000000002 0000000000000002
  GPR24: c00000062ac3ffe8 00000000275b19c4 0000000000000001 c00000062ac30000
  GPR28: c00000062c0c38d0 c00000062ac30050 c00000062ac30058 0000000000000000
  NIP memcmp+0x120/0x690
  LR  xfs_attr3_leaf_lookup_int+0x53c/0x5b0
  Call Trace:
    xfs_attr3_leaf_lookup_int+0x78/0x5b0 (unreliable)
    xfs_da3_node_lookup_int+0x32c/0x5a0
    xfs_attr_node_addname+0x170/0x6b0
    xfs_attr_set+0x2ac/0x340
    __xfs_set_acl+0xf0/0x230
    xfs_set_acl+0xd0/0x160
    set_posix_acl+0xc0/0x130
    posix_acl_xattr_set+0x68/0x110
    __vfs_setxattr+0xa4/0x110
    __vfs_setxattr_noperm+0xac/0x240
    vfs_setxattr+0x128/0x130
    setxattr+0x248/0x600
    path_setxattr+0x108/0x120
    sys_setxattr+0x28/0x40
    system_call+0x5c/0x70
  Instruction dump:
  7d201c28 7d402428 7c295040 38630008 38840008 408201f0 4200ffe8 2c050000
  4182ff6c 20c50008 54c61838 7d201c28 <7d402428> 7d293436 7d4a3436 7c295040

The instruction dump decodes as:
  subfic  r6,r5,8
  rlwinm  r6,r6,3,0,28
  ldbrx   r9,0,r3
  ldbrx   r10,0,r4	<-

Which shows us doing an 8 byte load from c00000062ac3fff9, which
crosses the page boundary at c00000062ac40000 and faults.

It's not OK for memcmp to read past the end of the source or
destination buffers.

The bug is in the code at the .Lcmp_rest_lt8bytes label. To fix it
test if we have at least 4 bytes to compare and if so do a 4 byte load
and compare. Otherwise, and/or if we have anything left, jump to the
existing code that does byte at a time comparison.

Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
Tested-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/memcmp_64.S | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
index 844d8e774492..cf7c7a8ed310 100644
--- a/arch/powerpc/lib/memcmp_64.S
+++ b/arch/powerpc/lib/memcmp_64.S
@@ -215,20 +215,29 @@ _GLOBAL_TOC(memcmp)
 	beq	.Lzero
 
 .Lcmp_rest_lt8bytes:
-	/* Here we have only less than 8 bytes to compare with. at least s1
-	 * Address is aligned with 8 bytes.
-	 * The next double words are load and shift right with appropriate
-	 * bits.
+	/*
+	 * Here we have less than 8 bytes left to compare with. We mustn't read
+	 * past the end of either source or dest.
 	 */
-	subfic  r6,r5,8
-	slwi	r6,r6,3
-	LD	rA,0,r3
-	LD	rB,0,r4
-	srd	rA,rA,r6
-	srd	rB,rB,r6
-	cmpld	cr0,rA,rB
+
+	/* If we have less than 4 bytes, just do byte at a time */
+	cmpwi   cr1, r5, 4
+	blt	cr1, .Lshort
+
+	/* Compare 4 bytes */
+	LW	rA,0,r3
+	LW	rB,0,r4
+	cmplw	cr0,rA,rB
 	bne	cr0,.LcmpAB_lightweight
-	b	.Lzero
+
+	/* If we had exactly 4 bytes left, we're done now */
+	beq	cr1, .Lzero
+
+	/* Otherwise do what ever's left a byte at a time */
+	subi	r5, r5, 4
+	addi	r3, r3, 4
+	addi	r4, r4, 4
+	b	.Lshort
 
 .Lnon_zero:
 	mr	r3,rC
-- 
2.20.1

