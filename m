Return-Path: <flucifredi@acm.org>
Received: from mail28.sea5.speakeasy.net (mail28.sea5.speakeasy.net
	[69.17.117.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0DAC67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Jan 2005 10:43:48 +1100 (EST)
Message-ID: <41F828EB.4040409@acm.org>
Date: Wed, 26 Jan 2005 18:34:03 -0500
From: Federico Lucifredi <flucifredi@acm.org>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Bora_=DEahin?= <bora.sahin@ttnet.net.tr>
References: <41DDA5DA.1030802@acm.org>
	<3535657973.20050126204614@ttnet.net.tr><41F816F6.8090204@acm.org>
	<371777686.20050127005702@ttnet.net.tr>
In-Reply-To: <371777686.20050127005702@ttnet.net.tr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Linux-ppc \[mailing list\]" <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8272ADS and frame buffer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bora Þahin wrote:

>But S1D13806 is showed in the web site as legacy. Instead of it S1D13506 is suggested, which seems
>it has the same properties with 13806... Do you know anything about it?
>
>  
>
hehe - I know, it is an oldie now. I used it because my company had one 
around, and it was a cheap approach to try what we had on hand first =)

A good thing for you is that the Linux driver is one for most of the 
Epson chips (download the file, you will see this sd1d1xxxfb.c (or 
something like it) file, it depends on different includes for different 
chips, but other than that it is always the same driver.

>Has it got X-Window driver[s] or only frame-buffer support? If only framebuffer, then it means frame
>buffer X-window server. And this one is a bit slow AFAIK...
>  
>
The driver is fb only - I agree with you, if you are going to use X, you 
dont want to go with that. On the other hand, unlsee you want a lot of 
applications on the desk, ditching X would help you in maximizing CPU 
usage as you request below. Qt-E by Trolltech (Disclaimer: I am a 
fanatical Qt user) supports Fb graphics, so if you do not need anything 
besides a browser (Opera can also use Qt-E, and Konqueror can also link 
agains it, although I would not recommend that one yet), you can well do 
without X.

>FL> I believe the card is enough for browser operation, yes. I am not sure
>FL> about playing video beacuse I have not performance-checked it , and as 
>FL> you pointed out, it is unaccelerated.  It should be able to display 
>FL> whatever you throw at it though, so if you can do the MPEG decoding 
>FL> completely in software on the MPC side, you should be fine.
>
>Thanks for these invaluable insights...
>  
>
My pleasure to be of help =)

>FL> Do you work at Turk Telecom or are you just a customer ?
>
>Yeah, I am just a customer. I dont like using company e-mail. Because it is read by third party
>products :-)
>  
>
>If possible, we want to decrease microprocessor clock. Normally we
>do it in VIA Epia-500MHz and thinking in parallel with, it should be done under 533, or perhaps
>[..] 466, 400. I dont know. We will test it. Do you know anything about it?
>  
>
Hmm - testing is the only way you can come up with a figure. But 
removing X from the equation will certinly gain you some % of CPU 
availability, which you will need for the soft mpeg decoder. You also 
want to test that the buffer setup of the whole thing is designed 
correctly for the kind of response and thruput you will need... I have 
seen reports on the mailing list of people having trouble b/c of some 
crippleware used in bus implementations.

-Federico


-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish

Muad'Dib of Caladan (Federico L. Lucifredi)- Harvard University & BU
http://metcs.bu.edu/~lucifred
