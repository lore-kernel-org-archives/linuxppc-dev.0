Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0F64D140112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:23:54 +1000 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 24 Apr 2014 08:23:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7C88817D805C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 08:24:46 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7NlbL67043374
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 07:23:47 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O7Nk5R025679
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 01:23:46 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 00/15] powerpc/boot: 64bit little endian wrapper (rebased
 on v3.15-rc2)
Date: Thu, 24 Apr 2014 09:23:24 +0200
Message-Id: <1398324219-8919-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
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

and finally, these add support for the 64bit little endian boot 
wrapper :

  powerpc/boot: define a routine to enter prom
  powerpc/boot: modify entry point for 64bit
  powerpc/boot: add a global entry point for pseries
  powerpc/boot: add support for 64bit little endian wrapper

Here are some topics to discuss :

  - to compile in 64bit, -m64 is added to the cross32 compiler.    
  - There are still some compile warnings due to 64bit, in addnote 
    and in the device tree library.
  - the wrapper is compiled as a position independent executable. 

This patchset is based on a 3.15-rc2 and was tested on qemu with 
the -kernel option, yaboot and grub for little and big endian 
guests. Tests were also done to check that the PowerVM stack was
not broken by these changes.

It is also available from :

	https://github.com/legoater/linux v3.15-rc2-zimagev2 

Cheers,

C. 

Changes since v1 :

  - Fixed Makefile for platforms generating a zImage.pseries 
  - used PROM_ERROR (-1u) to test return addr when claiming memory
  - removed patch modifying the call to the kernel entry point
  - merged last 3 patches to preserve bisectability 

Cédric Le Goater (15):
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
  powerpc/boot: add a global entry point for pseries
  powerpc/boot: add support for 64bit little endian wrapper

 arch/powerpc/boot/Makefile             |   21 +++-
 arch/powerpc/boot/addnote.c            |  128 +++++++++++++++--------
 arch/powerpc/boot/crt0.S               |  180 +++++++++++++++++++++++++++++++-
 arch/powerpc/boot/elf_util.c           |    4 +
 arch/powerpc/boot/of.c                 |    4 +-
 arch/powerpc/boot/of.h                 |   19 +++-
 arch/powerpc/boot/ofconsole.c          |    6 +-
 arch/powerpc/boot/oflib.c              |   92 ++++++++--------
 arch/powerpc/boot/ppc_asm.h            |   12 +++
 arch/powerpc/boot/pseries-head.S       |    8 ++
 arch/powerpc/boot/stdio.c              |   14 +++
 arch/powerpc/boot/swab.h               |   29 +++++
 arch/powerpc/boot/wrapper              |   17 ++-
 arch/powerpc/boot/zImage.lds.S         |   25 ++++-
 arch/powerpc/platforms/Kconfig.cputype |    5 +
 15 files changed, 464 insertions(+), 100 deletions(-)
 create mode 100644 arch/powerpc/boot/pseries-head.S
 create mode 100644 arch/powerpc/boot/swab.h

-- 
1.7.10.4
