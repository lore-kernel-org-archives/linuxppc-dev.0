Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id CE6CB2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 20:12:02 +1000 (EST)
Message-ID: <1375437816.3852.12.camel@thor.local>
Subject: Re: therm_pm72 units, interface
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Fri, 02 Aug 2013 12:03:36 +0200
In-Reply-To: <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jan Engelhardt <jengelh@inai.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ben Hutchings <ben@decadent.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sam, 2013-07-20 at 23:33 +0300, Aaro Koskinen wrote:
> Hi,
>=20
> On Sat, Jul 20, 2013 at 09:16:49AM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-07-19 at 20:43 +0300, Aaro Koskinen wrote:
> > > I booted a Xserve today with 3.11-rc1, and noticed the noise is comin=
g
> > > from slots-fan (PCI fan?) which is always 99%, although the slots-tem=
p is
> > > just 33. Is it on purpose the rm31 slots PID params are totally diffe=
rent
> > > from therm_pm72 slots params? It seems like they have been copied fro=
m
> > > pm72 "drive bay" PID params instead.
> >=20
> > Could be my mistake. What happens if you change them to match the old c=
ode ?
>=20
> I tried the change below (use SLOTS_PID_* values from therm_pm72.h),
> and the noise level is considerably lower. The slots-fan stays at 19%,
> and slots-temp rises to 42'C but not higher after running couple of hours=
.
>=20
> diff --git a/drivers/macintosh/windfarm_rm31.c b/drivers/macintosh/windfa=
rm_rm31.c
> index 0b9a79b..82fc86a 100644
> --- a/drivers/macintosh/windfarm_rm31.c
> +++ b/drivers/macintosh/windfarm_rm31.c
> @@ -439,15 +439,15 @@ static void backside_setup_pid(void)
> =20
>  /* Slots fan */
>  static const struct wf_pid_param slots_param =3D {
> -	.interval	=3D 5,
> -	.history_len	=3D 2,
> -	.gd		=3D 30 << 20,
> -	.gp		=3D 5 << 20,
> -	.gr		=3D 0,
> -	.itarget	=3D 40 << 16,
> -	.additive	=3D 1,
> -	.min		=3D 300,
> -	.max		=3D 4000,
> +	.interval	=3D 1,
> +	.history_len	=3D 20,
> +	.gd		=3D 0,
> +	.gp		=3D 0,
> +	.gr		=3D 0x00100000,
> +	.itarget	=3D 3200000,
> +	.additive	=3D 0,
> +	.min		=3D 20,
> +	.max		=3D 100,
>  };
> =20
>  static void slots_fan_tick(void)

Could a similar change fix the same problem on desktop G5s? The same
values for slots_param in windfarm_pm112.c don't help, unfortunately.


--=20
Earthling Michel D=C3=A4nzer           |                   http://www.amd.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
