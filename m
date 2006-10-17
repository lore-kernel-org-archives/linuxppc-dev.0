Return-Path: <walkinair@cn.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0294267BF2
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 23:17:15 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.8/8.13.5) with ESMTP id k9HDQqBP162846
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 23:26:52 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9HDKSNZ201498
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 23:20:34 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9HDH3qe000924
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 23:17:03 +1000
Message-ID: <4534D7C6.2080402@cn.ibm.com>
Date: Tue, 17 Oct 2006 21:16:54 +0800
From: Yao Fei Zhu <walkinair@cn.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [Regression] cpu hotplug failed on kernel 2.6.19-rc2
Content-Type: text/plain; charset=gb2312
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Running cpu hotplug regression tsstcase lhcs_regression on kernel 2.6.19-rc2/IBM System p5 will fall into xmon.

1:mon> e
cpu 0x1: Vector: 300 (Data Access) at [c000000023fa3570]
    pc: c0000000000abfa0: .__drain_pages+0x50/0xbc
    lr: c0000000000abfd8: .__drain_pages+0x88/0xbc
    sp: c000000023fa37f0
   msr: 8000000000001032
   dar: 0
 dsisr: 40010000
  current = 0xc000000002a5d070
  paca    = 0xc000000000494800
    pid   = 3345, comm = hotplug01.sh
1:mon> t
[c000000023fa3890] c0000000000ac040 .page_alloc_cpu_notify+0x34/0x70
[c000000023fa3910] c000000000378190 .notifier_call_chain+0x4c/0x90
[c000000023fa39a0] c000000000076b2c .blocking_notifier_call_chain+0x3c/0x6c
[c000000023fa3a40] c00000000008989c .cpu_down+0x218/0x32c
[c000000023fa3b30] c000000000242a0c .store_online+0x44/0xa0
[c000000023fa3bc0] c00000000023d0e0 .sysdev_store+0x44/0x60
[c000000023fa3c40] c00000000013f160 .sysfs_write_file+0x134/0x1b8
[c000000023fa3cf0] c0000000000dd814 .vfs_write+0x118/0x200
[c000000023fa3d90] c0000000000ddf84 .sys_write+0x4c/0x8c
[c000000023fa3e30] c00000000000871c syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000fe0de7c
SP (f8ccc0c0) is in userspace
1:mon> r
R00 = 8000000000001032   R16 = 00000000100a0000
R01 = c000000023fa37f0   R17 = 00000000100c2cd8
R02 = c0000000005cc460   R18 = 000000000000003f
R03 = c000000049fff600   R19 = 0000000000000000
R04 = 0000000000000000   R20 = c0000000004c9078
R05 = c000000020dc3250   R21 = 0000000000000005
R06 = 0000000000000000   R22 = c000000000665180
R07 = 0000000000000000   R23 = 0000000000008002
R08 = 0000000000000008   R24 = 0000000000000005
R09 = c000000049fff628   R25 = 0000000000000005
R10 = 0000000000000100   R26 = 0000000000000005
R11 = c000000049fff600   R27 = 0000000000000000
R12 = 0000000000000000   R28 = c000000049fff600
R13 = c000000000494800   R29 = 8000000000001032
R14 = 0000000010080000   R30 = c0000000004d31c8
R15 = 0000000000000000   R31 = 0000000000000000
pc  = c0000000000abfa0 .__drain_pages+0x50/0xbc
lr  = c0000000000abfd8 .__drain_pages+0x88/0xbc
msr = 8000000000001032   cr  = 24242448
ctr = c0000000000ac00c   xer = 0000000000000001   trap =  300
dar = 0000000000000000   dsisr = 40010000
1:mon> di c0000000000abfa0
c0000000000abfa0  e89f0002      lwa     r4,0(r31)
c0000000000abfa4  7f83e378      mr      r3,r28
c0000000000abfa8  38bf0010      addi    r5,r31,16
c0000000000abfac  38c00000      li      r6,0
c0000000000abfb0  4bfff9c1      bl      c0000000000ab970        #
.free_pages_bulk+0x0/0x2b4
c0000000000abfb4  38000000      li      r0,0
c0000000000abfb8  901f0000      stw     r0,0(r31)
c0000000000abfbc  7fa10164      mtmsrd  r29,1
c0000000000abfc0  3b7b0001      addi    r27,r27,1
c0000000000abfc4  3bff0020      addi    r31,r31,32
c0000000000abfc8  2fbb0002      cmpdi   cr7,r27,2
c0000000000abfcc  409effc4      bne     cr7,c0000000000abf90    #
.__drain_pages+0x40/0xbc
c0000000000abfd0  7f83e378      mr      r3,r28
c0000000000abfd4  48008c09      bl      c0000000000b4bdc        #
.next_zone+0x0/0x48
c0000000000abfd8  60000000      nop
c0000000000abfdc  2fa30000      cmpdi   cr7,r3,0
1:mon> mi
1:mon>
