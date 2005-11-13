Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B112968713
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 14:27:25 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20051113012608.GH21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<20051112215304.GB21448@stusta.de>
	<200511122257.05552.mbuesch@freenet.de>
	<20051112222045.GC21448@stusta.de>
	<1131834667.7406.49.camel@gaston>  <20051113012608.GH21448@stusta.de>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 14:23:29 +1100
Message-Id: <1131852210.5504.36.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] PPC_PREP: remove unneeded exports
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2005-11-13 at 02:26 +0100, Adrian Bunk wrote:
> On Sun, Nov 13, 2005 at 09:31:06AM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
> > > any way.
> > > 
> > > _prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.
> > 
> > Therse are old PREP stuffs
> >...
> 
> Is the patch below OK?

The ucXXX variables should probably go (or at least be unexported) but I
would keep the _prep_type export for now, unless we are certain no
driver and no out of tree stuff neither uses it (hrm... might well be
the case).

In any case, the proper fix is probably to move the EXPORT_SYMBOL() out
of ppc_ksyms, and have it next to the declaration of the variable.

Ben.
