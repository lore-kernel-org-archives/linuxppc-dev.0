Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 9940467A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 18:52:13 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so674715wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 08 Apr 2005 01:52:12 -0700 (PDT)
Message-ID: <9b7ca65705040801455b84eb0d@mail.gmail.com>
Date: Fri, 8 Apr 2005 17:45:22 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Best way to determine tb_ticks_per_jiffy inside
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

Hey folks,

I seem to have problem getting 1 second right. Board has no RTC so
I've basically NULLed all the todc_XXX functions except
todc_calibrate_decr.

Now question is, what value should I be assigning it to tb_ticks_per_jiffy ?

I was able to dig up some info from the archive, and it read,
=-=-=-FROM ARCHIVE =-=-=-
You must find this value by yourself but a good starting point is your
frequency in Hz (I think)
Example of the code
	unsigned int freq = 28000000;
	tb_tick_per_jiffy = freq/HZ;
	tb_to_us = mulhwu_scale_factor(freq,1000000);
=-=-=-END OF ARCHIVE =-=-=-

I'm fine with working it out myself but where do I start ? My board
has 33MHz OSC, so I've trie freq = 33 * 1000000 (where HZ is defined
100) but it turned out to be little short. I could have just tried few
more trial and error, but I prefer knowing what I'm doing so.. :)

Before I was trying it with 100 * 1000000 which had delays like 10:1.
Now its only about 1.5:1. So, I guess I'm on the right track.... so
can anyone please help me out here?

Also, could anyone spill their brain on mulhwu_scale_factor() ? I've
followed the code and ended up reading what seems to be a assembler.
(Should have paid attention during the lectures :P) Any hint on this ?

Thanks heaps..
Cheers,

-- 
Daniel
