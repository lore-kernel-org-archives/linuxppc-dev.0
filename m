Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 164BFB7B72
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 23:03:26 +1100 (EST)
In-Reply-To: <OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
Message-ID: <OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 17 Oct 2009 14:01:38 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund/Transmode wrote on 17/10/2009 13:24:18:
>
> Rex Feany <RFeany@mrv.com> wrote on 16/10/2009 22:25:41:
> >
> > Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
> >
> > > Right, it is the pte table walk that is blowing up.
> > > I just noted that 2.6 lacks a tophys() call in its table walk
> > > so I removed that one(there is one more tophys call but I don't think
> > > it should be removed).
> > > Try this addon patch:
> >
> > no difference

> OK, thinking a bit more, this part should not be executed as
> copy_tofrom_user executes in kernel space.
>
> Any chance you can stick a HW breakpoint on FixupDAR?
> Perhaps there is something different with kernel
> virtual address to phys address?
> A simple topys() works in 2.4, but perhaps not in 2.6?
> this is the part of interest:
> FixupDAR: /* Entry point for dcbx workaround. */
>  /* fetch instruction from memory. */
>  mfspr r10, SPRN_SRR0
>  andis. r11, r10, 0x8000
>  tophys  (r11, r10)
>  beq- 139b  /* Branch if user space address */
> 140: lwz r11,0(r11)

Probably better to walk the kernel page table too. Does this
make a difference(needs the tophys() patch I posted earlier):


>From 862dda30c3d3d3bedcc605e8520626408a26891c Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Sat, 17 Oct 2009 13:54:03 +0200
Subject: [PATCH] 8xx: Walk the page table for kernel addresses too.

---
 arch/powerpc/kernel/head_8xx.S |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 0e91da4..edc9e9b 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -532,28 +532,27 @@ DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR
  * by decoding the registers used by the dcbx instruction and adding them.
  * DAR is set to the calculated address and r10 also holds the EA on exit.
  */
-#define NO_SELF_MODIFYING_CODE /* define if you don't want to use self modifying code */
-     nop	/* A few nops to make the modified_instr: space below cache line aligned */
-     nop
-139:	/* fetch instruction from userspace memory */
+ /* define if you don't want to use self modifying code */
+#define NO_SELF_MODIFYING_CODE
+FixupDAR:/* Entry point for dcbx workaround. */
+	/* fetch instruction from memory. */
+     mfspr r10, SPRN_SRR0
      DO_8xx_CPU6(0x3780, r3)
      mtspr SPRN_MD_EPN, r10
      mfspr r11, SPRN_M_TWB	/* Get level 1 table entry address */
-     lwz   r11, 0(r11)	/* Get the level 1 entry */
+     cmplwi      cr0, r11, 0x0800
+     blt-  3f		/* Branch if user space */
+     lis   r11, swapper_pg_dir@h
+     ori   r11, r11, swapper_pg_dir@l
+     rlwimi      r11, r11, 0, 2, 19
+3:   lwz   r11, 0(r11)	/* Get the level 1 entry */
      DO_8xx_CPU6(0x3b80, r3)
      mtspr SPRN_MD_TWC, r11	/* Load pte table base address */
      mfspr r11, SPRN_MD_TWC	/* ....and get the pte address */
      lwz   r11, 0(r11)	/* Get the pte */
      /* concat physical page address(r11) and page offset(r10) */
      rlwimi      r11, r10, 0, 20, 31
-     b     140f
-FixupDAR:	/* Entry point for dcbx workaround. */
-	/* fetch instruction from memory. */
-     mfspr r10, SPRN_SRR0
-     andis.      r11, r10, 0x8000
-     tophys  (r11, r10)
-     beq-  139b		/* Branch if user space address */
-140: lwz   r11,0(r11)
+     lwz   r11,0(r11)
 /* Check if it really is a dcbx instruction. */
 /* dcbt and dcbtst does not generate DTLB Misses/Errors,
  * no need to include them here */
--
1.6.4.4
