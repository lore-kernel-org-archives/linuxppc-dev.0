Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18691DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 22:46:41 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m4ECjd9w024698
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 18:15:39 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4ECjT6e1364038
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 18:15:29 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id m4ECj3bv022217
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 18:15:03 +0530
Message-ID: <482ADEE0.7090301@linux.vnet.ibm.com>
Date: Wed, 14 May 2008 18:15:20 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Badness seen on 2.6.26-rc2 with lockdep enabled
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I see the following error on my power box at boot up.

RTAS: event: 14, Type: Platform Error, Severity: 2
------------[ cut here ]------------
Badness at kernel/lockdep.c:2680
NIP: c0000000000ae538 LR: c0000000000ae51c CTR: 0000000000000000
REGS: c0000000e7b139a0 TRAP: 0700   Not tainted  (2.6.26-rc2-mm1)
MSR: 8000000000029032 <EE,ME,IR,DR>  CR: 24000042  XER: 20000000
TASK = c0000000e7644620[411] 'rtasd' THREAD: c0000000e7b10000 CPU: 1
GPR00: 0000000000000000 c0000000e7b13c20 c000000000a55ef0 0000000000000001
GPR04: 0000000000000001 c00000000004bfb8 2d37313000000000 2d37313031303438
GPR08: 3644442000000000 c000000000ea3018 0000000000000020 0000000000000001
GPR12: 3644442000000000 c000000000a94600 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 4000000001c00000 c00000000086f400
GPR20: 0000000000000000 0000000000000001 00000000000000e4 000000000246f400
GPR24: c000000000a9c498 0000000000000008 c00000000004bfb8 c00000000087a5d8
GPR28: c00000000092cd48 0000000000000001 c0000000009bb738 c0000000e7b13c20
NIP [c0000000000ae538] .check_flags+0x9c/0x174
LR [c0000000000ae51c] .check_flags+0x80/0x174
Call Trace:
[c0000000e7b13c20] [c00000000004bc70] .pSeries_log_error+0x5c/0x400 (unreliable)
[c0000000e7b13ca0] [c0000000000b35c0] .lock_release+0x80/0x204
[c0000000e7b13d50] [c0000000005cfcf8] ._spin_unlock_irqrestore+0x34/0x94
[c0000000e7b13de0] [c00000000004bfb8] .pSeries_log_error+0x3a4/0x400
[c0000000e7b13ef0] [c00000000004c218] .rtasd+0x98/0x100
[c0000000e7b13f90] [c00000000002848c] .kernel_thread+0x4c/0x68
Instruction dump:
e92d01b0 8009085c 2f800000 40be002c 481f1b9d 60000000 2fa30000 419e00c4
e93e80f8 80090000 2f800000 409e00b4 <0fe00000> 480000ac 78290464 80090014
possible reason: unannotated irqs-on.
irq event stamp: 30
hardirqs last  enabled at (29): [<c0000000000b1d98>] .trace_hardirqs_on+0x1c/0x3
0
hardirqs last disabled at (30): [<c0000000000aebac>] .trace_hardirqs_off+0x1c/0x
30
softirqs last  enabled at (28): [<c00000000008bd08>] .__do_softirq+0x180/0x1a8
softirqs last disabled at (21): [<c000000000028124>] .call_do_softirq+0x14/0x24


-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
