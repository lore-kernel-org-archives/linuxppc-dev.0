Return-Path: <julia.lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxqwz6RkczDqZ1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 16:44:51 +1000 (AEST)
Date: Wed, 20 Sep 2017 08:34:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Bhumika Goyal <bhumirks@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: make irq_chip const, __initdata and __initconst
In-Reply-To: <87o9q5lwgq.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.DEB.2.20.1709200833320.4638@hadrien>
References: <1505743967-19448-1-git-send-email-bhumirks@gmail.com>
 <87o9q5lwgq.fsf@concordia.ellerman.id.au>
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



On Wed, 20 Sep 2017, Michael Ellerman wrote:

> Bhumika Goyal <bhumirks@gmail.com> writes:
>
> > Make ehv_pic_irq_chip, mpic_ipi_chip and mpic_tm_chip const as they are
> > used only as a copy operation. This usage is during init, so make them
> > __initconst too.
> > Make mpic_ipi_chip __initdata as it is only modified during the init
> > phase and there is no reference of it anywhere after init.
>
> The change log doesn't seem to match the code.
>
> It's mpic_tm_chip which you marked __initdata, and that looks wrong, as
> we keep a pointer to it here:
>
> 	mpic->hc_tm = mpic_tm_chip;

This looks like a memory copy.

julia
