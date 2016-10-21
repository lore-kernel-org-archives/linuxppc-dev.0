Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t0pgZ5rZCzDt14
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Oct 2016 01:57:30 +1100 (AEDT)
Date: Fri, 21 Oct 2016 10:57:27 -0400 (EDT)
Message-Id: <20161021.105727.140184460493941551.davem@davemloft.net>
To: borntraeger@de.ibm.com
Cc: peterz@infradead.org, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
 schwidefsky@de.ibm.com, noamc@ezchip.com
Subject: Re: [PATCH/RFC 0/5] cpu_relax: introduce yield, remove lowlatency
From: David Miller <davem@davemloft.net>
In-Reply-To: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 21 Oct 2016 13:58:53 +0200

> For spinning loops people did often use barrier() or cpu_relax().
> For most architectures cpu_relax and barrier are the same, but on
> some architectures cpu_relax can add some latency. For example on s390
> cpu_relax gives up the time slice to the hypervisor. On power cpu_relax
> tries to give some of the CPU to the neighbor threads. To reduce the
> latency another variant cpu_relax_lowlatency was introduced. Before this
> is used in more and more places, lets revert the logic of provide a new
> function cpu_relax_yield that can spend some time and for s390 yields
> the guest CPU.

Sparc64, fwiw, behaves similarly to powerpc.
