Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF717DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 00:15:07 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1C2F1@az33exm25.fsl.freescale.net>
References: <729E7ED6-D601-4D4C-B110-F951409BAE2B@kernel.crashing.org>
	<F408B146-AC76-43F5-9D9D-0094BAF14941@embeddedalley.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1C2F1@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f17b2e4ee4a9f92709e3de9f246e4943@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: macros and dtc
Date: Tue, 20 Feb 2007 14:15:00 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There are lot's of hardcoded constants floating around
> in the dts files that for clarity should be #defined (or
> whatever the m4 equivalent is) at the top of the file.

For *clarity*, they should be bare constants :-)

For maintainability, values that are not changing ever
(fixed addresses on some SoC for example) are fine as
a constant; they never change, after all.  Addresses
that are configurable though (PCI ranges for example)
could benefit from a macro def.  Then again, such things
should ideally be filled in by the boot wrapper instead
(for PCI, this means the boot wrapper would need to know
how to do PCI config on your PHB; it then could automatically
generate almost all of the PCI tree).  Well this is not
the best example I guess, Linux can do without the PCI
stuff in the tree, but the same idea goes for many other
features that can be probed; you have one basic DTB for
a whole family of boards and the boot wrapper fills in
the details.  It would be useful then (and now already)
to have some /proc/flatdevtree that outputs the binary
blob that the kernel was fed -- someone create that please :-)


Segher
