Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id BA943B7BE3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 01:41:28 +1100 (EST)
Subject: Re: term_adt746x: Invert bit required on this Powerbook G4
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Max Vozeler <max@hinterhof.net>
In-Reply-To: <20091104122355.GA7269@quark.vpn.nusquama.org>
References: <20091104122355.GA7269@quark.vpn.nusquama.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2009 06:41:15 -0800
Message-ID: <1257864075.4434.300.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[ Resending with linuxppc-dev list domain fixed ]

On Wed, 2009-11-04 at 13:23 +0100, Max Vozeler wrote:=20
> I installed Ubuntu 8.10 on this Powerbook G4 ("alu" I think)=20
> for a friend of mine. As soon as therm_adt746x got loaded, the=20
> fan turned into a noise steam engine.=20
>=20
> This was on Ubuntu's 2.6.31 kernel (2.6.31-14-powerpc) which=20
> includes 0512a9a8e277a9de2. I could reproduce it with latest
> mainline as well.
>=20
> The effect was just as Michel described in the changelog; The
> fan was running while temps were well below any of the limits,
> and it stopped only when I set ridiculously low limits.
>=20
> [ 1087.141482] adt746x: version 1 (supported)
> [ 1087.141495] adt746x: Thermostat bus: 1, address: 0x2e, limit_adjust: 0=
, fan_speed: -1
> [ 1087.141503] sensor 0: HDD BOTTOMSIDE
> [ 1087.141507] sensor 1: CPU TOPSIDE
> [ 1087.141512] sensor 2: GPU ON DIE
> [ 1087.161365] adt746x: ADT7460 initializing
> [ 1087.165245] adt746x: Lowering max temperatures from 73, 80, 109 to 70,=
 50, 70
> [ 1087.165261] adt746x: Setting speed to 0 for CPU TOPSIDE fan.
> [ 1087.166302] adt746x: Setting speed to 0 for GPU ON DIE fan.
>=20
> (What "worked" was limit_adjust=3D-30, fan did turn off, but so did
> the Powerbook shortly after, despite being cold.)
>=20
> After some poking around, in which everything seemed to be
> according to plan including write of 0 to both FAN_SPD_SET regs,
> I noticed that explicitly *setting* the invert bit as in=20
>=20
>  -		write_reg(th, MANUAL_MODE[fan],
>  -			(manual|MANUAL_MASK) & (~INVERT_MASK));
>  +		write_reg(th, MANUAL_MODE[fan],
>  +			(manual|MANUAL_MASK|INVERT_MASK));
>=20
> seems to cure it. The fan appears to behave normally now, it
> turns on slowly when the temp limits are reached, otherwise it
> stays off. The temperature is reasonable (ie, no too hot).
>=20
> So, puzzeled, I checked the spec, and it appears very clear on
> the question of invert: It should be off by default.

Right, that's what I based my patch on.

However, it sounds like your PowerBook model (mine is a PowerBook5,8) is
wired up such that the invert bit needs to be enabled. I can think of
two basic approaches for dealing with this offhand:

      * Set or clear the invert bit depending on the machine model or
        whatever is relevant.=20
      * Save the bit value during initialization and preserve it
        whenever writing to the register. Or maybe even add proper
        suspend/resume hooks which save/restore all hardware state, it
        seems like it may be luck that the current code works more or
        less for suspend/resume.

I'm not too interested in working on this anymore and I definitely won't
have time this or next week, anyone feel free to take it on.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
