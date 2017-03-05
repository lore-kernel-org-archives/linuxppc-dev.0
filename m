Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbjGL0kjSzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 23:41:29 +1100 (AEDT)
Date: Sun, 5 Mar 2017 06:37:37 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero in
 init_cache_info()
Message-ID: <20170305123737.GM31469@gate.crashing.org>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87pohw3tp4.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 05, 2017 at 09:26:47PM +1100, Michael Ellerman wrote:
> > I see a panic in early boot when building with a recent gcc toolchain.
> > The issue is a divide by zero, which is undefined. Older toolchains
> > let us get away with it:
> >
> > int foo(int a) { return a / 0; }
> >
> > foo:
> > 	li 9,0
> > 	divw 3,3,9
> > 	extsw 3,3
> > 	blr
> >
> > But newer ones catch it:
> >
> > foo:
> > 	trap
> >
> > Add a check to avoid the divide by zero.
> 
> Erk sorry. One of the static checkers spotted it, but I hadn't got
> around to fixing it because it seemed to not actually blow up, guess
> not.

The PowerPC divw etc. instructions do not trap by themselves, but recent
GCC inserts trap instructions on code paths that are always undefined
behaviour (like, dividing by zero).


Segher
