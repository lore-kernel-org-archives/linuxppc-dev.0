Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwktP2zjhzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 06:53:33 +1000 (AEST)
Date: Sun, 25 Jun 2017 21:53:24 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: gcc 4.6.3 miscompile on ppc32 (was Re: Regression in kernel 4.12-rc1
 for Powerpc 32 - bisected to commit 3448890c32c3)
Message-ID: <20170625205324.GW10672@ZenIV.linux.org.uk>
References: <20170621213415.GO10672@ZenIV.linux.org.uk>
 <655d304e-e455-6e0c-56e1-f127653ea13c@lwfinger.net>
 <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
 <20170623202943.GS10672@ZenIV.linux.org.uk>
 <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
 <20170625095351.GU10672@ZenIV.linux.org.uk>
 <20170625111404.GV10672@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <20170625111404.GV10672@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 25, 2017 at 12:14:04PM +0100, Al Viro wrote:
> On Sun, Jun 25, 2017 at 10:53:58AM +0100, Al Viro wrote:
> > On Sat, Jun 24, 2017 at 12:29:23PM -0500, Larry Finger wrote:
> > 
> > > I made a break through. If I turn off inline copy to/from users for 32-bit
> > > ppc with the following patch, then the system boots:
> > 
> > OK...  So it's 4.6.3 miscompiling something - it is hardware-independent,
> > reproduced in qemu.  I'd like to get more self-contained example of
> > miscompile, though; should be done by tonight...
> 
> OK, it's the call in rw_copy_check_uvector(); with INLINE_COPY_FROM_USER
> it's miscompiled by 4.6.3.  I hadn't looked through the generated code
> yet; will do that after I grab some sleep.

Confirmed.  It manages to bugger the loop immediately after the (successful)
copying of iovec array in rw_copy_check_uvector(); both with and without
INLINE_COPY_FROM_USER it has (just before the call of copy_from_user()) r27
set to nr_segs * sizeof(struct iovec).  The call is made, we check that it
has succeeded and that's when it hits the fan: without INLINE_COPY_FROM_USER
we have (interleaved with unrelated insns)
        addi 27,27,-8
        srwi 27,27,3
        addi 27,27,1
        mtctr 27
Weird, but manages to pass nr_segs to mtctr.  _With_ INLINE_COPY_FROM_USER we
get this:
        lis 9,0x2000
        mtctr 9
In other words, the loop will try to go through 8192 iterations.  No idea where
that number has come from, but it sure as hell is wrong.  That's where those
-EINVAL, etc. are coming from - we run into something negative in iov[seg].len,
after having run out of on-stack iovec array.

	Assembler generated out of rw_copy_check_uvector() with and without
INLINE_COPY_FROM_USER is attached; it's a definite miscompile.  Neither 4.4.5
nor 6.3.0 use mtctr/bdnz for that loop.

	The bottom line is, ppc cross-toolchain on kernel.org happens to be
the version that miscompiles rw_copy_check_uvector() with INLINE_COPY_FROM_USER
and hell knows what else.  Said that, I would rather have ppc32 drop the
INLINE_COPY_{TO,FROM}_USER anyway; that won't fix any other places where
the same 4.6.3 bug hits, but I seriously suspect that it will end up being
faster even on non^Wless buggy gcc versions.  Could powerpc folks check
what does removing those two defines from arch/powerpc/include/asm/uaccess.h
do to performance?  If there's no slowdown, I would strongly recommend just
removing those as in the patch Larry has posted upthread.

	Fixing whatever it is in gcc 4.6.3 that triggers that behaviour is
IMO pointless - it might make sense to switch kernel.org cross-toolchain to
something more recent, but that's it.

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Description: rw_copy_check_uvector() with INLINE_COPY_FROM_USER
Content-Disposition: attachment; filename="inlined.s"

	.globl rw_copy_check_uvector
	.type	rw_copy_check_uvector, @function
rw_copy_check_uvector:
.LFB2683:
	.loc 1 773 0
	stwu 1,-32(1)	 #,,
.LCFI142:
	mflr 0	 #,
.LCFI143:
	stmw 27,12(1)	 #,
.LCFI144:
	.loc 1 783 0
	mr. 27,5	 # nr_segs, nr_segs
	.loc 1 773 0
	mr 30,3	 # type, type
	stw 0,36(1)	 #,
.LCFI145:
	.loc 1 773 0
	mr 31,4	 # uvector, uvector
	mr 29,8	 # ret_pointer, ret_pointer
	.loc 1 776 0
	mr 28,7	 # iov, fast_pointer
	.loc 1 784 0
	li 0,0	 # ret,
	.loc 1 783 0
	beq- 0,.L495	 #
	.loc 1 792 0
	cmplwi 7,27,1024	 #, tmp160, nr_segs
	.loc 1 793 0
	li 0,-22	 # ret,
	.loc 1 792 0
	bgt- 7,.L495	 #
	.loc 1 796 0
	cmplw 7,27,6	 # fast_segs, tmp161, nr_segs
	ble- 7,.L496	 #
