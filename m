Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSnS1232LzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 17:25:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: Re: [PATCH 0/2] Allow configurable stack size (especially 32k on
 PPC64)
In-Reply-To: <20170220202440.25796-1-hamish.martin@alliedtelesis.co.nz>
References: <20170220202440.25796-1-hamish.martin@alliedtelesis.co.nz>
Date: Wed, 22 Feb 2017 17:25:52 +1100
Message-ID: <871suqn3m7.fsf@concordia.ellerman.id.au>
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

Hamish Martin <hamish.martin@alliedtelesis.co.nz> writes:
> This patch series adds the ability to configure the THREAD_SHIFT value and
> thereby alter the stack size on powerpc systems. We are particularly interested
> in configuring for a 32k stack on PPC64.
...
>
> For instance for a 70 frame stack, the architecture overhead just for the stack
> frames is:
>    70 * 16 bytes = 1120 bytes for PPC32, and
>    70 * 112 bytes = 7840 bytes for PPC64.
> So a simple doubling of the PPC32 stack size leaves us with a shortfall of 5600
> bytes (7840 - (2 * 1120)). In the example the stack frame overhead for PPC32 is
> 1120/8192 = 13.5% of the stack space, whereas for PPC64 it is 7840/16384 =
> 47.8% of the space.
>
> The aim of this series is to provide the ability for users to configure for
> larger stacks without altering the defaults in a way that would impact existing
> users. However, given the inequity between the PPC32 and PPC64 stacks when
> taking into account the respective minimum stack frame sizes, we believe
> consideration should be given to having a large default. We would appreciate
> any input or opinions on this issue.

Thanks for the detailed explanation.

The patches look fine, so I don't see any reason why we wouldn't merge
this. I might make the config option depend on EXPERT, but that's just
cosmetic.


You're right about the difference in stack overhead between 32 & 64-bit.
But I guess on the other hand we've been using 16K stacks on 64-bit for
over 15 years, and although we have had some reports of stack overflow
they're not a common problem.

cheers
