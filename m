Return-Path: <vitb@kernel.crashing.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DBD1FB7C30
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:11:13 +1100 (EST)
Date: Fri, 18 Dec 2009 08:50:58 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [POWERPC] add U-Boot bootcount driver.
Message-ID: <20091218085058.2d28577d@vitb-lp>
In-Reply-To: <20091217081607.4B621D43F21@gemini.denx.de>
References: <20091216024730.455b90fd@vitb-lp>
	<20091217081607.4B621D43F21@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=D0=92 Thu, 17 Dec 2009 09:16:07 +0100
Wolfgang Denk <wd@denx.de> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Dear Vitaly Bordug,
>=20
>=20
> repl: bad addresses:
> 	linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org> -- junk
> after local@domain (<) In message <20091216024730.455b90fd@vitb-lp>
> you wrote:
> >=20
> > From: Heiko Schocher <hs@denx.de>
> >=20
> > This driver provides (read/write) access to the
> > U-Boot bootcounter via PROC FS or sysFS.
> >=20
> > in u-boot, it uses a 8 byte mem area (it must hold the value over a
> > soft reset of course), for storing a bootcounter (it counts many
> > soft resets are done, on hard reset it starts with 0). If the
> > bootcountvalue exceeds the value in the env variable "bootlimit",
> > and alternative bootcmd stored in the env variable "altbootcmd" is
> > run.
> >=20
> > The bootcountregister gets configured via DTS.
> > for example on the mgsuvd board:
> >=20
> > bootcount@0x3eb0 {
> >                   device_type =3D "bootcount";
> >                   compatible =3D "uboot,bootcount";
> >                   reg =3D <0x3eb0 0x08>;
> >                  };
> >=20
> > This driver is tested on the mgcoge(82xx) and mgsuvd(8xx) board.
> >=20
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> > Signed-off-by: Wolfgang Denk <wd@denx.de>
> > Signed-off-by: Vitaly Bordyug <vitb@kernel.crashing.org>
>=20
> I think it would be good if the text of the commit message could be
> reworked by a native English speaker.
>=20
OK.=20

> Regarding the subject: it is probably important to point out that this
> driver implements the Linux kernel half of the boot count feature -
> the boot counter can only be reset after it is clear that the
> application has been started and is running correctly, which usually
> can only be determined by the application code itself. Thus the reset
> of the boot counter must be done by application code, which thus needs
> an appropriate driver.
>=20
I'll rework the commit message to make it more clear, thanks for the
details!

-Vitaly

> > I think there is no reason not to have this in mainline. Thoughts?
> > And I'm not sure what is right direction to push this - it's
> > representation of u-boot feature in fact, pretty useful tho.
>=20
> It's not only useful, it's actually a required feature by the Carrier
> Grade Linux Requirements Definition; see for example document "Carrier
> Grade Linux Requirements Definition Overview V3.0" at
> https://www.linux-foundation.org/images/1/1a/Cgl_req_def_overview_30.pdf
> Page 49:
>=20
> 	ID PLT.4.0 (2.3 in v1.1)	Boot Cycle Detection
>=20
>         Description: OSDL CGL specifies that carrier grade Linux
>         shall provide support for detecting a repeating reboot cycle
>         due to recurring failures and going to an offline state if
>         this occurs.
>=20
>=20
>=20
>=20
> Best regards,
>=20
> Wolfgang Denk
>=20
