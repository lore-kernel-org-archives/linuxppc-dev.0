Return-Path: <johnsoncheng@qnap.com.tw>
Received: from qnap.com.tw (unknown [211.75.85.25])
	by ozlabs.org (Postfix) with SMTP id F3D0167E42
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 13:45:17 +1000 (EST)
From: "JohnsonCheng" <johnsoncheng@qnap.com.tw>
To: "'Daniel Ann'" <ktdann@gmail.com>,
	=?ISO-8859-1?Q?'Anton_W=F6llert'?= <a.woellert@gmail.com>
Date: Tue, 2 Aug 2005 11:38:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
In-Reply-To: <9b7ca65705073118276e89b29@mail.gmail.com>
Message-Id: <20050802034517.F3D0167E42@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Daniel,

I also meet this problem on MPC8245 with linux-2.6.12.3, and I found it =
uses
LEVEL for interrupt in sandpoint.c. Do you have any idea for it?

Thanks,
Johnson Cheng

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Daniel Ann
Sent: Monday, August 01, 2005 9:27 AM
To: Anton W=F6llert
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Serial console

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
> > Having all the kernel boot up log on console means that I've done =
some
> > part right. But why am I not getting anything from the user =
processes
> > on the console screen ?
> >
> > Is there anything I need to do on the kernel config ?
> >
>=20
> Hi, we've had the same problem some time ago on a tqm850l (mpc850). =
Our
> problem was, that we had registered two serial consoles in the kernel
> config or something like that. we had to disable all serial-driver =
stuff
> and enable just the platform-specific serial-console driver. we =
tracked
> this down with inserting a printk(buf) into the tty_write fs-op of the
> serial-port driver in drivers/char/tty_io.c. the ttyS0 was used but =
has
> taken another serial-driver than the platform specific.
>=20
> may this help you :)
>=20
>=20
> anton
>=20


--=20
Daniel
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
