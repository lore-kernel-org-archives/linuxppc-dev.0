Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0DA0D1A0725
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 07:51:48 +1000 (AEST)
Message-ID: <1441053636.2720.21.camel@kernel.crashing.org>
Subject: Re: [Question] Is little endian supported on all the platforms?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Boqun Feng <boqun.feng@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, Geoff
 Levand <geoff@infradead.org>, Anatolij Gustschin <agust@denx.de>, Alistair
 Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Scott Wood
 <scottwood@freescale.com>, Kumar Gala <galak@kernel.crashing.org>, Olof
 Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Date: Tue, 01 Sep 2015 06:40:36 +1000
In-Reply-To: <1441019966.31779.1.camel@ellerman.id.au>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
 <1441003958.2720.5.camel@kernel.crashing.org>
 <20150831075340.GB1071@fixme-laptop.cn.ibm.com>
 <1441019966.31779.1.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-31 at 21:19 +1000, Michael Ellerman wrote:

> Yes. Maybe something like this?

I would have done it the other way around with endian at the top
and only the supported platforms displayed based on the endian...

But I don't care *that* much either way

>diff --git a/arch/powerpc/platforms/Kconfig.cputype >b/arch/powerpc/pl
atforms/Kconfig.cputype
> index c140e94..c359f72 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -415,9 +415,13 @@ config VDSO32
>           big endian. That is because the only little endian
> configuration we
>           support is ppc64le which is 64-bit only.
>  
> +config CHOOSE_ENDIAN
> +       bool
> +
>  choice
>         prompt "Endianness selection"
>         default CPU_BIG_ENDIAN
> +       depends on CHOOSE_ENDIAN
>         help
>           This option selects whether a big endian or little endian
> kernel will
>           be built.
> diff --git a/arch/powerpc/platforms/powernv/Kconfig
> b/arch/powerpc/platforms/powernv/Kconfig
> index 604190c..32d5661 100644
> --- a/arch/powerpc/platforms/powernv/Kconfig
> +++ b/arch/powerpc/platforms/powernv/Kconfig
> @@ -18,6 +18,7 @@ config PPC_POWERNV
>         select CPU_FREQ_GOV_ONDEMAND
>         select CPU_FREQ_GOV_CONSERVATIVE
>         select PPC_DOORBELL
> +       select CHOOSE_ENDIAN
>         default y
>  
>  config OPAL_PRD
> diff --git a/arch/powerpc/platforms/pseries/Kconfig
> b/arch/powerpc/platforms/pseries/Kconfig
> index 54c87d5..182f485 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -21,6 +21,7 @@ config PPC_PSERIES
>         select HOTPLUG_CPU if SMP
>         select ARCH_RANDOM
>         select PPC_DOORBELL
> +       select CHOOSE_ENDIAN
>         default y
>  
>  config PPC_SPLPAR
> 
> 
> 
> > > But the specific problem you are having looks like a differnet
> > > issue
> > > with the PS3 boot wrapper.
> > > 
> > 
> > But could the reason of this be that the building process of the
> > PS3
> > boot wrapper assumes the kernel is BE?
> 
> It looks more like we're getting confused between 32-bit and 64-bit,
> from your
> log:
> 
>     ld: powerpc:common64 architecture of input file
> `arch/powerpc/boot/ps3-head.o' is incompatible with powerpc:common
> output
> 
> Which says it has a .o which is 64-bit but it's trying to produce 32
> -bit output.
> 
> That's probably related to the PPC64_BOOT_WRAPPER stuff.
> 
> cheers
> 
