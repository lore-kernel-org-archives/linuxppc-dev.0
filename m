Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B71E92C0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 11:41:01 +1100 (EST)
Message-ID: <1352940045.23412.38.camel@pasglop>
Subject: Re: [PATCH 1/6] powerpc: Move branch instruction from
 ACCOUNT_CPU_USER_ENTRY to caller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Thu, 15 Nov 2012 11:40:45 +1100
In-Reply-To: <1351666269.32304.12.camel@hbabu-laptop>
References: <1351666269.32304.12.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, anton@au1.ibm.com,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-30 at 23:51 -0700, Haren Myneni wrote:
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -159,8 +159,9 @@ exc_##n##_common:                                                       \
        std     r9,GPR9(r1);            /* save r9 in stackframe */         \
        std     r10,_NIP(r1);           /* save SRR0 to stackframe */       \
        std     r11,_MSR(r1);           /* save SRR1 to stackframe */       \
+       beq     1f                      /* if from kernel mode */

Missing semicolon

        ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */      \
-       ld      r3,excf+EX_R10(r13);    /* get back r10 */                  \
+1:     ld      r3,excf+EX_R10(r13);    /* get back r10 */                  \
        ld      r4,excf+EX_R11(r13);    /* get back r11 */                  \
        mfspr   r5,SPRN_SPRG_GEN_SCRATCH;/* get back r13 */                 \
        std     r12,GPR12(r1);          /* save r12 in stackframe */        \


Please , please, please ... at the very least TEST BUILD the stuff you
change... I'm fixing that one up here this time.

Ben.
