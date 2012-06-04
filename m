Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5101B6FD7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2012 16:55:07 +1000 (EST)
Message-ID: <1338792897.7150.68.camel@pasglop>
Subject: Re: [PATCH] powerpc: pseries: Round up MSI-X requests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Mon, 04 Jun 2012 16:54:57 +1000
In-Reply-To: <1338792215.15716.5.camel@concordia>
References: <20120604091545.03ce738b@kryten>
 <1338792215.15716.5.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-04 at 16:43 +1000, Michael Ellerman wrote:
> There is some chance this will result in breakage because the driver
> asks for N - and assumes that is what was allocated - and the device is
> configured for > N.

We can fix that. We can whack the configuration back with N, just know
that we have "allocated"  > N.

> But that's a hypothetical, and we know the current approach sucks
> because it will result in many drivers falling back to a single
> interrupt.
> 
> I think this is the least-worst approach in light of the FW limitations,
> and we can always add quirks in here if we really have to.
> 
> Paul is the pseries maintainer so he gets to ACK or NAK it, but from an
> MSI point of view it gets my +1.
> 

Cheers,
Ben.
