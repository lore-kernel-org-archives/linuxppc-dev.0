Return-Path: <paubert@iram.es>
Received: from telmad-lavadora-l1mail2.puc.rediris.es (unknown
 [IPv6:2001:720:418:ca03::81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbqDY3Gd2zDqFj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 04:10:20 +1100 (AEDT)
Date: Sun, 5 Mar 2017 17:58:37 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Avoid panic during boot due to divide by zero
 in init_cache_info()
Message-ID: <20170305165837.GA2019@visitor2.iram.es>
References: <1488671674-20833-1-git-send-email-anton@ozlabs.org>
 <87pohw3tp4.fsf@concordia.ellerman.id.au>
 <20170305123737.GM31469@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170305123737.GM31469@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 05, 2017 at 06:37:37AM -0600, Segher Boessenkool wrote:
> On Sun, Mar 05, 2017 at 09:26:47PM +1100, Michael Ellerman wrote:
> > > I see a panic in early boot when building with a recent gcc toolchain.
> > > The issue is a divide by zero, which is undefined. Older toolchains
> > > let us get away with it:
> > >
> > > int foo(int a) { return a / 0; }
> > >
> > > foo:
> > > 	li 9,0
> > > 	divw 3,3,9
> > > 	extsw 3,3
> > > 	blr
> > >
> > > But newer ones catch it:
> > >
> > > foo:
> > > 	trap
> > >
> > > Add a check to avoid the divide by zero.
> > 
> > Erk sorry. One of the static checkers spotted it, but I hadn't got
> > around to fixing it because it seemed to not actually blow up, guess
> > not.
> 
> The PowerPC divw etc. instructions do not trap by themselves, but recent
> GCC inserts trap instructions on code paths that are always undefined
> behaviour (like, dividing by zero).


Is it systematic or does it depend from, e.g., optimization levels?

Is there anything in the standards about this feature?

    Gabriel
