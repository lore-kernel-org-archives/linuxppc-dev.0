Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD20A1A0501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 20:01:39 +1000 (AEST)
Message-ID: <1439805684.2416.16.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, ryabinin.a.a@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Aug 2015 20:01:24 +1000
In-Reply-To: <87mvxqp7l5.fsf@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
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

On Mon, 2015-08-17 at 15:20 +0530, Aneesh Kumar K.V wrote:

> For kernel linear mapping, our address space looks like
> 0xc000000000000000 - 0xc0003fffffffffff  (64TB)
> 
> We can't have virtual address(effective address) above that range
> in 0xc region. Hence in-order to shadow the linear mapping, I am 
> using region 0xe. ie, the shadow mapping now looks liwe
> 
> 0xc000000000000000 -> 0xe000000000000000 

Why ? IE. Why can't you put the shadow at address +64T and have it work
for everything ?
.../...

> Another reason why inline instrumentation is difficult is that for
> inline instrumentation to work, we need to create a mapping for 
> _possible_
> virtual address space before kasan is fully initialized. ie, we need
> to create page table entries for the shadow of the entire 64TB range,
> with zero page, even though we have lesser ram. We definitely can't 
> bolt those entries. I am yet to get the shadow for kernel linear 
> mapping to work without bolting. Also we will have to get the page 
> table allocated for that, because we can't share page table entries. 
> Our fault path use pte entries for storing hash slot index.

Hrm, that means we might want to start considering a page table to
cover the linear mapping...

> If we are ok to steal part of that 64TB range, for kasan mapping , ie
> we make shadow of each region part of the same region, may be we can
> get inline instrumentation to work. But that still doesn't solve the
> page table allocation overhead issue mentioned above.
> 
> -aneesh
