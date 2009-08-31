Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D2B86B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 19:32:46 +1000 (EST)
Subject: Re: [PATCH] powermac: thermal control turns system off in normal
	temperature conditions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux User #330250 <linuxuser330250@gmx.net>
In-Reply-To: <200908311125.56066.linuxuser330250@gmx.net>
References: <200908302054.20498.bzolnier@gmail.com>
	<200908311125.56066.linuxuser330250@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Aug 2009 19:32:30 +1000
Message-Id: <1251711150.15353.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-31 at 11:25 +0200, Linux User #330250 wrote:
> Hello!
> 
> First: I'm just a user. And I hope I don't cause disturbance.
> 
> I've read about this when I was setting up Linux on my Power Mac G4 MDD about 
> two years ago and I remember reading that the temperature might be reported 
> falsely. The original author reduced the limits to be on the safe side.
> 
> While Mac OS X seems to push the allowed temperature more to the limits, it 
> could still be fatal to trust the reported temperatures.
> 
> 
> My machine had the same shut-downs due to temperature at first. Since my MDD 
> was quite a few years old when I got it I cleaned the CPUs and used new 
> thermal compound with the original heatsink. This fixed the "overheat" issue 
> for me.

Thanks. I think pushing them a bit like this patch does still remains
within reasonably safe limits though. The CPU should cope with more
hopefully :-)

But yeah, cleaning up the dust is definitely a good idea :-)

Cheers,
Ben.

> 
> Sorry to interrupt,
> Andreas  aka  Linux User #330250
> 
> 
> 
> ----------  Original message  ----------
> Subject: [PATCH] powermac: thermal control turns system off in normal 
> temperature conditions
> Date:    Sonntag, 30. August 2009N
> From:    Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> To:      Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> > From: Lyonel Vincent <lyonel@ezix.org>
> > Subject: [PATCH] powermac: thermal control turns system off in normal
> > temperature conditions
> >
> > On certain PowerMacs, a module (therm_windtunnel) controls various
> > thermal settings (it can report CPU/case temperature, change speed
> > of internal fans, etc.)
> >
> > By default, the hardware thermal control has a temperature limit to
> > protect the computer from damages (the default limit seems to be 80°C)
> > but therm_windtunnel.c reduces it to an anormaly low value (65°C),
> > which means that he computer will shut down randomly when hit by direct
> > sun light or during summer (summer in France can be quite hot), actually
> > possibly losing data instead of protecting it.
> >
> > The overheat limit in therm_windtunnel.c:253-254 should be set to 75°C
> > and 70°C instead of 65°C and 60°C respectively.
> >
> > From: Lyonel Vincent <lyonel@ezix.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > Resurrected from Fedora's bugzilla (aka The Big Black Hole):
> > https://bugzilla.redhat.com/show_bug.cgi?id=171937
> >
> > The patch itself seems perfectly valid to me
> > (especially given comments in therm_windtunnel.c).
> >
> >  drivers/macintosh/therm_windtunnel.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Index: b/drivers/macintosh/therm_windtunnel.c
> > ===================================================================
> > --- a/drivers/macintosh/therm_windtunnel.c
> > +++ b/drivers/macintosh/therm_windtunnel.c
> > @@ -239,8 +239,8 @@ setup_hardware( void )
> >  	 * to be on the safe side (OSX doesn't)...
> >  	 */
> >  	if( x.overheat_temp == (80 << 8) ) {
> > -		x.overheat_temp = 65 << 8;
> > -		x.overheat_hyst = 60 << 8;
> > +		x.overheat_temp = 75 << 8;
> > +		x.overheat_hyst = 70 << 8;
> >  		write_reg( x.thermostat, 2, x.overheat_hyst, 2 );
> >  		write_reg( x.thermostat, 3, x.overheat_temp, 2 );
