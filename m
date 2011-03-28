Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AF12B6F83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 02:26:49 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add Initiate Coprocessor Store Word (icswx)
	support
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110326083239.1437c843@kryten>
Date: Mon, 28 Mar 2011 10:26:40 -0500
Message-Id: <7E97D7F7-1C70-4651-A620-0BACFB8C3CD5@kernel.crashing.org>
References: <20110326083239.1437c843@kryten>
To: Anton Blanchard <anton@samba.org>
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 25, 2011, at 4:32 PM, Anton Blanchard wrote:

> From: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
>=20
> Icswx is a PowerPC instruction to send data to a co-processor. On =
Book-S
> processors the LPAR_ID and process ID (PID) of the owning process are
> registered in the window context of the co-processor at initialization
> time. When the icswx instruction is executed the L2 generates a =
cop-reg
> transaction on PowerBus. The transaction has no address and the
> processor does not perform an MMU access to authenticate the =
transaction.
> The co-processor compares the LPAR_ID and the PID included in the
> transaction and the LPAR_ID and PID held in the window context to
> determine if the process is authorized to generate the transaction.
>=20
> The OS needs to assign a 16-bit PID for the process. This cop-PID =
needs
> to be updated during context switch. The cop-PID needs to be destroyed
> when the context is destroyed.
>=20
> Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>=20
> This is the v4 patch with a few changes:
>=20
> - Remove the lazy option. If we see overhead in the context switch =
path
>  we can add it back in once we have the basic patch working and =
merged.
>=20
> - Remove comment and ifdef around spinlock forward declaration. We =
don't
>  wrap forward declarations in ifdefs and they are common enough that =
we
>  don't need to explain them individually.
>=20
> - Check for CPU_FTR_ICSWX in drop_cop. Even though we shouldn't enter =
with
>  mm =3D=3D active_mm, we export the function and we should avoid doing =
writes
>  to model specific SPRs in any circumstance.
>=20
> - Convert WARN_ON -> WARN_ON_ONCE in drop_cop.
>=20
> - Fix comments to be docbook compliant
>=20
> - Update the Kconfig help text to read a bit better
>=20
> Index: powerpc.git/arch/powerpc/include/asm/cputable.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.git.orig/arch/powerpc/include/asm/cputable.h	=
2011-03-22 18:19:30.171445251 +1100
> +++ powerpc.git/arch/powerpc/include/asm/cputable.h	2011-03-26 =
08:15:44.284009603 +1100
> @@ -202,6 +202,7 @@ extern const char *powerpc_base_platform
> #define CPU_FTR_STCX_CHECKS_ADDRESS	=
LONG_ASM_CONST(0x0200000000000000)
> #define CPU_FTR_POPCNTB			=
LONG_ASM_CONST(0x0400000000000000)
> #define CPU_FTR_POPCNTD			=
LONG_ASM_CONST(0x0800000000000000)
> +#define CPU_FTR_ICSWX			=
LONG_ASM_CONST(0x1000000000000000)
>=20
> #ifndef __ASSEMBLY__
>=20
> @@ -421,7 +422,8 @@ extern const char *powerpc_base_platform
> 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
> 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
> 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
> -	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | =
CPU_FTR_POPCNTD)
> +	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | =
CPU_FTR_POPCNTD | \
> +	    CPU_FTR_ICSWX)
> #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
> 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
> 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
> Index: powerpc.git/arch/powerpc/include/asm/mmu-hash64.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- powerpc.git.orig/arch/powerpc/include/asm/mmu-hash64.h	=
2011-03-22 18:19:30.201446386 +1100
> +++ powerpc.git/arch/powerpc/include/asm/mmu-hash64.h	2011-03-26 =
08:15:44.284009603 +1100
> @@ -408,6 +408,7 @@ static inline void subpage_prot_init_new
> #endif /* CONFIG_PPC_SUBPAGE_PROT */
>=20
> typedef unsigned long mm_context_id_t;
> +struct spinlock;
>=20
> typedef struct {
> 	mm_context_id_t id;
> @@ -423,6 +424,11 @@ typedef struct {
> #ifdef CONFIG_PPC_SUBPAGE_PROT
> 	struct subpage_prot_table spt;
> #endif /* CONFIG_PPC_SUBPAGE_PROT */
> +#ifdef CONFIG_ICSWX

Seems like this really should be CONFIG_PPC_ICSWX

> +	struct spinlock *cop_lockp; /* guard acop and cop_pid */
> +	unsigned long acop;	/* mask of enabled coprocessor types */
> +	unsigned int cop_pid;	/* pid value used with coprocessors */
> +#endif /* CONFIG_ICSWX */
> } mm_context_t;
>=20
>=20

- k
