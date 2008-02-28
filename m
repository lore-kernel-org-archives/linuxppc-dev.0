Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7785DDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 19:00:28 +1100 (EST)
Subject: Re: [RFC][PATCH] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080226090210.6816c130@zod.rchland.ibm.com>
References: <1203634340.10422.203.camel@pasglop>
	<20080222192817.GA26211@ru.mvista.com>
	<20080222144919.3ded7c54@weaponx>
	<47C40548.4080608@ru.mvista.com> <47C41DBE.7090505@harris.com>
	<20080226090210.6816c130@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 18:54:59 +1100
Message-Id: <1204185299.15052.381.camel@pasglop>
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


On Tue, 2008-02-26 at 09:02 -0600, Josh Boyer wrote:
> Seems the code will do the right thing since everything is using
> flags.  I suppose my question can be withdrawn.  It is slightly
> confusing to do it that way though.  Perhaps a function to do
> read-modify-writes on DCRs would be welcome.  dcr_modify anyone?

Yup, we probably want to expose a dcri_clrset(), though I would also
expose then __mtdcri/__mfdcri (non locked version) and the spinlock in
case somebody wants to do something fancy.

Cheers,
Ben.
