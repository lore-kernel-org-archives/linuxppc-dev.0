Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 614A067A64
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:32:47 +1000 (EST)
Message-ID: <4256CE41.1000404@mvista.com>
Date: Fri, 08 Apr 2005 11:32:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Daniel Ann <ktdann@gmail.com>
References: <9b7ca65705040801455b84eb0d@mail.gmail.com>
In-Reply-To: <9b7ca65705040801455b84eb0d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Best way to determine tb_ticks_per_jiffy
	inside	todc_calibrate_decr()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel,

Daniel Ann wrote:

>Hey folks,
>
>I seem to have problem getting 1 second right. Board has no RTC so
>I've basically NULLed all the todc_XXX functions except
>todc_calibrate_decr.
>

If you don't have an RTC, you shouldn't be using any todc_xxx routines.

>
>Now question is, what value should I be assigning it to tb_ticks_per_jiffy ?
>
>I was able to dig up some info from the archive, and it read,
>=-=-=-FROM ARCHIVE =-=-=-
>You must find this value by yourself but a good starting point is your
>frequency in Hz (I think)
>Example of the code
>	unsigned int freq = 28000000;
>	tb_tick_per_jiffy = freq/HZ;
>	tb_to_us = mulhwu_scale_factor(freq,1000000);
>=-=-=-END OF ARCHIVE =-=-=-
>
>I'm fine with working it out myself but where do I start ? My board
>has 33MHz OSC, so I've trie freq = 33 * 1000000 (where HZ is defined
>100) but it turned out to be little short. I could have just tried few
>more trial and error, but I prefer knowing what I'm doing so.. :)
>

There are several platform files that explicitly set tb_ticks_per_jiffy 
and tb_to_us.  Did you try looking at those?

Also, 33MHz does not sound right but then you don't say what processor 
you're using so who knows.  You need to find the bus freq used by the 
cpu/system.  Try looking for the freq of the processor's SYSCLK input.  
Then you probably have to divide that by 4 to get the frequency that the 
decrementer runs at.  That's the value that you should use for the 
'freq' variable in the example code you included in your email.

Mark
