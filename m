Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34AA91A0332
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 13:08:25 +1100 (AEDT)
Message-ID: <1427162890.4770.307.camel@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Tue, 24 Mar 2015 13:08:10 +1100
In-Reply-To: <20150323.214453.255192641139042325.davem@davemloft.net>
References: <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323.214453.255192641139042325.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, aik@ozlabs.ru, sowmini.varadhan@oracle.com,
 anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 21:44 -0400, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 24 Mar 2015 09:21:05 +1100
> 
> > Dave, what's your feeling there ? Does anybody around still have
> > some HW that we can test with ?
> 
> I don't see what the actual problem is.
> 
> Even if you use multiple pools, which we should for scalability on
> sun4u too, just do the flush when allocation in _any_ pool wraps
> around.
> 
> That's still better than not doing the optimization at all.

I agree, I wasn't sure it was good enough for you, so was just putting
other options on the table.

> That is always going to be correct, and you can use a separate
> spinlock to make sure only one thread of control does the full
> IOMMU flush at a time.

That would have to be done inside the of the flush callback but I don't
see a big issue there.

For the large pool, we don't keep a hint so we don't know it's wrapped,
in fact we purposefully don't use a hint to limit fragmentation on it,
but then, it should be used rarely enough that flushing always is, I
suspect, a good option.

Cheers,
Ben.
