Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 168791A0338
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 22:09:15 +1000 (EST)
Date: Thu, 12 Jun 2014 22:09:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Christoph Lameter <cl@gentwo.org>
Subject: Re: Kernel build issues after yesterdays merge by Linus
Message-ID: <20140612220912.3447677f@kryten>
In-Reply-To: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
References: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rusty Russell <rusty@rustcorp.com.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

> This is under Ubuntu Utopic Unicorn on a Power 8 system while simply
> trying to build with the Ubuntu standard kernel config. It could be
> that these issues come about because we do not have an rc1 yet but I
> wanted to give some early notice. Also this is a new arch to me so I
> may not be aware of how things work.
> 
> 1. Bad relocation while building:
> 
> root@rd-power8:/rdhome/clameter/linux# make
>   CHK     include/config/kernel.release
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   SKIPPED include/generated/compile.h
>   CALL    arch/powerpc/kernel/systbl_chk.sh
>   CALL    arch/powerpc/kernel/prom_init_check.sh
>   CHK     kernel/config_data.h
>   CALL    arch/powerpc/relocs_check.pl
> WARNING: 1 bad relocations
> c000000000cc7df0 R_PPC64_ADDR64    __crc_TOC.

The TOC symbol export is special and I think we might need to get our
script to ignore it.

> 2. "make install" fails
> 
> root@rd-power8:/rdhome/clameter/linux# make install
> sh -x /rdhome/clameter/linux/arch/powerpc/boot/install.sh "3.15.0+"
> vmlinux System.map "/boot" arch/powerpc/boot/zImage.pseries
> arch/powerpc/boot/zImage.epapr
> + set -e
> + [ -x /home/clameter/bin/installkernel ]
> + [ -x /sbin/installkernel ]
> + exec /sbin/installkernel 3.15.0+ vmlinux System.map /boot
> arch/powerpc/boot/zImage.pseries arch/powerpc/boot/zImage.epapr
> Usage: installkernel <version> <image> <System.map> <directory>
> /rdhome/clameter/linux/arch/powerpc/boot/Makefile:393: recipe for target
> 'install' failed
> make[1]: *** [install] Error 1
> /rdhome/clameter/linux/arch/powerpc/Makefile:294: recipe for target
> 'install' failed
> make: *** [install] Error 2

Shows how much we use make install :) Below is a quick hack to get you going
but we should look at either fixing the Ubuntu installkernel to handle
extra optional args, or stop passing them from the ppc64 kernel
install.sh script.

Anton
--

diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
index b6a256b..e096e5a 100644
--- a/arch/powerpc/boot/install.sh
+++ b/arch/powerpc/boot/install.sh
@@ -23,8 +23,8 @@ set -e
 
 # User may have a custom install script
 
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
+if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} $1 $2 $3 $4; fi
+if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} $1 $2 $3 $4; fi
 
 # Default install
 
