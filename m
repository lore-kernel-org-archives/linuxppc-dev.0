Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 571582C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 07:16:00 +1000 (EST)
Subject: Re: [PATCH][v2] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1341263667-29875-1-git-send-email-stuart.yoder@freescale.com>
Date: Mon, 2 Jul 2012 23:15:53 +0200
Message-Id: <EB9E2FD4-8867-4E9D-93F9-B8EE3284F37A@suse.de>
References: <1341263667-29875-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 02.07.2012, at 23:14, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
>=20
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>=20
> -this patch is a pre-requisite for the idle hcall which I
> am trying to get into Alex's KVM tree, so ideally would like
> Ben's ack and get this applied to Alex's tree
>=20
> -built/tested with a 32-bit booke kernel, built a 64-bit
> booke kernel
>=20
> -v2
>   -moved CURRENT_THREAD_INFO under assembly only
>    #ifdef
>=20
> arch/powerpc/include/asm/exception-64s.h |    4 ++--
> arch/powerpc/include/asm/thread_info.h   |    8 ++++++++
> arch/powerpc/kernel/entry_32.S           |   24 =
++++++++++++------------
> arch/powerpc/kernel/entry_64.S           |   14 +++++++-------
> arch/powerpc/kernel/exceptions-64e.S     |    2 +-
> arch/powerpc/kernel/exceptions-64s.S     |    2 +-
> arch/powerpc/kernel/head_fsl_booke.S     |    2 +-
> arch/powerpc/kernel/idle_6xx.S           |    4 ++--
> arch/powerpc/kernel/idle_book3e.S        |    2 +-
> arch/powerpc/kernel/idle_e500.S          |    4 ++--
> arch/powerpc/kernel/idle_power4.S        |    2 +-
> arch/powerpc/kernel/misc_32.S            |    4 ++--
> arch/powerpc/kvm/bookehv_interrupts.S    |    6 +-----
> arch/powerpc/mm/hash_low_32.S            |    8 ++++----
> arch/powerpc/sysdev/6xx-suspend.S        |    2 +-
> 15 files changed, 46 insertions(+), 42 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/exception-64s.h =
b/arch/powerpc/include/asm/exception-64s.h
> index d58fc4e..5dbd00d 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -293,7 +293,7 @@ label##_hv:						=
		\
>=20
> #define RUNLATCH_ON				\
> BEGIN_FTR_SECTION				\
> -	clrrdi	r3,r1,THREAD_SHIFT;		\
> +	CURRENT_THREAD_INFO(r3, r1)		\
> 	ld	r4,TI_LOCAL_FLAGS(r3);		\
> 	andi.	r0,r4,_TLF_RUNLATCH;		\
> 	beql	ppc64_runlatch_on_trampoline;	\
> @@ -332,7 +332,7 @@ label##_common:						=
	\
> #ifdef CONFIG_PPC_970_NAP
> #define FINISH_NAP				\
> BEGIN_FTR_SECTION				\
> -	clrrdi	r11,r1,THREAD_SHIFT;		\
> +	CURRENT_THREAD_INFO(r11, r1)		\
> 	ld	r9,TI_LOCAL_FLAGS(r11);		\
> 	andi.	r10,r9,_TLF_NAPPING;		\
> 	bnel	power4_fixup_nap;		\
> diff --git a/arch/powerpc/include/asm/thread_info.h =
b/arch/powerpc/include/asm/thread_info.h
> index 68831e9..3760620 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -74,6 +74,14 @@ static inline struct thread_info =
*current_thread_info(void)
> 	return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
> }
>=20
> +#else
> +
> +#ifndef CONFIG_PPC64

Oh no! The logic is still backwards :(

> +#define CURRENT_THREAD_INFO(dest, sp)	rlwinm dest, sp, 0, 0, =
31-THREAD_SHIFT
> +#else
> +#define CURRENT_THREAD_INFO(dest, sp)	clrrdi dest, sp, =
THREAD_SHIFT
> +#endif


Alex
