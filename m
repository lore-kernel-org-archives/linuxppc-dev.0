Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdHxj0m1mzF0lv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 01:48:40 +1100 (AEDT)
Date: Fri, 9 Feb 2018 08:48:29 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc-linux-gnu-ld: cannot open linker script file
 arch/powerpc/boot/zImage.coff.lds: No such file or directory
Message-ID: <20180209144829.GP21977@gate.crashing.org>
References: <CA+7wUswUir9cHEyvdT8vc+tvSxrcsoY8da+CpqG6kpc4oMj9Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+7wUswUir9cHEyvdT8vc+tvSxrcsoY8da+CpqG6kpc4oMj9Wg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Fri, Feb 09, 2018 at 12:52:03PM +0100, Mathieu Malaterre wrote:
> Is anyone using O= output directory option ?

Yes, always.

> It seems that git/master is failing:
> 
> $ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
> $ make O=ppc6xx ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage

Works fine for me (exact same arch and defconfig).  Two differences:
1) I also set CROSS_COMPILE during the config step;
2) I don't build zImage, just the default (but manual "make zImage"
afterwards works fine).

>   WRAP    arch/powerpc/boot/zImage.coff
> powerpc-linux-gnu-ld: cannot open linker script file
> arch/powerpc/boot/zImage.coff.lds: No such file or directory
> ../arch/powerpc/boot/Makefile:375: recipe for target
> 'arch/powerpc/boot/zImage.coff' failed
> make[2]: *** [arch/powerpc/boot/zImage.coff] Error 1

Add V=1?


Segher
