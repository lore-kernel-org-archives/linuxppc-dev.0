Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39DD61401DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 14:59:59 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq14so9252513pab.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 20:59:55 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 shangw@linux.vnet.ibm.com, hegdevasant@linux.vnet.ibm.com,
 michael@ellerman.id.au, mikey@neuling.org, stewart@linux.vnet.ibm.com
Subject: [PATCH v2 0/2] OPAL message log interface
Date: Tue,  1 Apr 2014 14:28:18 +1030
Message-Id: <1396324700-22457-1-git-send-email-joel@jms.id.au>
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

Changes in V2:

The guts of the function used to read the console has been reworked. In doing
so, I've addressed the comments from Mikey and Ben:

 - Added barrier between reading header and data
 - Only read out_pos once
 - Check the return code before adding it to the number of bytes read

Unlike V1, this version correctly reads out a wrapped buffer.

Joel Stanley (2):
  powerpc/powernv: Add OPAL message log interface
  powerpc/powernv: Add invalid OPAL call

 arch/powerpc/include/asm/opal.h                |   6 ++
 arch/powerpc/platforms/powernv/Makefile        |   1 +
 arch/powerpc/platforms/powernv/opal-msglog.c   | 120 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   7 +-
 5 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-msglog.c

-- 
1.9.1
