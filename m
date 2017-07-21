Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDFxY1dHCzDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 13:05:05 +1000 (AEST)
Date: Fri, 21 Jul 2017 13:05:03 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Santosh Sivaraj <santosh@fossix.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Message-ID: <20170721130503.6e28a1e0@kryten>
In-Reply-To: <87bmofgsbh.fsf@concordia.ellerman.id.au>
References: <20170720095834.15153-1-santosh@fossix.org>
 <87bmofgsbh.fsf@concordia.ellerman.id.au>
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

Hi,

> > +static notrace int gettime_syscall_fallback(clockid_t clk_id,
> > +					     struct timespec *tp)
> > +{
> > +	register clockid_t id asm("r3") = clk_id;
> > +	register struct timespec *t asm("r4") = tp;
> > +	register int nr asm("r0") = __NR_clock_gettime;
> > +	register int ret asm("r3");  
> 
> I guess this works. I've always been a bit nervous about register
> variables TBH.

I don't think this works with clang unfortunately.

Anton
