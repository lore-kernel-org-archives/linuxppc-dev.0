Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wkHV5YW3zDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 18:27:50 +1000 (AEST)
Date: Wed, 30 May 2018 03:27:39 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH v6 1/4] powerpc/64: Align bytes before fall back to
 .Lshort in powerpc64 memcmp()
Message-ID: <20180530082739.GF17342@gate.crashing.org>
References: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
 <1527221256-17029-2-git-send-email-wei.guo.simon@gmail.com>
 <20180528103505.GY17342@gate.crashing.org>
 <20180530081150.GA5951@simonLocalRHEL7.x64>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530081150.GA5951@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi!

On Wed, May 30, 2018 at 04:11:50PM +0800, Simon Guo wrote:
> On Mon, May 28, 2018 at 05:35:12AM -0500, Segher Boessenkool wrote:
> > On Fri, May 25, 2018 at 12:07:33PM +0800, wei.guo.simon@gmail.com wrote:
> > If this doesn't use cr0 anymore, you can do  rlwinm r6,r6,0,7  instead of
> > andi r6,r6,7 .
> > 
> CR0 is used at .Lno_short handling.

Tricky.

> > > +	subfc.	r5,r6,r5
> > 
> > Why subfc?  You don't use the carry.
> OK. I will use subfc instead.

I meant subf -- no carry.  If you want CR0 set there is subf. just fine.

> > > +	bgt	cr0,8f
> > > +	li	r3,-1
> > > +8:
> > > +	blr
> > 
> >   blelr
> >   li r3,-1
> >   blr
> Sure. That looks more impact.

Should have been bgtlr of course -- well check please :-)


Segher
