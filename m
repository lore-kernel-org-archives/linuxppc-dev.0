Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7BD692C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Feb 2014 02:59:49 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 7 Feb 2014 15:59:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 060452190056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 15:59:40 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s17FxUjB65601648
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 15:59:30 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s17Fxf1Y013416
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Feb 2014 08:59:41 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [RFC PATCH 00/18] powerpc/boot: 64bit little endian wrapper for
 pseries
Date: Fri,  7 Feb 2014 16:59:13 +0100
Message-Id: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
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
wrapper for pseries. It is based on original code from Andrew Tauferner. 

The first patches provide fixes for 64bit. I also changed the prom 
code to make it converge with the prom_init kernel code. They have 
a lot in common and they could probably be merged if we find a way
to do it.
 
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

and these to support a 64bit boot wrapper in both endian order :

  powerpc/boot: define a routine to enter prom
  powerpc/boot: modify entry point for 64bit
  powerpc/boot: modify how we enter kernel on 64bit
  powerpc/boot: add a global entry point for pseries
  powerpc/boot: add support for 64bit big endian wrapper
  powerpc/boot: add support for 64bit little endian wrapper

This final patch restores the previous configuration for 64bit 
big endian kernel, which is to compile in 32bit : 

  powerpc/boot: add PPC64_BOOT_WRAPPER config option


Here are some initial topics to discuss :

  - To compile in 64bit, -m64 is added to the cross32 compiler ...
    This is not the most elegant solutions.
   
  - There are still some compile warnings due to 64bit in the 
    device tree wrapper library.

  - The boot wrapper is compiled as a position independent executable.
    This might not be an issue though.

This patchset is based on a 3.13 and was tested on qemu with the -kernel
option on little and big endian guests. It was also tested with a 
custom yaboot supporting Little Endian kernels.

Yours,

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
 arch/powerpc/boot/addnote.c            |  114 +++++++++++++-------
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
 16 files changed, 458 insertions(+), 93 deletions(-)
 create mode 100644 arch/powerpc/boot/pseries-head.S
 create mode 100644 arch/powerpc/boot/swab.h

-- 
1.7.10.4
