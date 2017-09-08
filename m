Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpRPT5Ml3zDrVv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 15:55:25 +1000 (AEST)
Message-ID: <1504850111.12628.50.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 8/8] powerpc/64s/radix: Only flush local TLB for
 spurious fault flushes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
Date: Fri, 08 Sep 2017 15:55:11 +1000
In-Reply-To: <20170908144437.65c6c982@roar.ozlabs.ibm.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
 <20170907145148.24398-9-npiggin@gmail.com>
 <1504821938.12628.28.camel@kernel.crashing.org>
 <20170908144437.65c6c982@roar.ozlabs.ibm.com>
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

On Fri, 2017-09-08 at 14:44 +1000, Nicholas Piggin wrote:
> On Fri, 08 Sep 2017 08:05:38 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > On Fri, 2017-09-08 at 00:51 +1000, Nicholas Piggin wrote:
> > > When permissiveness is relaxed, or found to have been relaxed by
> > > another thread, we flush that address out of the TLB to avoid a
> > > future fault or micro-fault due to a stale TLB entry.
> > > 
> > > Currently for processes with TLBs on other CPUs, this flush is always
> > > done with a global tlbie. Although that could reduce faults on remote
> > > CPUs, a broadcast operation seems to be wasteful for something that
> > > can be handled in-core by the remote CPU if it comes to it.
> > > 
> > > This is not benchmarked yet. It does seem cut some tlbie operations
> > > from the bus.  
> > 
> > What happens with the nest MMU here ?
> 
> Good question, I'm not sure. I can't tell from the UM or not if the
> agent and NMMU must discard cached translations if there is a
> translation cached but it has a permission fault. It's not clear 
> from that I've read that if it's relying on the host to send back a
> tlbie.

I think it's supposed to re-do a tablewalk.

> I'll keep digging.
> 
> Thanks,
> Nick
