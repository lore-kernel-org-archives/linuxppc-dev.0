Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj4Qz3qYTzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 17:22:35 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 77so22205712pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 23:22:35 -0700 (PDT)
Date: Tue, 14 Mar 2017 16:22:06 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC][PATCH 0/2] reworking cause_ipi and adding global doorbell
 support
Message-ID: <20170314162206.381c71d7@roar.ozlabs.ibm.com>
In-Reply-To: <1489467001.26634.1.camel@kernel.crashing.org>
References: <20170312171327.21088-1-npiggin@gmail.com>
 <1489447868.2174.16.camel@kernel.crashing.org>
 <20170314114950.6d197c80@roar.ozlabs.ibm.com>
 <1489458878.2174.23.camel@kernel.crashing.org>
 <20170314125318.5f227517@roar.ozlabs.ibm.com>
 <1489463840.2174.25.camel@kernel.crashing.org>
 <20170314143553.3bb2dab9@roar.ozlabs.ibm.com>
 <1489467001.26634.1.camel@kernel.crashing.org>
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

On Tue, 14 Mar 2017 15:50:01 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2017-03-14 at 14:35 +1000, Nicholas Piggin wrote:
> > > We might need a sync still between clearing the byte and calling the
> > > handler no ? Or at least a smp_wmb() to ensure that the clear is
> > > visible before any action of the handler.  
> > 
> > Yes I have exactly that (smp_wmb).
> > 
> > At first I checked and cleared each byte then did a single smp_wmb, but
> > I changed my mind because most of the time the IPI will fire with only
> > one message set, so it does not seem like it's worth the extra branches
> > to avoid a lwsync in the rare case of 2 messages.  
> 
> Will lwsync provide transitivity ?
> 
> What we care about is that if the handler does something that when observed
> by another CPU causes that other CPU to send back an IPI, the write by that
> other CPU comes after our clear. I'm not sure if lwsync is enough. We might
> need Paul Mck for that :-)

Hmm. Well lwsync is cumulative for the ordering it provides.

The target CPU can pick up messages without having gone through an
interrupt and msgsync, and even before sender has executed a sync.

Let's say we have the following situation where the IPI handler on
CPU1 reads variables set by CPU0 and CPU2, and stores the result in
other memory locations.

CPU0                   CPU1                 CPU2

data0=1
sync
CPU[1].msg[x]=1
                       msg=CPU[1].msg[x]
                       if (msg) /* handle x */
                         CPU[1].msg[x]=0
                         lwsync
                         ready0=data0
                         ready2=data2

                         ASSERTa(ready0==1)

                                            x=ready0
                                            if (x)
                                              ASSERTb(data0==1 after lwsync)
                                              data2=1
                                              sync
                                              CPU[1].msg[x]=1
                                              sync
                                              doorbell

                       *doorbell*
                       if (ready2==0)
                         ASSERTc(CPU[1].msg[x]==1)

ASSERTa is the simple pairwise that data from CPU0 must be visible if the
message is set. In this case sync and lwsync on CPU0 and 1 should make
that work for cache inhibited. I guess if we only order cacheable and
require CI to add their own syncs, then CPU0 sync may be lwsync as well?
Alternatively if we require CI ordering then CPU1 has to be sync.

ASSERTb is cumulative ordering where if CPU2 sees CPU1 handler result
then it must also see CPU0 pre-IPI result. I think this is covered by
example 2 on p820 of ISAv3 doc.

ASSERTc says that if the handler did not pick up CPU2's store after
setting msg[x]=0, then it must eventually see msg[x]=1 store from CPU2.
I think this should also be true because if CPU2 found ready0==1, then
it would also see CPU[1].msg[x]==0 after a barrier (simple pairwise
ordering).

You're right though, we should run it by Paul :)

Thanks,
Nick
