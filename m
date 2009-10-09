Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53407B7BA2
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 23:31:42 +1100 (EST)
In-Reply-To: <20091009064649.GA9660@compile2.chatsunix.int.mrv.com>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091009001527.GA6196@compile2.chatsunix.int.mrv.com>
	<OF505AFA1E.D2D84793-ONC125764A.0020E20A-C125764A.00210186@transmode.se>
	<20091009064649.GA9660@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH 0/6] 8xx MMU fixes
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OFD3D0374D.3D52F341-ONC125764A.004414DA-C125764A.0044B29A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 9 Oct 2009 14:30:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rex Feany <RFeany@mrv.com> wrote on 09/10/2009 08:46:49:
>
> Thus spake Joakim Tjernlund (joakim.tjernlund@transmode.se):
>
> > Rex Feany <RFeany@mrv.com> wrote on 09/10/2009 02:15:27:
>
> > > open("/proc/mounts", O_RDONLY)          = 3
> > > fstat64(0x3, 0x7fe7e2a8)                = 0
> > > mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =0x3001f000
> > > read(3, 0x3001f000, 1024)               = -1 EFAULT (Bad address)
> > > exit_group(0)                           = ?
> >
> > Try making the tlbil_va in fault.c unconditional, just to make sure
> > there isn't any old TLBs  around.
>
> didn't make a difference

Perhaps you are suffering from a buggy dcbst insn? I tested it
on a RO mapping and it SEGVs. Clearing the store bit manually
at least fixes the SEGVs.

Here is a patch for that.

     Jocke

>From 07dbca0cf9dc13cf0fbccf54d577e3bc1c5dfdf1 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 9 Oct 2009 14:18:21 +0200
Subject: [PATCH] 8xx: dcbst sets store bit in DTLB error, workaround.

dcbst should not set the store bit(bit 6, DSISR) when
trapping into a DTLB Error. Clear this bit while doing
the dcbX missing DAR workaround.
---
 arch/powerpc/kernel/head_8xx.S |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 292bd87..7b31feb 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -630,6 +630,30 @@ FixDAR:	/* Entry point for dcbx workaround. */
 	tophys  (r11, r10)
 	beq-	139b		/* Branch if user space address */
 140:	lwz	r11,0(r11)
+/* Check if it really is a dcbx instruction. */
+/* dcbt and dcbtst does not generate DTLB Misses/Errors,
+ * no need to include them here */
+	srwi	r10, r11, 26	/* check if major OP code is 31 */
+	cmpwi	cr0, r10, 31
+	bne-	141f
+	rlwinm	r10, r11, 0, 21, 30
+	cmpwi	cr0, r10, 2028	/* Is dcbz? */
+	beq+	142f
+	cmpwi	cr0, r10, 940	/* Is dcbi? */
+	beq+	142f
+	cmpwi	cr0, r10, 108	/* Is dcbst? */
+	beq+	144f		/* Fix up store bit! */
+	cmpwi	cr0, r10, 172	/* Is dcbf? */
+	beq+	142f
+	cmpwi	cr0, r10, 1964	/* Is icbi? */
+	beq+	142f
+141:	mfspr	r10, SPRN_DAR	/* r10 must hold DAR at exit */
+	b	DARfix		/* Nope, go back to normal TLB processing */
+
+144:	mfspr	r10, SPRN_DSISR
+	rlwinm	r10, r10,0,7,5	/* Clear store bit for buggy dcbst insn */
+	mtspr	SPRN_DSISR, r10
+142:	/* continue, it was a dcbx, dcbi instruction. */
 #ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)	/* restore r3 from memory */
 #endif
--
1.6.4.4
