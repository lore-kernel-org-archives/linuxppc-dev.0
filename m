Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id A540BB7C98
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 06:14:50 +1100 (EST)
Message-ID: <4B857AA8.9000208@mlbassoc.com>
Date: Wed, 24 Feb 2010 12:14:48 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: PCI on 834x
References: <4B854A93.7030405@mlbassoc.com> <4B85746F.3020200@freescale.com>
In-Reply-To: <4B85746F.3020200@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/24/2010 11:48 AM, Scott Wood wrote:
> Gary Thomas wrote:
>> Does anyone have experience setting up the PCI controller on
>> the MPC8349? I have it running fine when my system has 128MB
>> or less of main memory, but when I have 256MB or more, it all
>> falls apart :-(
>>
>> Any indication of the pertinent settings would be appreciated.
>
> Check the inbound PCI translation registers, especially PIWARn.

Yes, I set it to 256MB (the size of RAM).
I also set PCI_AR0 to a 512MB window (when it's set to 256, I
get address [segmentation violation] errors when accessing my
devices that end up at the high end of the logical address space)
Finally, I set POCMR0 to a 512MB window (corresponding to PCI_AR0)

In this configuration, my device doesn't seem to be able to
access RAM.  If PIWAR1 is too small, the device just hangs.

=============================== 128MB setup =========================
PIWAR1 = 0xA0055000 | (27-1)
POCMR0 = 0x800F0000
PCIAR0 = 0x80000000 | (28-1)
00:00.0 Power PC: Unknown device 1957:0082 (rev 30)
         Flags: bus master, 66MHz, fast devsel, latency 0
         Memory at cc000000 (32-bit, non-prefetchable) [size=1M]
         Memory at c0000000 (64-bit, prefetchable) [size=128M]
         Memory at <unassigned> (64-bit, non-prefetchable)
         Capabilities: [48] #06 [0000]

00:0b.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)
         Subsystem: Silicon Image, Inc. SiI 3512 SATALink Controller
         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 22
         I/O ports at 1000 [size=8]
         I/O ports at 1008 [size=4]
         I/O ports at 1010 [size=8]
         I/O ports at 1018 [size=4]
         I/O ports at 1020 [size=16]
         Memory at cc180000 (32-bit, non-prefetchable) [size=512]
         [virtual] Expansion ROM at cc100000 [disabled] [size=512K]
         Capabilities: [60] Power Management version 2

00:0c.0 Display controller: Fujitsu Limited. Unknown device 2019 (rev 01)
         Flags: bus master, medium devsel, latency 0, IRQ 19
         Memory at c8000000 (32-bit, non-prefetchable) [size=64M]
=====================================================================

=============================== 256MB setup =========================
PIWAR1 = 0xA0055000 | (28-1)
POCMR0 = 0x800E0000
PCIAR0 = 0x80000000 | (29-1)
00:00.0 Power PC: Unknown device 1957:0082 (rev 30)
         Flags: bus master, 66MHz, fast devsel, latency 0
         Memory at d4000000 (32-bit, non-prefetchable) [size=1M]
         Memory at c0000000 (64-bit, prefetchable) [size=256M]
         Memory at <unassigned> (64-bit, non-prefetchable)
         Capabilities: [48] #06 [0000]

00:0b.0 Mass storage controller: Silicon Image, Inc. SiI 3512 [SATALink/SATARaid] Serial ATA Controller (rev 01)
         Subsystem: Silicon Image, Inc. SiI 3512 SATALink Controller
         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 22
         I/O ports at 1000 [size=8]
         I/O ports at 1008 [size=4]
         I/O ports at 1010 [size=8]
         I/O ports at 1018 [size=4]
         I/O ports at 1020 [size=16]
         Memory at d4180000 (32-bit, non-prefetchable) [size=512]
         [virtual] Expansion ROM at d4100000 [disabled] [size=512K]
         Capabilities: [60] Power Management version 2

00:0c.0 Display controller: Fujitsu Limited. Unknown device 2019 (rev 01)
         Flags: bus master, medium devsel, latency 0, IRQ 19
         [virtual] Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
=====================================================================

Any ideas what I might be missing?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
