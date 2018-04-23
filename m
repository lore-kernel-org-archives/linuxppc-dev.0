Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V8SG1KDMzF22y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 00:47:06 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3NEjYj5100552
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 10:47:04 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hhgjhudr2-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 10:47:04 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 10:47:02 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, gregkh@linuxfoundation.org,
 arnd@arndb.de
Cc: corbet@lwn.net, seroyer@linux.vnet.ibm.com, mrochs@linux.vnet.ibm.com,
 adreznec@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com,
 davem@davemloft.net, linus.walleij@linaro.org,
 akpm@linux-foundation.org, rdunlap@infradead.org, mikey@neuling.org,
 pombredanne@nexb.com, tlfalcon@linux.vnet.ibm.com, msuchanek@suse.de,
 linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v1 0/1] misc: IBM Virtual Management Channel Driver
Date: Mon, 23 Apr 2018 09:46:51 -0500
Message-Id: <1524494812-60150-1-git-send-email-bryantly@linux.vnet.ibm.com>
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
- Documentation
- Use of dev_dbg instead of pr_dbg
- Change to misc class
- Fixed memory barrier usages
- Addressed styling, checkpatch, renaming of functions
- General fixes to the driver to make it more inline with
  existing upstream drivers.

Bryant G. Ly (1):
  misc: IBM Virtual Management Channel Driver

 Documentation/ioctl/ioctl-number.txt  |    1 +
 Documentation/misc-devices/ibmvmc.txt |  161 +++
 MAINTAINERS                           |    6 +
 arch/powerpc/include/asm/hvcall.h     |    1 +
 drivers/misc/Kconfig                  |    9 +
 drivers/misc/Makefile                 |    1 +
 drivers/misc/ibmvmc.c                 | 2413 +++++++++++++++++++++++++++++++++
 drivers/misc/ibmvmc.h                 |  215 +++
 8 files changed, 2807 insertions(+)
 create mode 100644 Documentation/misc-devices/ibmvmc.txt
 create mode 100644 drivers/misc/ibmvmc.c
 create mode 100644 drivers/misc/ibmvmc.h

-- 
2.7.2
