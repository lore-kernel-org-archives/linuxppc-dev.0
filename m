Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5DA5B7BFA
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 17:03:07 +1100 (EST)
Date: Tue, 16 Feb 2010 00:07:58 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU
	supports it
Message-ID: <20100216060758.GA12891@lixom.net>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten> <20100210111025.GF3399@kryten>
	<20100216042238.GB12167@lixom.net>
	<1266293943.16346.169.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1266293943.16346.169.camel@pasglop>
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2010 at 03:19:03PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-02-15 at 22:22 -0600, Olof Johansson wrote:
> > 
> > Turns out this one hurts PA6T performance quite a bit, lwsync seems to be
> > significantly more expensive there. I see a 25% drop in the microbenchmark
> > doing pthread_lock/unlock loops on two cpus.
> > 
> > Taking out the CPU_FTR_LWSYNC will solve it, it's a bit unfortunate since
> > the sync->lwsync changes definitely still can, and should, be done. 
> 
> So we should use a different feature bit. No biggie. If needed we can
> split them more anyways.

Yeah, fine with me.


-Olof
