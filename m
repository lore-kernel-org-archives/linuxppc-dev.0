Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 806BC2BF27
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 15:20:06 +1100 (EST)
In-Reply-To: <41E5B318.3060304@mvista.com>
References: <41E5B318.3060304@mvista.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <579DFDF6-651A-11D9-92A0-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 12 Jan 2005 22:19:39 -0600
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@ozlabs.org, Kumar Gala <galak@somerset.sps.mot.com>
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> My $0.02.
>
> I didn't go thru in complete detail but I like the idea.=A0 I have a
> couple minor comments, though.
>
> 1) Can we pick something other than 'soc' since the Marvell bridges
>  really aren't SOCs?=A0 I don't really know what is better but just to
> throw something out, how about haing them all look like ppc_pd_xxx()?

What about ppc_plat_xxx() or ppc_sys_xxx() [for system]?  'sys' maybe=20
more consistent with our naming conventions in that arch/ppc/platforms=20=

is more board focused, and arch/ppc/syslib is bridge and non-core chip=20=

functionality.

> 2) In 8540_ads.c you're digging out platform_device entries and
> modifying them in your mpc8540ads_setup_arch() routine.=A0 I think the
> platform_device "way" of doing that would be to make your mods via the
> platform_notify() hook (eventually called by device_add() which was
> ultimately called from platform_add_devices()).

This is problematic for some things like the updating of the IOMEM=20
resources since that needs to occur before platform_device_register is=20=

called.  However, the updates in mpc8540_ads.c could possibly handled=20
by platform_notify(), will look into that.

- kumar=
