Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 80D20DE0DC
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 08:22:40 +1000 (EST)
Message-ID: <49EE4729.3000100@mlbassoc.com>
Date: Tue, 21 Apr 2009 16:22:33 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI changes 2.6.26 => 2.6.28
References: <49EDF333.4000200@mlbassoc.com>
	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>
	<49EE306D.3000401@mlbassoc.com>
In-Reply-To: <49EE306D.3000401@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gary Thomas wrote:
> Kumar Gala wrote:
>> On Apr 21, 2009, at 3:30 PM, Gary Thomas wrote:
>>
>>> The [two] big differences I see are that the video card (00:0d.0)
>>> is being assigned 0xC0000000, which lspci marks as "virtual".
>>> I think I've had trouble in the past with memory regions which
>>> started at 0 relative to the PCI space.  Also "virtual" concerns me.
>>>
>>> Does this spark any ideas from anyone?
>> Doesn't ring any bells.  What does cat /proc/iomem look like between the
>> two kernels.
> 
> About what I gleaned from lspci. The working 2.6.26 kernel has
> space mapped in the controller (exposed memory window, I think)
> and the video card got moved down accordingly.
> 
> ---------------------------------- 2.6.26
> c0000000-cfffffff : /pci@ff008500
>   c0000000-c7ffffff : 0000:00:00.0
>   c8000000-cbffffff : 0000:00:0c.0
>     c8000000-cbffffff : CoralP_fb
>   cc000000-cc0fffff : 0000:00:00.0
>   cc100000-cc11ffff : 0000:00:0b.0
>   cc120000-cc12ffff : 0000:00:0a.0
>   cc130000-cc13ffff : 0000:00:0a.0
>   cc140000-cc140fff : 0000:00:0b.0
>     cc140000-cc140fff : sata_promise
>   cc141000-cc141fff : 0000:00:0d.0
>     cc141000-cc141fff : ohci_hcd
>   cc142000-cc142fff : 0000:00:0d.1
>     cc142000-cc142fff : ohci_hcd
>   cc143000-cc1430ff : 0000:00:0d.2
>     cc143000-cc1430ff : ehci_hcd
>   cc143100-cc143100 : 0000:00:00.0
> f0000000-f1ffffff : f0000000.flash
> ff000200-ff0002ff : wdt
> ff003000-ff0030ff : i2c
> ff003100-ff0031ff : i2c
> ff004500-ff004507 : serial
> ff004600-ff004607 : serial
> ff022000-ff022fff : usb
>   ff022000-ff022fff : ehci_hcd
> ff023000-ff023fff : usb
>   ff023000-ff023fff : usb
>     ff023000-ff023fff : ehci_hcd
> ff024000-ff024fff : ethernet
>   ff024520-ff02453f : mdio
> ff025000-ff025fff : ethernet
> 
> ---------------------------------- 2.6.28
> c0000000-cfffffff : /pci@ff008500
>   c0000000-c3ffffff : 0000:00:0c.0
>     c0000000-c3ffffff : CoralP_fb
>   c4000000-c401ffff : 0000:00:0b.0
>   c4020000-c402ffff : 0000:00:0a.0
>   c4030000-c403ffff : 0000:00:0a.0
>   c4040000-c4040fff : 0000:00:0b.0
>     c4040000-c4040fff : sata_promise
>   c4041000-c4041fff : 0000:00:0d.0
>     c4041000-c4041fff : ohci_hcd
>   c4042000-c4042fff : 0000:00:0d.1
>     c4042000-c4042fff : ohci_hcd
>   c4043000-c40430ff : 0000:00:0d.2
>     c4043000-c40430ff : ehci_hcd
> f0000000-f1ffffff : f0000000.flash
> ff004500-ff004507 : serial
> ff004600-ff004607 : serial
> ff022000-ff022fff : usb
>   ff022000-ff022fff : ehci_hcd
> ff023000-ff023fff : usb
>   ff023000-ff023fff : usb
>     ff023000-ff023fff : ehci_hcd
> ff024000-ff024fff : ethernet
>   ff024520-ff02453f : mdio
> ff025000-ff025fff : ethernet
> 
> I'm still looking into how the PCI address register for the video
> card did not get written, even though the system obviously thinks
> it did (hence "virtual")
> 

It most definitely has something to do with 0xC0000000 being
assigned to the video card.  I changed my DTS to move everything
up (started the whole space at 0xC4000000) and the video card
came to life!  Of course, I'm not interested in this hack,
so the simplest thing would be to figure out why 2.6.26 allocated
that outgoing window and 2.6.28 doesn't


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
