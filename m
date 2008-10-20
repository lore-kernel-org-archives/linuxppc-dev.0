Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69710DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 10:43:59 +1100 (EST)
Subject: Re: [PATCH] ibm_newemac: Fix new MAL feature handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081016143840.GA29805@yoda.jdub.homelinux.org>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<1224133010.8157.543.camel@pasglop>
	<20081016143840.GA29805@yoda.jdub.homelinux.org>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 10:43:41 +1100
Message-Id: <1224546221.7654.196.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-16 at 10:38 -0400, Josh Boyer wrote:
> On Thu, Oct 16, 2008 at 03:56:50PM +1100, Benjamin Herrenschmidt wrote:
> >> drivers/net/ibm_newemac/mal.c: In function 'mal_txeob':
> >> drivers/net/ibm_newemac/mal.c:284: error: implicit declaration of function 'mtdcri'
> >> drivers/net/ibm_newemac/mal.c:284: error: 'SDR0' undeclared (first use in this function)
> >> drivers/net/ibm_newemac/mal.c:284: error: (Each undeclared identifier is reported only once
> >> drivers/net/ibm_newemac/mal.c:284: error: for each function it appears in.)
> >> drivers/net/ibm_newemac/mal.c:285: error: implicit declaration of function 'mfdcri'
> >> drivers/net/ibm_newemac/mal.c: In function 'mal_rxeob':
> >> drivers/net/ibm_newemac/mal.c:302: error: 'SDR0' undeclared (first use in this function)
> >
> >That's annoying, I'll have a look.
> 
> Support for new features needed by the PPC 405EZ boards
> introduced some errors in the MAL and EMAC feature handling.
> This broke 'allmodconfig' builds as CONFIG_PPC_DCR_NATIVE is
> not set for those.
> 
> This patch fixes these errors by wrapping the code in the
> appropriate #ifdefs.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Jeff, this breaks build, I'll put it in powerpc.git for a merge today,

Cheers,
Ben.
