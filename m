Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5XRN4WZQzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 14:34:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] powernv:idle: Move initialization of sibling pacas to
 pnv_alloc_idle_core_states
In-Reply-To: <20170708190012.6c697975@roar.ozlabs.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
 <20170707011609.76c51329@roar.ozlabs.ibm.com>
 <20170707150416.GD8913@in.ibm.com>
 <20170708190012.6c697975@roar.ozlabs.ibm.com>
Date: Mon, 10 Jul 2017 14:34:08 +1000
Message-ID: <877ezgap1b.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Fri, 7 Jul 2017 20:34:16 +0530
> Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>> On Fri, Jul 07, 2017 at 01:16:09AM +1000, Nicholas Piggin wrote:
>> > 
>> > Speaking of which... core_idle_state and thread_sibling_pacas are
>> > allocated with kmalloc_node... What happens if we take an SLB miss
>> > in the idle wakeup code on these guys? Nothing good I think. Perhaps
>> > we should put them into the pacas or somewhere in bolted memory.  
>> 
>> Yes, though the SLB miss hasn't yet been encountered in practise so
>> far!
>
> Considering it's a node-affine allocation, it may actually be possible
> to hit in practice on very large memory systems in practice.

You can boot with disable_1tb_segments on the kernel command line to
increase the change of hitting it.

cheers
