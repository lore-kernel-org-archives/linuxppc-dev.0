Return-Path: <tony.p.lee@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id 3FA782BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 12:54:00 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 75so1584489rnl
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 07 Oct 2004 19:53:53 -0700 (PDT)
Message-ID: <470b6397041007195371655afb@mail.gmail.com>
Date: Thu, 7 Oct 2004 19:53:52 -0700
From: Tony Lee <tony.p.lee@gmail.com>
To: Jon Masters <jonathan@jonmasters.org>
In-Reply-To: <4165DB83.8080001@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <000001c4aace$245a5060$6500a8c0@PortatileLG>
	<35fb2e5904100508157a393ee2@mail.gmail.com>
	<4162C649.6060900@ru.mvista.com>
	<35fb2e590410051507367017a@mail.gmail.com>
	<41641222.6080405@ru.mvista.com>
	<470b63970410071534422f6617@mail.gmail.com>
	<4165DB83.8080001@jonmasters.org>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, linuxppc-embedded@ozlabs.org,
	Luca Giuliani <l.giuliani@tiscali.it>
Subject: Re: Linux on Memec Virtex II Pro V4P7 Rev. 3
Reply-To: Tony Lee <tony.p.lee@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 08 Oct 2004 01:12:51 +0100, Jon Masters <jonathan@jonmasters.org> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> > 
> The polled approach is worse IMO although I agree that there is very
> little overhead in the actual ISR. Where the author went wrong (well
> perhaps not wrong per se but didn't provide enough protection) was in
> the unlikely case that the hardware is braindead and generates
> interrupts that you didn't ask it to - the xsysace driver should also
> catch interrupts when we're QUEUE_EMPTY and should not try to manipulate
> an empty request queue.
> 
> Jon.

The problem I saw was that I can't turn off the interrupt at all.
Once I start one write command, the ISR keep coming in.
I review the verilog code and schematic multiple times with the
HW group but can't figure out what went wrong.   My best
guess was the BUFRDY line is mix up with the ISR line some
how when write cmd and when IDEN drive command is issued.  

I try turn off the ISR on write with SYSACE register and 
the ppc interrupt control register.  None of them worked.

Jon, 

Do you think if we add a small DMA engine would help
the performance or the performance problem is caused
by the sysace firmware + the CF disk?

The sysace controller IS VERY fast on loading the bitstream
and linux boot image.


-- 
-Tony
Having a lot of fun with Xilinx Virtex Pro II reconfigurable HW + ppc + Linux
