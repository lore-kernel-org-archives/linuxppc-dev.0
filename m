Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10ECE10088E
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2012 22:52:32 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <dwg@au1.ibm.com>;
 Mon, 16 Jan 2012 11:48:40 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0GBqNfe5251106
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2012 22:52:23 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0GBqMVX007951
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2012 22:52:23 +1100
Date: Mon, 16 Jan 2012 19:18:33 +1100
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
 flag
Message-ID: <20120116081833.GG4512@truffala.fritz.box>
References: <20111208111212.GB3720@in.ibm.com>
 <20111208112330.GB24484@in.ibm.com>
 <20111221005502.GE5188@truffala.fritz.box>
 <20111222093447.GD26407@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111222093447.GD26407@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2011 at 03:04:47PM +0530, K.Prasad wrote:
> On Wed, Dec 21, 2011 at 11:55:02AM +1100, David Gibson wrote:
> > On Thu, Dec 08, 2011 at 04:53:30PM +0530, K.Prasad wrote:
> > > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > > "features" member of "struct ppc_debug_info" to advertise support for the
> > > same on Book3E PowerPC processors.
> > 
> > Hrm.  I had assumed the reason there wasn't a feature bit for EXACT
> > originally was that EXACT breakpoints were *always* supposed to be
> > supported by the new interface.
> >
> 
> Okay. Although BookS doesn't support EXACT breakpoints, it is possible
> (after the introduction of new hw-breakpoint interfaces) to request for
> a breakpoint of length 1 Byte.

Hrm.  An EXACT breakpoint is not exactly the same as a range
breakpoint of length 1 (consider unaligned accesses).  But despite
that, it should be possible to implement exact breakpoints on Book3S
server hardware with some software filtering.

And since that leaves no hardware that *can't* implement exact
breakpoints (directly or indirectly), I'm not yet convinced of the
need for a flag bit.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
