Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 783F7DDDF8
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 07:39:05 +1000 (EST)
Date: Fri, 26 Oct 2007 23:37:51 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/2] PowerPC: Add 44x NDFC device-tree aware support
In-Reply-To: <20071026163058.GA11354@ru.mvista.com>
Message-ID: <alpine.LFD.0.9999.0710262316590.3186@localhost.localdomain>
References: <20071026163058.GA11354@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 26 Oct 2007, Valentine Barshak wrote:
> The major difference is that the original implements each chip connected NDFC banks as a
> separate MTD device. Here I try to have one MTD device spread on all chips found.
> However, the chips should have equal ID's and sizes, but I've never seen several different
> chips attached to single ndfc.

Bamboo has 2 different nand chips. And I'm aware of another board
which has a 2k-page onboard NAND and sockets for SmartMedia /
PictureXd cards, which will simply break with your design.

Restricting stuff for no good reason is never a good idea.

mtdconcat can build you a big one if you want, so why adding
restrictions to a driver ?

> I'm adding ndfc_of as a separate file, since some other changes
> have also been made (e.g. all i/o is made with ndfc_readl/writel inline functions).

This should be done in the original ndfc driver and not in a separate
incarnation.

> The original version didn't handle driver removal well (it never calls del_mtd...),it's 
> corrected here.

Why not fixing the original driver ?

> Any comments are greatly appreciated.

NACK.

Please fix the existing driver and convert it to deal with OF and fix
the other short comings as well.

Duplicate code is not going anywhere near drivers/mtd/nand

	tglx
