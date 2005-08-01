Return-Path: <tdallagnol@parks.com.br>
Received: from PKMAIL.parks.local (mail.parks.com.br [200.248.200.133])
	by ozlabs.org (Postfix) with ESMTP id ED63467E35
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 22:54:19 +1000 (EST)
Message-ID: <42EE1BDE.6050009@parks.com.br>
Date: Mon, 01 Aug 2005 09:55:58 -0300
From: Tiago Dall'Agnol <tdallagnol@parks.com.br>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <20050729013303.33814.qmail@web40712.mail.yahoo.com>	<42EA2A2E.5040708@parks.com.br>	<20050729144015.09fec9fe.ajz@cambridgebroadband.com>	<42EA34A1.7060600@parks.com.br>
	<20050729154359.1ac8f488.ajz@cambridgebroadband.com>
	<42EA60E1.7040804@parks.com.br>
	<b50c9dbfb13d8e2f5a82c2a299e46240@embeddededge.com>
In-Reply-To: <b50c9dbfb13d8e2f5a82c2a299e46240@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: request_8xxirq
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dan

Thanks for your attention. I believe that I'm doing some confusion about 
what is "request_8xxirq". I have this function (or some alias?) in my 
system, and I guess that there isn't any problem with it. But the 
problem I had was a pretty strange, and I decided to take a look at that 
function. And I hadn't find its implementation. I tried to grep 
request_8xxirq in the whole code, but I just found a 
EXPORT_SYMBOL(request_8xxirq).

Anyway, my problem was related to the SEC Lite module. In my Linux, what 
I had in source files originally was the use of SEC Lite interruption as 
a LEVEL4 (number 9). In some boards (I mean, the same models, just other 
boards), the interrupt handler was not called when it should be, i.e., 
when the SEC Lite module ends its processing and signals that the packed 
is ready for me. That's the way my system works, with interruption to 
signal that the packet was already processed.

So, after identifying that problem, I tried to change interrupt to 
LEVEL3 (number 7), and for my surprise... now it works, for all boards. 
But why?

Isn't it strange?

Best Regards,
Tiago

Dan Malek wrote:

>
> On Jul 29, 2005, at 1:01 PM, Tiago Dall'Agnol wrote:
>
>> Am I wrong? I didn't understand when that function request_irq is used.
>
>
> At some point I don't remember and against all of my wishes, the code
> was changed from using request_8xxirq to using request_irq using
> an ugly hack to add some offset to the 8xx interrupt vector number.
> I didn't see any bug that needed fixing, but people with the power to
> ignore my maintainer status decided to change it anyway.  So, now you
> have to modify your drivers to call request_irq() with some nonsensical
> interrupt number.  No value added, just confusion.
>
> Thanks.
>
>     -- Dan
>
