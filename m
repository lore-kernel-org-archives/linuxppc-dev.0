Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0222567A39
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 10:59:29 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <4288DFCB.2080208@mvista.com>
References: <1116222720.5095.86.camel@gaston>
	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>
	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>
	<1116255938.5095.133.camel@gaston>
	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
	<1116261725.5095.139.camel@gaston>  <4288DFCB.2080208@mvista.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 10:56:17 +1000
Message-Id: <1116291377.5095.150.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-05-16 at 11:00 -0700, Mark A. Greer wrote:
> Benjamin Herrenschmidt wrote:
> 
> >
> >series are by no mean stable. Embedded code has been rather frozen in
> >the rock, I don't think it's much to ask from the appropriate maintainer
> >to have a quick look at possibly upgrading their board support as well.
> >
> 
> Seems reasonable to me.
> 
> >And it isn't a difficult change for most 6xx/7xx/7xxx based boards
> >anyway.
> >
> 
>  From a quick grep, it looks like apus, gemini, k2, lopec, pplus, prep, 
> and prpmc800 are the offenders in the 6xx/7xx/74xx world.  Does anyone 
> even care about the lopec and k2 anymore?

Note that there is only a problem if those io_block_mapping calls are
done to map things in the virtual region between 2G and 3G. If they are
done to map things "high" (like 0xf*) they are still fine.

Ben.
