Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP1G44PzBzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 19:04:44 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id l64so1241557pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 02:04:44 -0700 (PDT)
Date: Fri, 4 Aug 2017 19:04:29 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Madhavan Srinivasan  <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 anton@samba.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 14/14] powerpc: rewrite local_t using soft_irq
Message-ID: <20170804190429.3383e932@roar.ozlabs.ibm.com>
In-Reply-To: <1501810843.2664.63.camel@kernel.crashing.org>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1501732158-19009-15-git-send-email-maddy@linux.vnet.ibm.com>
 <20170804035005.1d462325@roar.ozlabs.ibm.com>
 <1501810843.2664.63.camel@kernel.crashing.org>
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

On Fri, 04 Aug 2017 11:40:43 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2017-08-04 at 03:50 +1000, Nicholas Piggin wrote:
> > Hey, so... why are any of these implemented in asm? We should
> > just do them all in C, right? I looked a bit harder at code gen
> > and a couple of them are still emitting larx/stcx.  
> 
> As long as we can guarantee that the C compiler won't play games
> moving stuff around. But yes, I tend to agree.


I believe so. I mean we already depend on the same pattern for any
other sequence of local_irq_disable(); c code; local_irq_enable();
so we'd have other problems if we couldn't.

I can easily believe there have been bugs with the fixed r13
handling in gcc in the past, but it looks like it does the right
thing now AFAIKS.

Thanks,
Nick
