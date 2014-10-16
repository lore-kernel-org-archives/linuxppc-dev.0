Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462D41A034C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 09:52:44 +1100 (AEDT)
Message-ID: <1413499949.4567.3.camel@pasglop>
Subject: Re: [PATCH] drivers/crypto/nx: prevent oops on module exit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 17 Oct 2014 09:52:29 +1100
In-Reply-To: <1413499435.28062.2.camel@concordia>
References: <1413487819-6119-1-git-send-email-ddstreet@ieee.org>
 <1413499435.28062.2.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Seth Jennings <sjennings@variantweb.net>,
 Dan Streetman <ddstreet@ieee.org>, Robert Jennings <rcj4747@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-17 at 09:43 +1100, Michael Ellerman wrote:
> On Thu, 2014-10-16 at 15:30 -0400, Dan Streetman wrote:
> > Check old_devdata->dev in nx-842 driver before accessing it, as
> > on systems without any nx-842 hardware, the ->dev will never be
> > set.  Currently, the module will cause an oops during unload
> > since old_devdata->dev is null.
> 
> Hi Dan,
> 
> Patch looks reasonable. But I can't merge it, at least not without an ACK:
> 
> $ ./scripts/get_maintainer.pl -f drivers/crypto/nx/
> Nathan Fontenot <nfont@linux.vnet.ibm.com> (supporter:IBM Power 842 com...)
> Marcelo Henrique Cerri <mhcerri@linux.vnet.ibm.com> (supporter:IBM Power in-Nest...)
> Fionnuala Gunter <fin@linux.vnet.ibm.com> (supporter:IBM Power in-Nest...)
> Herbert Xu <herbert@gondor.apana.org.au> (maintainer:CRYPTO API)
> "David S. Miller" <davem@davemloft.net> (maintainer:CRYPTO API)
> linux-crypto@vger.kernel.org (open list:IBM Power in-Nest...)
> linux-kernel@vger.kernel.org (open list)
> 
> 
> If any of the above is out of date please send me a patch for MAINTAINERS.

I think Dan now owns that driver, Dan, please confirm.

Cheers,
Ben.
