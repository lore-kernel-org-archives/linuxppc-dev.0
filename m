Return-Path: <wolfgang.reissnegger@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 89FCCDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 01:36:58 +1000 (EST)
Date: Thu, 30 Aug 2007 08:36:49 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: melinda develey <melinda.develey70@yahoo.com>
Subject: Re: spin_lock doesn't work?!?
References: <762949.1267.qm@web63906.mail.re1.yahoo.com>
In-Reply-To: <762949.1267.qm@web63906.mail.re1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <20070830153614.5574C7E80A9@mail153-dub.bigfish.com>
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

Hi Melinda,

I agree with Josh, you should use spin_lock_irqsave(), especially in
your ioctl() routine. spin_lock_irqsave will not compile into a no-op,
even on a single processor machine and will at least disable interrupts.
On SMP machines they will also spin.

Depending on the type of access of the variables in your ioctl()
routine, you might want to consider using read/write spin-locks.

It is not wrong to use spin_locks the way use want to use them.
spin_locks are the right tool to protect a short section in your code.

Cheers,
   Wolfgang

melinda develey wrote:
> 
>     >You should still put the spin_lock calls into your code because >you
>     >never know if someone else will compile it and for another >target. If
>     >someone would, for example, compile the same code for a SMP
>     >machine then
>     >the spin_lock will actually lock.
>     I used the spinlock both in an interrupt handler to protect a group
>     of variables (because in an interrupt I can't use a semaphore) and
>     the same spinlock in a ioctl handler where the same group of
>     variables is accessed. Is this wrong? I have a 2.6.19.2 linux kernel.
>      
>     Thank you,
>     Melinda.
>      
>      
>      
> 
> ------------------------------------------------------------------------
> Ready for the edge of your seat? Check out tonight's top picks
> <http://us.rd.yahoo.com/evt=48220/*http://tv.yahoo.com/> on Yahoo! TV.
