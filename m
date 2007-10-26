Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 014EBDDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 04:19:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] Fix CONFIG_SMP=n build break
Date: Fri, 26 Oct 2007 20:19:10 +0200
References: <20071026165510.GA2323@lixom.net>
In-Reply-To: <20071026165510.GA2323@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710262019.12094.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 26 October 2007, Olof Johansson wrote:
> Fix two build errors on powerpc allyesconfig + CONFIG_SMP=3Dn:
>
> arch/powerpc/platforms/built-in.o: In function `cpu_affinity_set':
> arch/powerpc/platforms/cell/spu_priv1_mmio.c:78: undefined reference to
> `.iic_get_target_id' arch/powerpc/platforms/built-in.o: In function
> `iic_init_IRQ':
> arch/powerpc/platforms/cell/interrupt.c:397: undefined reference to
> `.iic_setup_cpu'

Thanks for reporting this.

> --- a/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> +++ b/arch/powerpc/platforms/cell/spu_priv1_mmio.c
> @@ -75,9 +75,11 @@ static u64 int_stat_get(struct spu *spu, int class)
> =A0
> =A0static void cpu_affinity_set(struct spu *spu, int cpu)
> =A0{
> +#ifdef CONFIG_SMP
> =A0=A0=A0=A0=A0=A0=A0=A0u64 target =3D iic_get_target_id(cpu);
> =A0=A0=A0=A0=A0=A0=A0=A0u64 route =3D target << 48 | target << 32 | targe=
t << 16;
> =A0=A0=A0=A0=A0=A0=A0=A0out_be64(&spu->priv1->int_route_RW, route);
> +#endif
> =A0}

I think here it would be better to move iic_get_target_id out of
CONFIG_SMP as well. We might want to kexec from an SMP kernel into
a UP kernel, and in that case, cpu_affinity_set() should better
reset the routing to CPU 0.

	Arnd <><
