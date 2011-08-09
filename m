Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE207B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 15:22:18 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc: book3e: Add ICSWX/ACOP support to Book3e
	cores like A2
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1312842408-21482-3-git-send-email-jimix@pobox.com>
Date: Tue, 9 Aug 2011 00:22:10 -0500
Message-Id: <57513F0E-7757-4D18-A741-A6066BFF662E@kernel.crashing.org>
References: <1312842408-21482-1-git-send-email-jimix@pobox.com>
	<1312842408-21482-3-git-send-email-jimix@pobox.com>
To: Jimi Xenidis <jimix@pobox.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Ian Munsie <imunsie@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 8, 2011, at 5:26 PM, Jimi Xenidis wrote:

> ICSWX is also used by the A2 processor to access coprocessors,
> although not all "chips" that contain A2s have coprocessors.
>=20
> Signed-off-by: Jimi Xenidis <jimix@pobox.com>
> ---
> arch/powerpc/include/asm/cputable.h   |    2 +-
> arch/powerpc/include/asm/mmu-book3e.h |    4 ++++
> arch/powerpc/include/asm/reg_booke.h  |    4 ++++
> arch/powerpc/kernel/cpu_setup_a2.S    |   10 ++++++++--
> arch/powerpc/platforms/wsp/Kconfig    |    1 +
> 5 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/cputable.h =
b/arch/powerpc/include/asm/cputable.h
> index e30442c..7044233 100644
> --- a/arch/powerpc/include/asm/cputable.h
> +++ b/arch/powerpc/include/asm/cputable.h
> @@ -437,7 +437,7 @@ extern const char *powerpc_base_platform;
> #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
>=20
> #define CPU_FTRS_A2 (CPU_FTR_USE_TB | CPU_FTR_SMT | CPU_FTR_DBELL | \
> -		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN)
> +		     CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN | =
CPU_FTR_ICSWX)
>=20
> #ifdef __powerpc64__
> #ifdef CONFIG_PPC_BOOK3E
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h =
b/arch/powerpc/include/asm/mmu-book3e.h
> index 3ea0f9a..06d7f91 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -212,6 +212,10 @@ typedef struct {
> 	unsigned int	id;
> 	unsigned int	active;
> 	unsigned long	vdso_base;
> +#ifdef CONFIG_PPC_ICSWX
> +	struct spinlock *cop_lockp; /* guard acop and cop_pid */
> +	unsigned long acop;	/* mask of enabled coprocessor types */
> +#endif /* CONFIG_PPC_ICSWX */

match whitespace (tab) formatting.

> } mm_context_t;
>=20
> /* Page size definitions, common between 32 and 64-bit

- k=
