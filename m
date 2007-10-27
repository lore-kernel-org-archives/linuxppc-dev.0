Return-Path: <SRS0=/0kd=PV=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 781E9DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 14:49:41 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/2] PowerPC: Add 44x NDFC device-tree aware support
Date: Sat, 27 Oct 2007 06:42:53 +0200
References: <20071026163058.GA11354@ru.mvista.com>
	<alpine.LFD.0.9999.0710262316590.3186@localhost.localdomain>
In-Reply-To: <alpine.LFD.0.9999.0710262316590.3186@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710270642.54171.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Valentine,

On Friday 26 October 2007, Thomas Gleixner wrote:
> On Fri, 26 Oct 2007, Valentine Barshak wrote:
> > The major difference is that the original implements each chip connected
> > NDFC banks as a separate MTD device. Here I try to have one MTD device
> > spread on all chips found. However, the chips should have equal ID's and
> > sizes, but I've never seen several different chips attached to single
> > ndfc.
>
> Bamboo has 2 different nand chips.

Right. This was my first thought after seeing your mail too.

> And I'm aware of another board 
> which has a 2k-page onboard NAND and sockets for SmartMedia /
> PictureXd cards, which will simply break with your design.
>
> Restricting stuff for no good reason is never a good idea.

Add my voice here too.

> mtdconcat can build you a big one if you want, so why adding
> restrictions to a driver ?
>
> > I'm adding ndfc_of as a separate file, since some other changes
> > have also been made (e.g. all i/o is made with ndfc_readl/writel inline
> > functions).
>
> This should be done in the original ndfc driver and not in a separate
> incarnation.

Right. And I always thought it would be a good idea to switch to using the 
in_be32() functions and friends for IO access in this driver too.

Best regards,
Stefan
