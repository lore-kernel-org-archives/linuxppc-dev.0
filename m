Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A09F3DE6B7
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 00:50:43 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KEocIh022334
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 10:50:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KEobcn216318
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 08:50:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KEoaUj018499
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 08:50:36 -0600
Date: Wed, 20 Aug 2008 10:50:35 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ftrace introduces instability into kernel 2.6.27(-rc2,-rc3)
Message-ID: <20080820105035.49f29509@zod.rchland.ibm.com>
In-Reply-To: <alpine.DEB.1.10.0808201022080.23571@gandalf.stny.rr.com>
References: <48591941.4070408@extricom.com> <48A92E15.2080709@extricom.com>
	<48A9901B.1080900@redhat.com> <20080818154746.GA26835@Krystal>
	<48A9AFA7.8080508@freescale.com>
	<alpine.DEB.1.10.0808181425090.796@gandalf.stny.rr.com>
	<1219110814.8062.2.camel@pasglop>
	<alpine.DEB.1.10.0808182208110.13401@gandalf.stny.rr.com>
	<1219113549.8062.13.camel@pasglop>
	<1219114600.8062.15.camel@pasglop>
	<alpine.DEB.1.10.0808182304300.13401@gandalf.stny.rr.com>
	<1219119431.8062.35.camel@pasglop>
	<1219216705.21386.46.camel@pasglop>
	<alpine.DEB.1.10.0808200913070.13132@gandalf.stny.rr.com>
	<1219241819.26429.24.camel@jdub.homelinux.org>
	<alpine.DEB.1.10.0808201022080.23571@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Alan Modra <amodra@au1.ibm.com>,
	Scott Wood <scottwood@freescale.com>, Eran Liberty <liberty@extricom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 10:22:49 -0400 (EDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> On Wed, 20 Aug 2008, Josh Boyer wrote:
> > 
> > Segher was looking at this a bit this morning.  He thinks it's really
> > -fno-omit-frame-pointer that is causing this.  That really shouldn't
> > even be set on PowerPC, but FTRACE uses select which overrides the
> > depends on stuff in Kconfig.
> 
> I can easily make a patch that makes that select an x86 only.

That's probably a first step, but you might want to wait until Segher
can fill in more details.  I'm sort of just relaying what he and I were
talking about on IRC.  IIRC, he was testing builds with and without
both -pg and -fno-omit-frame-pointer and found the bug only when
-fno-omit-frame-pointer was present.

josh
