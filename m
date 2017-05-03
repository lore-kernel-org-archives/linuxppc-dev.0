Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHsxt5QqNzDqCf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 19:17:38 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id d1so385063pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 May 2017 02:17:38 -0700 (PDT)
Date: Wed, 3 May 2017 19:17:21 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard  <anton@samba.org>, Paul
 Mackerras <paulus@ozlabs.org>
Subject: Re: [RFC][PATCH] powerpc/64s: Leave IRQs hard enabled over context
 switch
Message-ID: <20170503191721.2c55930c@roar.ozlabs.ibm.com>
In-Reply-To: <1493800107.25766.352.camel@kernel.crashing.org>
References: <20170503073414.18776-1-npiggin@gmail.com>
 <1493800107.25766.352.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 03 May 2017 10:28:27 +0200
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2017-05-03 at 17:34 +1000, Nicholas Piggin wrote:
> > Extending the soft IRQ disable to cover PMU interrupts will allow this
> > hard disable to be removed from hash based kernels too, but they will
> > still have to soft-disable PMU interrupts.
> > 
> > - Q1: Can we do this? It gives nice profiles of context switch code
> >   rather than assigning it all to local_irq_enable.  
> 
> Probably ok with radix yes.

Cool.

> > - Q2: What is the unrecoverable SLB miss on exception entry? Is there
> >   anywhere we access the kernel stack with RI disabled? Something else?  
> 
> Not sure what you mean by Q2, but the original problem is an occurrence
> of what we call the 'megabug' which hit us in different forms over the
> years, and happens when we get a kernel stack SLB entry wrong.
> 
> Normally, the segment containing the current kernel stack is always
> bolted in the SLB in a specific slot. If we accidentally lose that
> "bolt", we can end up faulting it into the wrong slot, thus making it
> possible for it to get evicted later on etc...
> 
> That in turns hits the exception return path which accesses the kernel
> stack after clearing RI and setting SRR0/1 to the return values.

This is exactly my question. The original patch said there was an
unrecoverable SLB miss at exception entry. Either I missed that or
it has since been removed. The stack access at exit would do it. I
didn't want to change anything for hash, just wondering where the
bug was (subject line got truncated but is supposed to say "for radix").

Thanks,
Nick
