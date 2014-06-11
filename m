Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 316921A0D2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 16:02:31 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 11:32:25 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0F322E0044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 11:33:23 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B63CX039518268
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 11:33:13 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B62JKN029282
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 11:32:19 +0530
Message-ID: <5397F0E9.8060305@linux.vnet.ibm.com>
Date: Wed, 11 Jun 2014 14:02:17 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-dev@lists.ozlabs.org>
Subject: Kernel build fail with "Circular xxxx <- xxxx dependency dropped"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I recently build linux next kernel in IBM Power7 platform, use default 
config file copy from /boot/config-3.6.10-4.fc18.ppc64p7

[root@cena01 linux-next]# uname -a
Linux cena01.austin.ibm.com 3.15.0-rc1+ #47 SMP Thu Apr 24 20:59:46 CDT 
2014 ppc64 ppc64 ppc64 GNU/Linux

[root@cena01 linux-next]# cat /etc/issue
Fedora release 18 (Spherical Cow)
Kernel \r on an \m (\l)

and build error log below:

[root@cena01 linux-next]# make -j60
   CHK     include/config/kernel.release
   CHK     include/generated/uapi/linux/version.h
   CHK     include/generated/utsrelease.h
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   CALL    arch/powerpc/kernel/prom_init_check.sh
   CHK     include/generated/uapi/linux/version.h
   CALL    arch/powerpc/relocs_check.pl
   Building modules, stage 2.
WARNING: 1 bad relocations
c000000001455040 R_PPC64_ADDR64    uprobes_fetch_type_table
make[1]: Circular arch/powerpc/boot/zImage.lds.S <- 
arch/powerpc/boot/zImage.lds dependency dropped.
make[1]: Circular arch/powerpc/boot/zImage.coff.lds.S <- 
arch/powerpc/boot/zImage.lds dependency dropped.
make[1]: Circular arch/powerpc/boot/zImage.coff.lds.S <- 
arch/powerpc/boot/zImage.coff.lds dependency dropped.
make[1]: Circular arch/powerpc/boot/zImage.ps3.lds.S <- 
arch/powerpc/boot/zImage.lds dependency dropped.
make[1]: Circular arch/powerpc/boot/zImage.ps3.lds.S <- 
arch/powerpc/boot/zImage.coff.lds dependency dropped.
make[1]: Circular arch/powerpc/boot/zImage.ps3.lds.S <- 
arch/powerpc/boot/zImage.ps3.lds dependency dropped.
   WRAP    arch/powerpc/boot/zImage.ps3.lds.S
INFO: Uncompressed kernel (size 0x14d0db8) overlaps the address of the 
wrapper(0x400000)
INFO: Fixing the link_address of wrapper to (0x1500000)
ld: cannot open linker script file arch/powerpc/boot/zImage.lds: No such 
file or directory
make[1]: *** [arch/powerpc/boot/zImage.ps3.lds.S] Error 1
make: *** [zImage] Error 2
make: *** Waiting for unfinished jobs....
   MODPOST 1853 modules

I use git bisect to find out the possible commits to lead this problem:
7e1c04779efd51154baf652e653ceb24ce68939b kbuild: Use relative path for 
$(objtree)
890676c65d699db3ad82e7dddd0cf8fb449031af kbuild: Use relative path when 
building in the source tree
9da0763bdd82572be243fcf5161734f11568960f kbuild: Use relative path when 
building in a subdir of the source tree


Thanks
Mike
