Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CEEA2DDEEA
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 18:14:09 +1100 (EST)
Date: Sun, 11 Nov 2007 01:14:38 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Avoid unpaired stwcx. on some processors
Message-ID: <20071111071438.GA12369@lixom.net>
References: <11946460863124-git-send-email-becky.bruce@freescale.com>
	<20071109231927.GA19415@lixom.net>
	<1194756365.21340.32.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1194756365.21340.32.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 11, 2007 at 03:46:05PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Seems like a "better" (but still ugly) workaround would be to create a
> > _new_ reservation to a RA that's unavailable to any userspace process,
> > so that they could never do a successful store to it. That way you would
> > have stray reservations, but never dangling stwcx:es. No?
> 
> Many processors don't compare the reservation address locally. If
> there's any valid reservation held by that processor, a subsequent
> stwcx. will always succeed. That would make you scheme dangerous :-)

Yeah, I had missed that arch detail. Becky already explained it in her
reply, but thanks for doing it again. :)


-Olof
