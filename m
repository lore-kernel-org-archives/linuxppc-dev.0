Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D427967B1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 04:39:11 +1000 (EST)
Message-ID: <425AC449.4070401@mvista.com>
Date: Mon, 11 Apr 2005 11:39:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Daniel Ann <ktdann@gmail.com>
References: <9b7ca65705040801455b84eb0d@mail.gmail.com>	
	<4256CE41.1000404@mvista.com>
	<9b7ca6570504081829cb84a7d@mail.gmail.com>
In-Reply-To: <9b7ca6570504081829cb84a7d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Best way to determine tb_ticks_per_jiffy inside
	todc_calibrate_decr()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Ann wrote:

>On Apr 9, 2005 3:32 AM, Mark A. Greer <mgreer@mvista.com> wrote:
>  
>

>>Also, 33MHz does not sound right but then you don't say what processor
>>you're using so who knows.  You need to find the bus freq used by the
>>cpu/system.  Try looking for the freq of the processor's SYSCLK input.
>>Then you probably have to divide that by 4 to get the frequency that the
>>decrementer runs at.  That's the value that you should use for the
>>'freq' variable in the example code you included in your email.
>>    
>>
>
>Okay guess I had all these things mixed up in head. What I should have
>said is, source to PCI_SYNC_IN is 33MHz.
>

Ah, that sounds reasonable.  ;)

>Anyway, following the MPC8245 hardware Spec pdf file, I was able to
>find the peripheral logic/memory bus clock to be 99,000,000. Dividing
>that by 4 like you said, gave me the value of 24,750,000. Which is
>I've used it to get very real 1 second :)
>

Cool.

>
>BTW, why do you have to divide it by 4 ?
>

Because the internally kept time in ppc linux is based on the 
decrementer counter and, according to the manual for the 8245, the 
decrementer counter is decremented once every four sys_logic_clk 
cycles.  Therefore, you need to divide by 4.

Mark
