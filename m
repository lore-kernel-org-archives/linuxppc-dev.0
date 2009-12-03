Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60C9DB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Dec 2009 10:56:36 +1100 (EST)
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple
	PowerMac/PowerBook IDE controller
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <4B1772D0.5030303@garzik.org>
References: <20091202003630.29919100851@ozlabs.org>
	<4B1772D0.5030303@garzik.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 10:55:41 +1100
Message-ID: <1259884541.2076.1239.camel@pasglop>
Mime-Version: 1.0
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 03:12 -0500, Jeff Garzik wrote:

> Looks fine to me.  Two minor comments, which might perhaps be ignored if 
> that is your taste:
> 
> * prefer enums to #define's, for constants

yeah well ... I lifted those definitions from the old driver and didn't
feel like changing them all :-) I might do a separate patch later to
clean that up, we don't actually use a lot of those anymore since I use
pre-calculated tables, though they are good to keep as documentation.

> * prefer direct function call to "ap->ops->foo_bar()", because 
> ap->ops->foo_bar() is guaranteed to be a constant value known to the 
> driver.  The driver is the entity responsible for the function pointer.
>
> Maybe saves a cycle or two.  Not terribly important, but hey, calling 
> ap->ops->sff_exec_command() from pata_macio_bmdma_setup() is a hot path.

Makes sense. I'm tempted to make that a separate patch tho, since I've
already queued up the existing one and it's just a relatively minor
performance optim. 

Cheers,
Ben.
