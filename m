Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 33FE1B7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 07:22:55 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8F73EDDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Aug 2009 07:22:54 +1000 (EST)
Subject: Re: [PATCH] powermac: thermal control turns system off in normal
	temperature conditions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200908302054.20498.bzolnier@gmail.com>
References: <200908302054.20498.bzolnier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Aug 2009 07:22:31 +1000
Message-Id: <1251667351.20467.201.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Lyonel Vincent <lyonel@ezix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-08-30 at 20:54 +0200, Bartlomiej Zolnierkiewicz wrote:
> From: Lyonel Vincent <lyonel@ezix.org>
> Subject: [PATCH] powermac: thermal control turns system off in normal temperature conditions
> 
> On certain PowerMacs, a module (therm_windtunnel) controls various
> thermal settings (it can report CPU/case temperature, change speed
> of internal fans, etc.)
> 
> By default, the hardware thermal control has a temperature limit to
> protect the computer from damages (the default limit seems to be 80°C)
> but therm_windtunnel.c reduces it to an anormaly low value (65°C),
> which means that he computer will shut down randomly when hit by direct
> sun light or during summer (summer in France can be quite hot), actually
> possibly losing data instead of protecting it.
> 
> The overheat limit in therm_windtunnel.c:253-254 should be set to 75°C
> and 70°C instead of 65°C and 60°C respectively.

Looks reasonable, thanks.

Ben.

> From: Lyonel Vincent <lyonel@ezix.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
> Resurrected from Fedora's bugzilla (aka The Big Black Hole):
> https://bugzilla.redhat.com/show_bug.cgi?id=171937
> 
> The patch itself seems perfectly valid to me
> (especially given comments in therm_windtunnel.c).
> 
>  drivers/macintosh/therm_windtunnel.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: b/drivers/macintosh/therm_windtunnel.c
> ===================================================================
> --- a/drivers/macintosh/therm_windtunnel.c
> +++ b/drivers/macintosh/therm_windtunnel.c
> @@ -239,8 +239,8 @@ setup_hardware( void )
>  	 * to be on the safe side (OSX doesn't)...
>  	 */
>  	if( x.overheat_temp == (80 << 8) ) {
> -		x.overheat_temp = 65 << 8;
> -		x.overheat_hyst = 60 << 8;
> +		x.overheat_temp = 75 << 8;
> +		x.overheat_hyst = 70 << 8;
>  		write_reg( x.thermostat, 2, x.overheat_hyst, 2 );
>  		write_reg( x.thermostat, 3, x.overheat_temp, 2 );
>  
