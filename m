Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D81ECDDEDE
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Nov 2007 15:46:23 +1100 (EST)
Subject: Re: [PATCH] Avoid unpaired stwcx. on some processors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071109231927.GA19415@lixom.net>
References: <11946460863124-git-send-email-becky.bruce@freescale.com>
	<20071109231927.GA19415@lixom.net>
Content-Type: text/plain
Date: Sun, 11 Nov 2007 15:46:05 +1100
Message-Id: <1194756365.21340.32.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Seems like a "better" (but still ugly) workaround would be to create a
> _new_ reservation to a RA that's unavailable to any userspace process,
> so that they could never do a successful store to it. That way you would
> have stray reservations, but never dangling stwcx:es. No?

Many processors don't compare the reservation address locally. If
there's any valid reservation held by that processor, a subsequent
stwcx. will always succeed. That would make you scheme dangerous :-)

Ben.
