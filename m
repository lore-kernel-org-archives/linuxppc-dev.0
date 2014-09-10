Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9254C1A004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 22:36:46 +1000 (EST)
Message-ID: <541045D6.3070609@suse.de>
Date: Wed, 10 Sep 2014 14:36:38 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2 v6] powerpc/kvm: common sw breakpoint instr across ppc
References: <1410282456-11287-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1410282456-11287-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1410282456-11287-3-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09.09.14 19:07, Madhavan Srinivasan wrote:
> This patch extends the use of illegal instruction as software
> breakpoint instruction across the ppc platform. Patch extends
> booke program interrupt code to support software breakpoint.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
> Patch is only compile tested. Will really help if
> someone can try it out and let me know the comments.

I've squashed the following patch into this one to make it work on booke hv.

Alex


diff --git a/arch/powerpc/kvm/bookehv_interrupts.S
b/arch/powerpc/kvm/bookehv_interrupts.S
index c8e4da5..81bd8a0 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -238,7 +238,7 @@ kvm_handler BOOKE_INTERRUPT_EXTERNAL, EX_PARAMS(GEN), \
 kvm_handler BOOKE_INTERRUPT_ALIGNMENT, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1,(NEED_DEAR | NEED_ESR)
 kvm_handler BOOKE_INTERRUPT_PROGRAM, EX_PARAMS(GEN), \
-	SPRN_SRR0, SPRN_SRR1,NEED_ESR
+	SPRN_SRR0, SPRN_SRR1, (NEED_ESR | NEED_EMU)
 kvm_handler BOOKE_INTERRUPT_FP_UNAVAIL, EX_PARAMS(GEN), \
 	SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_AP_UNAVAIL, EX_PARAMS(GEN), \
@@ -348,7 +348,7 @@ kvm_handler BOOKE_INTERRUPT_INST_STORAGE, SPRN_SRR0,
SPRN_SRR1, NEED_ESR
 kvm_handler BOOKE_INTERRUPT_EXTERNAL, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_ALIGNMENT, \
 	SPRN_SRR0, SPRN_SRR1, (NEED_DEAR | NEED_ESR)
-kvm_handler BOOKE_INTERRUPT_PROGRAM, SPRN_SRR0, SPRN_SRR1, NEED_ESR
+kvm_handler BOOKE_INTERRUPT_PROGRAM, SPRN_SRR0, SPRN_SRR1, (NEED_ESR |
NEED_EMU)
 kvm_handler BOOKE_INTERRUPT_FP_UNAVAIL, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_SYSCALL, SPRN_SRR0, SPRN_SRR1, 0
 kvm_handler BOOKE_INTERRUPT_AP_UNAVAIL, SPRN_SRR0, SPRN_SRR1, 0
