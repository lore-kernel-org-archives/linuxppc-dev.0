Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F98BDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 18:15:23 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IIghM-0004TE-D5
	for linuxppc-embedded@ozlabs.org; Wed, 08 Aug 2007 01:15:20 -0700
Message-ID: <12048974.post@talk.nabble.com>
Date: Wed, 8 Aug 2007 01:15:20 -0700 (PDT)
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

     I have found the book by Rubini you have mentioned:
http://www.oreilly.com/catalog/linuxdrive3/book/index.csp

I did not find however what would be the best way to propagate interrupt
signals to the USER level / notify the client that interrupt has occurred.

I have checked also in the kernel 2.4 kernel/signal.c file and
kill_proc_info symbol was there exported but in the kernel 2.6 it is not a
case. I have modified the kernel/signal.c file inserting the line:

EXPORT_SYMBOL(kill_proc_info);

and I use the kill_proc_info straight from the interrupt handler routine. I
do not know however if it is a safe 
solution. This what does not work with kill_proc_info is that (struct
siginfo *) pInfo->si_value.sival_int
is not passed to the user space. To pass an integer value I use (struct
siginfo *) pInfo->si_code instead.
This works but it is not an elegant solution since the si_code is meant to
be used for something else.

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
View this message in context: http://www.nabble.com/signals-handling-in-the-kernel-tf4229566.html#a12048974
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
