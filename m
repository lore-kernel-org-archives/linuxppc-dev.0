Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdS6r1vR6zF0fB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 07:57:07 +1100 (AEDT)
Date: Fri, 9 Feb 2018 14:56:58 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: powerpc-linux-gnu-ld: cannot open linker script file
 arch/powerpc/boot/zImage.coff.lds: No such file or directory
Message-ID: <20180209205658.GW21977@gate.crashing.org>
References: <CA+7wUswUir9cHEyvdT8vc+tvSxrcsoY8da+CpqG6kpc4oMj9Wg@mail.gmail.com>
 <20180209144829.GP21977@gate.crashing.org>
 <CA+7wUsybiroxTP8tuvANuAKYKQjNQ8ayNtQDL=1jBV3uZJe-ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+7wUsybiroxTP8tuvANuAKYKQjNQ8ayNtQDL=1jBV3uZJe-ow@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2018 at 04:55:20PM +0100, Mathieu Malaterre wrote:
> >> $ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
> >> $ make O=ppc6xx ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage
> >
> > Works fine for me (exact same arch and defconfig).  Two differences:
> > 1) I also set CROSS_COMPILE during the config step;
> > 2) I don't build zImage, just the default (but manual "make zImage"
> > afterwards works fine).
> 
> Could you run command (2) a second time on your system.

That works fine, also with -j$BIG .

> $ make O=ppc6xx ARCH=powerpc ppc6xx_defconfig
> $ make O=ppc6xx ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- zImage
> -> ok so far
> $ make O=ppc6xx -j4 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-

Ah.  I configure with O=, but then cd to that dir and build without O= .
Also not in a subdir of the kernel source tree.

make ARCH=$ARCH CROSS_COMPILE=$TARGET- -C $KERNEL_SRC O=$PWD $DEFCONFIG
make ARCH=$ARCH CROSS_COMPILE=$TARGET- $MAKEOPTS

(everything run in the build dir).


Segher
