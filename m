Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZSKS35kVzF2Q5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 00:56:11 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j11so6919717pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 07:56:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] hvc and powerpc opal console latency reduction
Date: Tue,  1 May 2018 00:55:43 +1000
Message-Id: <20180430145558.4308-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm seeing scattered reports of hard lockups triggering in the OPAL
console code. I haven't got a full latency trace -- they are difficult
to reproduce and sometimes just show up in dmesg of a bug report when
the system is having other issues. But it does seem like there are
some improvements that can be made to the hvc console and powerpc
opal driver.

I'm not sure how this series should be merged yet, but we can cross
that if/when it comes. Possibly all can go via the tty tree with
acks from powerpc maintainers.

Comments appreciated.

Thanks,
Nick

--
Nicholas Piggin (15):
  powerpc/powernv: opal_put_chars partial write fix
  powerpc/powernv: Fix OPAL console driver OPAL_BUSY loops
  powerpc/powernv: opal-kmsg standardise OPAL_BUSY handling
  powerpc/powernv: opal-kmsg use flush fallback from console code
  powerpc/powernv: Implement and use opal_flush_console
  powerpc/powernv: Remove OPALv1 support from opal console driver
  powerpc/powernv: move opal console flushing to udbg
  powerpc/powernv: implement opal_put_chars_atomic
  tty: hvc: remove unexplained "just in case" spin delay
  tty: hvc: use mutex instead of spinlock for hvc_structs lock
  tty: hvc: hvc_poll break hv read loop
  tty: hvc: hvc_poll may sleep
  tty: hvc: hvc_write may sleep
  tty: hvc: introduce the hv_ops.flush operation for hvc drivers
  powerpc/powernv: provide a console flush operation for opal hvc driver

 arch/powerpc/include/asm/opal.h            |   3 +
 arch/powerpc/platforms/powernv/opal-kmsg.c |  30 +---
 arch/powerpc/platforms/powernv/opal.c      | 176 +++++++++++++------
 drivers/tty/hvc/hvc_console.c              | 194 +++++++++++++--------
 drivers/tty/hvc/hvc_console.h              |   1 +
 drivers/tty/hvc/hvc_opal.c                 |  33 ++--
 6 files changed, 276 insertions(+), 161 deletions(-)

-- 
2.17.0
