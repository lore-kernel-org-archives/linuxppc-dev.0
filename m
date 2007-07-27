Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BF22DDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 02:35:50 +1000 (EST)
Date: Fri, 27 Jul 2007 11:35:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pq2fads support...
Message-ID: <20070727163529.GA26893@ld0162-tx32.am.freescale.net>
References: <op.tv4h01apnhx3hy@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <op.tv4h01apnhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 27, 2007 at 03:24:08PM +0300, Alexandros Kostopoulos wrote:
> In your patch for the pq2fads support, the device tree seems to be missing  
> a memory node, for which dtc complains loudly. Is this board tested to  
> boot with these patches (because I'm now using this as a template for my  
> board - with your patchset applied to Paul's git)

Sorry about that -- dtc complains about a lot of silly things, falsely
assuming that the result is intended to be a complete tree ready for
passing to Linux (which is rarely true).  I'd been running with a patch
to remove some of those checks, but it got rejected, and I forgot to
stick the templates back into the dts.

The next patchset will have a dts that works with current dtc; in the
meantime, you can add the -f flag to dtc in arch/powerpc/boot/wrapper, or
add the missing nodes based on the mpc8272ads device tree (the actual
information will be filled in by the bootwrapper).

> PS. What's about this new cpm-serial driver? is this supposed to be a  
> replacement for cpm_uart?

No, it's a minimal driver for the bootwrapper.

-Scott
