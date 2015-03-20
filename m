Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D52BA1A2A87
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 22:02:48 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Fri, 20 Mar 2015 16:32:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B24FE1258056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:34:14 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2KB2dCQ11862106
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:32:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2KB2bSN017173
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 16:32:37 +0530
Subject: [PATCH v2 0/2]  LED interface for PowerNV platform
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Date: Fri, 20 Mar 2015 16:32:37 +0530
Message-ID: <20150320105921.14866.83209.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com, rpurdie@rpsys.net,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following series implements LED driver for PowerNV platform.

PowerNV platform has below type of indicators:
  - System attention indicator (Check log indicator)
      Indicates there is a problem with the system that needs attention.
  - Identify
      Helps the user locate/identify a particular FRU or resource in the
      system.
  - Fault
      Indicates there is a problem with the FRU or resource at the
      location with which the indicator is associated.

On PowerNV (Non Virtualized) platform OPAL firmware provides LED
information to host via device tree (location code and LED type).
During init we check for 'ibm,opal/led' node in device tree to
enable LED driver. And we use OPAL API's to get/set LEDs.

patch 1/2: PowerNV architecture specific code. This adds necessary
           OPAL APIs.
patch 2/2 is actual LED driver implemenation for PowerNV platform.


changes in v2:
  - Rebased patches on top of mpe's next branch
     https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
  - Added System Attention Indicator support
  - Removed redundant code in leds-powernv.c file

---

Anshuman Khandual (2):
      powerpc/powernv: Add OPAL interfaces for accessing and modifying system LED states
      leds/powernv: Add driver for PowerNV platform


 arch/powerpc/include/asm/opal-api.h            |   29 +
 arch/powerpc/include/asm/opal.h                |    5 
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 
 arch/powerpc/platforms/powernv/opal.c          |   12 
 drivers/leds/Kconfig                           |    9 
 drivers/leds/Makefile                          |    1 
 drivers/leds/leds-powernv.c                    |  620 ++++++++++++++++++++++++
 7 files changed, 676 insertions(+), 2 deletions(-)
 create mode 100644 drivers/leds/leds-powernv.c

--
Vasant
Signature
