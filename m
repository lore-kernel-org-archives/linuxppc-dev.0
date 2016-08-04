Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4lMM11sRzDqSB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 19:41:50 +1000 (AEST)
Message-ID: <1470303695.12584.142.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xics: Properly set Edge/Level type and enable
 resend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 04 Aug 2016 19:41:35 +1000
In-Reply-To: <87twf1f8pj.fsf@concordia.ellerman.id.au>
References: <1470105583.12584.5.camel@kernel.crashing.org>
 <87twf1f8pj.fsf@concordia.ellerman.id.au>
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

On Thu, 2016-08-04 at 14:40 +1000, Michael Ellerman wrote:
> > Finally now that edge interrupts are properly identified, we can enable
> > CONFIG_HARDIRQS_SW_RESEND which will make the core re-send them if
> > they occur while masked, which some drivers rely upon.
> >
> > This fixes issues with lost interrupts on some Mellanox adapters.
> >
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Broken since forever?
> 
> Cc stable?

Broken since forever but I want a bit more testing before that goes to
stable. Some drivers like Mellanox had a workaround but they want to
remove it.

Cheers,
Ben.
