Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3F2BDDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Aug 2007 21:49:08 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IN5kn-0000aO-Ti
	for linuxppc-embedded@ozlabs.org; Mon, 20 Aug 2007 04:49:05 -0700
Message-ID: <12234438.post@talk.nabble.com>
Date: Mon, 20 Aug 2007 04:49:05 -0700 (PDT)
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


Thank you for you suggestions. Sorry for the dealy but I was on holidays.

I understand that select() is more appropriate solution to handle
interrupts.
In my case I found somehow more convenient to deal with signals. The server
program which I use was originally written for VxWorks. In VxWorks there was
no separation betwenn the user and kernel space. When the interrupt occured
in VxWorks the interrupt service routine was called. The interrupt service
routine was implemented in the server. 

I found it somehow easier to use signals to trigger signal handler
(previously in VxWorks interrupt service routine) than changing the
structure of the server to deal with select().

I hope however that there is no fundamental problem with sending signals
from kernel (interrupt service routine) to the user space.
I do not know why the function kill_proc_info does not export its symbol
within the kernel 2.6.21 .
With previous version of the kernel 2.4 and early 2.6.* the kill_proc_info
symbol was exported.

Best Regards

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
View this message in context: http://www.nabble.com/signals-handling-in-the-kernel-tf4229566.html#a12234438
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
