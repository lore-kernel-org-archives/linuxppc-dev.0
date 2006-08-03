Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C7A8367B82
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 08:00:23 +1000 (EST)
Subject: Re: [PATCH] Convert to mac-address for ethernet MAC address data.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0D9BEF4A-F8A5-42C5-9962-8C88322C9F50@kernel.crashing.org>
References: <1154640338.26770.34.camel@cashmere.sps.mot.com>
	<0D9BEF4A-F8A5-42C5-9962-8C88322C9F50@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1154642143.27512.6.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 03 Aug 2006 16:55:43 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-03 at 16:49, Kumar Gala wrote:

> >
> > -		mac_addr = get_property(np, "address", NULL);
> > -		memcpy(gfar_data.mac_addr, mac_addr, 6);
> > +		mac_addr = get_property(np, "local-mac-address", NULL);
> 
> If "mac-address" the preferred mechanism, why dont we check for it  
> first?

It's not.  "local-mac-address" is.  But that is HW specific.
SW version comes in as "mac-address".  Here's what was said
earlier by Paul Nasrat:

    Well I'm biased and say we shouldn't reinvent the wheel
    with dtc if we don't need to.  I've sent Jon a patch to
    start validating this for dtc and am waiting feedback
    before I add additional device_types. So we should have
    local-mac-address be preassiged hwaddr and mac-address last
    used. For some setups this would be the same persistently,
    but I can envisage some non OF setups populating mac-address
    from the card. 

    Paul

Which I interpreted to mean the order: local-mac-address first,
mac-address next, and the obsolete one, "address" last.

jdl
