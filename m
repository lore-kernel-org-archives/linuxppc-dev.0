Return-Path: <haren@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CDBB567B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 07:16:51 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7ALGmm8020671
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 17:16:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7ALFj1W294076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 15:15:45 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7ALFiiL031679
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 15:15:44 -0600
Message-ID: <44DBA1C6.2020902@us.ibm.com>
Date: Thu, 10 Aug 2006 14:14:46 -0700
From: Haren Myneni <haren@us.ibm.com>
MIME-Version: 1.0
To: Wolfgang Pfeiffer <roto@gmx.net>
Subject: Re: latest git: compile error: arch/powerpc/kernel/built-in.o
References: <20060810181154.GA3668@localhost>
In-Reply-To: <20060810181154.GA3668@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, ellerman@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Pfeiffer wrote:

A couple of Michael's patches are needed. I am able to build with your 
config file.

http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024271.html
http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024272.html

Thanks
Haren

>Hi All
>
>I'm trying to compile a fresh git kernel, with latest sources pulled today,
>Aug. 10. To no avail so far. 
>
>OS is Debian/unstable, last time I upgraded the system as far as the
>dependencies allowed doing that was yesterday, Aug. 10.
>
>---------------------
>$ cat /proc/cpuinfo 
>processor       : 0
>cpu             : 7447A, altivec supported
>clock           : 833.333000MHz
>revision        : 0.5 (pvr 8003 0105)
>bogomips        : 16.57
>timebase        : 8320000
>platform        : PowerMac
>machine         : PowerBook5,8
>motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
>detected as     : 287 (PowerBook G4 15")
>pmac flags      : 00000019
>L2 cache        : 512K unified
>pmac-generation : NewWorld
>-----------------------------
>
>Here's the config I used:
>
>http://wolfgangpfeiffer.com/config.060810.txt
>
>The compile messages:
>
>--------------------------------
>time MAKEFLAGS="CC=gcc-4.1"  fakeroot make-kpkg --append-to-version=-060810 kernel_image
>
>results in [excerpts]:
>
>  CC      lib/sha1.o
>  CC      lib/string.o
>  CC      lib/vsprintf.o
>  AR      lib/lib.a
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
>arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
>(.text+0xcd34): undefined reference to `kexec_sr_activated'
>arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
>(.text+0xcd44): undefined reference to `crash_kexec_secondary'
>arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
>(.init.text+0x1cdc): undefined reference to `reserve_crashkernel'
>arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
>(.init.text+0x1e1c): undefined reference to `overlaps_crashkernel'
>make[1]: *** [.tmp_vmlinux1] Error 1
>make[1]: Leaving directory `/home/shorty/kernel-factory/git.08102006/linux-2.6'
>make: *** [debian/stamp-build-kernel] Error 2
>
>real    9m39.089s
>user    8m21.904s
>sys     0m59.167s
>
>------------------------------------------------------------
>
>and with gcc-4.0 the same:
>
>time MAKEFLAGS="CC=gcc-4.0"  fakeroot make-kpkg --append-to-version=-060810 kernel_image
>
>results in [excerpts]:
>
>  CC      lib/vsprintf.o
>  AR      lib/lib.a
>  GEN     .version
>  CHK     include/linux/compile.h
>  UPD     include/linux/compile.h
>  CC      init/version.o
>  LD      init/built-in.o
>  LD      .tmp_vmlinux1
>arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
>(.text+0xcccc): undefined reference to `kexec_sr_activated'
>arch/powerpc/kernel/built-in.o: In function `__restore_cpu_setup':
>(.text+0xccdc): undefined reference to `crash_kexec_secondary'
>arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
>(.init.text+0x15d0): undefined reference to `reserve_crashkernel'
>arch/powerpc/kernel/built-in.o: In function `early_init_devtree':
>(.init.text+0x1710): undefined reference to `overlaps_crashkernel'
>make[1]: *** [.tmp_vmlinux1] Error 1
>make[1]: Leaving directory `/home/shorty/kernel-factory/git.08102006/linux-2.6'
>make: *** [debian/stamp-build-kernel] Error 2
>
>--------------------------------------
>
>Please let me know if you need more details.
>
>Thanks in anticipation
>
>Best Regards
>Wolfgang Pfeiffer
>
>  
>
