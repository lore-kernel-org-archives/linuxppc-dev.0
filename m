Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E01FADDE48
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 23 Jul 2007 13:35:47 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1ICoi0-0000xN-Ho
	for linuxppc-embedded@ozlabs.org; Sun, 22 Jul 2007 20:35:44 -0700
Message-ID: <11737447.post@talk.nabble.com>
Date: Sun, 22 Jul 2007 20:35:44 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem faced while using workqueue in the character driver.
In-Reply-To: <46A0EE6B.3000904@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <11705912.post@talk.nabble.com> <46A0EE6B.3000904@ovro.caltech.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi David

Thanks for your reply I really appreciate it from the heart.

The problem is solved now ,Actually I was using a kernel timer in open call
(to run for the first time which ever application would open it and deleting
the timer for the last exit ) to simulate for an Interrupt in the same
driver. There i did mistake in the implimentation in the logic and as a
consiquence of which it was crashing the system and not because of the
workqueue.

thanks 
misbah

David Hawkins-3 wrote:
> 
> Hi Misbah,
> 
>> I am working on a character driver for FPGA, in which i am using a
>> blocked
>> read call on workqueue. The read call will be unblocked by the Interrupt
>> from the Fpga to PPC Cpu.
>> 
>> The problem is that if the process is in blocked mode and then an
>> Interrupt
>> occurs the system gives kernel Panic where as it get unblocked and start
>> reading the data but very soon it gets crashed.
>> 
>> Please send me your suggessins regarding the mentioned problem.
> 
> Er, without seeing the code, its a bit difficult to suggest
> anything.
> 
> Perhaps you are using work-queues incorrectly?
> 
> Take a look at:
> 
> simple_work_queue.c
> 
> In the tar-ball
> 
> http://www.ovro.caltech.edu/~dwh/correlator/software/driver_design.tar.gz
> 
> Which is described in:
> 
> http://www.ovro.caltech.edu/~dwh/correlator/pdf/LNX-723-Hawkins.pdf
> 
> There's also a more complex 'COBRA driver' here:
> 
> http://www.ovro.caltech.edu/~dwh/correlator/cobra_docs.html
> 
> Having an example of a working driver that uses work-queues
> might help you.
> 
> Dave
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Problem-faced-while-using-workqueue-in-the-character-driver.-tf4116327.html#a11737447
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
