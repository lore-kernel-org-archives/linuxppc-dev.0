Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 3C6C167E05
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 10:16:38 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so8767wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 17:16:37 -0700 (PDT)
Message-ID: <9b7ca6570508021716516d74fc@mail.gmail.com>
Date: Wed, 3 Aug 2005 09:16:37 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <E227A82E-9A6F-449F-9CD9-9FD6D1893082@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050802034517.F3D0167E42@ozlabs.org>
	<E227A82E-9A6F-449F-9CD9-9FD6D1893082@freescale.com>
Cc: JohnsonCheng <johnsoncheng@qnap.com.tw>, linuxppc-embedded@ozlabs.org
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

Right. Guess I found it hard way :)
After using LEVEL interrupt, it all works now.

On 8/2/05, Kumar Gala <kumar.gala@freescale.com> wrote:
>=20
> On Aug 1, 2005, at 10:38 PM, JohnsonCheng wrote:
>=20
> > Dear Daniel,
> >
> > I also meet this problem on MPC8245 with linux-2.6.12.3, and I
> > found it uses
> > LEVEL for interrupt in sandpoint.c. Do you have any idea for it?
>=20
> All internal interrupts on the MPC8245/1 should be LEVEL interrupts.
>=20
> - kumar
>=20
> > -----Original Message-----
> > From: linuxppc-embedded-bounces@ozlabs.org
> > [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Daniel Ann
> > Sent: Monday, August 01, 2005 9:27 AM
> > To: Anton W=F6llert
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: Serial console
> >
> > Thanks for your input Anton.
> > I'm not all that certain about sandpoint platform has its own serial
> > driver so I've worked with 8250.c. Anyway, I've got it working now. It
> > was problem with interrupt. As soon as I changed interrupt from EGDE
> > to LEVEL it began working. Altho I'm faced with yet another problem
> > with openpic but I'm digging thru it at the moment.
> >
> > BTW, I have no idea why EDGE didnt work and LEVEL does.
> >
> > Cheers,
> > Daniel
> >
> > On 7/30/05, Anton W=F6llert <a.woellert@gmail.com> wrote:
> >
> >> Daniel Ann wrote:
> >>
> >>> Hi folks,
> >>>
> >>> Having all the kernel boot up log on console means that I've done
> >>> some
> >>> part right. But why am I not getting anything from the user
> >>> processes
> >>> on the console screen ?
> >>>
> >>> Is there anything I need to do on the kernel config ?
> >>>
> >>>
> >>
> >> Hi, we've had the same problem some time ago on a tqm850l
> >> (mpc850). Our
> >> problem was, that we had registered two serial consoles in the kernel
> >> config or something like that. we had to disable all serial-driver
> >> stuff
> >> and enable just the platform-specific serial-console driver. we
> >> tracked
> >> this down with inserting a printk(buf) into the tty_write fs-op of
> >> the
> >> serial-port driver in drivers/char/tty_io.c. the ttyS0 was used
> >> but has
> >> taken another serial-driver than the platform specific.
> >>
> >> may this help you :)
> >>
> >>
> >> anton
> >>
> >>
> >
> >
> > --
> > Daniel
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>=20
>=20


--=20
Daniel
