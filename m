Return-Path: <bauerman@br.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp03.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8588B6F69
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2011 10:42:06 +1000 (EST)
Received: from /spool/local by br.ibm.com with XMail ESMTP
	for <linuxppc-dev@ozlabs.org> from <bauerman@br.ibm.com>;
	Wed, 24 Aug 2011 21:42:00 -0300
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7P0ibjI1880238
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 21:44:37 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7P0fivv009042
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 21:41:45 -0300
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug
	feature flag
From: Thiago Jung Bauermann <bauerman@br.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20110824040010.GC30097@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
	<20110823050931.GT30097@yookeroo.fritz.box>
	<20110823092756.GB2962@in.ibm.com>
	<20110824040010.GC30097@yookeroo.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Aug 2011 21:41:43 -0300
Message-ID: <1314232903.14168.4.camel@hactar>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-08-24 at 14:00 +1000, David Gibson wrote:
> On Tue, Aug 23, 2011 at 02:57:56PM +0530, K.Prasad wrote:
> > On Tue, Aug 23, 2011 at 03:09:31PM +1000, David Gibson wrote:
> > > On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> > > > 
> > > > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > > > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > > > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > > > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > > > "features" member of "struct ppc_debug_info" to advertise support for the
> > > > same on Book3E PowerPC processors.
> > > 
> > > I thought the idea was that the BP_EXACT mode was the default - if the
> > > new interface was supported at all, then BP_EXACT was always
> > > supported.  So, why do you need a new flag?
> > > 
> > 
> > Yes, BP_EXACT was always supported but not advertised through
> > PPC_PTRACE_GETHWDBGINFO. We're now doing that.
> 
> I can see that.  But you haven't answered why.

BookS doesn't support BP_EXACT, that's why I suggested this flag.

A BP_EXACT watchpoint triggers only when there's a memory access exactly
at the given address. It doesn't trigger when there's (for example) a
4-byte write at an address immediately before which also changes the
memory contents of the byte watched by the BP_EXACT watchpoint. a ranged
watchpoint would trigger, so the semantics are different.

As a general rule, GDB only sets ranged watchpoints and only uses
BP_EXACT ones when the user sets a flag. I want GDB to fail when the
user sets the flag on BookS since it can't provide the feature.
-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
