Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DD20B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Oct 2010 07:57:07 +1100 (EST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pacman@kosh.dhis.org
In-Reply-To: <20101020183336.1714.qmail@kosh.dhis.org>
References: <20101020183336.1714.qmail@kosh.dhis.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 21 Oct 2010 07:56:55 +1100
Message-ID: <1287608215.2198.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-10-20 at 13:33 -0500, pacman@kosh.dhis.org wrote:
> > Just try :-) "quiesce" is something that afaik only apple ever
> > implemented anyways. It uses hooks inside their OF to shut down all
> > drivers that do bus master (among other HW sanitization tasks).
> 
> I booted a version with a prom_close_stdout after the last prom_debug. It
> didn't have any effect. That 1000Hz clock was still ticking. 

Ok so you'll have to make up a "workaround" in prom_init that looks for
OHCI's in the device-tree and disable them.

Check if the OHCI node has some existing f-code words you can use for
that with "dev /path-to-ohci words" in OF for example. If not, you may
need to use the low level register accessors. Use OF client interface
"interpret" to run forth code from C.

Cheers,
Ben.
