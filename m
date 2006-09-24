Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B60367A39
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Sep 2006 15:48:59 +1000 (EST)
Message-ID: <45161ADB.4020106@dlasys.net>
Date: Sun, 24 Sep 2006 01:42:51 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <mailman.241.1158193867.2423.linuxppc-embedded@ozlabs.org>
	<002501c6d79e$cca7ee40$800101df@monstertop>
	<528646bc0609131852s41a8bc4ev44b84d68f51b1d2d@mail.gmail.com>
	<45093A94.2080407@dlasys.net>
	<200609141353.k8EDrkPN065101@penguin.ncube.com>
	<528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
	<87hcz4z47p.fsf@sleipner.barco.com>
	<528646bc0609190717u1c7cd349m7e08e5bafd341c38@mail.gmail.com>
	<528646bc0609191310l240d9f94tb18415941f8b5d4f@mail.gmail.com>
	<451055D2.5080308@dlasys.net>
	<528646bc0609191427o11146c54q650738bcb10f8d98@mail.gmail.com>
In-Reply-To: <528646bc0609191427o11146c54q650738bcb10f8d98@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>
> Step 1: run away
> Step 2: don't look back.
    There are days.

>
> Just kidding.  Unless you want to help move Virtex support from
> arch/ppc to arch/powerpc, you don't really need to worry about device
> trees for a while.
>
> If you are interested, look at
> Documentation/powerpc/booting-without-of.txt.  Then start poking Matt
> Porter about when he's going to get 4xx ported to arch/powerpc.
    That depends. I am a consultant. My works is primarily paid for by
my clients, clients.
    I tinker when I am not otherwise busy. But I am very busy, despite
being short on work !?

   
>
> I've been half heartedly looking at what needs to be done to generate
> a device tree based on either system.mhs or xparameters.h.  I'm
> probably going to write a tiny C program that is compiled against
> xparameters.h and spits out a valid dts file.  The dts file can then
> be run through the device tree compiler to produce the flattened
> device tree structure.
    That sounds somewhat interesting.

    But as was somewhat raised elsewhere - what about partial
reprogramming the FPGA on the fly ?
   
    One of the fundimental issues I am facing, is that I have to deal
with a system where nothing is certain except that there is a
    ppc405 present. There will always be more than that - but there is
not another component that MUST be present.
    As things go forward, more optional components get added.
    Pico is not yet doing partial FPGA reprogramming on the fly - but I
am certain it is coming. It fits perfectly with the goals and objectives
    of the company and its clients.

    For the moment the problem is fairly small. But it is only going to
get worse with time. The decisions I make now, will either make my life
pleasant or horrible later.
    Better to work towards where we are going now.

    I guess I need to digest
Documentation/powerpc/booting-without-of.txt. now. At the moment things
are  busy
>
>>
>>      The vague Picture I have is the have something to do with some
>> datastructure that Mac's typically create at or prior to boot. And
>> that for
>> embedded systems we are building them
>>      externally compiling them and then attaching the compiled device
>> tree
>> to our project.
>
> That right.  You don't compile device base addresses, irqs, etc into
> the kernel.  You pass them in at boot time with a data structure.
>
>>
>>      I got a Xilinv V4 device currently with a Pic, UartLite, TEMAC,
>> Flash
>> and Keyhole (pseuodo serial host interface). Of those it is only certain
>> that the flash will always be there.
>>      We have bit images with Keyhole only, Uartlite only TEMAC only,
>> Sometimes we have a Pic sometimes not. I was trying to get to the
>> point were
>> I could dynamically add what was there
>>      to Platform devices during initialization.
>>
>>      If Device trees are static, then do they even apply to what I
>> have to
>> deal with ?
>
> Device trees don't have to be static.  They can be generated/modified
> on the fly if the bootloader supports it.  Or you can pass a different
> tree depending on what IP you have on the board.
    Can you populate the tree dynamically inside the Linux setup code ?

>
> Cheers,
> g.
>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
