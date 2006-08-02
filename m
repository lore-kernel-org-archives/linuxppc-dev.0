Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 5369C67C09
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 06:45:29 +1000 (EST)
Date: Wed, 2 Aug 2006 13:49:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
Message-ID: <20060802204908.GA28403@mag.az.mvista.com>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
	<1154548217.32357.27.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154548217.32357.27.camel@basalt.austin.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 02:50:17PM -0500, Hollis Blanchard wrote:
> On Wed, 2006-08-02 at 13:48 -0500, Jon Loeliger wrote:
> > 
> > +               PowerPC,8641@0 {
> > +                       device_type = "cpu";
> > +                       reg = <0>;
> > +                       d-cache-line-size = <20>;       // 32 bytes
> > +                       i-cache-line-size = <20>;       // 32 bytes
> > +                       d-cache-size = <8000>;          // L1, 32K
> > +                       i-cache-size = <8000>;          // L1, 32K
> > +                       timebase-frequency = <0>;       // 33 MHz,
> > from uboot
> > +                       bus-frequency = <0>;            // From uboot
> > +                       clock-frequency = <0>;          // From uboot
> > +                       32-bit;
> > +                       linux,boot-cpu;
> > +               }; 
> 
> I need to do something similar for Xen, so I was curious: I guess the
> preferred way for runtime software to fill in values is by *overwriting*
> bogus values inserted at compile time?
> 
> The other alternative would be for the runtime code to insert new
> properties (presumably via memmove()), but overwriting definitely seems
> simpler.

Two reasons you may want to overwrite instead of insert a new one (at
least for now):

1) Strictly opinion: Its nice to be able to see the completely
functional tree and not one that's missing a critical property
that is magically inserted behind the scenes.

2) Strictly practical for now: If you plan on using a zImage with
the fdt patches that are being discussed right now, the fdt code
doesn't currently support inserting a new property, only modifying an
existing one.  Patches always welcome though! :)

Mark
