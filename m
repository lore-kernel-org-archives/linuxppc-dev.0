Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 79FED67B1A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 11:30:04 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so844605wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Apr 2005 18:30:00 -0700 (PDT)
Message-ID: <9b7ca6570504081829cb84a7d@mail.gmail.com>
Date: Sat, 9 Apr 2005 10:29:57 +0900
From: Daniel Ann <ktdann@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <4256CE41.1000404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca65705040801455b84eb0d@mail.gmail.com>
	<4256CE41.1000404@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Best way to determine tb_ticks_per_jiffy inside
	todc_calibrate_decr()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Apr 9, 2005 3:32 AM, Mark A. Greer <mgreer@mvista.com> wrote:
> If you don't have an RTC, you shouldn't be using any todc_xxx routines.

Yeah, I figured this much :)

> There are several platform files that explicitly set tb_ticks_per_jiffy
> and tb_to_us.  Did you try looking at those?

Actually that didnt occur to me since I thought it was related to the
supplied oscillator. Not knowing what their board is equiped with, I
couldnt trust their value any more than my estimated value. But
reading your next comment, it seems that it's related to processor as
well.

> Also, 33MHz does not sound right but then you don't say what processor
> you're using so who knows.  You need to find the bus freq used by the
> cpu/system.  Try looking for the freq of the processor's SYSCLK input.
> Then you probably have to divide that by 4 to get the frequency that the
> decrementer runs at.  That's the value that you should use for the
> 'freq' variable in the example code you included in your email.

Okay guess I had all these things mixed up in head. What I should have
said is, source to PCI_SYNC_IN is 33MHz.
Anyway, following the MPC8245 hardware Spec pdf file, I was able to
find the peripheral logic/memory bus clock to be 99,000,000. Dividing
that by 4 like you said, gave me the value of 24,750,000. Which is
I've used it to get very real 1 second :)

BTW, why do you have to divide it by 4 ?

-- 
Daniel
