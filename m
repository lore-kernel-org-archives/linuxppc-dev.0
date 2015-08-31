Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89AB31A028B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 16:54:02 +1000 (AEST)
Message-ID: <1441003958.2720.5.camel@kernel.crashing.org>
Subject: Re: [Question] Is little endian supported on all the platforms?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geoff Levand <geoff@infradead.org>, Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>, Matt
 Porter <mporter@kernel.crashing.org>, Vitaly Bordug
 <vitb@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>, Kumar
 Gala <galak@kernel.crashing.org>, Olof Johansson <olof@lixom.net>, Arnd
 Bergmann <arnd@arndb.de>
Date: Mon, 31 Aug 2015 16:52:38 +1000
In-Reply-To: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
References: <20150831064453.GA1071@fixme-laptop.cn.ibm.com>
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

On Mon, 2015-08-31 at 14:44 +0800, Boqun Feng wrote:
> Hi all,
> 
> I hit a strange build error on v4.2, when I try to build a LE kernel
> with a slightly modification of the ppc64_defconfig. What I did is just
> make ppc64_defconfig and make menuconfig to set CPU_LITTLE_ENDIAN=y, and
> then build the kernel.
> 
> I did a little research myself, and found out the error is because of
> trying to build a LE kernel with CONFIG_PPC_PS3=y. So a simple way to
> reproduce is:

First, LE isn't supported on PS/3 :-) It's only supported on POWER8
machines (and *some* P7 machines and only when running as KVM guest).

But the specific problem you are having looks like a differnet issue
with the PS3 boot wrapper.

Cheers,
Ben
> .

> 1. make menuconfig
> 	> set CONFIG_CPU_LITTLE_ENDIAN=y
> 	> set CONFIG_PPC_PS3=y
> 	> (I will also attach the .config in the email)
> 2. make
> 
> will see make errors like:
> 
>       CALL    arch/powerpc/relocs_check.sh
>     WARNING: 1 bad relocations
>     c000000000c8c778 R_PPC64_ADDR64    __crc_TOC.
>       DTC     arch/powerpc/boot/ps3.dtb
>       WRAP    arch/powerpc/boot/dtbImage.ps3
>     ld: powerpc:common64 architecture of input file `arch/powerpc/boot/ps3-head.o' is incompatible with powerpc:common output
>     ld: powerpc:common64 architecture of input file `arch/powerpc/boot/ps3-hvcall.o' is incompatible with powerpc:common output
>     ld: powerpc:common64 architecture of input file `arch/powerpc/boot/ps3.o' is incompatible with powerpc:common output
>     ...
>     arch/powerpc/boot/wrapper.a(crt0.o): In function `p_toc':
>     (.text+0x30): undefined reference to `__toc_start'
>     arch/powerpc/boot/wrapper.a(crt0.o): In function `p_dyn':
>     (.text+0x38): undefined reference to `__dynamic_start'
>     arch/powerpc/boot/wrapper.a(crt0.o): In function `p_rela':
>     (.text+0x40): undefined reference to `__rela_dyn_start'
>     make[1]: *** [arch/powerpc/boot/dtbImage.ps3] Error 1
>     rm arch/powerpc/boot/ps3.dtb
>     make: *** [zImage] Error 2
> 
> 
> Does this error occur because little endian is not supported on PS3?
> If so, should we do something like:
> 
> config PPC_PS3
> 	> bool "Sony PS3"
> -> 	> depends on PPC64 && PPC_BOOK3S
> +> 	> depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
> 	> select PPC_CELL
> 
> ?
> 
> Besides, I don't see any platform stating "depends on CPU_BIG_ENDIAN"
> or "depends on CPU_LITTLE_ENDIAN" in its Kconfig, which means all the
> platforms support both big endian and little endian, at least, based on
> the information provided by Kconfigs.
> 
> Is this true?
> 
> Thanks and Best Regards,
> Boqun
