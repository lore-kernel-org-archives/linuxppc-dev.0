Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (adsl-203-134.38-151.net24.it [151.38.134.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1B28DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Jul 2007 22:27:51 +1000 (EST)
Received: from mail.gnudd.com (rubini@localhost [127.0.0.1])
	by mail.gnudd.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	l6KCDMPm024064
	for <linuxppc-embedded@ozlabs.org>; Fri, 20 Jul 2007 14:13:22 +0200
Received: (from rubini@localhost)
	by mail.gnudd.com (8.13.4/8.13.4/Submit) id l6KCDMhC024061
	for linuxppc-embedded@ozlabs.org; Fri, 20 Jul 2007 14:13:22 +0200
Date: Fri, 20 Jul 2007 14:13:22 +0200
From: Alessandro Rubini <rubini@gnudd.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kmalloc returns which address
Message-ID: <20070720121322.GA24055@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <11705981.post@talk.nabble.com>
References: <11705981.post@talk.nabble.com>
	<e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello.

> In linux kmelloc returns the pointer to virtual address not the physical
> address, to return to the physical address there is different function
> called ioremap 

Not exactly. Both return virtual addresses. The kmalloc one is allocated
RAM memory, the ioremap is the virtual address built for you to
access a physical address you specified (i.e., a device memory area).

>> For Tx and Rx, hardware uses buffers, so I have to allocate buffers and
>> pass
>> the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
>> should convert it into physical address?

If you allocate with kmalloc, use __pa(addr) to turn the virtual
address addr into the physical address you need to pass to the device,
ad DMA access is outside of the virtual view of the address space.

However, please note that according to how your device is connected
and what bus it is using, the design can get more hairy, you may need
to study the consistent memory allocations.

Hope this helps
/alessandro
