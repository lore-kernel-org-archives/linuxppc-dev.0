Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA7252C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 23:38:25 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] rapidio: add inbound memory mapping API
Date: Tue, 18 Sep 2012 09:37:19 -0400
Message-Id: <1347975441-6723-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add RapidIO subsystem interface to support mapping of RapidIO memory space into
system's local memory. 

RapidIO specification defines memory mapped read (NREAD) and write (NWRITE,
NWRITE_R and SWRITE) requests that allow to access memory space on remote target
device. Existing RapidIO controllers/bridges provide hardware mechanism
to map addresses on RapidIO side into system's local memory. Patches provided in
this package define common interface that has to be supported by RIO master port
devices and hardware dependent implementation for IDT Tsi721 PCIe-to-SRIO bridge.

These patches are based on the work submitted by Li Yang <leoli@freescale.com>
(https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/071210.html) but
implement only the inbound mapping portion of it.

Combined with RapidIO DMA engine interface support these patches allow to perform
memory mapped data transfers between devices connected to a RapidIO network.  

Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
Alexandre Bounine (2):
  rapidio: add inbound memory mapping interface
  rapidio/tsi721: add inbound memory mapping callbacks

 drivers/rapidio/devices/tsi721.c |   88 +++++++++++++++++++++++++++++++++++++-
 drivers/rapidio/devices/tsi721.h |   15 +++++-
 drivers/rapidio/rio.c            |   44 +++++++++++++++++++
 include/linux/rio.h              |    5 ++
 include/linux/rio_drv.h          |    5 ++
 5 files changed, 153 insertions(+), 4 deletions(-)

-- 
1.7.8.4
