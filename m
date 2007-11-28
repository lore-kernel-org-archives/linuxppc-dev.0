Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB5ABDDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 19:41:11 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id lAS6TVrX028659
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 17:29:31 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lAS6XA77234184
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 17:33:10 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAS6THF2000916
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 17:29:17 +1100
Message-ID: <474D0AAC.5010005@linux.vnet.ibm.com>
Date: Wed, 28 Nov 2007 11:59:00 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: [BUG] 2.6.24-rc3-git2 softlockup detected 
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Soft lockup is detected while bootup with 2.6.24-rc3-git2 on powerbox

BUG: soft lockup - CPU#1 stuck for 11s! [insmod:375]
NIP: c00000000002f02c LR: d0000000001414fc CTR: c00000000002f018
REGS: c00000077cbef0b0 TRAP: 0901   Not tainted  (2.6.24-rc3-git2-autotest)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24022088  XER: 00000000
TASK = c00000077cbd8000[375] 'insmod' THREAD: c00000077cbec000 CPU: 1
GPR00: d0000000001414fc c00000077cbef330 c00000000052b930 d000080080002014 
GPR04: d00008008000202c 0000000000000000 c00000077ca1cb00 d00000000014ce54 
GPR08: c00000077ca1c63c 0000000000000000 000000000000002a c00000000002f018 
GPR12: d000000000143610 c000000000473d00 
NIP [c00000000002f02c] .ioread8+0x14/0x60
LR [d0000000001414fc] .sym_hcb_attach+0x1188/0x1378 [sym53c8xx]
Call Trace:
[c00000077cbef330] [c00000077cbef3c0] 0xc00000077cbef3c0 (unreliable)
[c00000077cbef3a0] [d0000000001414fc] .sym_hcb_attach+0x1188/0x1378 [sym53c8xx]
[c00000077cbef470] [d0000000001395f8] .sym2_probe+0x700/0x99c [sym53c8xx]
[c00000077cbef710] [c0000000001bc118] .pci_device_probe+0x124/0x1b0
[c00000077cbef7b0] [c000000000221138] .driver_probe_device+0x144/0x20c
[c00000077cbef850] [c000000000221450] .__driver_attach+0xcc/0x154
[c00000077cbef8e0] [c00000000021ff94] .bus_for_each_dev+0x7c/0xd4
[c00000077cbef9a0] [c000000000220e9c] .driver_attach+0x28/0x40
[c00000077cbefa20] [c0000000002204d8] .bus_add_driver+0x90/0x228
[c00000077cbefac0] [c000000000221858] .driver_register+0x94/0xb0
[c00000077cbefb40] [c0000000001bc430] .__pci_register_driver+0x6c/0xcc
[c00000077cbefbe0] [d000000000143428] .sym2_init+0x108/0x15b0 [sym53c8xx]
[c00000077cbefc80] [c00000000008ce80] .sys_init_module+0x17c4/0x1958
[c00000077cbefe30] [c00000000000872c] syscall_exit+0x0/0x40
Instruction dump:
60000000 786b0420 38210070 7d635b78 e8010010 7c0803a6 4e800020 7c0802a6 
f8010010 f821ff91 7c0004ac 89230000 <0c090000> 4c00012c 79290620 2f8900ff 

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
