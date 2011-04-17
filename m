Return-Path: <olof@lixom.net>
MIME-Version: 1.0
In-Reply-To: <021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
Date: Sat, 16 Apr 2011 22:58:09 -0700
Message-ID: <BANLkTik+_mRdG5trNfCDCmkxyX3e_WvHGg@mail.gmail.com>
Subject: Re: [PATCH 10/15] powerpc: Define slb0_limit() for BOOK3E
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org,
	kumar.gala@freescale.com, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, Apr 15, 2011 at 1:32 AM, Michael Ellerman <michael@ozlabs.org> wrot=
e:
> From: Michael Ellerman <michael@ellerman.id.au>
>
> On BOOK3E we don't have an SLB 0, but the equivalent concept is the
> bolted entry mapping the kernel. Currently this is a 1G entry, so
> for now hardcode that. This will probably need to be reworked in
> future.

A year from now when someone sees the ifdef, the above comment would
be nice to have in the code instead of running a git annotate/log to
find out why it's hardcoded the way it is. :)


-Olof


>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> =A0arch/powerpc/kernel/setup_64.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_6=
4.c
> index 91a5cc5..3d0daf4 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -436,10 +436,14 @@ void __init setup_system(void)
>
> =A0static u64 slb0_limit(void)
> =A0{
> +#ifdef CONFIG_PPC_BOOK3E
> + =A0 =A0 =A0 return 1 << 30;
> +#else
> =A0 =A0 =A0 =A0if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1UL << SID_SHIFT_1T;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 1UL << SID_SHIFT;
> +#endif
> =A0}
>
> =A0static void __init irqstack_early_init(void)
> --
> 1.7.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
