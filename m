Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D0988DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 07:19:50 +1000 (EST)
Message-ID: <46535DC7.6080807@freescale.com>
Date: Tue, 22 May 2007 16:16:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 10/13] mpc83xx: Power Management support
References: <20070507182955.GI26920@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.60.0705222301070.4243@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0705222301070.4243@poirot.grange>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:
>>+	/* There can only be one fsl,mpc83xx-pmc device in the system;
>>+	 * it is assumed that it is the one that the pmc driver matches.
>>+	 */
>>+	if (of_device_is_compatible(sleep_controller, "fsl,mpc83xx-pmc")) {
>>+		sleep->sccr_mask = sleepdata[1];
>>+		ret = 0;
>>+	}
> 
> 
> Just wondering - do we really want to special-case 83xx-pmc here? What 
> when / if further "sleep controllers" get implemented? Shouldn't this be 
> some callback?

The quick and ugly thing would be more if checks.  The ideal solution 
would be a mechanism to look up a device by phandle, returning an ops 
struct corresponding to the requested class (if the device supports it).

> BTW, do we have an interface similar to platform-driver/device for of? 
> Like of_driver/device. This would be a use case for it. Just register a 
> of_driver, which would trigger a dt-scan (just a find_compatible), calling 
> driver's probe()... Would it make sense?

See asm-powerpc/of_platform.h.  However, that won't help find the driver 
  you need to talk to if all you have is a phandle.

-Scott
