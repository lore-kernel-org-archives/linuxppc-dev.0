Return-Path: <alistair@popple.id.au>
Received: from ipmailnode02.adl6.internode.on.net
 (ipmailnode02.adl6.internode.on.net [150.101.137.148])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xsSSQ2LF1zDrJ3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 13:53:25 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <nicholas.piggin@gmail.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, clombard@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH v3 2/2] cxl: Enable global TLBIs for cxl contexts
Date: Wed, 13 Sep 2017 13:53:22 +1000
Message-ID: <1722769.VMcgIllh4T@new-mexico>
In-Reply-To: <20170908165624.22dca915@roar.ozlabs.ibm.com>
References: <20170903181513.29635-1-fbarrat@linux.vnet.ibm.com>
 <20170903181513.29635-2-fbarrat@linux.vnet.ibm.com>
 <20170908165624.22dca915@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 8 Sep 2017 04:56:24 PM Nicholas Piggin wrote:
> On Sun,  3 Sep 2017 20:15:13 +0200
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> wrote:
> 
> > The PSL and nMMU need to see all TLB invalidations for the memory
> > contexts used on the adapter. For the hash memory model, it is done by
> > making all TLBIs global as soon as the cxl driver is in use. For
> > radix, we need something similar, but we can refine and only convert
> > to global the invalidations for contexts actually used by the device.
> > 
> > The new mm_context_add_copro() API increments the 'active_cpus' count
> > for the contexts attached to the cxl adapter. As soon as there's more
> > than 1 active cpu, the TLBIs for the context become global. Active cpu
> > count must be decremented when detaching to restore locality if
> > possible and to avoid overflowing the counter.
> > 
> > The hash memory model support is somewhat limited, as we can't
> > decrement the active cpus count when mm_context_remove_copro() is
> > called, because we can't flush the TLB for a mm on hash. So TLBIs
> > remain global on hash.
> 
> Sorry I didn't look at this earlier and just wading in here a bit, but
> what do you think of using mmu notifiers for invalidating nMMU and
> coprocessor caches, rather than put the details into the host MMU
> management? npu-dma.c already looks to have almost everything covered
> with its notifiers (in that it wouldn't have to rely on tlbie coming
> from host MMU code).

Sorry, just finding time to catch up on this. From subsequent emails it looks
like you may have figured this out. The TLB flush in npu-dma.c is a workaround
for a HW issue rather than there to explicitly manage the NMMU caches. The
intent for NPU was always to have the NMMU snoop normal core tlbies rather than
do it via notifiers. A subsequent patch series
(https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=1681) removes
this flush now that the HW issue has been worked around via a FW fix.

I agree this is something we could look into optimising in the medium term, but
for the moment it would be good if we could get this series merged.

- Alistair
