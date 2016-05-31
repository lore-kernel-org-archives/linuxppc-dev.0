Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJkh267xmzDqZC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 16:52:34 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 31 May 2016 00:52:32 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@ozlabs.org>,
 benh@kernel.crashing.org, paulus@samba.org, acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc: Avoid load hit store when using
 find_linux_pte_or_hugepte()
In-Reply-To: <1464668290.32478.5.camel@ellerman.id.au>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
 <1464523432-12605-3-git-send-email-anton@ozlabs.org>
 <1464650992.16938.8.camel@ellerman.id.au>
 <87k2ia29du.fsf@skywalker.in.ibm.com>
 <1464668290.32478.5.camel@ellerman.id.au>
Date: Tue, 31 May 2016 12:22:22 +0530
Message-ID: <87eg8i1zyx.fsf@skywalker.in.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Tue, 2016-05-31 at 08:59 +0530, Aneesh Kumar K.V wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> > On Sun, 2016-05-29 at 22:03 +1000, Anton Blanchard wrote:
>> > > From: Anton Blanchard <anton@samba.org>
>> > > 
>> > > In many cases we disable interrupts right before calling
>> > > find_linux_pte_or_hugepte().
>> > > 
>> > > find_linux_pte_or_hugepte() first checks interrupts are disabled
>> > > before calling __find_linux_pte_or_hugepte():
>> > > 
>> > >         if (!arch_irqs_disabled()) {
>> > >                 pr_info("%s called with irq enabled\n", __func__);
>> > >                 dump_stack();
>> > >         }
>> > 
>> > Should that be a VM_WARN_ON()?
>> > 
>> 
>> VM_WARN_ON() put them inside CONFIG_DEBUG_VM. We should be able to use
>
> Yeah that was my point. Does this still need to be an always-on check, or can
> we hide it behind CONFIG_DEBUG_VM ?

Ok I guess we can move that within a CONFIG_DEBUG_VM #ifdef considering
we will run with DEBUG_VM enabled once in a while to catch wrong usage. I will get
a patch to do that.

-aneesh
