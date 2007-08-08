Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBE92DDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 17:32:45 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IIg26-0003Hs-FA
	for linuxppc-embedded@ozlabs.org; Wed, 08 Aug 2007 00:32:42 -0700
Message-ID: <12048448.post@talk.nabble.com>
Date: Wed, 8 Aug 2007 00:32:42 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: signals handling in the kernel
In-Reply-To: <46B8BA93.8020909@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12032525.post@talk.nabble.com> <46B8A3C9.7060806@ovro.caltech.edu>
	<46B8BA93.8020909@ovro.caltech.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Dave,

       I run embedded Linux on ppc405 (ml403 xilinx evaluation board). I use
the GPIO based device build on FPGA part of the xilinx chip.  My gpio device
generates interrupts whenever it changes its state.
I use Montavista gpio driver with some modifications to react on interrupts.
Each time when interrupt occurs the interrupt handler routine is called.
This routine sends the signal to the application in user space to trigger
it. When the application is triggered it reads the data from the GPIO
device.

I read that in this situation the best is to use signals. In my case the
ideal would be to use kill_proc_info which sends to the application the
Signal with info data were I intended to put just one integer value. Such a
value determines how to react for the signal on the application level.

Would you have some other suggestion better then the kill_proc_info function
use or even different technique then signaling.

Could you please direct me to the Rubini documentation which you have
mentioned in your last post.

Many thanks 

Mirek 




David Hawkins-3 wrote:
> 
> 
> Hi Mirek,
> 
>>>     I would like to send signals from the interrupt handler
>>> routine (in the kernel) to the user application (in user space).
>>> I have googled on that net and I have found that it could be done with
>>> the
>>> function: kill_proc_info.
>> 
>> Look in Rubini for the section regarding asynchronous
>> notification, Ch 6.
>> 
>> The callback to generate SIGIO is fasync.
>> 
> 
> Actually, before you go off and implement something, can
> you describe why you want to use signals.
> 
> I mistakenly used signals once to indicate notification of
> an event. Then when I wanted multiple events from multiple
> boards I found the problem with signals; you don't know
> who sent it.
> 
> Using select() on multiple file descriptors ended up being
> a more appropriate solution for my application. That
> solution also works nicely with the ACE C++ ACE_Reactor
> pattern.
> 
> Cheers,
> Dave
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/signals-handling-in-the-kernel-tf4229566.html#a12048448
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
