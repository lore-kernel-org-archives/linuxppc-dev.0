Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15966DE303
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:38:56 +1100 (EST)
Date: Tue, 8 Jan 2008 11:38:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
Message-ID: <20080108173845.GA5188@loki.buserror.net>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 08:58:17AM -0700, Grant Likely wrote:
> On 1/7/08, Li Yang <leoli@freescale.com> wrote:
> > +       soc@e0000000 {
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               device_type = "soc";
> 
> I recommend dropping device_type and adding 'compatible = "fsl,mpc8377-immr";'

I recommend fixing the code that looks for this device_type before
recommending that people drop it. :-)

> > +               wdt@200 {
> > +                       compatible = "mpc83xx_wdt";
> 
> "fsl,mpc8377_wdt", "fsl,mpc83xx_wdt" as per generic names recommended practice.

Speaking of generic names, can we change the node name to "watchdog"?

> > +               /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> > +               usb@23000 {
> > +                       compatible = "fsl-usb2-dr";
> > +                       reg = <23000 1000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +                       interrupt-parent = < &ipic >;
> > +                       interrupts = <26 8>;
> > +                       phy_type = "utmi_wide";
> 
> fsl,phy_type please.

Again, code will break.  Can we stop ambushing people submitting board
support with complaints against existing, non-board-specific code/device
trees?  Fix that first, then complain if new code reintroduces the crud.

Also, if we're going to change the property name, we should also change the
underscore to a dash.

> > +               enet0: ethernet@24000 {
> > +                       cell-index = <0>;
> > +                       device_type = "network";
> > +                       model = "eTSEC";
> 
> Drop model property

Fix the code that checks for it.

-Scott
