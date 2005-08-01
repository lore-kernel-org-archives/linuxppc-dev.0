Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 721D967D88
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 11:27:01 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i28so923108wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 31 Jul 2005 18:27:00 -0700 (PDT)
Message-ID: <9b7ca65705073118276e89b29@mail.gmail.com>
Date: Mon, 1 Aug 2005 10:27:00 +0900
From: Daniel Ann <ktdann@gmail.com>
To: =?ISO-8859-1?Q?Anton_W=F6llert?= <a.woellert@gmail.com>
In-Reply-To: <42EB587D.80403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca65705072918062249e41f@mail.gmail.com>
	<42EB587D.80403@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console
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

Thanks for your input Anton.
I'm not all that certain about sandpoint platform has its own serial
driver so I've worked with 8250.c. Anyway, I've got it working now. It
was problem with interrupt. As soon as I changed interrupt from EGDE
to LEVEL it began working. Altho I'm faced with yet another problem
with openpic but I'm digging thru it at the moment.

BTW, I have no idea why EDGE didnt work and LEVEL does.

Cheers,
Daniel

On 7/30/05, Anton W=F6llert <a.woellert@gmail.com> wrote:
> Daniel Ann wrote:
> > Hi folks,
> >
> > Having all the kernel boot up log on console means that I've done some
> > part right. But why am I not getting anything from the user processes
> > on the console screen ?
> >
> > Is there anything I need to do on the kernel config ?
> >
>=20
> Hi, we've had the same problem some time ago on a tqm850l (mpc850). Our
> problem was, that we had registered two serial consoles in the kernel
> config or something like that. we had to disable all serial-driver stuff
> and enable just the platform-specific serial-console driver. we tracked
> this down with inserting a printk(buf) into the tty_write fs-op of the
> serial-port driver in drivers/char/tty_io.c. the ttyS0 was used but has
> taken another serial-driver than the platform specific.
>=20
> may this help you :)
>=20
>=20
> anton
>=20


--=20
Daniel
