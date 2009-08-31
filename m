Return-Path: <linuxuser330250@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by bilbo.ozlabs.org (Postfix) with SMTP id 333E5B7B9D
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 19:32:48 +1000 (EST)
From: "Linux User #330250" <linuxuser330250@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powermac: thermal control turns system off in normal
	temperature conditions
Date: Mon, 31 Aug 2009 11:25:55 +0200
References: <200908302054.20498.bzolnier@gmail.com>
In-Reply-To: <200908302054.20498.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200908311125.56066.linuxuser330250@gmx.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

=46irst: I'm just a user. And I hope I don't cause disturbance.

I've read about this when I was setting up Linux on my Power Mac G4 MDD abo=
ut=20
two years ago and I remember reading that the temperature might be reported=
=20
falsely. The original author reduced the limits to be on the safe side.

While Mac OS X seems to push the allowed temperature more to the limits, it=
=20
could still be fatal to trust the reported temperatures.


My machine had the same shut-downs due to temperature at first. Since my MD=
D=20
was quite a few years old when I got it I cleaned the CPUs and used new=20
thermal compound with the original heatsink. This fixed the "overheat" issu=
e=20
for me.


Sorry to interrupt,
Andreas  aka  Linux User #330250



=2D---------  Original message  ----------
Subject: [PATCH] powermac: thermal control turns system off in normal=20
temperature conditions
Date:    Sonntag, 30. August 2009N
=46rom:    Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:      Benjamin Herrenschmidt <benh@kernel.crashing.org>

> From: Lyonel Vincent <lyonel@ezix.org>
> Subject: [PATCH] powermac: thermal control turns system off in normal
> temperature conditions
>
> On certain PowerMacs, a module (therm_windtunnel) controls various
> thermal settings (it can report CPU/case temperature, change speed
> of internal fans, etc.)
>
> By default, the hardware thermal control has a temperature limit to
> protect the computer from damages (the default limit seems to be 80=B0C)
> but therm_windtunnel.c reduces it to an anormaly low value (65=B0C),
> which means that he computer will shut down randomly when hit by direct
> sun light or during summer (summer in France can be quite hot), actually
> possibly losing data instead of protecting it.
>
> The overheat limit in therm_windtunnel.c:253-254 should be set to 75=B0C
> and 70=B0C instead of 65=B0C and 60=B0C respectively.
>
> From: Lyonel Vincent <lyonel@ezix.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Resurrected from Fedora's bugzilla (aka The Big Black Hole):
> https://bugzilla.redhat.com/show_bug.cgi?id=3D171937
>
> The patch itself seems perfectly valid to me
> (especially given comments in therm_windtunnel.c).
>
>  drivers/macintosh/therm_windtunnel.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: b/drivers/macintosh/therm_windtunnel.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/macintosh/therm_windtunnel.c
> +++ b/drivers/macintosh/therm_windtunnel.c
> @@ -239,8 +239,8 @@ setup_hardware( void )
>  	 * to be on the safe side (OSX doesn't)...
>  	 */
>  	if( x.overheat_temp =3D=3D (80 << 8) ) {
> -		x.overheat_temp =3D 65 << 8;
> -		x.overheat_hyst =3D 60 << 8;
> +		x.overheat_temp =3D 75 << 8;
> +		x.overheat_hyst =3D 70 << 8;
>  		write_reg( x.thermostat, 2, x.overheat_hyst, 2 );
>  		write_reg( x.thermostat, 3, x.overheat_temp, 2 );
