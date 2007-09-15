Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5E784DDE17
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 00:27:13 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8FERAdp025641
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 10:27:10 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8FERAIl409574
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:27:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8FER97d026779
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:27:10 -0600
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200709150523.12817.sr@denx.de>
References: <20070914185410.387074000@linux.vnet.ibm.com>
	<20070914185410.387074000@linux.vnet.ibm.com> >
	<20070914185649.272138000@linux.vnet.ibm.com> >
	<200709150523.12817.sr@denx.de>
Content-Type: text/plain
Date: Sat, 15 Sep 2007 09:26:19 -0500
Message-Id: <1189866379.17593.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-09-15 at 05:23 +0200, Stefan Roese wrote:
> On Friday 14 September 2007, Josh Boyer wrote:
> > A new binding for flash devices was recently introduced.  This updates the
> > Walnut DTS to use the new binding.
> >
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/boot/dts/walnut.dts |   17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > --- linux-2.6.orig/arch/powerpc/boot/dts/walnut.dts
> > +++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
> > @@ -137,6 +137,10 @@
> >  			dcr-reg = <012 2>;
> >  			#address-cells = <2>;
> >  			#size-cells = <1>;
> > +			/* The ranges property is supplied by the bootwrapper
> > +			 * and is based on the firmware's configuration of the
> > +			 * EBC bridge
> > +			 */
> >  			clock-frequency = <0>; /* Filled in by zImage */
> >
> >  			sram@0,0 {
> > @@ -144,13 +148,16 @@
> >  			};
> >
> >  			flash@0,80000 {
> > -				device_type = "rom";
> > -				compatible = "direct-mapped";
> > -				probe-type = "JEDEC";
> > +				compatible = "jedec-flash";
> >  				bank-width = <1>;
> > -				partitions = <0 80000>;
> > -				partition-names = "OpenBIOS";
> >  				reg = <0 80000 80000>;
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				partition@0 {
> > +					label = "OpenBIOS";
> > +					reg = <0 80000>;
> > +					read-only;
> > +				};
> 
> There are not only Bamboo board running PIBS, but running U-Boot too. How 
> should we handle this different FLASH partitioning? Same goes for Ebony too 
> btw.

That's a good question.  I'm working on making the NOR flash show up for
Bamboo right now, and I had intended to just leave the partition
subnodes missing.

josh
