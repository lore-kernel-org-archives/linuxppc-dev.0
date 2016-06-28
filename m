Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf39X629jzDqxK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:14:40 +1000 (AEST)
Message-ID: <1467112469.20278.123.camel@kernel.crashing.org>
Subject: Re: [PATCH 06/38] powerpc: Move 64-bit feature fixup earlier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Jun 2016 21:14:29 +1000
In-Reply-To: <87a8i560ak.fsf@skywalker.in.ibm.com>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-7-git-send-email-benh@kernel.crashing.org>
 <87a8i560ak.fsf@skywalker.in.ibm.com>
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

On Tue, 2016-06-28 at 16:35 +0530, Aneesh Kumar K.V wrote:
> Why not move it immediately after we finish all the device tress
> scan.

Do you need it in early_init_mmu ? The important thing is to have it
done before we *turn on* the MMU but yeah, there's no big deal
moving it even further up I think..

> ie,
>         early_init_devtree(__va(dt_ptr));
> 
>         epapr_paravirt_early_init();
> 
>   +      apply_feature_fixups();
>         /* Now we know the logical id of our boot cpu, setup the
> paca. */
>         setup_paca(&paca[boot_cpuid]);
>         fixup_boot_paca();
> 
> Also with a comment explaining why we can't move it further up ?

Yup, adding some comments about the why things are done in that order
would be good, I'll improve that

Cheers,
Ben.
