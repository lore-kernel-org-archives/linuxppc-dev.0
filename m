Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 1B626DDF01
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 05:40:46 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <avorontsov@ru.mvista.com>
Subject: RE: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	registermmc_spi stub
Date: Thu, 26 Jul 2007 21:40:23 +0200
Message-ID: <02bd01c7cfbc$cf213610$02ac10ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20070726154747.GA6930@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com] 
> Sent: den 26 juli 2007 17:48
> To: Joakim Tjernlund
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, 
> registermmc_spi stub
> 
> On Thu, Jul 26, 2007 at 05:36:06PM +0200, Joakim Tjernlund wrote:
> [...]
> > >  		spi@4c0 {
> > >  			device_type = "spi";
> > > +			device-id = <1>;
> > >  			compatible = "fsl_spi";
> > >  			reg = <4c0 40>;
> > >  			interrupts = <2>;
> > >  			interrupt-parent = <&qeic>;
> > > -			mode = "cpu";
> > > +			mode = "qe";
> > 
> > The driver is still using "cpu" mode. It just happens that 
> the cpu mode for QE
> > enabled CPUs isn't 100% compatible with the defacto cpu 
> mode used by other CPU:s.
> 
> Yup, indeed.
> 
> > So mode should probably be "cpu_qe" or, even better, if the 
> drver could
> 
> That's easy to change, thanks.
> 
> > autodetect that it is running on a QE enabled CPU and 
> adjust accordinly.
> > Maybe the Freescale guys have some ideas how to do that.
> 
> Ok. Well, for now could we use machine_is() for kind of autodetect?
> Or it's better leave it as is, and just rename mode to cpu_qe?

Unless the DTS guys thinks otherwise, just rename to "cpu_qe".
"qe" would then be reserved for true QE mode.

 Jocke
