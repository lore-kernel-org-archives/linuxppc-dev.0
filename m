Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WYMr03pVzF24Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 07:33:11 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3PLTSt4011262
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 17:33:08 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hjwy912wh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 17:33:07 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Wed, 25 Apr 2018 17:33:06 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, gregkh@linuxfoundation.org,
 arnd@arndb.de
Cc: corbet@lwn.net, seroyer@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
 adreznec@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 davem@davemloft.net, linus.walleij@linaro.org,
 akpm@linux-foundation.org, rdunlap@infradead.org, mikey@neuling.org,
 pombredanne@nexb.com, tlfalcon@linux.vnet.ibm.com, msuchanek@suse.de,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tomburks@linux.vnet.ibm.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v2 0/1] misc: IBM Virtual Management Channel Driver (VMC)
Date: Wed, 25 Apr 2018 16:32:56 -0500
Message-Id: <1524691977-1456-1-git-send-email-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Royer had previously attempted to upstream this
driver two years ago, but never got the chance to address
the concerns from Greg Kroah-Hartman.

The thread with the initial upstream is:
https://lkml.org/lkml/2016/2/16/918

I have addressed the following:

Version 1:
- Documentation
- Use of dev_dbg instead of pr_dbg
- Change to misc class
- Fixed memory barrier usages
- Addressed styling, checkpatch, renaming of functions
- General fixes to the driver to make it more inline with
  existing upstream drivers.

Version 2:
- Changed Documentation from .rst to .txt and addressed
  small changes in documentation per request from Randy.
- Clarified Documentation based upon Linus Walleij's
  comments
- Fixed kbuild warning in regards to unititialized use of
  rc

Bryant G. Ly (1):
  misc: IBM Virtual Management Channel Driver (VMC)

 Documentation/ioctl/ioctl-number.txt  |    1 +
 Documentation/misc-devices/ibmvmc.rst |  226 +++
 MAINTAINERS                           |    6 +
 arch/powerpc/include/asm/hvcall.h     |    1 +
 drivers/misc/Kconfig                  |   14 +
 drivers/misc/Makefile                 |    1 +
 drivers/misc/ibmvmc.c                 | 2418 +++++++++++++++++++++++++++++++++
 drivers/misc/ibmvmc.h                 |  209 +++
 8 files changed, 2876 insertions(+)
 create mode 100644 Documentation/misc-devices/ibmvmc.rst
 create mode 100644 drivers/misc/ibmvmc.c
 create mode 100644 drivers/misc/ibmvmc.h

-- 
2.7.2
