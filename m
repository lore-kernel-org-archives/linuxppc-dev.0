Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 975FADDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Apr 2008 11:58:54 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JpwAE-0003Tp-5F
	for linuxppc-embedded@ozlabs.org; Sat, 26 Apr 2008 18:58:50 -0700
Message-ID: <16918127.post@talk.nabble.com>
Date: Sat, 26 Apr 2008 18:58:50 -0700 (PDT)
From: mtwallet <mike_timmons@trimble.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 arch=powerpc kernel=2.6.24: how do I request external
	IRQ0-3?
In-Reply-To: <161B3BAD77161449A144FF054231C3D60206D6DC@uss-am-xch-01.am.trimblecorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <161B3BAD77161449A144FF054231C3D60206D6DC@uss-am-xch-01.am.trimblecorp.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I got something working. I created a "device" child in the DTS file and used
th platform driver subsystem to register my module and get the virtual IRQ
as derived from the interrupt triplet-style spec in the dts file.

I'm still not real content as my child is nested with the SOC peripherals,
but this is more of a style/readability hang-up for me, for now. At least
now I can get the virtual irq by registering a platform driver, requesting
the irq number, and successfully requesting the irq.

I welcome any advice if I have used the dts file in an unintended fashion,
but it feels like the right place to specify a "device", even if all the
device embodies is an IRQ. Newbie conceptual difficulty overcome.



mtwallet wrote:
> 
> I am confused on a very simple subject: requesting an external IRQ from
> a custom driver I'm writing  for a lite5200b-based board running kernel
> 2.6.24, arch=powerpc. 
> 
>  
> 
> With the old arch=ppc I saw reference to MPC52xx_IRQ3 and such. I don't
> see reference to specific IRQs under the powerpc arch. I am starting to
> better understand the dts scheme for peripheral interrupts, but I am
> hung-up on the seemingly simple task of requesting an external IRQ and
> registering a callback from my driver:
> 
>  
> 
> request_irq(  virtual_irq_number_for_IRQ3_that_I_don't_know_right_now,
> &my_callback, flags, name, dev)
> 
>  
> 
> For this to work do I need to create a child node in the dts that
> specifies interrupts = <1 3 2> for IRQ3?  Must the IRQ I'm requesting be
> associated with the dev argument to request_irq via the dts?
> 
>  
> 
> I just think I'm missing something very obvious as regards using
> IRQ[0-3] on the mpc52xx. The DTS makes sens to me for peripheral
> interrupts getting associated with their respective peripherals, but
> when I want any old driver to use IRQ0-3 How do I request it?
> 
>  
> 
> Thanks.
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/mpc5200-arch%3Dpowerpc-kernel%3D2.6.24%3A-how-do-I-request-external-IRQ0-3--tp16900805p16918127.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
