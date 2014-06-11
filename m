Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0029E1A03D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 06:26:39 +1000 (EST)
Message-ID: <1402518392.14780.63.camel@pasglop>
Subject: Re: Kernel build issues after yesterdays merge by Linus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <cl@gentwo.org>
Date: Thu, 12 Jun 2014 06:26:32 +1000
In-Reply-To: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
References: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-11 at 10:44 -0500, Christoph Lameter wrote:
> This is under Ubuntu Utopic Unicorn on a Power 8 system while simply
> trying to build with the Ubuntu standard kernel config. It could be that
> these issues come about because we do not have an rc1 yet but I wanted to
> give some early notice. Also this is a new arch to me so I may not be
> aware of how things work.

Can you try my current -next ? It has an additional fix or two by Anton
for building with ABIv2 that I'll send to Linus tomorrow.

Cheers,
Ben.

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
> 
> 
> 
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
> 
> 
> 
> 3. Ubuntu "make-kpkg" fails
> 
> clameter@rd-power8:~/linux$ fakeroot make-kpkg --initrd --revision 1
> kernel_image
> exec make kpkg_version=13.013 -f
> /usr/share/kernel-package/ruleset/minimal.mk debian DEBIAN_REVISION=1
> INITRD=YES
> ====== making target debian/stamp/conf/minimal_debian [new prereqs:
> ]======
> This is kernel package version 13.013.
> test -d debian             || mkdir debian
> test ! -e stamp-building || rm -f stamp-building
> install -p -m 755 /usr/share/kernel-package/rules debian/rules
> for file in ChangeLog  Control  Control.bin86 config templates.in rules;
> do                                      \
>             cp -f  /usr/share/kernel-package/$file ./debian/;
> \
>         done
> cp: cannot stat ‘/usr/share/kernel-package/ChangeLog’: No such file or
> directory
> for dir  in Config docs examples ruleset scripts pkg po;  do
> \
>           cp -af /usr/share/kernel-package/$dir  ./debian/;
> \
>         done
> test -f debian/control || sed         -e 's/=V/../g'  \
>                 -e 's/=D/1/g'         -e 's/=A/ppc64el/g'  \
> 	-e 's/=SA//g'  \
> 	-e 's/=I//g'				    \
> 	-e 's/=CV/./g'			    \
> 	-e 's/=M/Unknown Kernel Package Maintainer
> <unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
> \
> 	-e 's/=ST/linux/g'      -e 's/=B/ppc64el/g'    \
>                 -e 's/=R//g'    /usr/share/kernel-package/Control >
> debian/control
> test -f debian/changelog ||  sed -e 's/=V/../g'       \
>             -e 's/=D/1/g'        -e 's/=A/ppc64el/g'       \
>             -e 's/=ST/linux/g'     -e 's/=B/ppc64el/g'         \
>             -e 's/=M/Unknown Kernel Package Maintainer
> <unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
> \
>              /usr/share/kernel-package/changelog > debian/changelog
> chmod 0644 debian/control debian/changelog
> test -d ./debian/stamp || mkdir debian/stamp
> make -f debian/rules debian/stamp/conf/kernel-conf
> make[1]: Entering directory '/rdhome/clameter/linux'
> debian/ruleset/misc/checks.mk:36: *** Error. I do not know where the
> kernel image goes to [kimagedest undefined] The usual case for this is
> that I could not determine which arch or subarch this machine belongs to.
> Please specify a subarch, and try again..  Stop.
> make[1]: Leaving directory '/rdhome/clameter/linux'
> /usr/share/kernel-package/ruleset/minimal.mk:93: recipe for target
> 'debian/stamp/conf/minimal_debian' failed
> make: *** [debian/stamp/conf/minimal_debian] Error 2
> Failed to create a ./debian directory:  at /usr/bin/make-kpkg line 966.
> 
> 
> 
> 
> 4. Errors during build:
> 
> Lots of integer to differnt pointer size conversions?
