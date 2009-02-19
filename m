Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F4DBDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 05:38:33 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1JIcOOT024563
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 11:38:30 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n1JIcOWT005197
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 12:38:24 -0600 (CST)
Date: Thu, 19 Feb 2009 12:38:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: Dushara Jayasinghe <DusharaJ@optiscan.com>
Subject: Re: Newby trying to get Ethernet going on MPC83xx series device.
Message-ID: <20090219183823.GA4180@ld0162-tx32.am.freescale.net>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
Cc: "'linuxppc-dev@ozlabs.org'" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 19, 2009 at 03:26:41PM +1100, Dushara Jayasinghe wrote:
> I get the following error during the boot sequence:
> 
> IP-Config: Device `eth0' not found
> 
> I also found that both gfar_init (in gianfar.c) and gfar_mdio_init (in
> gianfar_mii.c) are called but the probe handlers of either of these
> devices are not executed.

Check your board code to see if the soc node is being probed by
of_platform_bus_probe.  Ideally, the soc node would have "simple-bus"
included in the compatible property, as would the of_device_id array.

-Scott