.LBB1538:
.LBB1539:
	.file 21 "./include/linux/slab.h"
	.loc 21 495 0
	lis 4,0x140	 # tmp190,
	slwi 3,27,3	 #, nr_segs,
	ori 4,4,192	 #,, tmp190,
	bl __kmalloc	 #
.LBE1539:
.LBE1538:
	.loc 1 799 0
	li 0,-12	 # ret,
	.loc 1 798 0
	mr. 28,3	 # iov,
	beq- 0,.L495	 #
.L496:
.LBB1540:
.LBB1541:
.LBB1542:
.LBB1543:
	.loc 19 113 0
	lwz 0,1128(2)	 # current.192_185->thread.fs.seg, D.39493
.LBE1543:
.LBE1542:
.LBE1541:
.LBE1540:
	.loc 1 803 0
	slwi 27,27,3	 # n, nr_segs,
.LBB1549:
.LBB1548:
.LBB1547:
.LBB1546:
	mr 5,27	 # n, n
	.loc 19 113 0
	cmplw 7,31,0	 # D.39493, tmp165, uvector
	bgt- 7,.L497	 #
	addi 9,27,-1	 # tmp166, n,
	subf 0,31,0	 # tmp167, uvector, D.39493
	cmplw 7,9,0	 # tmp167, tmp168, tmp166
	bgt- 7,.L497	 #
.LBB1544:
.LBB1545:
	.file 22 "./arch/powerpc/include/asm/uaccess.h"
	.loc 22 305 0
	mr 3,28	 #, iov
	mr 4,31	 #, uvector
	bl __copy_tofrom_user	 #
.LBE1545:
.LBE1544:
	.loc 19 115 0
	mr. 5,3	 # n,
	beq+ 0,.L498	 #
.L497:
	.loc 19 116 0
	subf 3,5,27	 # tmp170, n, n
	li 4,0	 #,
	add 3,28,3	 #, iov, tmp170
	bl memset	 #
	b .L510	 #
.L498:
.LBE1546:
.LBE1547:
.LBE1548:
.LBE1549:
.LBB1550:
	.loc 1 833 0
	lis 9,0x2000	 #,
	.loc 1 828 0
	cmpwi 6,30,0	 #, tmp186, type
	.loc 1 833 0
	lis 6,0x7fff	 # tmp189,
	mtctr 9	 # tmp188,
	.loc 1 829 0
	mr 5,2	 # current.121, current
	li 8,0	 # ivtmp.533,
	li 0,0	 # ret,
	.loc 1 833 0
	ori 6,6,61440	 #, tmp187, tmp189,
.L501:
	.loc 1 819 0
	mr 11,28	 # D.40168, iov
	lwzux 10,11,8	 # MEM[base: iov_4, index: ivtmp.533_176, offset: 0B], buf
	.loc 1 820 0
	lwz 9,4(11)	 # MEM[base: D.40168_211, offset: 4B], len
	.loc 1 824 0
	cmpwi 7,9,0	 #, tmp175, len
	blt- 7,.L508	 #
	.loc 1 828 0
	blt- 6,.L499	 #
	.loc 1 829 0
	lwz 7,1128(5)	 # current.121_33->thread.fs.seg, D.36573
	cmplw 1,10,7	 # D.36573, tmp177, buf
	bgt- 1,.L510	 #
	.loc 1 829 0 is_stmt 0 discriminator 1
	beq- 7,.L499	 #
	.loc 1 829 0 discriminator 4
	addi 4,9,-1	 # tmp179, len,
	subf 10,10,7	 # tmp180, buf, D.36573
	cmplw 7,4,10	 # tmp180, tmp181, tmp179
	bgt- 7,.L510	 #
.L499:
	.loc 1 833 0 is_stmt 1
	subf 10,0,6	 # len, ret, tmp187
	cmpw 7,9,10	 # len, tmp183, len
	ble- 7,.L500	 #
	.loc 1 835 0
	stw 10,4(11)	 # MEM[base: D.40168_211, offset: 4B], len
	mr 9,10	 # len, len
.L500:
	.loc 1 837 0
	add 0,0,9	 # ret, ret, len
	addi 8,8,8	 # ivtmp.533, ivtmp.533,
.LBE1550:
	.loc 1 818 0
	bdnz .L501	 #
	b .L495	 #
.L508:
.LBB1551:
	.loc 1 825 0
	li 0,-22	 # ret,
	b .L495	 #
.L510:
	.loc 1 830 0
	li 0,-14	 # ret,
.L495:
.LBE1551:
	.loc 1 842 0
	addi 11,1,32	 #,,
	.loc 1 840 0
	stw 28,0(29)	 # *ret_pointer_53(D), iov
	.loc 1 842 0
	mr 3,0	 #, ret
	b _restgpr_27_x	 #
.LFE2683:
	.size	rw_copy_check_uvector,.-rw_copy_check_uvector

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Description: the same without INLINE_COPY_FROM_USER
Content-Disposition: attachment; filename="uninlined.s"

	.globl rw_copy_check_uvector
	.type	rw_copy_check_uvector, @function
rw_copy_check_uvector:
.LFB2683:
	.loc 1 773 0
	stwu 1,-32(1)	 #,,
