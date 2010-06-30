Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C1E2B6EED
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 23:28:09 +1000 (EST)
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20100625111829.GH12443@tyan-ft48-01.lab.bos.redhat.com>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
	<57727.84.105.60.153.1277464103.squirrel@gate.crashing.org>
	<20100625111829.GH12443@tyan-ft48-01.lab.bos.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Jun 2010 16:10:39 +1000
Message-ID: <1277878239.4200.285.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-25 at 13:18 +0200, Jakub Jelinek wrote:
> On Fri, Jun 25, 2010 at 01:08:23PM +0200, Segher Boessenkool wrote:
> > > -		stw%U0%X0 %L2,%1"
> > > -	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> > > +		stw%U1%X1 %L2,%1"
> > > +	: "=m<>" (*ptep), "=m<>" (*((unsigned char *)ptep+4))
> > >  	: "r" (pte) : "memory");
> > 
> > This still isn't correct -- the constraint says that a byte
> > is written, but the insn changes a word.  Probably should just
> > be ptep[1] ?

Oops, almost forgot about this. Are you guys shooting a new patch or do
you want me to do it ?

Cheers,
Ben.
