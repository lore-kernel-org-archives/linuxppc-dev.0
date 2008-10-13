Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A51A9DDEED
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:30:11 +1100 (EST)
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081013142100.7efc2c81@zod.rchland.ibm.com>
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
	<20081013144904.GB18363@yoda.jdub.homelinux.org>
	<20081013154127.GA27124@yoda.jdub.homelinux.org>
	<209E575D-DDE2-406A-82DE-2DD445046C02@kernel.crashing.org>
	<20081013142100.7efc2c81@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 10:30:03 +1100
Message-Id: <1223940603.8157.286.camel@pasglop>
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

On Mon, 2008-10-13 at 14:21 -0400, Josh Boyer wrote:
> I don't think it matters much when it gets fixed, pre or post -rc1.  But
> it should probably get fixed.  My hack was to pull isa_bridge_pcidev
> into pci-common.c and export it from there.  The 64-bit PCI code can
> initialized it, and the 32-bit can leave it NULL.  But I have no idea
> if that is sane.  If so, I can probably submit a patch for it.

I think the proper fix in the long run is to make the isa bridge
handling code in pci-64 common, but that's going to be after I rework
the IO space allocation/mapping mechanisms for pci-32 to also look like
pci-64 so it will take a little while.

In the meantime, I agree, just leave it to NULL, we can do a better
fixup on top of that. As it is, it's going to hurt Pegasos too (the
other 5 users :-)

Cheers,
Ben.
