Return-Path: <dbolcsfoldi@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 3A2E667C27
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 02:47:29 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so1218730pyc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 09:47:28 -0700 (PDT)
Message-ID: <609d5c8e0610130947k5ea1f955sadc8c5e82f693aa8@mail.gmail.com>
Date: Fri, 13 Oct 2006 09:47:27 -0700
From: "David Bolcsfoldi" <dbolcsfoldi@gmail.com>
To: "Robert Corley" <rcorley@aegis-inc.net>
Subject: Re: which driver for uartlite with 2.6.17?
In-Reply-To: <20061013155908.4944.qmail@web56302.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061013155908.4944.qmail@web56302.mail.re3.yahoo.com>
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi :-)

Good question. Well I was unaware of the fact that there were other
uartlite drivers so you should take mine off that list. Peter's driver
is slated for inclusion in the mainline and I am currently in the
process of adding a few things to it.

For 2.6.17 support you should probably just remove the IRQF_DISABLED
flag and change IRQF_SAMPLE_RANDOM to SA_SAMPLE_RANDOM in the
request_irq call and it should work. I am unaware of any other
important differences between the two releases affecting this driver.

Cheers,
David

On 10/13/06, Robert Corley <rcorley@aegis-inc.net> wrote:
> All,
>
> Based on what was posted recently, it appears that there is more than one uartlite driver
> floating about.
>
> Can someone please inform me of which driver works for which kernel?
>
> Here is what I see
>
> D. Lynch    2.6.15    polled, (Pico E12 board specific?)
> P. Korsgaard    2.6.18    interrupt driven, official lanana.org nodes
> D. Bolcsfoldi    2.6.18    interrupt driven
>
> patch locations:
> D. Lynch    http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021592.html
> P. Korsgaard    http://lkml.org/lkml/2006/9/13/71
> D. Bolcsfoldi    http://ozlabs.org/pipermail/linuxppc-embedded/2006-October/024697.html
>
> Comments?
>
> And, lastly, I need a driver for 2.6.17.  Can someone point me in the right direction?
> I have tried Peter's driver but it fails to compile, showing this:
>
> CC      drivers/serial/serial_core.o
> CC      drivers/serial/uartlite.o
> drivers/serial/uartlite.c: In function `ulite_startup':
> drivers/serial/uartlite.c:199: error: `IRQF_DISABLED' undeclared (first use in this function)
> drivers/serial/uartlite.c:199: error: (Each undeclared identifier is reported only once
> drivers/serial/uartlite.c:199: error: for each function it appears in.)
> drivers/serial/uartlite.c:199: error: `IRQF_SAMPLE_RANDOM' undeclared (first use in this function)
> make[2]: *** [drivers/serial/uartlite.o] Error 1
> make[1]: *** [drivers/serial] Error 2
> make: *** [drivers] Error 2
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