.LCFI142:
	mflr 0	 #,
.LCFI143:
	stmw 27,12(1)	 #,
.LCFI144:
	.loc 1 783 0
	mr. 27,5	 # nr_segs, nr_segs
	.loc 1 773 0
	mr 31,3	 # type, type
	stw 0,36(1)	 #,
.LCFI145:
	.loc 1 773 0
	mr 30,4	 # uvector, uvector
	mr 29,8	 # ret_pointer, ret_pointer
	.loc 1 776 0
	mr 28,7	 # iov, fast_pointer
	.loc 1 784 0
	li 0,0	 # ret,
	.loc 1 783 0
	beq- 0,.L495	 #
	.loc 1 792 0
	cmplwi 7,27,1024	 #, tmp151, nr_segs
	.loc 1 793 0
	li 0,-22	 # ret,
	.loc 1 792 0
	bgt- 7,.L495	 #
	.loc 1 796 0
	cmplw 7,27,6	 # fast_segs, tmp152, nr_segs
	ble- 7,.L496	 #
.LBB1516:
.LBB1517:
	.file 21 "./include/linux/slab.h"
	.loc 21 495 0
	lis 4,0x140	 # tmp175,
	slwi 3,27,3	 #, nr_segs,
	ori 4,4,192	 #,, tmp175,
	bl __kmalloc	 #
.LBE1517:
.LBE1516:
	.loc 1 799 0
	li 0,-12	 # ret,
	.loc 1 798 0
	mr. 28,3	 # iov,
	beq- 0,.L495	 #
.L496:
	.loc 1 803 0
	slwi 27,27,3	 # n, nr_segs,
.LBB1518:
.LBB1519:
	.loc 19 153 0
	mr 3,28	 #, iov
	mr 4,30	 #, uvector
	mr 5,27	 #, n
	bl _copy_from_user	 #
.LBE1519:
.LBE1518:
	.loc 1 804 0
	li 0,-14	 # ret,
	.loc 1 803 0
	cmpwi 7,3,0	 #, tmp156,
	bne- 7,.L495	 #
.LBB1520:
	.loc 1 833 0
	addi 27,27,-8	 # tmp172, n,
	.loc 1 828 0
	cmpwi 6,31,0	 #, tmp168, type
	.loc 1 833 0
	srwi 27,27,3	 # tmp173, tmp172,
	lis 6,0x7fff	 # tmp174,
	addi 27,27,1	 #, tmp173,
	.loc 1 829 0
	mr 5,2	 # current.121, current
	.loc 1 833 0
	mtctr 27	 # tmp170,
	.loc 1 829 0
	li 8,0	 # ivtmp.528,
	li 0,0	 # ret,
	.loc 1 833 0
	ori 6,6,61440	 #, tmp169, tmp174,
.L499:
	.loc 1 819 0
	mr 11,28	 # D.40034, iov
	lwzux 10,11,8	 # MEM[base: iov_4, index: ivtmp.528_176, offset: 0B], buf
	.loc 1 820 0
	lwz 9,4(11)	 # MEM[base: D.40034_183, offset: 4B], len
	.loc 1 824 0
	cmpwi 7,9,0	 #, tmp157, len
	blt- 7,.L505	 #
	.loc 1 828 0
	blt- 6,.L497	 #
	.loc 1 829 0
	lwz 7,1128(5)	 # current.121_33->thread.fs.seg, D.36573
	cmplw 1,10,7	 # D.36573, tmp159, buf
	bgt- 1,.L507	 #
	.loc 1 829 0 is_stmt 0 discriminator 1
	beq- 7,.L497	 #
	.loc 1 829 0 discriminator 4
	addi 4,9,-1	 # tmp161, len,
	subf 10,10,7	 # tmp162, buf, D.36573
	cmplw 7,4,10	 # tmp162, tmp163, tmp161
	bgt- 7,.L507	 #
.L497:
	.loc 1 833 0 is_stmt 1
	subf 10,0,6	 # len, ret, tmp169
	cmpw 7,9,10	 # len, tmp165, len
	ble- 7,.L498	 #
	.loc 1 835 0
	stw 10,4(11)	 # MEM[base: D.40034_183, offset: 4B], len
	mr 9,10	 # len, len
.L498:
	.loc 1 837 0
	add 0,0,9	 # ret, ret, len
	addi 8,8,8	 # ivtmp.528, ivtmp.528,
.LBE1520:
	.loc 1 818 0
	bdnz .L499	 #
	b .L495	 #
.L505:
.LBB1521:
	.loc 1 825 0
	li 0,-22	 # ret,
	b .L495	 #
.L507:
	.loc 1 830 0
	li 0,-14	 # ret,
.L495:
.LBE1521:
	.loc 1 842 0
	addi 11,1,32	 #,,
	.loc 1 840 0
	stw 28,0(29)	 # *ret_pointer_53(D), iov
	.loc 1 842 0
	mr 3,0	 #, ret
	b _restgpr_27_x	 #
.LFE2683:
	.size	rw_copy_check_uvector,.-rw_copy_check_uvector

--NzB8fVQJ5HfG6fxh--
