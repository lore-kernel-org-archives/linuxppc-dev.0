Return-Path: <bauerman@br.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp01.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A7A8B6F8C
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 10:27:49 +1000 (EST)
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp01.br.ibm.com (8.14.4/8.13.1) with ESMTP id p7V1ggoV019370
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 21:42:42 -0400
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7V0Uf4L3584186
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 21:30:41 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7UGRhtI015802
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Aug 2011 13:27:43 -0300
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug
	feature flag
From: Thiago Jung Bauermann <bauerman@br.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20110826044123.GI2308@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
	<20110823050931.GT30097@yookeroo.fritz.box>
	<20110823092756.GB2962@in.ibm.com>
	<20110824040010.GC30097@yookeroo.fritz.box>
	<1314232903.14168.4.camel@hactar>
	<20110826044123.GI2308@yookeroo.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 30 Aug 2011 21:27:41 -0300
Message-ID: <1314750461.20347.1.camel@hactar>
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

On Fri, 2011-08-26 at 14:41 +1000, David Gibson wrote:
> On Wed, Aug 24, 2011 at 09:41:43PM -0300, Thiago Jung Bauermann wrote:
> > On Wed, 2011-08-24 at 14:00 +1000, David Gibson wrote:
> > > On Tue, Aug 23, 2011 at 02:57:56PM +0530, K.Prasad wrote:
> > > > On Tue, Aug 23, 2011 at 03:09:31PM +1000, David Gibson wrote:
> > > > > On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> > > > > > 
> > > > > > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > > > > > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > > > > > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > > > > > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > > > > > "features" member of "struct ppc_debug_info" to advertise support for the
> > > > > > same on Book3E PowerPC processors.
> > > > > 
> > > > > I thought the idea was that the BP_EXACT mode was the default - if the
> > > > > new interface was supported at all, then BP_EXACT was always
> > > > > supported.  So, why do you need a new flag?
> > > > > 
> > > > 
> > > > Yes, BP_EXACT was always supported but not advertised through
> > > > PPC_PTRACE_GETHWDBGINFO. We're now doing that.
> > > 
> > > I can see that.  But you haven't answered why.
> > 
> > BookS doesn't support BP_EXACT, that's why I suggested this flag.
> 
> Surely you can support it with exactly the same sort of filtering
> you're using for the 8-byte ranges now?

Yes, but to detect that the processor doesn't support BP_EXACT in
hardware I'd have to send a ptrace request, and have it rejected. Only
then I'd step back and simulate one with ranges. Considering that it's
easy and backwards compatible to add a new flag to signal that BP_EXACT
is not supported, I don't know why it would be better to go with the
more convoluted process.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
