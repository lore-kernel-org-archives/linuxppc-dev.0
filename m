Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 85C62DDE9B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 08:04:58 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix 44x Machine Check handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071116085813.3cebed79@weaponx>
References: <20071116072149.350ADDDDF4@ozlabs.org>
	<20071116074025.GA4741@lixom.net>  <20071116085813.3cebed79@weaponx>
Content-Type: text/plain
Date: Sat, 17 Nov 2007 08:03:23 +1100
Message-Id: <1195247003.28865.167.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-16 at 08:58 -0600, Josh Boyer wrote:
> > 2) Please just move the machine check handlers out to individual
> ones
> > instead of using the generic one. That way you don't need runtime
> checks
> > between the two (they don't seem to share much of it as-is anyway).
> 
> Anton pinged me about cleaning that up a couple months ago.  I have a
> half-baked patch for it somewhere, but I agree having 4xx set a ppc_md
> specific handler would be a good idea.

No need. The 2 asm implementation can branch to 2 different C functions
and the IVOR will be set to the right one.

Ben.
