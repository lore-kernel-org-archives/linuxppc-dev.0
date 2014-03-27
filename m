Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 90E99140076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 10:50:55 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq14so4159439pab.24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Mar 2014 16:50:52 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com,
 michael@ellerman.id.au, stewart@linux.vnet.ibm.com
Subject: [PATCH 0/2] OPAL message log interface
Date: Fri, 28 Mar 2014 10:20:38 +1030
Message-Id: <1395964240-8305-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches add support for the message log, and expose a new OPAL call
called opal_invalid that allow me to cause OPAL to inject messages into the
log.

The naming is a bit mixed, as our device tree node is opal-memcons and I
retained the naming of the header structure 'struct memcons', but all other
references are to the OPAL message log.

They have been tested on a POWER7+ machine running some recent firmware.

Joel Stanley (2):
  powerpc/powernv: Add OPAL message log interface
  powerpc/powernv: Add invalid OPAL call

 arch/powerpc/include/asm/opal.h                |  6 ++
 arch/powerpc/platforms/powernv/Makefile        |  1 +
 arch/powerpc/platforms/powernv/opal-messages.c | 97 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/opal.c          |  6 +-
 5 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-messages.c

-- 
1.9.1
