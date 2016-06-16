Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVhvm1wJCzDqmb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 22:07:16 +1000 (AEST)
Message-ID: <1466078830.19127.0.camel@ellerman.id.au>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2016 22:07:10 +1000
In-Reply-To: <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
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

On Thu, 2016-06-16 at 11:12 +0300, Denis Kirjanov wrote:
> On 6/6/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Mon, 2016-06-06 at 10:52 +0300, Denis Kirjanov wrote:
> > > I haven't bisected this yet. Photo attached.
> > 
> > A bisect would be awesome.
> 
> Ok, the issue was introduced by the commit
> caca285e5ab4a7a19fede51688106ceed6fc45dd (powerpc/mm/radix: Use
> STD_MMU_64 to properly isolate hash related code) and 970mp dies on
> the following condition:

> +BEGIN_MMU_FTR_SECTION
>         bl      slb_allocate_realmode
> -
> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)

Thanks.

How did you work that out?

That FTR section says to call slb_allocate_realmode() when MMU_FTR_RADIX is
clear (ie. zero). That should always be the case on your machine, unless you've
plugged a Power9 into your G5 ;)

> In my config I've enabled radix MMU lookup but in my understanding
> only recent IBM  machines support this feature and we have to call SLB
> entry through slb_allocate_realmode on HPTE machine?

That's right, and that's what the code should be doing.

My G5 is booting OK:

michael@cogito:~$ uname -a
Linux cogito 4.7.0-rc3-gdb06d75 #1 SMP Thu Jun 16 05:16:31 AEST 2016 ppc64 GNU/Linux

michael@cogito:~$ cat /proc/cpuinfo 
processor	: 0
cpu		: PPC970FX, altivec supported
clock		: 1599.999000MHz
revision	: 3.0 (pvr 003c 0300)

timebase	: 33333333
platform	: PowerMac
model		: PowerMac8,1
machine		: PowerMac8,1
motherboard	: PowerMac8,1 MacRISC4 Power Macintosh 
detected as	: 338 (iMac G5)
pmac flags	: 00000000
L2 cache	: 512K unified
pmac-generation	: NewWorld

michael@cogito:~$ zgrep RADIX /proc/config.gz 
CONFIG_PPC_RADIX_MMU=y

michael@cogito:~$ dmesg|grep _features
[    0.000000] cpu_features      = 0x0804806318100448
[    0.000000] cpu_user_features = 0xdc080000 0x00000000
[    0.000000] mmu_features      = 0x0c000001
[    0.000000] firmware_features = 0x0000000000000000

In particular notice:

#define MMU_FTR_RADIX			ASM_CONST(0x80000000)
                              mmu_features      = 0x0c000001

ie. MMU_FTR_RADIX is clear.

Do you see a different value for mmu_features?

cheers
