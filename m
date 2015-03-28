Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89A681A0260
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 21:57:21 +1100 (AEDT)
Message-ID: <1427540240.7547.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Remove powernv RTAS support
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 28 Mar 2015 21:57:20 +1100
In-Reply-To: <87k2y24n4f.fsf@linux.vnet.ibm.com>
References: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
 <87k2y24n4f.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-27 at 18:24 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > The powernv code has some conditional support for running on bare metal
> > machines that have no OPAL firmware, but provide RTAS.
> >
> > No released machines ever supported that, and even in the lab it was
> > just a transitional hack in the days when OPAL was still being
> > developed.
> >
> > So remove the code.
> 
> So when we select CONFIG_PPC_PSERIES, we end up selecting
> CONFIG_PPC_RTAS. What is the expected behaviour there for powernv ? 

After this patch, the expected behaviour is that the powernv platform code
won't use RTAS, even if it's there. And that's fine because no real powernv
machines have RTAS.

In a perfect world the RTAS code would be isolated in platforms/pseries, but
it's used on other platforms, so it's a bit messier than that. But the expected
behaviour is that the powernv code won't use RTAS, even if the code is still
built in.

Is that what you meant?

> Can we use RTAS call from powernv code if rtas node is present in device
> tree ? 

Yes you can, if you build with CONFIG_PPC_RTAS=y. Though when I add a
powernv_defconfig (soon), it won't have CONFIG_PPC_RTAS.

> Or do we want to make sure powernv always use OPAL call ?

It depends what you mean by "powernv". Once this patch is applied the powernv
*platform* code will not use RTAS.

There may still be other code that can be built into a kernel and booted on
powernv that then uses RTAS. That's fine, if it makes sense for someone, I
don't think we need to prevent that happening.

> For example, right now we will use rtas_node get-term-char and
> put-term-char even with this patch applied.

Well you will *if* your machine has RTAS, and you have CONFIG_HVC_RTAS=y and/or
CONFIG_UDBG_RTAS_CONSOLE=y.

So I think that's fine?

cheers
