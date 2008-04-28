Return-Path: <mtk.manpages@googlemail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.234])
	by ozlabs.org (Postfix) with ESMTP id B6A88DE0E6
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:42:19 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id e11so2953370qbe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 08:42:18 -0700 (PDT)
Message-ID: <cfd18e0f0804280842q14aa0cb1ref0c8a775e7db83d@mail.gmail.com>
Date: Mon, 28 Apr 2008 17:42:18 +0200
From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
To: "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH] Add fast little-endian switch system call
In-Reply-To: <20080428144332.GA17109@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18453.18943.906693.409245@cargo.ozlabs.ibm.com>
	<20080428144332.GA17109@lst.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, mtk.manpages@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 4:43 PM, Christoph Hellwig <hch@lst.de> wrote:
> Please see Michael Kerrisk on userspace ABI updates.  A nice little
> manpage for this gimmick would be helpful, and maybe help other
> platforms that want one aswell to implement the same API.

Thanks Chrsitoph.  I'm not on any of these lists at the moment.

Paul -- is this syscall defintely going in?  Could you write a short
description for userland programmers?  I'll do the grotty *roff stuff.

> On Mon, Apr 28, 2008 at 01:52:31PM +1000, Paul Mackerras wrote:
> > This adds a system call on 64-bit platforms for switching between
> > little-endian and big-endian modes that is much faster than doing a
> > prctl call.  This system call is handled as a special case right at
> > the start of the system call entry code, and because it is a special
> > case, it uses a system call number which is out of the range of
> > normal system calls, namely 0x1ebe.
> >
> > Measurements with lmbench on a 4.2GHz POWER6 showed no measurable
> > change in the speed of normal system calls with this patch.
> >
> > Switching endianness with this new system call takes around 60ns on a
> > 4.2GHz POWER6, compared with around 300ns to switch endian mode with a
> > prctl.  This can provide a significant performance advantage for
> > emulators for little-endian architectures that want to switch between
> > big-endian and little-endian mode frequently, e.g. because they are
> > generating instructions sequences on the fly and they want to run
> > those sequences in little-endian mode.
> >
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > ---
> >
> > diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> > index 215973a..2eb49a7 100644
> > --- a/arch/powerpc/kernel/head_64.S
> > +++ b/arch/powerpc/kernel/head_64.S
> > @@ -239,6 +239,10 @@ instruction_access_slb_pSeries:
> >       .globl  system_call_pSeries
> >  system_call_pSeries:
> >       HMT_MEDIUM
> > +BEGIN_FTR_SECTION
> > +     cmpdi   r0,0x1ebe
> > +     beq-    1f
> > +END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
>
> Am I missing something here or does this add a branch for every normal
> syscall?
>
> >       mr      r9,r13
> >       mfmsr   r10
> >       mfspr   r13,SPRN_SPRG3
> > @@ -253,6 +257,13 @@ system_call_pSeries:
> >       rfid
> >       b       .       /* prevent speculative execution */
> >
> > +/* Fast LE/BE switch system call */
> > +1:   mfspr   r12,SPRN_SRR1
> > +     xori    r12,r12,MSR_LE
> > +     mtspr   SPRN_SRR1,r12
> > +     rfid            /* return to userspace */
> > +     b       .
> > +
> >       STD_EXCEPTION_PSERIES(0xd00, single_step)
> >       STD_EXCEPTION_PSERIES(0xe00, trap_0e)
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> ---end quoted text---
>



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
