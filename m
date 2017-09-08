Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpSw82MRDzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 17:03:35 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id e199so3260794pfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 00:03:35 -0700 (PDT)
Date: Fri, 8 Sep 2017 17:03:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard  <anton@samba.org>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [RFC PATCH 8/8] powerpc/64s/radix: Only flush local TLB for
 spurious fault flushes
Message-ID: <20170908170316.11f33cc6@roar.ozlabs.ibm.com>
In-Reply-To: <20170908144437.65c6c982@roar.ozlabs.ibm.com>
References: <20170907145148.24398-1-npiggin@gmail.com>
 <20170907145148.24398-9-npiggin@gmail.com>
 <1504821938.12628.28.camel@kernel.crashing.org>
 <20170908144437.65c6c982@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 8 Sep 2017 14:44:37 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

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
> 
> I'll keep digging.

Okay, talking to Alistair and for NPU/CAPI, this is a concern because
the NMMU may not walk page tables if it has a cached translation. Have
to confirm that with hardware.

So we've got them wanting to hook into the core code and make it give
them tibies.

For now I'll put this on hold until NPU and CAPI and VAS get their
patches in and working, then maybe revisit. Might be good to get them
all moved to using a common nmmu.c driver that gives them a page fault
handler and uses mmu notifiers to do their nmmu invalidations.

Thanks,
Nick
