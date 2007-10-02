Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 005DEDDFB3
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 08:02:49 +1000 (EST)
Subject: Re: [PATCH 2/7] [POWERPC] Fix QEIC->MPIC cascading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20071002122005.GA6425@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143429.GB5323@localhost.localdomain>
	<1191280461.6310.37.camel@pasglop>
	<20071002122005.GA6425@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 03 Oct 2007 08:02:42 +1000
Message-Id: <1191362562.22572.24.camel@pasglop>
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


> 
> Exactly, this is what that patch is trying to do. QEIC cascade handler is
> calling mpic's eoi() (end() actually, as it's flow level, but end == eoi.
> Is it main objection? Ok, I can get rid of it, and use chip level eoi()
> directly).

Yes, use eoi() directly, don't add end()

> Yup, exactly. Actually, QEIC's cascade handlers do not really know
> what needs to be done, but they're good at guessing (if (chip->eoi)).
> 
> Sure, I can place board-specific QEIC handlers in the board file, but
> that will be quite big code duplication for all machines using QEIC.

Maybe you can provide a set of common ones, and then just pick the one
you want from the board file ?

Or have some board code call into a QEIC init routine specifying the
type of cascade handler to use ... or whatevre you like here.

Just don't add end() where it doesn't belong.

Cheers,
Ben.
