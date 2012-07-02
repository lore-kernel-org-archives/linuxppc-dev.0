Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F0F42C009A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 06:59:50 +1000 (EST)
Subject: Re: [PATCH] PPC: use CURRENT_THREAD_INFO instead of open coded
 assembly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1341262574-2841-1-git-send-email-stuart.yoder@freescale.com>
Date: Mon, 2 Jul 2012 22:59:41 +0200
Message-Id: <40388C8A-6D3B-409E-9C6D-45005E1F6016@suse.de>
References: <1341262574-2841-1-git-send-email-stuart.yoder@freescale.com>
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


On 02.07.2012, at 22:56, Stuart Yoder wrote:

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
> arch/powerpc/include/asm/exception-64s.h |    4 ++--
> arch/powerpc/include/asm/thread_info.h   |    6 ++++++
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
> 15 files changed, 44 insertions(+), 42 deletions(-)
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
> index 68831e9..2e7bc3c 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -22,6 +22,12 @@
>=20
> #define THREAD_SIZE		(1 << THREAD_SHIFT)
>=20
> +#ifndef CONFIG_PPC64

I usually way prefer positive to negative logic. So if you could swap =
the 2 cases, I'd be a lot happier ;)

> +#define CURRENT_THREAD_INFO(dest, sp)	rlwinm dest, sp, 0, 0, =
31-THREAD_SHIFT
> +#else
> +#define CURRENT_THREAD_INFO(dest, sp)	clrrdi dest, sp, =
THREAD_SHIFT
> +#endif

This should go into an #ifdef __ASSEMBLY__ block, right? :)

The rest looks great :)


Alex
