Return-Path: <arun.prabha@wipro.com>
Received: from wip-ectls-mx1.wipro.com (wip-ectls-mx1.wipro.com
	[203.91.193.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx1.wipro.com",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 917136842D
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2005 02:12:56 +1000 (EST)
Received: from wip-ectls-mx1.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 3D1F822004F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2005 21:30:55 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ectls-mx1.wipro.com (Postfix) with ESMTP id 30D3A220003
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2005 21:30:55 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 28 Sep 2005 21:30:54 +0530
Message-ID: <3D81D46E0E63304FBC9ECEB136B4CF26E92246@BLR-EC-MBX04.wipro.com>
From: <arun.prabha@wipro.com>
To: <linuxppc-dev@ozlabs.org>
Cc: arun.prabha@wipro.com
Subject: Help Reqd on Strange kernel panic with PPC-405 running Linux.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hi All,

I am seeking help for a custom kernel module. If this is not the
appropriate
list, I apologize and could you point me to the right list.

I am seeing a strange kernel panic in a tasklet that gets
scheduled by an ISR. The panic happens when it tries to write to
a memory mapped register. A function is called to write to the
register in the tasklet with the base address, offset and value,
as arguments(in this order). The function adds the base and offset
and uses writel() to do the actual write.

This usually works fine. But when the panic happens, register r3
(base) and r4 (offset) have the same value. r3/base is the expected
ioremaped address, but r4 somehow gets the value of base. This is
strange as we always use #defined values for the offset (After the
panic, I have verified that the load immediate instruction has the
correct value and is not corrupted). When r3 and r4 are added, we=0D
get an invalid virtual address and the kernel panics. In the oops
message it is clear that r0 is r3 + r4.

This is what the disassembled code looks like.
000005f8 <write_to_register>:
     5f8:   7c 03 22 14     add r0,r3,r4
     5fc:   7c a0 05 2c     stwbrx  r5,r0,r0
     600:   7c 00 06 ac     eieio
     604:   4e 80 00 20     blr

The most puzzling part I felt is that when I modified the code to loop
infinitely if base and offset are equal (See below for the new code),
we don't see the panic at all. In the above case the panic
happens in just a few minutes when I increase the frequency of the
interrupts, While in this case it works for hours.

000005f8 <write_to_register>:
     5f8:   7c 03 20 00     cmpw    r3,r4
     5fc:   41 a2 00 00     beq+    5fc <write_to_register+0x4>
     600:   7c 03 22 14     add r0,r3,r4
     604:   7c a0 05 2c     stwbrx  r5,r0,r0
     608:   7c 00 06 ac     eieio
     60c:   4e 80 00 20     blr

I don't see the problem when I modify in the following ways.
1. Add two nops before the add r0,r3,r4 instruction. (With one nop the=0D
   problem happens).
2. Inlining the register write function.

Basically, I have observed that even the slightest change in the
instruction
sequence in and around the call to the register write function obviates
the
problem.

In the tasklet this register write routine is called a lot of times,
sometimes in big loops, to program different registers. But the crash
always happens at the same place.

There seems to be no data corruption. I can't say for sure for a stack
corruption,
but then why does the nops fix (or at least appears to have fixed) the
issue.

Could this be due to some errors in instruction re-ordering/branch
prediction
by the processor?=0D

Hoping that the problem is something obvious to the PPC gurus.
I would appreciate any help/tips on what could be the problem.

I am running MontaVista Linux on a Xilinx PPC405.

Thanks in advance,
Arun.

PS. Please cc me as I am not subscribed to the group.



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
