Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 266F2DDDD6
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 01:16:05 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAGEGP0m025310
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 01:16:25 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lAGEJdiv276964
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 01:19:39 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAGEFlM9030555
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 01:15:48 +1100
Message-ID: <473DA608.1020804@linux.vnet.ibm.com>
Date: Fri, 16 Nov 2007 19:45:36 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	nfs@lists.sourceforge.net, Andy Whitcroft <apw@shadowen.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: [BUG] 2.6.24-rc2-mm1 - kernel bug on nfs v4 
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew,

The kernel enters the xmon state while running the file system
stress on nfs v4 mounted partition.
 
0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c0000000dbd4f820]
    pc: c000000000065be4: .__wake_up_common+0x44/0xe8
    lr: c000000000069768: .__wake_up+0x54/0x88
    sp: c0000000dbd4faa0
   msr: 8000000000001032
   dar: 0
 dsisr: 40010000
  current = 0xc0000000dfb6f680
  paca    = 0xc000000000574580
    pid   = 1865, comm = rpciod/0
0:mon> t
[c0000000dbd4fb50] c000000000069768 .__wake_up+0x54/0x88
[c0000000dbd4fc00] d00000000086b890 .nfs_sb_deactive+0x44/0x58 [nfs]
[c0000000dbd4fc80] d000000000872658 .nfs_free_unlinkdata+0x2c/0x74 [nfs]
[c0000000dbd4fd10] d000000000598510 .rpc_release_calldata+0x50/0x74 [sunrpc]
[c0000000dbd4fda0] c00000000008d960 .run_workqueue+0x10c/0x1f4
[c0000000dbd4fe50] c00000000008ec70 .worker_thread+0x118/0x138
[c0000000dbd4ff00] c0000000000939f4 .kthread+0x78/0xc4
[c0000000dbd4ff90] c00000000002b060 .kernel_thread+0x4c/0x68
0:mon> r
R00 = c000000000069768   R16 = 4000000001c00000
R01 = c0000000dbd4faa0   R17 = c0000000004410c0
R02 = c0000000006752d8   R18 = 0000000000000000
R03 = c0000000ace4ffc0   R19 = 000000000019c000
R04 = 0000000000000003   R20 = c00000000050af08
R05 = 0000000000000001   R21 = 000000000210af08
R06 = 0000000000000000   R22 = 000000000210b178
R07 = 0000000000000000   R23 = c00000000050b178
R08 = 0000000000000000   R24 = 0000000000000003
R09 = 0000000000000000   R25 = 0000000000000000
R10 = 0000000000000001   R26 = 0000000000000000
R11 = ffffffffffffffe8   R27 = c0000000ace4ffc0
R12 = 0000000000004000   R28 = 0000000000000001
R13 = c000000000574580   R29 = 0000000000000003
R14 = 0000000000000000   R30 = c00000000061bad8
R15 = c000000000442888   R31 = d0000000008baa50
pc  = c000000000065be4 .__wake_up_common+0x44/0xe8
lr  = c000000000069768 .__wake_up+0x54/0x88
msr = 8000000000001032   cr  = 24000022
ctr = 80000000001af404   xer = 0000000000000002   trap =  300
dar = 0000000000000000   dsisr = 40010000
0:mon>

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
