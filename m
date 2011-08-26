Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 032C2B6F8C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 14:45:51 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7Q4isHq010278
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 14:44:54 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7Q4jp1d1749056
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 14:45:51 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7Q4jogJ020288
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Aug 2011 14:45:51 +1000
Date: Fri, 26 Aug 2011 14:41:23 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Thiago Jung Bauermann <bauerman@br.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
	flag
Message-ID: <20110826044123.GI2308@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
	<20110823050931.GT30097@yookeroo.fritz.box>
	<20110823092756.GB2962@in.ibm.com>
	<20110824040010.GC30097@yookeroo.fritz.box>
	<1314232903.14168.4.camel@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314232903.14168.4.camel@hactar>
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

On Wed, Aug 24, 2011 at 09:41:43PM -0300, Thiago Jung Bauermann wrote:
> On Wed, 2011-08-24 at 14:00 +1000, David Gibson wrote:
> > On Tue, Aug 23, 2011 at 02:57:56PM +0530, K.Prasad wrote:
> > > On Tue, Aug 23, 2011 at 03:09:31PM +1000, David Gibson wrote:
> > > > On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> > > > > 
> > > > > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > > > > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > > > > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > > > > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > > > > "features" member of "struct ppc_debug_info" to advertise support for the
> > > > > same on Book3E PowerPC processors.
> > > > 
> > > > I thought the idea was that the BP_EXACT mode was the default - if the
> > > > new interface was supported at all, then BP_EXACT was always
> > > > supported.  So, why do you need a new flag?
> > > > 
> > > 
> > > Yes, BP_EXACT was always supported but not advertised through
> > > PPC_PTRACE_GETHWDBGINFO. We're now doing that.
> > 
> > I can see that.  But you haven't answered why.
> 
> BookS doesn't support BP_EXACT, that's why I suggested this flag.

Surely you can support it with exactly the same sort of filtering
you're using for the 8-byte ranges now?

> A BP_EXACT watchpoint triggers only when there's a memory access exactly
> at the given address. It doesn't trigger when there's (for example) a
> 4-byte write at an address immediately before which also changes the
> memory contents of the byte watched by the BP_EXACT watchpoint. a ranged
> watchpoint would trigger, so the semantics are different.
> 
> As a general rule, GDB only sets ranged watchpoints and only uses
> BP_EXACT ones when the user sets a flag. I want GDB to fail when the
> user sets the flag on BookS since it can't provide the feature.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
