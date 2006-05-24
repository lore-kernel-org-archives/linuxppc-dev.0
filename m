Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 09AB467B24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 19:48:42 +1000 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: sandeep malik <malik_mca2000@yahoo.co.in>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
Date: Wed, 24 May 2006 11:48:38 +0200
References: <20060524081447.12399.qmail@web8410.mail.in.yahoo.com>
In-Reply-To: <20060524081447.12399.qmail@web8410.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200605241148.38708.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On onsdag 24 maj 2006 10.14, you wrote:
> Hi Roger...
>   Thanks for your response.....but in my case the application is causing
> this error....
It might be the application who runs, calls kernel for output, drivers used
for output uses floating point.
No application running => no floating point exceptions...

>   The result was exactly what is expected.....so i think this is not
> related to floating point but might be some other issue......
Some driver, most likely your if you have made any yourself is
using floating point.
  serial, console, ethernet drivers?


>
>   Are there any other scenarios which can lead to this message????

Not unless the exception is setup wrong - I would not bet on that.

Lets trace it:
> >   floating point used in kernel (task=c0398410, pc=3184)
This message is generated in ./arch/ppc/kernel/head.S

pc = 3184 (in hex)
Now check your System.map
The routine with the closest lower address is your main suspect,
the use of inlines can blur this...
(the task pointer is not that useful, they should have converted it
to process id)

/RogerL
