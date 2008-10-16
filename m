Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id BB85CDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 19:48:53 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: Problems with PCI-E devices not being detected with switch
Date: Thu, 16 Oct 2008 10:48:45 +0200
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<200810161003.31801.sr@denx.de> <1224145785.7654.4.camel@pasglop>
In-Reply-To: <1224145785.7654.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200810161048.45937.sr@denx.de>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, Victor Gallardo <vgallardo@amcc.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 October 2008, Benjamin Herrenschmidt wrote:
> On Thu, 2008-10-16 at 10:03 +0200, Stefan Roese wrote:
> > Doing this unconditionally is not a good idea since we could have an old
> > (buggy) firmware which didn't configure the PCIe controller correctly.
> > But I really like your idea with the device-tree property to optionally
> > skip this re-configuration. Now we only need to find some "volunteer" to
> > do this job... ;)
>
> I don't have a problem adding support for testing that property and
> skipping most of the initial HW setup, basically treating the endpoint
> as pre-configured.
>
> What about using a value for "status" ?

No. "status" is already used to disable/skip the PCIe slot completely. For 
example on Canyonlands where PCIe#0 is multiplexed with the SATA port.

> Or an empty "configured" 
> property ? Ideally, it should have been the other way around, ie
> "unconfigured" for old/buggy stuff but I'm worried there may be existing
> out-of-tree device-trees without it :-)

Yeah. I could add this "configured" property to the current U-Boot version. 
Perhaps we should add some version information to it so that Linux could 
eventually decide to re-configure when the "configured" version is known to 
be buggy. What do you think?

Best regards,
Stefan
