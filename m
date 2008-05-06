Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BAB4DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 10:12:35 +1000 (EST)
Subject: Re: [PATCH 1/4] [v4][POWERPC] refactor dcr code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.5C26F2B0059@mail60-sin.bigfish.com>
Content-Type: text/plain
Date: Tue, 06 May 2008 10:12:19 +1000
Message-Id: <1210032739.21644.133.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 10:56 -0700, Stephen Neuendorffer wrote:
> Previously, dcr support was configured at compile time to either using
> MMIO or native dcr instructions.  Although this works for most
> platforms, it fails on FPGA platforms:
> 
> 1) Systems may include more than one dcr bus.
> 2) Systems may be native dcr capable and still use memory mapped dcr interface.
> 
> This patch provides runtime support based on the device trees for the
> case where CONFIG_PPC_DCR_MMIO and CONFIG_PPC_DCR_NATIVE are both
> selected.  Previously, this was a poorly defined configuration, which
> happened to provide NATIVE support.  The runtime selection is made
> based on the dcr controller having a 'dcr-access-method' attribute
> in the device tree.  If only one of the above options is selected,
> then the code uses #defines to select only the used code in order to
> avoid introducing overhead in existing usage.
> 
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Quick look seems ok, but that was really only a quick look :-)

I'll rely on Josh to review further.

Cheers,
Ben.
