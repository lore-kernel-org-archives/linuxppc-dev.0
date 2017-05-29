Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wblkF3NblzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 15:32:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
In-Reply-To: <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
Date: Mon, 29 May 2017 15:32:37 +1000
Message-ID: <87lgpg6xe2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> On Fri, May 26, 2017 at 01:46:58PM +1000, Michael Ellerman wrote:
>>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>>
>>> On Thu, May 25, 2017 at 04:19:53PM +1000, Michael Ellerman wrote:
>>>>The commit message for 3af229f2071f says:
>>>>
>>>>    In practice, we never see a system with 256 NUMA nodes, and in fact, we
>>>>    do not support node hotplug on power in the first place, so the nodes
>>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>    that are online when we come up are the nodes that will be present for
>>>>    the lifetime of this kernel.
>>>>
>>>>Is that no longer true?
>>>
>>> I don't know what the reasoning behind that statement was at the time,
>>> but as far as I can tell, the only thing missing for node hotplug now is
>>> Balbir's patchset [1]. He fixes the resource issue which motivated
>>> 3af229f2071f and reverts it.
>>>
>>> With that set, I can instantiate a new numa node just by doing
>>> add_memory(nid, ...) where nid doesn't currently exist.
>>
>>But does that actually happen on any real system?
>
> I don't know if anything currently tries to do this. My interest in 
> having this working is so that in the future, our coherent gpu memory 
> could be added as a distinct node by the device driver.

Sure. If/when that happens, we would hopefully still have some way to
limit the size of the possible map.

That would ideally be a firmware property that tells us the maximum
number of GPUs that might be hot-added, or we punt and cap it at some
"sane" maximum number.

But until that happens it's silly to say we can have up to 256 nodes
when in practice most of our systems have 8 or less.

So I'm still waiting for an explanation from Michael B on how he's
seeing this bug in practice.

cheers
