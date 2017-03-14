Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj1Cj40c8zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 14:57:37 +1100 (AEDT)
Message-ID: <1489463840.2174.25.camel@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 14 Mar 2017 14:57:20 +1100
In-Reply-To: <20170314125318.5f227517@roar.ozlabs.ibm.com>
References: <20170312171327.21088-1-npiggin@gmail.com>
 <1489447868.2174.16.camel@kernel.crashing.org>
 <20170314114950.6d197c80@roar.ozlabs.ibm.com>
 <1489458878.2174.23.camel@kernel.crashing.org>
 <20170314125318.5f227517@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-03-14 at 12:53 +1000, Nicholas Piggin wrote:
> >   - Load all
> >   - For each byte if set
> >      - clear byte
> >      - then call handler
> 
> Yes. I think that will be okay because we shouldn't get any load-hit-
> store
> issues. I'll do some benchmarking anyway.

We might need a sync still between clearing the byte and calling the
handler no ? Or at least a smp_wmb() to ensure that the clear is
visible before any action of the handler.

Cheers,
Ben.
