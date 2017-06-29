Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyvWq6SQkzDr1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 19:29:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/kexec: Fix radix to hash kexec
In-Reply-To: <20170629082734.4195-1-bsingharora@gmail.com>
References: <20170629082734.4195-1-bsingharora@gmail.com>
Date: Thu, 29 Jun 2017 19:29:58 +1000
Message-ID: <87mv8r9m5l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> This patch fixes a crash seen while doing a kexec from
> radix mode to hash mode. Key 0 is special in hash and
> used in the RPN by default, we set the key values to 0
> today. In radix mode key 0 is used to control
> supervisor<->user access. In hash key 0 is used by default,
> so the first instruction after the switch causes a crash on
> kexec.
>
> This patch fixes
> (3b10d00 powerpc/mm/radix: Prevent kernel execution of user space)
> The commit above introduced setting of IAMR and AMOR values to
> prevent execution of user mode instructions from supervisor mode.
> We need to clean up these SPR's on kexec.
>
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>
> NOTES:
>  This patch can be made power9 specific, but I've chosen not
>  to do so, I could add it in a feature section if recommended.

Well neither register existed in the architecture prior to Power8.
Possibly they were defined in BookIV or they were nops, but most likely
it will just explode on old CPUs.

And probably Book3E as well.

So it should be in a CPU_FTR_ARCH_207S section at a minimum.

But maybe it should just be done in C earlier in the call chain.

cheers
