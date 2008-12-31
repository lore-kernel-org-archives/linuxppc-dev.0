Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35CF9DDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 20:09:46 +1100 (EST)
Subject: Re: [PATCH] net/ehea: use consistent type
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081230.215101.228854586.davem@davemloft.net>
References: <20081231141730.81449124.sfr@canb.auug.org.au>
	<20081230.215101.228854586.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 31 Dec 2008 20:09:01 +1100
Message-Id: <1230714541.15389.69.camel@pasglop>
Mime-Version: 1.0
Cc: tklein@de.ibm.com, sfr@canb.auug.org.au, themann@de.ibm.com,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-30 at 21:51 -0800, David Miller wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 31 Dec 2008 14:17:30 +1100
> 
> > ehea_plpar_hcall9() takes an unsigned long array, so pass that.
> > 
> > This change will avoid some warnings when we change u64 to unsigned
> > long long.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Patch rejected, for the same reasons as the other driver
> change.
> 
> We're not going to poop up some drivers with the assumption that long
> is 64-bit.

Well, in that case, this patch is actually correct without considering
the u64 change. The array is what lands in the registers of the pHyp
call, so strictly speaking, it's an array of unsigned long's (ie, 32-bit
on a 32-bit platform, 64-bit on a 64-bit platform), not an array of
u64's. This function being a wrapper on that pHyp call, it may as well
use the right type.

Cheers,
Ben.
