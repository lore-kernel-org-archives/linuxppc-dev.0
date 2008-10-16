Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38A04DDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 19:41:19 +1100 (EST)
Subject: Re: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200810161003.31801.sr@denx.de>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>  <200810161003.31801.sr@denx.de>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 19:29:45 +1100
Message-Id: <1224145785.7654.4.camel@pasglop>
Mime-Version: 1.0
Cc: Ayman El-Khashab <AymanE@tanisys.com>, Victor Gallardo <vgallardo@amcc.com>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 10:03 +0200, Stefan Roese wrote:
> Doing this unconditionally is not a good idea since we could have an old 
> (buggy) firmware which didn't configure the PCIe controller correctly. But I 
> really like your idea with the device-tree property to optionally skip this 
> re-configuration. Now we only need to find some "volunteer" to do this 
> job... ;)

I don't have a problem adding support for testing that property and
skipping most of the initial HW setup, basically treating the endpoint
as pre-configured.

What about using a value for "status" ? Or an empty "configured"
property ? Ideally, it should have been the other way around, ie
"unconfigured" for old/buggy stuff but I'm worried there may be existing
out-of-tree device-trees without it :-)

Cheers,
Ben
