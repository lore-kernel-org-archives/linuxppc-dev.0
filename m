Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B9D7DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:23:02 +1000 (EST)
Date: Wed, 4 Apr 2007 02:25:44 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404022544.59b022a6@the-village.bc.nu>
In-Reply-To: <20070403212928.GA12951@cynthia.pants.nu>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The TTY_MAJOR should have never belonged to 8250.c in the first place.
> I know it's just my opinion, but I think this major device should be
> owned by the serial core, and it shouldn't matter what chip drives each
> individual port. Each hardware driver should just register with the
> core how many ports it has and should be allocated from the same range.

That would be completely unmanagable on many systems with multiport
controllers and interfaces where the naming tells you things like which
cable port off which socket off which multiplexor is the one you are
talking about.

You can't dynamically identify serial ports, you can't generally speaking
probe the device the other end and get persistant identifiers.

> This situation is purely a side-effect of the fact that all the
> original Linux supported hardware used the 8250 driver and everyone
> who didn't use 8250 was marginalized enough that they got ignored.

Nope. The original design used different numbers of each type of port
quite intentionally. Having handy names for the onboard ports is useful
as well but not related. One or two people cheated and its finally come
back to haunt them.

Alan
