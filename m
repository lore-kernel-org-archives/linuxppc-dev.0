Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 96872B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Oct 2010 20:49:43 +1100 (EST)
Message-ID: <4CB2DE2B.7040504@windriver.com>
Date: Mon, 11 Oct 2010 17:51:39 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: david.hagood@gmail.com
Subject: Re: Questions on interrupt vector assignment on MPC8641D
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>	<20100921170700.53a99e56@udp111988uds.am.freescale.net>	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>	<20101007152626.4e834d43@udp111988uds.am.freescale.net>
	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
In-Reply-To: <adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

david.hagood@gmail.com wrote:
> First of all - where is all of this documented? There seems to be a great
> deal of "oral tradition" type knowledge here, but is any of it actually
> written down somewhere? (see below for examples)
> 
>> On Thu, 7 Oct 2010 15:12:26 -0500
>> This is asking for the 256th specifier in the interrupts property in
>> the mpic node -- not what you want.
> 
> That was from some of the previous emails in this thread.
> 
>> Ideally you would have a node for your device with an interrupt
>> specifier that you could look up with irq_of_parse_and_map().
> 
> OK, and how do these devices come into being? From what I can tell, they
> are defined by uBoot, and if uBoot doesn't define it, then you are out of
> luck.

You should define MSI device nodes on your target dts. And you can refer to the
file, mpc8572ds.dts.

Often U-Boot dose not generate MSI information and embed that to dtb.

> 
> But even assuming you can define these nodes at run time, as far as I can
> see, you are right back to the question of "and how do I know what the
> mappings are so I can create the node?" You haven't answered the question,
> you've just moved where you are asking it.

I think you can check fsl_msi.c to figure out what you want.
> 
> 
>> The vector/priority register (MSIVPR0) is at offset
>> 0x51c00.  Each interrupt source is 32 bytes.  The first interrupt
>> source is at 0x50000.
>>
>> So the interrupt number is (0x51c00 - 0x50000) / 32 = 224.
> 
> OK, so that's how you get the MPIC IRQ number. It's a pity that the key
> piece of information - "MPIC IRQ Numbers are defined by the interrupt
> vector table starting at 0x50000 and incrementing by 0x20 - see table 9.3
> of the MPD8641D manual for details" wasn't spelled out anywhere I could
> find.
> 
> Given the data I had: the kernel sources, the MPD8641D manual, and not
> much else, I had three unknowns:
> * a table of config registers, that could map an set of events into an
> arbitrary vector number.
> * The standard kernel "request_irq" API that takes that arbitrary vector
> number
> * A set of APIs (irq_of_parse_and_map(), irq_create_mapping) that were,
> for all intents, undocumented (just "here's the parameters", no
> description of when and how to use them), that took a ???? and returned a
> ???? (because, with the documentation I had, that's basically all I could
> say about them).

Firstly you should use irq_of_parse_and_map()/irq_create_mapping() to map the
real hardware irq to virtual irq. Then use request_irq() with the virtual irq to
hook your interrupt handler.

> 
> There was no documentation that said how to compute the MPIC interrupt
> vector, no documentation that said which API to use to convert that to an
> kernel IRQ, nothing.

Often most latest classic books/articles always use x86 code as an example to
clarify Linux. So you have to understand something on PPC via codes. But I think
you will benefit more information from the codes than documents :)

> 
>> BTW, the MSIs are already described in an msi node in the device tree.
> 
> As I stated previously - not that I can see. Neither does
> /proc/device_tree contain such a listing, nor does doing a
> "of_find_node_by_name(0,"msi");" nor "of_find_node_by_type(0,"msi");" find
> them.
> 
> It may be they are defined in PCI Root Complex mode, but again - I am
> writing code to handle Endpoint mode, which, as far as I can tell from the
> kernel sources, is NOT handled in any standardized way.

Maybe you can check the file, ppc4xx_pci.c since ppc4xx also can support EP as I
previously said. And sounds Scott will do something to support EP for Freescale
chip.

Looks you want to your host root complex to trigger MSI to mpc8641 EP target? If
so I'm a bit confused since MSIs should be delivered to to the Root Complex
resided on your host.

Tiejun

> 
> 
> Again, it would be nice were this sort of thing documented somewhere. If
> it is, I'd love a link - I've tried every combination of search terms I
> can think of to find it to no avail.
> 
> If it isn't documented, might I suggest that either a) creating a
> dedicated "Programming PPC Embedded devices and their components under
> Linux" be created, or b) an appropriate chapter or chapters be drafted and
> submitted to the Linux Device Drivers book.
> 
> 
> Don't take this message the wrong way - I do want to say "THANK YOU FOR
> THE HELP!" - I am just trying to point out why somebody with a fair amount
> of Linux kernel experience and a great deal of general embedded experience
> is having great trouble doing a simple thing.
> 
> I'll try creating a mapping, binding to it, and seeing what happens.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
