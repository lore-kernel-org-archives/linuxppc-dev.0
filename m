Return-Path: <dominik@greysector.net>
Received: from watanuki.greysector.net (watanuki.greysector.net
 [IPv6:2a01:4f8:bc:610::b2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 302231A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 17:39:48 +1000 (AEST)
Received: from mokona.greysector.net (81.obywatelska.supermedia.pl
 [212.180.237.81])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by watanuki.greysector.net (Postfix) with ESMTPS id DB65520103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:31:10 +0200 (CEST)
Received: from mokona.greysector.net (localhost [127.0.0.1])
 by mokona.greysector.net (Postfix) with ESMTP id 404CC125A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:31:10 +0200 (CEST)
Received: from sakura.greysector.net (unknown [192.193.115.36])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mokona.greysector.net (Postfix) with ESMTPSA id 5E56D1259
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:31:09 +0200 (CEST)
Date: Thu, 20 Aug 2015 09:31:07 +0200
From: Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: error: 'asm' operand has impossible constraints when compiling
 gromacs 5.1 on PPC64 and PPC64LE with VSX SMD
Message-ID: <20150820073106.GB10057@sakura.greysector.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!
When gromacs-5.1 is configured for double precision, I get the following
compilation error when building the internal tests (make check):
[...]
[ 94%] Building CXX object src/gromacs/simd/tests/CMakeFiles/simd-test.dir/simd_integer.cpp.o
cd /builddir/build/BUILD/gromacs-5.1/openmpi_d/src/gromacs/simd/tests && /usr/bin/c++   -DGMX_DOUBLE -DGTEST_USE_OWN_TR1_TUPLE=1 -DHAVE_CONFIG_H -DTEST_DATA_PATH=\"src/gromacs/simd/tests\" -DTEST_TEMP_PATH=\"/builddir/build/BUILD/gromacs-5.1/openmpi_d/src/gromacs/simd/tests/Testing/Temporary\" -mvsx   -std=c++0x -O2 -g -pipe -Wall -Werror=format-security -Wp
,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64  -Wundef -Wextra -Wno-missing-field-initializers -Wpointer-arith -Wall -Wno-unused-function   -funroll-all-loops -fexcess-precision=fast  -Wno-array-bounds  -isystem /builddir/build/BUILD/gromacs-5.1/src/external/gmock-1.7.0/gtest/include -isystem /builddir/build/BUILD/gromacs-5.1/src/external/gmock-1.7.0/include -I/builddir/build/BUILD/gromacs-5.1/openmpi_d/src/external/tng_io/include -I/builddir/build/BUILD/gromacs-5.1/src/external/tng_io/include -I/builddir/build/BUILD/gromacs-5.1/openmpi_d/src -I/builddir/build/BUILD/gromacs-5.1/src/external/thread_mpi/include -I/builddir/build/BUILD/gromacs-5.1/src -I/usr/include/openmpi-ppc64    -Wno-unused-variable -o CMakeFiles/simd-test.dir/simd_integer.cpp.o -c /builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/tests/simd_integer.cpp
In file included from /builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/simd.h:138:0,
                 from /builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/tests/simd_integer.cpp:37:
/builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/impl_ibm_vsx/impl_ibm_vsx.h: In member function 'virtual void gmx::test::{anonymous}::SimdIntegerTest_gmxSimdCvtI2R_Test::TestBody()':
/builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/impl_ibm_vsx/impl_ibm_vsx.h:452:80: error: 'asm' operand has impossible constraints
     __asm__ ("xvcvsxwdp %0,%1" : "=ww" (x) : "ww" ((__vector signed int) (ix)));
                                                                                ^
/builddir/build/BUILD/gromacs-5.1/src/gromacs/simd/impl_ibm_vsx/impl_ibm_vsx.h:452:80: error: 'asm' operand has impossible constraints
     __asm__ ("xvcvsxwdp %0,%1" : "=ww" (x) : "ww" ((__vector signed int) (ix)));
                                                                                ^
src/gromacs/simd/tests/CMakeFiles/simd-test.dir/build.make:209: recipe for target 'src/gromacs/simd/tests/CMakeFiles/simd-test.dir/simd_integer.cpp.o' failed
make[3]: *** [src/gromacs/simd/tests/CMakeFiles/simd-test.dir/simd_integer.cpp.o] Error 1
[...]

This happens on:

$ cat /proc/cpuinfo 
processor	: 0
cpu		: POWER8E (raw), altivec supported
clock		: 3425.000000MHz
revision	: 2.1 (pvr 004b 0201)

processor	: 1
cpu		: POWER8E (raw), altivec supported
clock		: 3425.000000MHz
revision	: 2.1 (pvr 004b 0201)

timebase	: 512000000
platform	: pSeries
model		: IBM pSeries (emulated by qemu)
machine		: CHRP IBM pSeries (emulated by qemu)

in Fedora rawhide (F24) chroot while building the gromacs package
(http://pkgs.fedoraproject.org/cgit/gromacs.git) under mock.
You have to remove the %ifnarch ppc64 ppc64le part in %install section
to reproduce.

More details here: http://redmine.gromacs.org/issues/1808

AltiVec assembly is far beyond my skill, so I'd appreciate it if someone
could help figure it out.

Regards,
Dominik
-- 
Fedora http://fedoraproject.org/wiki/User:Rathann
RPMFusion http://rpmfusion.org
"Faith manages."
        -- Delenn to Lennier in Babylon 5:"Confessions and Lamentations"
