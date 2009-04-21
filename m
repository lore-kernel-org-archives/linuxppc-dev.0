Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id CB5C8DDF77
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 06:32:44 +1000 (EST)
Message-ID: <49EE2D67.10707@mlbassoc.com>
Date: Tue, 21 Apr 2009 14:32:39 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: PCI changes 2.6.26 => 2.6.28
References: <49EDF333.4000200@mlbassoc.com> <49EE2CD8.7010700@mlbassoc.com>
In-Reply-To: <49EE2CD8.7010700@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> Gary Thomas wrote:
>> I had a stable port of 2.6.26 for my 834x hardware, with a
>> frame buffer on a PCI device.  After I upgraded to 2.6.28,
>> this isn't working any more.  The frame buffer code is happily
>> writing to a mapped [memory] space on the PCI card, but nothing
>> is happening.
>>
>> Did something [subtle] change in how the PCI is handled in
>> this timeframe?  Perhaps with how PCI devices are mapped or
>> enabled?  I've looked at the changes between the two versions,
>> but nothing leaps out at me.
>>
>> n.b. I have other devices on the PCI bus, such as a SATA
>> controller, which work the same in both versions.
>>
>> Thanks for any ideas
>>
> 
> The difference seems to be in how the PCI bus gets mapped.
> 
> In the working, 2.6.26 based kernel, 'lspci -v' shows this:
> 
> 00:00.0 Bridge: Unknown device 1957:0084 (rev 11)
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Memory at cc000000 (32-bit, non-prefetchable) [size=1M]
>         Memory at c0000000 (64-bit, prefetchable) [size=128M]
>         Memory at cc143100 (64-bit, non-prefetchable) [size=1]
>         Capabilities: [48] #06 [0000]
> 
> 00:0a.0 Network controller: Unknown device 001c:0001 (rev 02)
>         Subsystem: Unknown device 001c:0004
>         Flags: medium devsel, IRQ 22
>         Memory at cc120000 (32-bit, non-prefetchable) [size=64K]
>         Memory at cc130000 (32-bit, non-prefetchable) [size=64K]
> 
> 00:0b.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus) (rev 02)
>         Subsystem: Promise Technology, Inc. Unknown device 3573
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 23
>         I/O ports at 1000 [size=128]
>         I/O ports at 1100 [size=256]
>         Memory at cc140000 (32-bit, non-prefetchable) [size=4K]
>         Memory at cc100000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [60] Power Management version 2
> 
> 00:0c.0 Display controller: Fujitsu Limited. Unknown device 2019 (rev 01)
>         Flags: bus master, medium devsel, latency 0, IRQ 24
>         Memory at c8000000 (32-bit, non-prefetchable) [size=64M]
> 
> 00:0d.0 USB Controller: Philips Semiconductors USB 1.1 Host Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Philips Semiconductors USB 1.1 Host Controller
>         Flags: bus master, medium devsel, latency 0, IRQ 25
>         Memory at cc141000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [dc] Power Management version 2
> 
> 00:0d.1 USB Controller: Philips Semiconductors USB 1.1 Host Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Philips Semiconductors USB 1.1 Host Controller
>         Flags: bus master, medium devsel, latency 0, IRQ 25
>         Memory at cc142000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [dc] Power Management version 2
> 
> 00:0d.2 USB Controller: Philips Semiconductors USB 2.0 Host Controller (rev 11) (prog-if 20 [EHCI])
>         Subsystem: Philips Semiconductors USB 2.0 Host Controller
>         Flags: bus master, medium devsel, latency 0, IRQ 25
>         Memory at cc143000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [dc] Power Management version 2
> 
> This is what 2.6.28 shows:
> 
> 00:00.0 Bridge: Unknown device 1957:0084 (rev 11)
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Memory at <unassigned> (64-bit, prefetchable)
>         Memory at <unassigned> (64-bit, non-prefetchable)
>         Capabilities: [48] #06 [0000]
> 
> 00:0a.0 Network controller: Unknown device 001c:0001 (rev 02)
>         Subsystem: Unknown device 001c:0004
>         Flags: medium devsel, IRQ 16
>         Memory at c4020000 (32-bit, non-prefetchable) [size=64K]
>         Memory at c4030000 (32-bit, non-prefetchable) [size=64K]
> 
> 00:0b.0 Mass storage controller: Promise Technology, Inc. PDC40775 (SATA 300 TX2plus) (rev 02)
>         Subsystem: Promise Technology, Inc. Unknown device 3573
>         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 21
>         I/O ports at 1000 [size=128]
>         I/O ports at 1100 [size=256]
>         Memory at c4040000 (32-bit, non-prefetchable) [size=4K]
>         Memory at c4000000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [60] Power Management version 2
> 
> 00:0c.0 Display controller: Fujitsu Limited. Unknown device 2019 (rev 01)
>         Flags: bus master, medium devsel, latency 0, IRQ 22
>         [virtual] Memory at c0000000 (32-bit, non-prefetchable) [size=64M]
> 
> 00:0d.0 USB Controller: Philips Semiconductors USB 1.1 Host Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Philips Semiconductors USB 1.1 Host Controller
>         Flags: bus master, medium devsel, latency 0, IRQ 23
>         Memory at c4041000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [dc] Power Management version 2
> 
> 00:0d.1 USB Controller: Philips Semiconductors USB 1.1 Host Controller (rev 11) (prog-if 10 [OHCI])
>         Subsystem: Philips Semiconductors USB 1.1 Host Controller
>         Flags: bus master, medium devsel, latency 0, IRQ 23
>         Memory at c4042000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [dc] Power Management version 2
> 
> 00:0d.2 USB Controller: Philips Semiconductors USB 2.0 Host Controller (rev 11) (prog-if 20 [EHCI])
>         Subsystem: Philips Semiconductors USB 2.0 Host Controller
>         Flags: bus master, medium devsel, latency 0, IRQ 23
>         Memory at c4043000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [dc] Power Management version 2
> 
> The [two] big differences I see are that the video card (00:0d.0)
> is being assigned 0xC0000000, which lspci marks as "virtual".
> I think I've had trouble in the past with memory regions which
> started at 0 relative to the PCI space.  Also "virtual" concerns me.
> 
> Does this spark any ideas from anyone?
> 

n.b. "virtual" means that Linux reports that the device has
been mapped to 0xC0000000, but the device address register
is still unset :-(  How can this happen?


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
