Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19A5BDDE3B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 20:57:03 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IOAN2-0004bg-3D
	for linuxppc-embedded@ozlabs.org; Thu, 23 Aug 2007 03:57:00 -0700
Message-ID: <12291367.post@talk.nabble.com>
Date: Thu, 23 Aug 2007 03:57:00 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: signals handling in the kernel
In-Reply-To: <46C9C70D.9080903@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12032525.post@talk.nabble.com> <46B8A3C9.7060806@ovro.caltech.edu>
	<46B8BA93.8020909@ovro.caltech.edu> <12234438.post@talk.nabble.com>
	<46C9C70D.9080903@ovro.caltech.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi David,

    Thank you for your hints. I was not aware about race conditions in
signal handling routines. So far I did not noticed any anomalies when
running my server since I use only one interrupt which refers to only one
signal. 
I would be interested however in the solution you have suggested with:
SIGIO and fasync() 

Would you be so kind to provide me with some example code.

Best Regards

Mirek




David Hawkins-3 wrote:
> 
> Hi Mirek,
> 
>> In my case I found somehow more convenient to deal with
>> signals.
> 
> Ok.
> 
>> The server program which I use was originally written
>> for VxWorks. In VxWorks there was no separation betwenn
>> the user and kernel space. When the interrupt occured
>> in VxWorks the interrupt service routine was called.
>> The interrupt service routine was implemented in the server. 
>> 
>> I found it somehow easier to use signals to trigger signal handler
>> (previously in VxWorks interrupt service routine) than changing the
>> structure of the server to deal with select().
> 
> I guess it depends on what you consider 'easier'.
> Signals have potential race conditions, and so using
> select() is safer. I find it 'easier' to have less
> problems, so would spend the time to make the server
> use select().
> 
> But, you are free to ignore this advice. :)
> 
>> I hope however that there is no fundamental problem with
>> sending signals from kernel (interrupt service routine)
>> to the user space.
> 
> There are potential race conditions. I'm not sure if this
> problem was 2.4 kernel specific, or 2.6 kernel specific,
> or signals specific. I think its signals specific.
> 
> A web search should yield more info on this. Try googling
> 'signals race condition', and it looks like its a problem
> still.
> 
> So it depends on whether your server is running in
> a critical, and secure system, as to whether you want
> to stick with signals.
> 
>> I do not know why the function kill_proc_info does not 
>> export its symbol within the kernel 2.6.21 .
>> With previous version of the kernel 2.4 and early 2.6.*
>> the kill_proc_info symbol was exported.
> 
> If SIGIO is sufficient for you, then just use the driver
> fasync() call-back mechanism. The example code I referred
> to has an example. If its not clear to you, I can
> explain it.
> 
> If you're having to modify some corner of the kernel not
> used by many, then I'm sure your solution is not the
> correct one, and you won't get anyone helping you
> when things go wrong.
> 
> So, take the experience of others; re-write the server
> to use signals. If the server was well written to start
> with you should be able to call the 'signal handler'
> function after returning from your select() call with
> the handle ready. It shouldn't be that hard.
> 
> Come on, you've just returned from holiday, it should
> be no sweat to code up a new server :)
> 
> Regards,
> Dave
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/signals-handling-in-the-kernel-tf4229566.html#a12291367
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
