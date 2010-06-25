Return-Path: <jakub@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9EB6FB6F10
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jun 2010 21:17:51 +1000 (EST)
Date: Fri, 25 Jun 2010 13:18:29 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Adjust arch/powerpc inline asms for recent gcc change
Message-ID: <20100625111829.GH12443@tyan-ft48-01.lab.bos.redhat.com>
References: <20100625095606.GG12443@tyan-ft48-01.lab.bos.redhat.com>
	<57727.84.105.60.153.1277464103.squirrel@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57727.84.105.60.153.1277464103.squirrel@gate.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: Jakub Jelinek <jakub@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 25, 2010 at 01:08:23PM +0200, Segher Boessenkool wrote:
> > -		stw%U0%X0 %L2,%1"
> > -	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
> > +		stw%U1%X1 %L2,%1"
> > +	: "=m<>" (*ptep), "=m<>" (*((unsigned char *)ptep+4))
> >  	: "r" (pte) : "memory");
> 
> This still isn't correct -- the constraint says that a byte
> is written, but the insn changes a word.  Probably should just
> be ptep[1] ?

Yeah.

	Jakub
