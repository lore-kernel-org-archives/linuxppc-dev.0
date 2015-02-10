Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 380B31A0374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 13:27:40 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 9 Feb 2015 19:27:39 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E40D719D8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 19:18:46 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1A2RvnX48103454
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:57 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1A2RBSZ002571
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Feb 2015 19:27:12 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 00/18] sync opal.h with firmware
Date: Tue, 10 Feb 2015 13:26:42 +1100
Message-Id: <1423535220-6322-1-git-send-email-stewart@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series takes a careful step-by-step process to sync the
opal.h header file (definition of interface to OPAL firmware) with
opal.h in firmware.

Each patch is designed to be as obvious as possible so that it's
easy for someone else to prove that I haven't messed it up anywhere.

In the process of doing this, I fixed a few things in firmware too,
so this matches skiboot at 4681ed9, which is a little after the most
recent skiboot release (4.1.1).

The biggest change is moving the function prototypes for API calls
out to opal-api.h.

Stewart Smith (18):
  powerpc/powernv: sync OPAL API tokens with skiboot
  powerpc/powernv: synchronize OPAL calls and return codes with
    firmware
  powerpc/powernv:
    s/OPAL_PCI_SET_PHB_CXL_MODE/OPAL_PCI_SET_PHB_CAPI_MODE/ to match
    firmware
  powerpc/powernv: relocate struct opal_sg_entry in opal.h to same
    place it is in firmware
  powerpc/powernv: synchronize opal.h whitespace with firmware
  powerpc/powernv: move OPAL_DUMP_REGION defines in opal.h to same
    place as in firmware opal.h
  powerpc/powernv: make whitespace for OPAL_PM_* defines match firmware
  powerpc/powernv: Move OpalSysparamPerm,OpalMessageType in opal.h to
    match firmware
  powerpc/powernv: match enum OpalMessageType with firmware
  powerpc/powernv: move OPAL API prototypes to opal-api.h
  powerpc/powernv: make whitespace in enum OpalSysparamPerm match
    firmware
  powerpc/powernv: add CAPI and EPOW parts to opal.h
  powerpc/powernv: add remaining missing enums to opal.h
  powerpc/powernv: sync comments and whitespace in opal.h with firmware
  powerpc/powernv: sync #includes in opal.h with firmware
  powerpc/powernv: move SG_ENTRIES_PER_NODE to linux-specific
    opal-api.h
  powerpc/powernv: s/u8/uint8_t/ to match firmware in opal.h
  powerpc/powernv: s/OpalM64EnableAction/OpalM64Action/ and __be64
    annotation

 arch/powerpc/include/asm/opal-api.h                |  244 ++++++++++
 arch/powerpc/include/asm/opal.h                    |  492 +++++++-------------
 arch/powerpc/kernel/prom.c                         |    1 +
 arch/powerpc/platforms/powernv/eeh-ioda.c          |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c       |    1 +
 arch/powerpc/platforms/powernv/opal-async.c        |    1 +
 arch/powerpc/platforms/powernv/opal-dump.c         |    1 +
 arch/powerpc/platforms/powernv/opal-elog.c         |    1 +
 arch/powerpc/platforms/powernv/opal-flash.c        |    1 +
 arch/powerpc/platforms/powernv/opal-hmi.c          |    1 +
 arch/powerpc/platforms/powernv/opal-lpc.c          |    1 +
 .../powerpc/platforms/powernv/opal-memory-errors.c |    1 +
 arch/powerpc/platforms/powernv/opal-msglog.c       |    1 +
 arch/powerpc/platforms/powernv/opal-nvram.c        |    1 +
 arch/powerpc/platforms/powernv/opal-rtc.c          |    1 +
 arch/powerpc/platforms/powernv/opal-sensor.c       |    1 +
 arch/powerpc/platforms/powernv/opal-sysparam.c     |    1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    2 +-
 arch/powerpc/platforms/powernv/opal-xscom.c        |    1 +
 arch/powerpc/platforms/powernv/opal.c              |    1 +
 arch/powerpc/platforms/powernv/pci-ioda.c          |    5 +-
 arch/powerpc/platforms/powernv/pci-p5ioc2.c        |    1 +
 arch/powerpc/platforms/powernv/pci.c               |    1 +
 arch/powerpc/platforms/powernv/setup.c             |    1 +
 arch/powerpc/platforms/powernv/smp.c               |    1 +
 arch/powerpc/platforms/powernv/subcore.c           |    1 +
 arch/powerpc/sysdev/xics/ics-opal.c                |    1 +
 drivers/char/ipmi/ipmi_powernv.c                   |    2 +-
 drivers/hwmon/ibmpowernv.c                         |    1 +
 drivers/i2c/busses/i2c-opal.c                      |    1 +
 drivers/rtc/rtc-opal.c                             |    1 +
 drivers/tty/hvc/hvc_opal.c                         |    1 +
 32 files changed, 450 insertions(+), 322 deletions(-)
 create mode 100644 arch/powerpc/include/asm/opal-api.h

-- 
1.7.10.4
