Return-Path: <prvs=0626a9bc6f=stewart@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BZ0z6b01zDq82
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 17:02:59 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2T5xLog099647
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:02:57 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h0p2krg90-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:02:56 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Thu, 29 Mar 2018 02:02:56 -0400
From: Stewart Smith <stewart@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: Stewart Smith <stewart@linux.ibm.com>
Subject: [PATCH] hvc_opal: don't set tb_ticks_per_usec in
 udbg_init_opal_common()
Date: Thu, 29 Mar 2018 17:02:46 +1100
Message-Id: <20180329060246.9970-1-stewart@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

time_init() will set up tb_ticks_per_usec based on reality.
time_init() is called *after* udbg_init_opal_common() during boot.

from arch/powerpc/kernel/time.c:
  unsigned long tb_ticks_per_usec = 100; /* sane default */

Currently, all powernv systems have a timebase frequency of 512mhz
(512000000/1000000 == 0x200) - although there's nothing written
down anywhere that I can find saying that we couldn't make that
different based on the requirements in the ISA.

So, we've been (accidentally) thwacking the (currently) correct
(for powernv at least) value for tb_ticks_per_usec earlier than
we otherwise would have.

The "sane default" seems to be adequate for our purposes between
udbg_init_opal_common() and time_init() being called, and if it isn't,
then we should probably be setting it somewhere that isn't hvc_opal.c!

Signed-off-by: Stewart Smith <stewart@linux.ibm.com>
---
 drivers/tty/hvc/hvc_opal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 2ed07ca6389e..9645c0062a90 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -318,7 +318,6 @@ static void udbg_init_opal_common(void)
 	udbg_putc = udbg_opal_putc;
 	udbg_getc = udbg_opal_getc;
 	udbg_getc_poll = udbg_opal_getc_poll;
-	tb_ticks_per_usec = 0x200; /* Make udelay not suck */
 }
 
 void __init hvc_opal_init_early(void)
-- 
2.14.3
