Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EFD56B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Oct 2010 14:09:59 +1100 (EST)
Message-ID: <4CB3D1FF.6070102@windriver.com>
Date: Tue, 12 Oct 2010 11:11:59 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Questions on interrupt vector assignment on MPC8641D
References: <6e7b840fa55e4fba421e1b1cea2716ec.squirrel@localhost>	<1682399277683944B902B3657D2FCE21654570D791@CAREXCLUSTER03.ATL.CW.LOCAL>	<20100921170700.53a99e56@udp111988uds.am.freescale.net>	<fe4c3e4086132d746b79670f236302f1.squirrel@localhost>	<20101007152626.4e834d43@udp111988uds.am.freescale.net>	<adaf806ee1c11621dbb51246bef0acd8.squirrel@localhost>	<20101011105031.52a5c06a@udp111988uds.am.freescale.net>	<9af5fd3c8f713d261c7acdc1d195fb84.squirrel@localhost>
	<20101011123006.5b489d19@udp111988uds.am.freescale.net>
In-Reply-To: <20101011123006.5b489d19@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: david.hagood@gmail.com,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Mon, 11 Oct 2010 12:02:15 -0500
> <david.hagood@gmail.com> wrote:
> 
>> Re-ordering your questions a bit:
>>
>>> What board are you using?  What kernel?
>> One of 2 boards: Either an Embedded Planet or a Performance Tech uTCA
>> board based on the MPC8641D, running the 2.6.26 as supplied by EP.
> 
> That's a very old kernel.  Have you contacted EP support?
> 
> You may be better off trying to migrate anything board-specific to the
> latest kernel, rather than do new development on the vendor kernel,
> especially if you're looking for community support, and definitely if
> you're trying to do something that could be merged upstream to help
> others.
> 
> The MPC8641D itself is supported in mainline Linux.
> 
>>> On Sat, 9 Oct 2010 10:52:49 -0500
>>> Documentation/powerpc/dts-bindings/fsl/mpic.txt
>> Not present in the version I have.
> 
> We didn't have a time machine, so we were only able to add things to new
> releases, not old ones. :-)
> 
> Should it have been documented from the start?  Ideally, yes, and we're
> pickier now than we were then about insisting on bindings being
> documented before they're used.  But nothing's perfect.

On the *latest* tree you can find more than your tree:
------
Documentation/powerpc/dts-bindings/fsl/msi-pic.txt
Documentation/powerpc/booting-without-of.txt

If you want to understand dts in detail you can refer to the file,
------
http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

> 
>>> If it's not in the dts, add it.  If for whatever reason that's not an
>>> option, you can use irq_create_mapping() as I mentioned in the previous
>>> e-mail.
>> And as I've said previously, I have no good info on HOW to add the nodes,
>> WHAT to add, or WHERE. You may as well be saying "Bargle the Narbog".
> 
> There are no nodes to add with irq_create_mapping().

Sure.

> 
> Just bargle the narbog.
> 
>> And when I try to use irq_create_mapping() it seg faults, which doesn't
>> exactly help me get my interrupt hooked up.
> 
> Well, I didn't know it was going to do that...  Your usage of
> irq_create_mapping() seems fine, there's just something going wrong.

The 'NULL' host would be 'irq_default_host'. For OOPS you can check my another
email and hope its useful.

-Tiejun

> See my other reply about the number of MPIC interrupts.
