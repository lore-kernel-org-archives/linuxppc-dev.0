Return-Path: <cl@gentwo.org>
Received: from qmta06.emeryville.ca.mail.comcast.net
 (qmta06.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:43:76:96:30:56])
 by lists.ozlabs.org (Postfix) with ESMTP id 3912B1A03CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 01:52:46 +1000 (EST)
Date: Wed, 11 Jun 2014 10:44:24 -0500 (CDT)
From: Christoph Lameter <cl@gentwo.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: Kernel build issues after yesterdays merge by Linus
Message-ID: <alpine.DEB.2.10.1406111013580.8422@gentwo.org>
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1363266080-1402501464=:8422"
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1363266080-1402501464=:8422
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

This is under Ubuntu Utopic Unicorn on a Power 8 system while simply
trying to build with the Ubuntu standard kernel config. It could be that
these issues come about because we do not have an rc1 yet but I wanted to
give some early notice. Also this is a new arch to me so I may not be
aware of how things work.


1. Bad relocation while building:

root@rd-power8:/rdhome/clameter/linux# make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  SKIPPED include/generated/compile.h
  CALL    arch/powerpc/kernel/systbl_chk.sh
  CALL    arch/powerpc/kernel/prom_init_check.sh
  CHK     kernel/config_data.h
  CALL    arch/powerpc/relocs_check.pl
WARNING: 1 bad relocations
c000000000cc7df0 R_PPC64_ADDR64    __crc_TOC.



2. "make install" fails

root@rd-power8:/rdhome/clameter/linux# make install
sh -x /rdhome/clameter/linux/arch/powerpc/boot/install.sh "3.15.0+"
vmlinux System.map "/boot" arch/powerpc/boot/zImage.pseries
arch/powerpc/boot/zImage.epapr
+ set -e
+ [ -x /home/clameter/bin/installkernel ]
+ [ -x /sbin/installkernel ]
+ exec /sbin/installkernel 3.15.0+ vmlinux System.map /boot
arch/powerpc/boot/zImage.pseries arch/powerpc/boot/zImage.epapr
Usage: installkernel <version> <image> <System.map> <directory>
/rdhome/clameter/linux/arch/powerpc/boot/Makefile:393: recipe for target
'install' failed
make[1]: *** [install] Error 1
/rdhome/clameter/linux/arch/powerpc/Makefile:294: recipe for target
'install' failed
make: *** [install] Error 2



3. Ubuntu "make-kpkg" fails

clameter@rd-power8:~/linux$ fakeroot make-kpkg --initrd --revision 1
kernel_image
exec make kpkg_version=13.013 -f
/usr/share/kernel-package/ruleset/minimal.mk debian DEBIAN_REVISION=1
INITRD=YES
====== making target debian/stamp/conf/minimal_debian [new prereqs:
]======
This is kernel package version 13.013.
test -d debian             || mkdir debian
test ! -e stamp-building || rm -f stamp-building
install -p -m 755 /usr/share/kernel-package/rules debian/rules
for file in ChangeLog  Control  Control.bin86 config templates.in rules;
do                                      \
            cp -f  /usr/share/kernel-package/$file ./debian/;
\
        done
cp: cannot stat ¡/usr/share/kernel-package/ChangeLog¢: No such file or
directory
for dir  in Config docs examples ruleset scripts pkg po;  do
\
          cp -af /usr/share/kernel-package/$dir  ./debian/;
\
        done
test -f debian/control || sed         -e 's/=V/../g'  \
                -e 's/=D/1/g'         -e 's/=A/ppc64el/g'  \
	-e 's/=SA//g'  \
	-e 's/=I//g'				    \
	-e 's/=CV/./g'			    \
	-e 's/=M/Unknown Kernel Package Maintainer
<unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
\
	-e 's/=ST/linux/g'      -e 's/=B/ppc64el/g'    \
                -e 's/=R//g'    /usr/share/kernel-package/Control >
debian/control
test -f debian/changelog ||  sed -e 's/=V/../g'       \
            -e 's/=D/1/g'        -e 's/=A/ppc64el/g'       \
            -e 's/=ST/linux/g'     -e 's/=B/ppc64el/g'         \
            -e 's/=M/Unknown Kernel Package Maintainer
<unknown@unconfigured.in.etc.kernel-pkg.conf>/g'
\
             /usr/share/kernel-package/changelog > debian/changelog
chmod 0644 debian/control debian/changelog
test -d ./debian/stamp || mkdir debian/stamp
make -f debian/rules debian/stamp/conf/kernel-conf
make[1]: Entering directory '/rdhome/clameter/linux'
debian/ruleset/misc/checks.mk:36: *** Error. I do not know where the
kernel image goes to [kimagedest undefined] The usual case for this is
that I could not determine which arch or subarch this machine belongs to.
Please specify a subarch, and try again..  Stop.
make[1]: Leaving directory '/rdhome/clameter/linux'
/usr/share/kernel-package/ruleset/minimal.mk:93: recipe for target
'debian/stamp/conf/minimal_debian' failed
make: *** [debian/stamp/conf/minimal_debian] Error 2
Failed to create a ./debian directory:  at /usr/bin/make-kpkg line 966.




4. Errors during build:

Lots of integer to differnt pointer size conversions?

--8323329-1363266080-1402501464=:8422--
