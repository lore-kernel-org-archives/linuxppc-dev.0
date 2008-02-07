Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34E32DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Feb 2008 03:07:42 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JN9Hl-0007EE-9s
	for linuxppc-embedded@ozlabs.org; Thu, 07 Feb 2008 08:07:37 -0800
Message-ID: <15337076.post@talk.nabble.com>
Date: Thu, 7 Feb 2008 08:07:37 -0800 (PST)
From: khollan <khollan@daktronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: System Clock runaway on Xilinx platform
In-Reply-To: <fa686aa40802061452i78838bb0g87c99d76509c866e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <15312437.post@talk.nabble.com>
	<fa686aa40802061229w3c6ae051kec18d1d25ad1da4@mail.gmail.com>
	<1202337576.20550.6.camel@kevin-laptop>
	<fa686aa40802061452i78838bb0g87c99d76509c866e@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




jozsef imrek wrote:
> 
> 
> kevin, how do you get that 175 MHz PLB?
> 
> it should not matter, since the wall clock is derived from the
> cpu clock, but i suspect that your cpu clock is just twice the
> PLB clock, thus it is not 300 MHz, but 350 MHz. this would explain
> the time drift, as
> 
>         300 s * (350 MHz / 300 MHz) = 350 s   (obviously :)
> 
> so here is the extra 50 secs in every 5 minutes.
> 
> 
> 
> -- 
> mazsi
> 
> 

Thanks to an email by jozef imrek I realized that I'm an idiot.  To get the
CPU clock I multiply the PLB X 2 which is 175MHz X 2 = 350 MHz not 300MHz, I
guess I had a brain fart in calculation.  I changed the xparameters to 350
and it seems to be keeping time, I haven't tested it for very long but it's
doing a lot better than before.  Thanks to him I didn't have to wait 45 min
to rebuild the bit stream and probe the clocks.
Thanks Kevin
-- 
View this message in context: http://www.nabble.com/System-Clock-runaway-on-Xilinx-platform-tp15312437p15337076.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
