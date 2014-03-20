Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 36F842C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 02:10:44 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 20 Mar 2014 15:10:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 482A21B08069
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:29 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KFAQQn52363436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:10:26 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KFAb16016814
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 09:10:38 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 00/18] powerpc/boot: 64bit little endian wrapper
Date: Thu, 20 Mar 2014 16:09:55 +0100
Message-Id: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The following patchset adds support for 64bit little endian boot 
wrapper. It is based on original code from Andrew Tauferner. 

The first patches provide fixes for 64bit support. I also changed 
the prom code to make it converge with the prom_init kernel code. 
They have a lot in common and they could probably be merged.

  powerpc/boot: fix do_div for 64bit wrapper
  powerpc/boot: use a common prom_args struct in oflib
  powerpc/boot: use prom_arg_t in oflib
  powerpc/boot: add byteswapping routines in oflib
  powerpc/boot: add PROM_ERROR define in oflib
  powerpc/boot: rework of_claim() to make it 64bit friendly
  powerpc/boot: define typedef ihandle as u32
  powerpc/boot: fix compile warning in 64bit

These are for little endian only:

  powerpc/boot: define byteswapping routines for little endian
  powerpc/boot: add 64bit and little endian support to addnote
  powerpc/boot: add little endian support to elf utils

and these to support a 64bit boot wrapper in both endian
order :

  powerpc/boot: define a routine to enter prom
  powerpc/boot: modify entry point for 64bit
  powerpc/boot: modify how we enter kernel on 64bit
  powerpc/boot: add a global entry point for pseries
  powerpc/boot: add support for 64bit big endian wrapper
  powerpc/boot: add support for 64bit little endian wrapper

This final patch restores the previous configuration for 
64bit big endian kernel, which is to compile in 32bit : 

  powerpc/boot: add PPC64_BOOT_WRAPPER config option


Here are some topics to discuss :

  - to compile in 64bit, -m64 is added to the cross32 compiler. 
   
  - There are still some compile warnings due to 64bit, in addnote 
    and in the device tree library.

  - the wrapper is compiled as a position independent executable. 
    This might not be an issue.

  - is the addnote executable still in use ? It seems important for 
    RS6000.

This patchset is based on a 3.14-rc7 and was tested on qemu with 
the -kernel option on little and big endian guests and with a custom
yaboot suporting LE. An another round of tests will be required when 
a 64bit grub is available.

Best,

C. 

Cédric Le Goater (18):
  powerpc/boot: fix do_div for 64bit wrapper
  powerpc/boot: use a common prom_args struct in oflib
  powerpc/boot: use prom_arg_t in oflib
  powerpc/boot: add byteswapping routines in oflib
  powerpc/boot: add PROM_ERROR define in oflib
  powerpc/boot: rework of_claim() to make it 64bit friendly
  powerpc/boot: define typedef ihandle as u32
  powerpc/boot: fix compile warning in 64bit
  powerpc/boot: define byteswapping routines for little endian
  powerpc/boot: add 64bit and little endian support to addnote
  powerpc/boot: add little endian support to elf utils
  powerpc/boot: define a routine to enter prom
  powerpc/boot: modify entry point for 64bit
  powerpc/boot: modify how we enter kernel on 64bit
  powerpc/boot: add a global entry point for pseries
  powerpc/boot: add support for 64bit big endian wrapper
  powerpc/boot: add support for 64bit little endian wrapper
  powerpc/boot: add PPC64_BOOT_WRAPPER config option

 arch/powerpc/boot/Makefile             |   18 +++-
 arch/powerpc/boot/addnote.c            |  128 +++++++++++++++--------
 arch/powerpc/boot/crt0.S               |  180 +++++++++++++++++++++++++++++++-
 arch/powerpc/boot/elf_util.c           |    4 +
 arch/powerpc/boot/main.c               |    4 +
 arch/powerpc/boot/of.c                 |    4 +-
 arch/powerpc/boot/of.h                 |   17 ++-
 arch/powerpc/boot/ofconsole.c          |    6 +-
 arch/powerpc/boot/oflib.c              |   94 +++++++++--------
 arch/powerpc/boot/ppc_asm.h            |   12 +++
 arch/powerpc/boot/pseries-head.S       |    8 ++
 arch/powerpc/boot/stdio.c              |   14 +++
 arch/powerpc/boot/swab.h               |   29 +++++
 arch/powerpc/boot/wrapper              |   17 ++-
 arch/powerpc/boot/zImage.lds.S         |   25 ++++-
 arch/powerpc/platforms/Kconfig.cputype |    5 +
 16 files changed, 465 insertions(+), 100 deletions(-)
 create mode 100644 arch/powerpc/boot/pseries-head.S
 create mode 100644 arch/powerpc/boot/swab.h

-- 
1.7.10.4
