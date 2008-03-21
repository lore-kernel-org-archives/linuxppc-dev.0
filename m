Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 515B4DDEEA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 20:01:08 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Add AMCC Glacier 460GT eval board dts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1205943310-26323-1-git-send-email-sr@denx.de>
References: <1205943310-26323-1-git-send-email-sr@denx.de>
Content-Type: text/plain
Date: Fri, 21 Mar 2008 20:00:31 +1100
Message-Id: <1206090031.8420.67.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-03-19 at 17:15 +0100, Stefan Roese wrote:
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       model = "PowerPC,460GT";
> +                       reg = <0>;
> 

I wonder if we should do something here to differenciate the SoC chip
from the core. After all, all those 4xx mostly have the same core (there
are 2 or 3 revisions of the core maybe ...) but they tend to have all
different PVR which is a pain and won't scale...

Maybe AMCC could do something in HW (splitting the PVR from whatever
indicates what "chip" it is, and keeping the PVR purely for the core
rev) but I'm wondering if we should also do something in the DTS..
Stefan can you talk to your AMCC contacts about this ?

As for the DTS, maybe a "compatible" property in the CPU might make some
sense with a content along the lines of "ppc440x6" or whatever rev of
the 440 core it is.

What do you think ?

Cheers,
Ben.
