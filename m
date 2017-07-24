Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGYXB0wL0zDqpZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 06:54:33 +1000 (AEST)
Message-ID: <1500929646.10674.82.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/6] powerpc/mm: Ensure cpumask update is ordered
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Date: Tue, 25 Jul 2017 06:54:06 +1000
In-Reply-To: <20170724212007.7f472332@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-3-benh@kernel.crashing.org>
 <20170724212007.7f472332@roar.ozlabs.ibm.com>
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

On Mon, 2017-07-24 at 21:20 +1000, Nicholas Piggin wrote:
> I think this is the right thing to do, but it should be commented.
> Is hwsync the right barrier? (i.e., it will order the page table walk)

This is an open question, I've asked the architects and HW guys and
waiting for an answer.

That said, are we really trying to order the page table walk or are
we trying to order any (speculative or not) load/store that may trigger
a page table update ?

Cheers,
Ben.
