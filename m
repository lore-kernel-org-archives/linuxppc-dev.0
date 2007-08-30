Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35F8CDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 01:23:31 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IQlrj-0002ak-QZ
	for linuxppc-embedded@ozlabs.org; Thu, 30 Aug 2007 08:23:27 -0700
Message-ID: <12409543.post@talk.nabble.com>
Date: Thu, 30 Aug 2007 08:23:27 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: Re: signals handling in the kernel
In-Reply-To: <46B9FB23.8040903@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12032525.post@talk.nabble.com> <46B8A3C9.7060806@ovro.caltech.edu>
	<46B8BA93.8020909@ovro.caltech.edu> <12048448.post@talk.nabble.com>
	<46B9FB23.8040903@ovro.caltech.edu>
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

       I went throught the Rubini book about device drivers and I see that
you are absolutly right about
the way how to handle interrupts in the user space. 

When I find a bit of time I will try your first suggestion with read() which
bolckes in the user space and
waits forr ISR to write data to the buffer.

Many thanks for all your suggestions

Best Regards

Mirek




David Hawkins-3 wrote:
> 
> Hi Mirek,
> 
>> I run embedded Linux on ppc405 (ml403 xilinx evaluation board).
>> I use the GPIO based device build on FPGA part of the xilinx
>> chip. My gpio device generates interrupts whenever it changes
>> its state.
>>
>> I use Montavista gpio driver with some modifications to react
>> on interrupts. Each time when interrupt occurs the interrupt
>> handler routine is called. This routine sends the signal to the
>> application in user space to trigger it. When the application
>> is triggered it reads the data from the GPIO device.
>> 
>> I read that in this situation the best is to use signals. In my
>> case the ideal would be to use kill_proc_info which sends to the
>> application the Signal with info data were I intended to put just
>> one integer value. Such a value determines how to react for the
>> signal on the application level.
> 
> Signals are not the appropriate solution.
> 
> It sounds like your application is read-only, so how about
> the following use-cases for the driver:
> 
> 1. In user-space, you only have one GPIO, and the code
>     only needs to react in response to this one I/O port.
>     The information required by user-space is the 1-byte
>     (or 2, or 4) of GPIO
> 
>     Solution:
>     The driver implements a buffer that a user-space read() call
>     consumes. A user-space read() call blocks until there is
>     data in the buffer.
> 
>     The driver ISR reads the GPIO port, and writes the
>     contents to the buffer.
> 
> 2. In user-space, you have multiple GPIO ports, and
>     the code needs to respond to any one.
> 
>     Solution:
>     The driver implements the poll() call back so that
>     user-space can call select() on the multiple GPIO
>     file descriptors.
> 
>     Again, the driver ISR reads the different GPIO ports,
>     and writes the data to the GPIO specific buffer.
> 
> I have plenty of driver code lying around, and can point
> you to an example that implements both of these options.
> The driver easily supports both (1) and (2) since
> (1) is just a blocking-read, and (2) is poll().
> 
> Is the kernel 2.4 or 2.6? Here's some code I wrote for
> 2.6, and this code was ported from some 2.4 drivers
> (and I still have that code in CVS)
> 
> http://www.ovro.caltech.edu/~dwh/correlator/cobra_docs.html
> http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
> http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-762-Hawkins.pdf
> 
> I can re-write say the parallel port example to demonstrate
> how the value of the GPIO port (the parallel port) can be
> sent to user space. There's a parallel port interrupt
> example in there somewhere. I know I wrote a GPIO driver
> for my Yosemite board (440EP example), but I don't see it
> in that zip ... it must be lying around here somewhere :)
> 
> I wouldn't necessarily copy say a parallel port example
> verbatim, since there is only ever one of those devices
> in a system. There are more likely to be multiple GPIO ports,
> so the driver design would be generalized a little more.
> Look at the COBRA driver code. I have crates of cPCI equipment
> loaded with 10s of boards, with each board having multiple
> device nodes, transferring megabytes per second over
> multiple cPCI crates :)
> 
> Anyway, stop thinking about signals, they'll just mess you up.
> 
> Oh, the driver will also support sending SIGIO to the process,
> via the fasync() driver call, so you can try signals, and
> convince yourself that select() is much nicer.
> 
> A GPIO driver seems like such an obvious thing to write. Are
> you sure the montavista driver doesn't already support these
> features? I have no idea of your experience with coding, so
> it could just be that you are unaware of what the driver
> implements. If you are allowed to post it, go ahead, and
> I'll comment on its features.
> 
> Cheers
> Dave
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/signals-handling-in-the-kernel-tf4229566.html#a12409543
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
