Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [194.196.100.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B53B4B6FBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:31:54 +1100 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate7.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p29DVnFr030279
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:31:49 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p29DW1M52007286
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:32:03 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p29DVk3n016097
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 06:31:46 -0700
Date: Wed, 9 Mar 2011 14:31:52 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
Message-ID: <20110309143152.3cc6c191@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1299676769.2308.2944.camel@twins>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins>
	<1299670429.2308.2834.camel@twins>
	<20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
	<1299676769.2308.2944.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 09 Mar 2011 14:19:29 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2011-03-09 at 14:15 +0100, Martin Schwidefsky wrote:
> > On Wed, 09 Mar 2011 12:33:49 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, 2011-03-09 at 11:19 +0100, Peter Zijlstra wrote:
> > > > > It appears that this corresponds to one CPU deciding to rebuild the
> > > > > sched domains. There's various reasons why that can happen, the typical
> > > > > one in our case is the new VPNH feature where the hypervisor informs us
> > > > > of a change in node affinity of our virtual processors. s390 has a
> > > > > similar feature and should be affected as well.
> > > > 
> > > > Ahh, so that's triggering it :-), just curious, how often does the HV do
> > > > that to you? 
> > > 
> > > OK, so Ben told me on IRC this can happen quite frequently, to which I
> > > must ask WTF were you guys smoking? Flipping the CPU topology every time
> > > the HV scheduler does something funny is quite insane. And you did that
> > > without ever talking to the scheduler folks, not cool.
> > > 
> > > That is of course aside from the fact that we have a real bug there that
> > > needs fixing, but really guys, WTF!
> > 
> > Just for info, on s390 the topology change events are rather infrequent.
> > They do happen e.g. after an LPAR has been activated and the LPAR
> > hypervisor needs to reshuffle the CPUs of the different nodes.
> 
> But if you don't also update the cpu->node memory mappings (which I
> think it near impossible) what good is it to change the scheduler
> topology?

The memory for the different LPARs is striped over all nodes (or books as we
call them). We heavily rely on the large shared cache between the books to hide
the different memory access latencies.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
