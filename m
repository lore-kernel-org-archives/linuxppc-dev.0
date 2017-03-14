Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj2NW3Rf7zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 15:50:19 +1100 (AEDT)
Message-ID: <1489467001.26634.1.camel@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 14 Mar 2017 15:50:01 +1100
In-Reply-To: <20170314143553.3bb2dab9@roar.ozlabs.ibm.com>
References: <20170312171327.21088-1-npiggin@gmail.com>
 <1489447868.2174.16.camel@kernel.crashing.org>
 <20170314114950.6d197c80@roar.ozlabs.ibm.com>
 <1489458878.2174.23.camel@kernel.crashing.org>
 <20170314125318.5f227517@roar.ozlabs.ibm.com>
 <1489463840.2174.25.camel@kernel.crashing.org>
 <20170314143553.3bb2dab9@roar.ozlabs.ibm.com>
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

On Tue, 2017-03-14 at 14:35 +1000, Nicholas Piggin wrote:
> > We might need a sync still between clearing the byte and calling the
> > handler no ? Or at least a smp_wmb() to ensure that the clear is
> > visible before any action of the handler.
> 
> Yes I have exactly that (smp_wmb).
> 
> At first I checked and cleared each byte then did a single smp_wmb, but
> I changed my mind because most of the time the IPI will fire with only
> one message set, so it does not seem like it's worth the extra branches
> to avoid a lwsync in the rare case of 2 messages.

Will lwsync provide transitivity ?

What we care about is that if the handler does something that when observed
by another CPU causes that other CPU to send back an IPI, the write by that
other CPU comes after our clear. I'm not sure if lwsync is enough. We might
need Paul Mck for that :-)

Cheers,
Ben.
