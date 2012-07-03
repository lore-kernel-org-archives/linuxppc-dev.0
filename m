Return-Path: <B08248@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AA202C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 01:07:57 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH][v2] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
Date: Tue, 3 Jul 2012 15:07:47 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503398D2C@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1341263667-29875-1-git-send-email-stuart.yoder@freescale.com>
 <EB9E2FD4-8867-4E9D-93F9-B8EE3284F37A@suse.de>
In-Reply-To: <EB9E2FD4-8867-4E9D-93F9-B8EE3284F37A@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Monday, July 02, 2012 4:16 PM
> To: Yoder Stuart-B08248
> Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH][v2] PPC: use CURRENT_THREAD_INFO instead of open cod=
ed assembly
>=20
>=20
> On 02.07.2012, at 23:14, Stuart Yoder wrote:
>=20
> > From: Stuart Yoder <stuart.yoder@freescale.com>
> >
> > Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> > ---
> >
> > -this patch is a pre-requisite for the idle hcall which I
> > am trying to get into Alex's KVM tree, so ideally would like
> > Ben's ack and get this applied to Alex's tree
> >
> > -built/tested with a 32-bit booke kernel, built a 64-bit
> > booke kernel
> >
> > -v2
> >   -moved CURRENT_THREAD_INFO under assembly only
> >    #ifdef
> >
> > arch/powerpc/include/asm/exception-64s.h |    4 ++--
> > arch/powerpc/include/asm/thread_info.h   |    8 ++++++++
> > arch/powerpc/kernel/entry_32.S           |   24 ++++++++++++-----------=
-
> > arch/powerpc/kernel/entry_64.S           |   14 +++++++-------
> > arch/powerpc/kernel/exceptions-64e.S     |    2 +-
> > arch/powerpc/kernel/exceptions-64s.S     |    2 +-
> > arch/powerpc/kernel/head_fsl_booke.S     |    2 +-
> > arch/powerpc/kernel/idle_6xx.S           |    4 ++--
> > arch/powerpc/kernel/idle_book3e.S        |    2 +-
> > arch/powerpc/kernel/idle_e500.S          |    4 ++--
> > arch/powerpc/kernel/idle_power4.S        |    2 +-
> > arch/powerpc/kernel/misc_32.S            |    4 ++--
> > arch/powerpc/kvm/bookehv_interrupts.S    |    6 +-----
> > arch/powerpc/mm/hash_low_32.S            |    8 ++++----
> > arch/powerpc/sysdev/6xx-suspend.S        |    2 +-
> > 15 files changed, 46 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/in=
clude/asm/exception-64s.h
> > index d58fc4e..5dbd00d 100644
> > --- a/arch/powerpc/include/asm/exception-64s.h
> > +++ b/arch/powerpc/include/asm/exception-64s.h
> > @@ -293,7 +293,7 @@ label##_hv:								\
> >
> > #define RUNLATCH_ON				\
> > BEGIN_FTR_SECTION				\
> > -	clrrdi	r3,r1,THREAD_SHIFT;		\
> > +	CURRENT_THREAD_INFO(r3, r1)		\
> > 	ld	r4,TI_LOCAL_FLAGS(r3);		\
> > 	andi.	r0,r4,_TLF_RUNLATCH;		\
> > 	beql	ppc64_runlatch_on_trampoline;	\
> > @@ -332,7 +332,7 @@ label##_common:							\
> > #ifdef CONFIG_PPC_970_NAP
> > #define FINISH_NAP				\
> > BEGIN_FTR_SECTION				\
> > -	clrrdi	r11,r1,THREAD_SHIFT;		\
> > +	CURRENT_THREAD_INFO(r11, r1)		\
> > 	ld	r9,TI_LOCAL_FLAGS(r11);		\
> > 	andi.	r10,r9,_TLF_NAPPING;		\
> > 	bnel	power4_fixup_nap;		\
> > diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/incl=
ude/asm/thread_info.h
> > index 68831e9..3760620 100644
> > --- a/arch/powerpc/include/asm/thread_info.h
> > +++ b/arch/powerpc/include/asm/thread_info.h
> > @@ -74,6 +74,14 @@ static inline struct thread_info *current_thread_inf=
o(void)
> > 	return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
> > }
> >
> > +#else
> > +
> > +#ifndef CONFIG_PPC64
>=20
> Oh no! The logic is still backwards :(

Doh...somehow I missed that comment in your previous reply.  Will fix=20
that.

Stuart
