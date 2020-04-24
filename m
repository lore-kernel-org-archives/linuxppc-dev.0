Return-Path: <SRS0=4/q6=6I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BDC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 02:52:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8A1206ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 02:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8A1206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 497dxs5m38zDq5b
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2020 12:52:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=vivo.com (client-ip=59.111.176.16; helo=m17616.mail.qiye.163.com;
 envelope-from=wenhu.wang@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=vivo.com
Received: from m17616.mail.qiye.163.com (m17616.mail.qiye.163.com
 [59.111.176.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 497dqx0X0XzDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2020 12:47:19 +1000 (AEST)
Received: from ubuntu.localdomain (unknown [58.251.74.226])
 by m17616.mail.qiye.163.com (Hmail) with ESMTPA id 23DA4104AC2;
 Fri, 24 Apr 2020 10:47:07 +0800 (CST)
From: Wang Wenhu <wenhu.wang@vivo.com>
To: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3,0/5] misc: generic user level sram dynamic access support
Date: Thu, 23 Apr 2020 19:45:49 -0700
Message-Id: <20200424024554.30709-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVOSk9CQkJDTU1PQ05NWVdZKFlBSE
 83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6OCo6Gjg8AlZPEikhORVD
 PkwwFB9VSlVKTkNMTUJNT0lCTUhOVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
 Q1VJTkpVTE9VSUlNWVdZCAFZQU9OSEs3Bg++
X-HM-Tid: 0a71aa14e2029374kuws23da4104ac2
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: robh@kernel.org, oss@buserror.net, kernel@vivo.com, paulus@samba.org,
 Wang Wenhu <wenhu.wang@vivo.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series add a new misc module that act as an interface for user level
applications to access SRAM memory dynamically. Freescale 85xx Cache-SRAM
is exact an example.

This is extremely helpful for the user level applications that require
high performance memory accesses, such as some embedded networking devices
that need to process data in user space.

The series also fix the compile errors and warning of the freescale 85xx
Cache-SRAM driver, and implement a module to register the SRAM device to
sram_dynamic module, which enables its access for users in user space.

Changes since v1: addressed comments from Arnd
 * Changed the ioctl cmd definitions using _IO micros
 * Export interfaces for HW-SRAM drivers to register apis to available list
 * Modified allocation alignment to PAGE_SIZE
 * Use phys_addr_t as type of SRAM resource size and offset
 * Support compat_ioctl
 * Misc device name:sram
 * Use tristate for SRAM_UAPI
 * Use postcore_initcall

Changes since v2: addressed comments from Arnd, greg and Scott
 * Name the module with sram_dynamic in comparing with drivers/misc/sram.c

    I tried to tie the sram_dynamic with the abstractions in sram.c as
    Arnd suggested, and actually sram.c probes SRAM devices from devicetree
    and manages them with different partitions and create memory pools which
    are managed with genalloc functions.

    Here sram_dynamic acts only as a interface to user space. A SRAM memory
    pool is managed by the module that registers APIs to us, such as the
    backend hardware driver of Freescale 85xx Cache-SRAM.

 * Create one sram_device for each backend SRAM device(from Scott)
 * Allow only one block of SRAM memory allocated to a file descriptor(from Scott)
 * Add sysfs files for every allocated SRAM memory block
 * More documentations(As Greg commented)
 * Make uapi and non-uapi components apart(from Arnd and Greg)
 * Add a new module to register freescale 85xx Cache-SRAM APIs to the
   sram_dynamic module

Wang Wenhu (5):
  powerpc: sysdev: fix compile error for fsl_85xx_l2ctlr
  powerpc: sysdev: fix compile error for fsl_85xx_cache_sram
  powerpc: sysdev: fix compile warning for fsl_85xx_cache_sram
  misc: sram_dynamic for user level SRAM access
  powerpc: sysdev: support userspace access of fsl 85xx sram

 .../powerpc/include/asm/fsl_85xx_cache_sram.h |   4 +
 arch/powerpc/platforms/85xx/Kconfig           |  10 +
 arch/powerpc/sysdev/Makefile                  |   1 +
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h     |   6 +
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c     |  15 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c         |   1 +
 arch/powerpc/sysdev/fsl_85xx_sram_uapi.c      |  39 ++
 drivers/misc/Kconfig                          |  11 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/sram_dynamic.c                   | 580 ++++++++++++++++++
 drivers/misc/sram_uapi.c                      | 351 +++++++++++
 include/linux/sram_dynamic.h                  |  23 +
 include/uapi/linux/sram.h                     |  11 +
 13 files changed, 1052 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_sram_uapi.c
 create mode 100644 drivers/misc/sram_dynamic.c
 create mode 100644 drivers/misc/sram_uapi.c
 create mode 100644 include/linux/sram_dynamic.h
 create mode 100644 include/uapi/linux/sram.h

-- 
2.17.1

