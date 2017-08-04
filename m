Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNqQ53TMjzDqgJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 11:41:01 +1000 (AEST)
Message-ID: <1501810843.2664.63.camel@kernel.crashing.org>
Subject: Re: [PATCH v9 14/14] powerpc: rewrite local_t using soft_irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, anton@samba.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 Aug 2017 11:40:43 +1000
In-Reply-To: <20170804035005.1d462325@roar.ozlabs.ibm.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1501732158-19009-15-git-send-email-maddy@linux.vnet.ibm.com>
 <20170804035005.1d462325@roar.ozlabs.ibm.com>
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

On Fri, 2017-08-04 at 03:50 +1000, Nicholas Piggin wrote:
> Hey, so... why are any of these implemented in asm? We should
> just do them all in C, right? I looked a bit harder at code gen
> and a couple of them are still emitting larx/stcx.

As long as we can guarantee that the C compiler won't play games
moving stuff around. But yes, I tend to agree.

Cheers,
Ben.
