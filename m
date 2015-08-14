Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D0361A1D37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 12:01:10 +1000 (AEST)
Message-ID: <1439517670.2056.2.camel@ellerman.id.au>
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>,
 benh@kernel.crashing.org, paulus@samba.org, Ulrich Weigand
 <Ulrich.Weigand@de.ibm.com>, Michael Gschwind <mkg@us.ibm.com>, Bill
 Schmidt <wschmidt@us.ibm.com>
Date: Fri, 14 Aug 2015 12:01:10 +1000
In-Reply-To: <20150805140300.218ef661@kryten>
References: <20150805140300.218ef661@kryten>
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

On Wed, 2015-08-05 at 14:03 +1000, Anton Blanchard wrote:
> Hi,
> 
> While looking at traces of kernel workloads, I noticed places where gcc
> used a large number of non volatiles. Some of these functions
> did very little work, and we spent most of our time saving the
> non volatiles to the stack and reading them back.
> 
> It made me wonder if we have the right ratio of volatile to non
> volatile GPRs. Since the kernel is completely self contained, we could
> potentially change that ratio.
> 
> Attached is a quick hack to gcc and the kernel to decrease the number
> of non volatile GPRs to 8. I'm not sure if this is a good idea (and if
> the volatile to non volatile ratio is right), but this gives us
> something to play with.

OK, interesting idea. Can't say I'd ever though of that.

I'm thinking we'd want some pretty solid analysis of the resulting code-gen and
real world perf before we made a switch like that.

Presumably it's going to hurt our null syscall, due to the added save/restores,
but hopefully help with paths that do actual work.

If the caller is actually using the non-volatiles then presumably it will be a
wash, because the caller will have to do the save anyway. Though maybe it would
still be a win because the caller can do the saves & restores when it needs to
rather than all in a block.

I'm also not clear on how it would affect folks who build modules separate from
the kernel. We'd have to make sure they had the right GCC, or things would go
badly wrong, unless it can be done with command line flags? I don't know how
much we care about that but distros presumably do.

cheers
