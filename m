Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 45F8E67A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 01:06:22 +1000 (EST)
In-Reply-To: <424AAF09.9050706@ru.mvista.com>
References: <424AAF09.9050706@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <5a325f210dccfd254541824008e8c5a1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 30 Mar 2005 09:06:02 -0600
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, Jakob Viketoft <jakob.viketoft@bitsim.se>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Platform bus/ppc sys model...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 30, 2005, at 7:52 AM, Andrei Konovalov wrote:

> Sylvain Munaut wrote:
>  > Hi,
>  >
> >
> >> Is there some good documentation about how to use the platform bus=20=

> / ppc
>  >> sys model or is it only possible to read and try to understand the=20=

> code
>  >> for the freescale devices?
>  >
> >
> > I'm not aware on documentation for the ppc_sys model in particular=20=

> but
>  > the code is pretty easy to understand/read.
> >
> > Basically you have a ???_devices.c that describe all the devices you=20=

> can
>  > find in a family of devices (by family I mean basically the same
> > processors but with slightly different options/peripheral), then a
> > ???_sys.c that describe each particular variant with the devices =
that
> > are really implemented in that variant). Then somewhere in platform=20=

> init
> > code, you need to identify the ppc system=A0 you're runngin on ( by =
a
> > identify_ppc_sys_by_id(mfspr(SPRN_SVR)); for e.g. ).
>  >
> > Kumar, if I got it wrong, please correct ;)

thats a pretty fair description.

> Do I understand correct that the ppc_sys model used by 85xx, 83xx, and=20=

> 52xx
>  SOCs is not so well suited for Virtex-II Pro (which Jakob and me bear=20=

> in mind)?
>  In case of Xilinx ???_devices.c could be the list of all the IPs=20
> supported in linux.
>  But ???_sys.c has little sense as for any given combination of the=20
> particular
>  Virtex-II Pro chip and the particular board the set of IPs (as well=20=

> as the memory
> map, interrupt numbers, some hardware options (if ethernet has SGDMA=20=

> or not))
>  is not fixed. I.e. ideally we would need some kind of run time system=20=

> configuration
>  instead of compiled time system configuration implemented by=20
> ???_sys.c.

This is correct.  There is nothing that precludes us from building up a=20=

way to dynamically create the information.  Is there some way to query=20=

the hardware itself, or is the information implied something else?

- kumar
