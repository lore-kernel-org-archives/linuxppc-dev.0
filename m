Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A95B1A003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 14:59:09 +1000 (EST)
Message-ID: <1407301138.3073.68.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/nohash: Split __early_init_mmu() into boot
 and secondary
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 06 Aug 2014 14:58:58 +1000
In-Reply-To: <1407286090.7427.19.camel@snotra.buserror.net>
References: <1406948861-11322-1-git-send-email-scottwood@freescale.com>
 <1406948861-11322-2-git-send-email-scottwood@freescale.com>
 <1407213410.19150.65.camel@pasglop>
 <1407286090.7427.19.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-05 at 19:48 -0500, Scott Wood wrote:
> I'll do s/mmu_allcpus/this_mmu/ but early_init_mmu() needs to do things
> both before and after early_init_mmu_common().  Do you want two new
> functions (before and after) or is it OK to just rename
> early_init_mmu_allcpus() and put a comment before early_init_mmu()
> saying it's just for the boot cpu?

Do we really need that before/after ? The "after" code is the linear
mapping setup but does it rely on the MAS4 setting done above ?

Otherwise you can do before/after using a separate function
mmu_set_linear_map()

Always nicer to break down too large functions anyway.

Cheers,
Ben.
