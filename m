Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1F6F7DDF3A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 03:17:07 +1000 (EST)
Date: Mon, 23 Jun 2008 12:16:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
Subject: Re: Virqs of cascaded interrupt controller.
Message-ID: <20080623171644.GB6978@loki.buserror.net>
References: <1CADFA951940554D86FBD8B24BBFF3A0017B35B9@LONMLVEM08.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1CADFA951940554D86FBD8B24BBFF3A0017B35B9@LONMLVEM08.e2k.ad.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 03:00:35PM +0100, Welch, Martyn (GE EntSol, Intelligent Platforms) wrote:
> I'm in the process of porting Linux to one of our boards based on an
> 8641D. Some of the interrupts of on-board devices are dealt with by a
> custom interrupt controller in one of the onboard FPGAs, which cascades
> into the 8641D's mpic. I'm trying to write a driver for it.
> 
> Looking at examples of cascaded interrupt handlers I've managed to get
> to the point where the kernel is trying to register interrupts from the
> DTB file I provide it. The problem is I don't know what virqs are being
> assigned to the interrupts or how virqs are/should be assigned to a
> cascaded interrupt controller.

The virqs are created by irq_create_mapping() or irq_of_parse_and_map(). 
It is preferred to use the latter, with the interrupts expressed in the
device tree.

If that doesn't answer your question, could you be more specific about what
you're trying to find out, and/or what aspect of the existing cascaded irq
controllers (e.g. sysdev/qe_lib/qe_ic.c, platforms/82xx/pq2ads-pci-pic.c)
you want clarfication of?  Do you want to know what to pass to request_irq,
how to turn virqs back into hwirqs in the cascade driver, or something else?

-Scott
