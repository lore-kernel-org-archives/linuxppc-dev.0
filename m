Return-Path: <lukebr@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0CDFDE234
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:04:50 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4LG1JW6027413
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 12:01:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4LG4VjQ066586
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:04:31 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4LG4UYp028232
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:04:30 -0600
Received: from [9.67.84.73] (wecm-9-67-84-73.wecm.ibm.com [9.67.84.73])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m4LG4TNC027711
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:04:30 -0600
Subject: qs21 crashes during boot.   Using 2.6.26-rc3.
From: Luke Browning <lukebr@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 21 May 2008 13:05:05 +0000
Message-Id: <1211375105.11785.6.camel@luke-desktop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Is this a known problem?  

Thx, Luke


0:mon> x
Unable to handle kernel paging request for data at address 0x00000170
Faulting instruction address: 0xc0000000000d8f70
cpu 0x0: Vector: 300 (Data Access) at [c0000000007c3500]
    pc: c0000000000d8f70: .kmem_cache_alloc+0x3c/0xd0
    lr: c00000000000f2dc: .alloc_thread_info+0x24/0x3c
    sp: c0000000007c3780
   msr: 9000000000009032
   dar: 170
 dsisr: 40000000
  current = 0xc0000000006a4080
  paca    = 0xc000000000833480
    pid   = 0, comm = swapper
enter ? for help

0:mon> di c0000000000d8f70
c0000000000d8f70  eba90170      ld      r29,368(r9)
c0000000000d8f74  7fa7eb78      mr      r7,r29
c0000000000d8f78  ebfd0000      ld      r31,0(r29)
c0000000000d8f7c  2fbf0000      cmpdi   cr7,r31,0
c0000000000d8f80  7cc802a6      mflr    r6
c0000000000d8f84  40be0010      bne     cr7,c0000000000d8f94
# .kmem_cache_alloc+0x60/0xd0
c0000000000d8f88  4bfff559      bl      c0000000000d84e0
# .__slab_alloc+0x0/0x514
c0000000000d8f8c  7c7f1b78      mr      r31,r3
c0000000000d8f90  48000014      b       c0000000000d8fa4
# .kmem_cache_alloc+0x70/0xd0
c0000000000d8f94  801d0014      lwz     r0,20(r29)
c0000000000d8f98  78001f24      rldicr  r0,r0,3,60
c0000000000d8f9c  7c1f002a      ldx     r0,r31,r0
c0000000000d8fa0  f81d0000      std     r0,0(r29)
c0000000000d8fa4  2fbc0000      cmpdi   cr7,r28,0
c0000000000d8fa8  38600000      li      r3,0
c0000000000d8fac  419e0008      beq     cr7,c0000000000d8fb4
# .kmem_cache_alloc+0x80/0xd0
0:mon> r
R00 = c00000000000f2dc   R16 = 4000000001400000
R01 = c0000000007c3780   R17 = c00000000057ba00
R02 = c0000000007b9068   R18 = c00000000057a3d8
R03 = 0000000000000000   R19 = 0000000000000000
R04 = 00000000000000d0   R20 = c0000000007c3b60
R05 = ffffffffffffffff   R21 = c0000000007c3de0
R06 = c00000003e02002b   R22 = 0000000000000001
R07 = c00000003ffeec90   R23 = 0000000000000000
R08 = 0000000000000048   R24 = 0000000000800b00
R09 = 0000000000000000   R25 = 0000000000000001
R10 = 0000000000000000   R26 = fffffffffffffff4
R11 = 0000000000000000   R27 = 00000000000000d0
R12 = 9000000000009032   R28 = 0000000000000001
R13 = c000000000833480   R29 = c00000003e130000
R14 = 0000000000000000   R30 = c000000000721fd0
R15 = 0000000000000000   R31 = c00000000083cb70
pc  = c0000000000d8f70 .kmem_cache_alloc+0x3c/0xd0
lr  = c00000000000f2dc .alloc_thread_info+0x24/0x3c
msr = 9000000000009032   cr  = 84000048
ctr = 0000000000000000   xer = 0000000000000000   trap =  300
dar = 0000000000000170   dsisr = 40000000
