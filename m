Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C11811A0283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 01:08:12 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 24 Nov 2014 14:08:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6359517D8047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 14:08:21 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOE86mH10158396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 14:08:06 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOE83Eh010299
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2014 07:08:05 -0700
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pseries/le: Fix endiannes issue in RTAS call from xmon
Date: Mon, 24 Nov 2014 15:07:53 +0100
Message-Id: <1416838073-16642-1-git-send-email-ldufour@linux.vnet.ibm.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On pseries system (LPAR) xmon failed to enter when running in LE mode, system
is hunging. Inititating xmon will lead to such an output on the console:

SysRq : Entering xmon
cpu 0x15: Vector: 0  at [c0000003f39ffb10]
    pc: c00000000007ed7c: sysrq_handle_xmon+0x5c/0x70
    lr: c00000000007ed7c: sysrq_handle_xmon+0x5c/0x70
    sp: c0000003f39ffc70
   msr: 8000000000009033
  current = 0xc0000003fafa7180
  paca    = 0xc000000007d75e80	 softe: 0	 irq_happened: 0x01
    pid   = 14617, comm = bash
Bad kernel stack pointer fafb4b0 at eca7cc4
cpu 0x15: Vector: 300 (Data Access) at [c000000007f07d40]
    pc: 000000000eca7cc4
    lr: 000000000eca7c44
    sp: fafb4b0
   msr: 8000000000001000
   dar: 10000000
 dsisr: 42000000
  current = 0xc0000003fafa7180
  paca    = 0xc000000007d75e80	 softe: 0	 irq_happened: 0x01
    pid   = 14617, comm = bash
cpu 0x15: Exception 300 (Data Access) in xmon, returning to main loop
xmon: WARNING: bad recursive fault on cpu 0x15

The root cause is that xmon is calling RTAS to turn off the surveillance
when entering xmon, and RTAS is requiring big endian parameters.

This patch is byte swapping the RTAS arguments when running in LE mode.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index b988b5addf86..c8efbb37d6e0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -293,10 +293,10 @@ static inline void disable_surveillance(void)
 	args.token = rtas_token("set-indicator");
 	if (args.token == RTAS_UNKNOWN_SERVICE)
 		return;
-	args.nargs = 3;
-	args.nret = 1;
+	args.nargs = cpu_to_be32(3);
+	args.nret = cpu_to_be32(1);
 	args.rets = &args.args[3];
-	args.args[0] = SURVEILLANCE_TOKEN;
+	args.args[0] = cpu_to_be32(SURVEILLANCE_TOKEN);
 	args.args[1] = 0;
 	args.args[2] = 0;
 	enter_rtas(__pa(&args));
-- 
1.9.1
