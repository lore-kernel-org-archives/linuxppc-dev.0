Subject: Re: [PATCH] Permedia2 fb on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: mzyngier@freesurf.fr
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <wrpr8q5baho.fsf@hina.wild-wind.fr.eu.org>
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
	<1007572780.21734.65.camel@pismo>
	<wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org> <1007848074.9125.10.camel@pismo>
	 <wrpr8q5baho.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Dec 2001 23:51:36 +0100
Message-Id: <1007851896.9146.12.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2001-12-08 at 23:41, Marc ZYNGIER wrote:
> >>>>> "Michel" == Michel Dänzer <michdaen@iiic.ethz.ch> writes:
>
> Michel> And does it work with the XFree86 glint driver with Option
> Michel> "UseFBDev"?
> >>
> >> Don't know yet. _Now_ that I have a console (thanks to this patch),
> >> I'll have a look at the X11 thingy.
>
> Michel> Well at least when I last worked on the glint driver, it
> Michel> relied on the register aperture being big endian.
>
> Indeed, glint driver doesn't work with UseFBDev.
>
> Could this be a chipset issue (3DLabs vs TI) ? Mine is a Texas
> Instrument (aka ti_pm2) :

No, IIRC that's exactly the one it assumes you have if you're running
pm2fb.

As I said, the driver assumes the register aperture is big endian with
Option "UseFBDev". And without, it will also try to use the big endian
aperture.


If there's really no way to use the big endian aperture on some boards,
the only solution I see is to change both pm2fb and the glint driver to
always use the little endian one.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
