Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD737B7B9D
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 22:06:32 +1100 (EST)
In-Reply-To: <20091009064649.GA9660@compile2.chatsunix.int.mrv.com>
References: <1255008298-19949-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091009001527.GA6196@compile2.chatsunix.int.mrv.com>
	<OF505AFA1E.D2D84793-ONC125764A.0020E20A-C125764A.00210186@transmode.se>
	<20091009064649.GA9660@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH 0/6] 8xx MMU fixes
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OFDEC75DA5.7C7664B8-ONC125764A.003C37C9-C125764A.003CE1A4@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 9 Oct 2009 13:04:59 +0200
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

OK, so how about:
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 6541855..f4b5dca 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -339,9 +339,9 @@ InstructionTLBMiss:
 	mfspr	r11, SPRN_MD_TWC	/* ....and get the pte address */
 	lwz	r10, 0(r11)	/* Get the pte */

-	/* r10=(r10&~_PAGE_PRESENT)|((r10&_PAGE_ACCESSED)>>5) */
-	rlwimi.	r10, r10, 27, 31, 31
-	beq-	cr0, 2f /* Can be removed, costs a ITLB Err */
+	andi.	r11, r10, _PAGE_ACCESSED | _PAGE_PRESENT
+	cmpwi	cr0, r11, _PAGE_ACCESSED | _PAGE_PRESENT
+	bne-	cr0, 2f

 #if 0 	/* Dont' bother with PP lsb, bit 21 for now */
 	/* r10 = (r10 & ~0x0400) | ((r10 & _PAGE_EXEC) << 7) */
@@ -429,9 +429,11 @@ DataStoreTLBMiss:
 	/* Need to know if load/store -> force a TLB Error
 	 * by copying ACCESSED to PRESENT.
 	*/
-	/* r10=(r10&~_PAGE_PRESENT)|((r10&_PAGE_ACCESSED)>>5) */
-	rlwimi	r10, r10, 27, 31, 31
-
+	andi.	r11, r10, _PAGE_ACCESSED | _PAGE_PRESENT
+	cmpwi	cr0, r11, _PAGE_ACCESSED | _PAGE_PRESENT
+	beq+	cr0, 6f
+	rlwinm	r10, r10, 0, 0, 30 /* Clear _PAGE_PRESENT */
+6:
 #if 0 /* Not yet */
 	/* Honour kernel RO, User NA */
 	andi.	r11, r10, _PAGE_USER | _PAGE_RW
@@ -492,7 +494,7 @@ DataTLBError:
 	cmpwi	cr0, r10, 0x00f0
 	beq-	FixDAR	/* must be a buggy dcbX, icbi insn. */
 DARFix:	/* Return from dcbx instruction bug workaround, r10 holds value of DAR */
-
+	b	2f /* Do DIRTY in C */
 	mfspr	r11, SPRN_DSISR
 	andis.	r11, r11, 0x4800	/* !translation or protection */
 	bne	2f	/* branch if either is set */
