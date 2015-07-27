Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EB6C1A0709
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 14:19:15 +1000 (AEST)
In-Reply-To: <1435652431-22024-2-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [1/5] powerpc/perf: Drop the branch sample when 'from' cannot be
 fetched
Message-Id: <20150727041915.63106140326@ozlabs.org>
Date: Mon, 27 Jul 2015 14:19:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-30-06 at 08:20:27 UTC, Anshuman Khandual wrote:
> BHRB (Branch History Rolling Buffer) is a rolling buffer. Hence we
> might end up in a situation where we have read one target address
> but when we try to read the next entry indicating the from address
> of the target address, the buffer just overflows. In this case, the
> captured from address will be zero which indicates the end of the
> buffer.

Right. But with SMT8 the size of the buffer is very small, so we will actually
hit this case somewhat often. When we originally wrote this we decided it was
better to get some information, ie. the from address, than no information at
all.

> 	This patch drops the entire branch record which would have
> otherwise confused the user space tools.

Does it confuse the tools? Can you show me before/after output from perf?

I'm not opposed to changing this but we need to be 100% sure it's the best
option.

cheers
