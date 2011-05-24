Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC6D7B6FB5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 May 2011 13:40:25 +1000 (EST)
Subject: RE: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tirumala Marri <tmarri@apm.com>
In-Reply-To: <6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
References: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
	<1302306484.2458.64.camel@pasglop>
	<178c7df4696bacdd1510bacae143222a@mail.gmail.com>
	<20110429170240.GA21384@crust.elkhashab.com>
	<1304109476.2513.243.camel@pasglop> <1304487166.2513.351.camel@pasglop>
	<BANLkTi=BaYhw92wYHp9rPvz1yq2H1p0G9w@mail.gmail.com>
	<20110509160935.GA14965@crust.elkhashab.com>
	<6a09a426f126fb315b773fc207d68eb9@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 May 2011 13:40:12 +1000
Message-ID: <1306208412.7481.214.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Ayman El-Khashab <ayman@elkhashab.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-05-12 at 11:16 -0700, Tirumala Marri wrote:
> So what is the best way to handle this?  It appears (based
> on the comments of others and my own experience) that there
> is no DCR that exists and behaves the way that previous SOCs
> behaved to give us the link status? 

 The register above
> PECFGn_DLLSTA is actually in the PCIe configuration space so
> we would have to map that in to be able to read that
> register during the link check.  Is that correct or ok?
> [marri] yes, you need to program DCR register access these local PCIE_CFG
> registers.

We do I think, tho we might have to re-order some stuff. I'm facing a
similar issue with some internal design here, I'm thinking off adding a
new hook to the ppc4xx_pciex_hwops for link checking to replace the SDR
business.

The interesting question of course is whether that 460SX stuff is the
same as what we're using internally :-)

> I've communicated with some people over email and they had
> tried the (PESDRn_HSSLySTS) register.  Recognizing that
> there exists one of these for each port/lane, is there a way
> to use this one?  It is in the indirect DCR space.  I'd
> tried this myself and never did get it to do anything but I
> could have been looking at the wrong lane or something.
> [marri]This is at SERDES level. If this link up doesn't necessarily
> Overall stack is up. This is mostly used for BIST and diagnostics.
> 
> Lastly, what was the reason for forcing the original code to
> be GEN-1 speeds?
> [marri] Gen-2 need some extra checks compared to Gen-1.
> There were not many Gen-2 devices at the time of submission
> To test them.

Can we fix that ?

Cheers,
Ben.
