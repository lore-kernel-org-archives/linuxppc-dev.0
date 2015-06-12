Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF0C91A02D5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 19:47:35 +1000 (AEST)
In-Reply-To: <1434014729-12068-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/powernv: Bump opal_init initcall priority
Message-Id: <20150612094735.C2DAB1402B4@ozlabs.org>
Date: Fri, 12 Jun 2015 19:47:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-06 at 09:25:29 UTC, Alistair Popple wrote:
> opal_init() is called via a machine_subsys_initcall(). Due to a hack
> in the eeh code the eeh driver is initialised with at the same
> initcall level. This means depending on link ordering the following
> error can occur because the opal irchip has not been initialised:
> 
> irq: XICS didn't like hwirq-0x9 to VIRQ17 mapping (rc=-22)
> pnv_eeh_post_init: Can't request OPAL event interrupt (0)
> 
> This patch solves the issue by making sure opal_init is called prior
> to the subsystems that may need it.

What is the hack in the eeh code?

I'm seeing eeh_ops->post_init() called from eeh_init() which is
core_initcall_sync(), is that what you're talking about?

Then pnv_eeh_post_init() is the powernv version of eeh_ops->post_init, and it
calls opal_event_request().

So you'd need the irq_chip setup by then I think?

So I guess I'm missing the hack you're talking about.

Regardless of which level it needs to be at, the only thing that needs to run
early is opal_event_init() am I right? Not all of opal_init().

cheers
