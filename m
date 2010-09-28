Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 3169FB7108
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Sep 2010 01:31:56 +1000 (EST)
Date: Tue, 28 Sep 2010 08:31:54 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: david.hagood@gmail.com
Subject: Re: Parsing a bus fault message?
Message-ID: <20100928153153.GA22485@ovro.caltech.edu>
References: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2bef2051c143a8d6e619519b222016f9.squirrel@localhost>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2010 at 09:26:51AM -0500, david.hagood@gmail.com wrote:
> I finally found my problems accessing the PPC OWBAR registers as an
> endpoint (copy/paste brown paper bag bug on my part), but I still get a
> bus fault trying to access the device.
> 
> The problem is that I don't know if the fault is internal to the PPC (e.g.
> I don't have something in the chip set up) or if the fault is happening on
> the PCIe side of things.
> 
> Are there any good how-tos on interpreting the kernel machine check error
> for the PPC, that might help me know where to look for the problem?
> 
> 
> Alternatively, can somebody see a hint in the message that I don't know
> enough to pick out? At this point, my code is trying to memcpy() from the
> PCIe bus (mapped via the outbound ATMU) to local memory, so the fault is
> either a) the ATMU is not accessible b) the ATMU is accessible but not
> mapped (which I would have thought the ioremap call I made would have
> handled) or c) the chip is not able to bus master on the PCI bus.
> 
> 
> Machine check in kernel mode.
> Caused by (from SRR1=149030): Transfer error ack signal

^^^ this is the line that contains some critical info

In the 86xx CPU manual, you should be able to find information about the
SRR1 register. Decoding the hex SRR1=0x149030 may help.

The kernel is telling you this is a TEA (transfer error acknowledge)
error. I've only seen this when I get an unhandled timeout on the local
bus. For example, a FPGA that has died in the middle of a request.

On the PCI bus, I haven't seen this error. The 83xx PCI controller is
smart enough to return 0xffffffff when reading a non-existent device.

I'm only familiar with 83xx, so I can't help too much on an 86xx board.
My best advice is: check your addresses. Make sure they're correct.

I assume that PCI on 86xx behaves similarly to 83xx. If you read from an
outbound window, your access gets translated into a PCI address and goes
onto the PCI bus. A good way of testing this is with the devmem utility
(part of busybox). It allows you to read/write any physical memory
location.

Using devmem will help you determine if the problem is in your code or
in your setup procedure.

I hope it helps,
Ira

> Oops: Machine check, sig: 7 [#1]
> SMP NR_CPUS=2 EP8641A
> Modules linked in: Endpoint_driver rionetlink
> NIP: c0014e80 LR: f102d434 CTR: 00000200
> REGS: ef05fdf0 TRAP: 0200   Not tainted  (2.6.26.2-ep1.10)
> MSR: 00149030 <EE,ME,IR,DR>  CR: 24004482  XER: 00000000
> TASK = ef05b310[76] 'cat' THREAD: ef05e000 CPU: 0
> GPR00: 00000000 ef05fea0 ef05b310 eed06000 f14dfffc 00001000 eed05ffc
> 80000000
> GPR08: 00000000 00000000 00001000 c0014e60 00001000 100a7264 0ffff100
> 00000001
> GPR16: ffffffff 004005b4 007fff00 c0290000 c02f0000 ef05ff20 bfba5978
> eed06000
> GPR24: eed14ce0 ef02c678 eed61910 00000000 00000000 efb8d4b0 fffffffb
> 00001000
> NIP [c0014e80] memcpy+0x20/0x9c
> LR [f102d434] Endpoint_atmu_read+0x4c/0x90 [Endpoint_driver]
> Call Trace:
> [ef05fea0] [ef05609c] 0xef05609c (unreliable)
> [ef05feb0] [c00cf2c0] read+0xd8/0x1c8
> [ef05fef0] [c007ff40] vfs_read+0xcc/0x16c
> [ef05ff10] [c008074c] sys_read+0x4c/0x90
> [ef05ff40] [c0011174] ret_from_syscall+0x0/0x38
> --- Exception: c01 at 0xff697f0
>     LR = 0x10007008
> Instruction dump:
> 4200fff0 4e800020 7c032040 418100a0 54a7e8ff 38c3fffc 3884fffc 41820028
> 70c00003 7ce903a6 40820054 80e40004 <85040008> 90e60004 95060008 4200fff0
> ---[ end trace e0620da52f69882d ]---
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
