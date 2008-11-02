Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1A04DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 08:33:37 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081102134153.GA1029@zod.rchland.ibm.com>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<48FF3889.2030304@linux.vnet.ibm.com>
	<fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
	<20081101113018.GA13646@zod.rchland.ibm.com>
	<1225576502.8004.222.camel@pasglop>
	<20081102134153.GA1029@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 03 Nov 2008 08:33:16 +1100
Message-Id: <1225661596.8004.226.camel@pasglop>
Mime-Version: 1.0
Cc: Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org,
	pvr@emcraft.com, dzu@denx.de, Hollis Blanchard <hollis@penguinppc.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-11-02 at 08:41 -0500, Josh Boyer wrote:
> On Sun, Nov 02, 2008 at 08:55:02AM +1100, Benjamin Herrenschmidt wrote:
> >On Sat, 2008-11-01 at 07:30 -0400, Josh Boyer wrote:
> >> 
> >> That is on purpose.  The chip has an errata that causes badness if
> >> you use the last XX bytes of DRAM.  I forget exactly what XX is, but
> >> we just remove the last page.
> >
> >Doing that from the device-tree is very hairy tho... you end up with
> >informations in there that aren't aligned etc... oh well.
> 
> What?  -ENOTVERBOSEENOUGH.
> 
> I don't see how this is really different from U-Boot just passing in
> a smaller memory size in the old arch/ppc world.  (And I think U-Boot
> will actually fixup the device tree in a similar manner itself these
> days.)  So if there are problems with this, please do tell.

Is it cropping the memory nodes or using the reserve map ?

Ben.
