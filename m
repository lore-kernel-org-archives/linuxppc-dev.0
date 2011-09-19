Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58744B70BD
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 12:46:03 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8J2dGmg023729
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 12:39:16 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8J2k2Wc974888
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 12:46:02 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8J2k1cT031296
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 12:46:02 +1000
Date: Mon, 19 Sep 2011 11:10:51 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Thiago Jung Bauermann <bauerman@br.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
	flag
Message-ID: <20110919011051.GI9025@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
	<20110823050931.GT30097@yookeroo.fritz.box>
	<20110823092756.GB2962@in.ibm.com>
	<20110824040010.GC30097@yookeroo.fritz.box>
	<1314232903.14168.4.camel@hactar>
	<20110826044123.GI2308@yookeroo.fritz.box>
	<1314750461.20347.1.camel@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314750461.20347.1.camel@hactar>
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

On Tue, Aug 30, 2011 at 09:27:41PM -0300, Thiago Jung Bauermann wrote:
> On Fri, 2011-08-26 at 14:41 +1000, David Gibson wrote:
> > On Wed, Aug 24, 2011 at 09:41:43PM -0300, Thiago Jung Bauermann wrote:
> > > On Wed, 2011-08-24 at 14:00 +1000, David Gibson wrote:
> > > > On Tue, Aug 23, 2011 at 02:57:56PM +0530, K.Prasad wrote:
> > > > > On Tue, Aug 23, 2011 at 03:09:31PM +1000, David Gibson wrote:
> > > > > > On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> > > > > > > 
> > > > > > > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > > > > > > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > > > > > > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > > > > > > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > > > > > > "features" member of "struct ppc_debug_info" to advertise support for the
> > > > > > > same on Book3E PowerPC processors.
> > > > > > 
> > > > > > I thought the idea was that the BP_EXACT mode was the default - if the
> > > > > > new interface was supported at all, then BP_EXACT was always
> > > > > > supported.  So, why do you need a new flag?
> > > > > > 
> > > > > 
> > > > > Yes, BP_EXACT was always supported but not advertised through
> > > > > PPC_PTRACE_GETHWDBGINFO. We're now doing that.
> > > > 
> > > > I can see that.  But you haven't answered why.
> > > 
> > > BookS doesn't support BP_EXACT, that's why I suggested this flag.
> > 
> > Surely you can support it with exactly the same sort of filtering
> > you're using for the 8-byte ranges now?
> 
> Yes, but to detect that the processor doesn't support BP_EXACT in
> hardware I'd have to send a ptrace request, and have it rejected. Only
> then I'd step back and simulate one with ranges. Considering that it's
> easy and backwards compatible to add a new flag to signal that BP_EXACT
> is not supported, I don't know why it would be better to go with the
> more convoluted process.

No, I'm saying why not implement BP_EXACT on server.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
