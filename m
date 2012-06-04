Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A258CB6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 08:01:23 +1000 (EST)
Message-ID: <1338847242.7150.83.camel@pasglop>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Date: Tue, 05 Jun 2012 08:00:42 +1000
In-Reply-To: <20120604110305.GA16707@visitor2.iram.es>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120531110439.GA17373@visitor2.iram.es>
 <1338542315.16119.50.camel@pasglop>
 <192298D25D96A042975E372855100DB70FF0E2@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120604110305.GA16707@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wrobel Heinz-R39252 <r39252@freescale.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Steffen Rumler <steffen.rumler.ext@nsn.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-04 at 13:03 +0200, Gabriel Paubert wrote:
> There is no conflict to the ABI. These functions are supposed to be
> directly reachable from whatever code
> section may need them.
> 
> Now I have a question: how did you get the need for this?
> 
> None of my kernels uses them:
> - if I compile with -O2, the compiler simply expands epilogue and
> prologue to series of lwz and stw
> - if I compile with -Os, the compiler generates lmw/stmw which give
> the smallest possible cache footprint
> 
> Neither did I find a single reference to these functions in several
> systems that I grepped for.

Newer gcc's ... even worse, with -Os, it does it for a single register
spill afaik. At least that's how I hit it with grub2 using whatever gcc
is in fc17.

Cheers,
Ben.
