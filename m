Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 01E28B7BA5
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 08:38:05 +1100 (EST)
Message-ID: <4B182FBC.7040104@ovro.caltech.edu>
Date: Thu, 03 Dec 2009 13:38:04 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: PCI interrupt question
References: <1259821316.12651.26.camel@qu102.quarc.com>	<4B17F14A.1060001@ovro.caltech.edu>	<1259869140.18190.52.camel@qu102.quarc.com>	<4B1816F9.1020601@ovro.caltech.edu>
	<20091203212821.463D5E6D391@gemini.denx.de>
In-Reply-To: <20091203212821.463D5E6D391@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jeff Hane <jeff.hane@maxim-ic.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfgang,

> In message <4B1816F9.1020601@ovro.caltech.edu> you wrote:
>> Yep. It might require enabling a PCI subsystem in U-Boot.
>> I recall playing with a Yosemite board and a PCI card,
>> but I forget whether I had to do anything to enable
>> PCI configuration space setup. Post a question to the
>> U-Boot list.
> 
> PCI is enabled by default on the Canyonlands board, both in U-Boot and
> Linux.

Great, thanks!

So Jeff, check out whether or not you can write to the
IRQ register in the PCI configuration space of the device
(using setpci from your host).

If you cannot write to the register, then I'd check your
FPGA core settings.

Cheers,
Dave

PS. Here's the output of lspci for a couple of machines I
have in the lab:

----------------------------------------------------------------------
PLX PCI-9054 master/target interface, with Trenton x86 host board
-----------------------------------------------------------------

[dwh@labslcor6 ~]$ lspci -s 03:0c.0 -v
03:0c.0 Bridge: PLX Technology, Inc. PCI9054 32-bit 33MHz PCI <-> IOBus 
Bridge (
rev 0a)
         Subsystem: PLX Technology, Inc. PCI9054 32-bit 33MHz PCI <-> 
IOBus Bridg
e
         Flags: bus master, medium devsel, latency 64, IRQ 169
         Memory at fe9ff000 (32-bit, non-prefetchable) [size=256]
         Memory at fb000000 (32-bit, prefetchable) [size=8M]
         Capabilities: <access denied>

[dwh@labslcor6 ~]$ lspci -s 03:0c.0 -x
03:0c.0 Bridge: PLX Technology, Inc. PCI9054 32-bit 33MHz PCI <-> IOBus 
Bridge (
rev 0a)
00: b5 10 54 90 17 01 90 02 0a 00 80 06 08 40 00 00
10: 00 f0 9f fe 08 00 00 fb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b5 10 54 90
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00


0x3c = IRQ 11, whereas the lspci output indicates IRQ 169,
so there is an IRQ mapping going on there.

----------------------------------------------------------------------
MPC8349EA-based board, with Force Computers x86 host CPU
--------------------------------------------------------

[dwh@labslcor4 ~]$ lspci -s 01:0b.0 -v
01:0b.0 Power PC: Freescale Semiconductor Inc MPC8349E (rev 30)
         Flags: 66MHz, fast devsel, IRQ 9
         Memory at f9100000 (32-bit, non-prefetchable) [size=1M]
         Memory at f9600000 (32-bit, non-prefetchable) [size=4K]
         Memory at f9500000 (32-bit, non-prefetchable) [size=1M]
         Memory at f9400000 (64-bit, non-prefetchable) [size=1M]
         Capabilities: <access denied>

[dwh@labslcor4 ~]$ lspci -s 01:0b.0 -x
01:0b.0 Power PC: Freescale Semiconductor Inc MPC8349E (rev 30)
00: 57 19 80 00 02 01 b0 00 30 00 20 0b 08 40 00 00
10: 00 00 10 f9 00 00 60 f9 00 00 50 f9 00 00 00 00
20: 04 00 40 f9 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 48 00 00 00 00 00 00 00 09 01 00 00


0x3c = IRQ 9, and that matches the lspci output, so there is
no extra mapping here.
