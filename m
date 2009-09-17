Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 9846AB7B68
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 02:08:59 +1000 (EST)
Message-ID: <4AB2592D.2020209@ovro.caltech.edu>
Date: Thu, 17 Sep 2009 08:43:41 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: FPGA access over PCI-E on MPC8536
References: <4AB1B84F.8080606@embedded-sol.com>
	<C13B4529-4766-48C9-8004-A45B4A6EAE69@kernel.crashing.org>
In-Reply-To: <C13B4529-4766-48C9-8004-A45B4A6EAE69@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felix,

>> On my custom MPC8536 based board running 2.6.31 kernel
>> FPGA is connected via x2 PCI-E lane. FPGA is identified
>> during PCI scan and is visible via lspci.
>>
>> 0000:01:00.0 Class ff00: Altera Corporation Unknown device 0004 (rev 01)
>>        Subsystem: Altera Corporation Unknown device 0004
>>        Flags: fast devsel, IRQ 16
>>        Memory at 98000000 (32-bit, non-prefetchable) [disabled] [size=1M]
>>        Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+ 
>> Queue=0/5 Enable-
>>        Capabilities: [78] Power Management version 3
>>        Capabilities: [80] Express Endpoint IRQ 0
>>        Capabilities: [100] Virtual Channel
>>
>>
>> However when I attempt to access FPGA memory my mmapping it in 
>> userspace the read hangs. The same happens in kernel space. Does it 
>> happen because FPGA memory is marked as disabled, or because FPGA code 
>> is doing something wrong ?
> 
> Can you access the device in u-boot?  That would possible tell you if 
> the HW is functioning or not.
> 
>> Another question is what can cause PCI device memory be marked as
>> disabled.
> 
> Good question, no idea how lspci decided to print [disabled].  Take a 
> look at lspci source and see :)


lspci has a -x and -xxx options to print the bytes in the
PCI configuration space header. You should use that to
see what the settings are, and then you'll be able
to interpret what disabled means.

For example, here's lspci run from an x86 host CPU looking
at an MPC8349EA processor peripheral board:

# lspci -s 04:0d.0 -v
04:0d.0 Power PC: Freescale Semiconductor Inc MPC8349E (rev 30)
         Flags: 66Mhz, fast devsel, IRQ 10
         Memory at fc300000 (32-bit, non-prefetchable) [size=1M]
         Memory at fe400000 (32-bit, prefetchable) [size=4K]
         Memory at fe300000 (64-bit, prefetchable) [size=1M]
         Memory at fe200000 (64-bit, prefetchable) [size=1M]
         Capabilities: [48] #06 [0080]

# lspci -s 04:0d.0 -x
04:0d.0 Power PC: Freescale Semiconductor Inc MPC8349E (rev 30)
00: 57 19 80 00 42 01 b0 00 30 00 20 0b 08 40 00 00
10: 00 00 30 fc 08 00 40 fe 0c 00 30 fe 00 00 00 00
20: 0c 00 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 00 00

The memory, non-prefetchable, and size are decoded from bits in
the base address registers. I'm pretty sure there is an
enabled/disabled bit in there too. Thats probably where your
lspci output is getting it from.

I suspect that you could perform a configuration space
write to enable that bit, or that the FPGA initialization
code should be setting that bit. It really depends on
what the PCIe component inside the FPGA was designed to
do.

For example, on the MPC8349EA processor configured as a
peripheral board, the PCI bridge can come up enabled, or
disabled. If the bridge is disabled, then it is up to the
PowerPC processor core (U-boot code) to enable the PCI
interface prior to the host CPU BIOS configuring the base
addresses in the interface. Its possible you've missed
something like this when you configured the core,
eg. an 'enable on boot option' (I haven't used the PCIe
core, so have no idea if this is an option - but you
could submit an Altera service request).

Since you're playing with an FPGA, you should be able to
connect Altera's logic analyzer core to the PCI interface
and capture traffic as well, so that could be used to
debug your problem.

Cheers,
Dave
