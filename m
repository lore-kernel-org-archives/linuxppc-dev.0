Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsPTL3w3fzDqcK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 06:38:30 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2RJSeID109623
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:38:20 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29f7p1bypc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 15:38:20 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 01:08:17 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2RJcA2m17760424
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:08:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2RJcCWb032626
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 01:08:14 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Subject: [PATCH 2/2] powerpc: bpf: use memset32() to pre-fill traps in BPF
 page(s)
Date: Tue, 28 Mar 2017 01:07:41 +0530
In-Reply-To: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <b8df164016428d3313925cbb223416da71e81171.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the newly introduced memset32() to pre-fill BPF page(s) with trap
instructions.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index aee2bb817ac6..1a92ab6c245f 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -25,11 +25,7 @@ int bpf_jit_enable __read_mostly;
 
 static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
 {
-	int *p = area;
-
-	/* Fill whole space with trap instructions */
-	while (p < (int *)((char *)area + size))
-		*p++ = BREAKPOINT_INSTRUCTION;
+	memset32(area, BREAKPOINT_INSTRUCTION, size/4);
 }
 
 static inline void bpf_flush_icache(void *start, void *end)
-- 
2.11.1
