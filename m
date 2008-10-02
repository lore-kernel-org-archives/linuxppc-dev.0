Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 14510DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Oct 2008 15:51:47 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: EMAC2 in ibm_newemac driver
Date: Thu, 2 Oct 2008 07:51:42 +0200
References: <f608b67d0810012138w64ba5ecbg1f88fff505c820b7@mail.gmail.com>
In-Reply-To: <f608b67d0810012138w64ba5ecbg1f88fff505c820b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810020751.42821.sr@denx.de>
Cc: vb <vb@vsbe.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 02 October 2008, vb wrote:
> I have a 460GT based system with three ethernet interfaces, and I
> don't seem to be able to bring up EMAC2 in RGMII mode. The PHY works
> just fine, the counterpart on the other side of the serdes link
> autonegotiates successfully, etc. When I attempt to send something
> from the interface though, nothing shows up on the RGMII lines (I use
> a scope to probe it). The received traffic is passed from the  PHY to
> the MAC, but again, nothing is reported by the rx driver.
>
> I am using the latest released code from 2.6.26.5 (I started with
> 2.6.25 release, and in that case just EMAC0 worked, updgrading to to
> 2.6.26.5 made the second interface work, but the third one seems to be
> stuck. I see that the Denx tree has a lot of changes in the driver,
> but it is not as cleanly portable, so advancing  there is not an
> option.

The ibm_newemac driver in the DENX repository has absolutely no changes to the 
kernel.org version.

> I am trying to debug it, but  am wondering if anyone had more than two
> interfaces going on this architecture and if so - what are the
> gotchas.

The AMCC Glacier 460GT eval board uses all 4 EMAC's with RGMII. IIRC, then you 
need to configure the GPIO multiplexing differently (compared to Canyonlands 
460EX) to fully support all 4 EMAC's on 460GT. This is done in U-Boot. I 
suggest that you check this configuration first.

Best regards,
Stefan
