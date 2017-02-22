Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSqhW0rlszDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:06:50 +1100 (AEDT)
Message-ID: <1487750793.23576.219.camel@kernel.crashing.org>
Subject: Re: [PATCH 0/2] Allow configurable stack size (especially 32k on
 PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Hamish Martin
 <hamish.martin@alliedtelesis.co.nz>, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Feb 2017 19:06:33 +1100
In-Reply-To: <871suqn3m7.fsf@concordia.ellerman.id.au>
References: <20170220202440.25796-1-hamish.martin@alliedtelesis.co.nz>
 <871suqn3m7.fsf@concordia.ellerman.id.au>
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

On Wed, 2017-02-22 at 17:25 +1100, Michael Ellerman wrote:
> 
> Thanks for the detailed explanation.
> 
> The patches look fine, so I don't see any reason why we wouldn't merge
> this. I might make the config option depend on EXPERT, but that's just
> cosmetic.
> 
> 
> You're right about the difference in stack overhead between 32 & 64-bit.
> But I guess on the other hand we've been using 16K stacks on 64-bit for
> over 15 years, and although we have had some reports of stack overflow
> they're not a common problem.

Right and in fact I wonder if we could generally help this for cases
like this one (lots of stacked devices) by having the generic driver
core break those chains by deferring new device registration to a work
queue or kthread.

That would help in a lot of cases. We do get some stupid deep chains
in cases of many bus encapsulation.

Cheers,
Ben.
