Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [194.196.100.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19B57B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:46:35 +1100 (EST)
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p29DkUwP009160
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:46:30 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
	[9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p29DkiuG1913086
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:46:44 GMT
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p29DkTVE012656
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2011 13:46:29 GMT
Date: Wed, 9 Mar 2011 14:46:36 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
Message-ID: <20110309144636.3f0899d1@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1299677636.2308.2960.camel@twins>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins>
	<1299670429.2308.2834.camel@twins>
	<20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
	<1299676769.2308.2944.camel@twins>
	<20110309143152.3cc6c191@mschwide.boeblingen.de.ibm.com>
	<1299677636.2308.2960.camel@twins>
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

On Wed, 09 Mar 2011 14:33:56 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, 2011-03-09 at 14:31 +0100, Martin Schwidefsky wrote:
> > > But if you don't also update the cpu->node memory mappings (which I
> > > think it near impossible) what good is it to change the scheduler
> > > topology?
> > 
> > The memory for the different LPARs is striped over all nodes (or books as we
> > call them). We heavily rely on the large shared cache between the books to hide
> > the different memory access latencies. 
> 
> Right, so effectively you don't have NUMA due to that striping. So why
> then change the CPU topology? Simply create a topology without NUMA and
> keep it static, that accurately reflects the memory topology.

Well the CPU topology can change due to different grouping of logical CPUs
dependent on which LPARs are activated. And we effectively do not have a
memory topology, only CPU. Its basically all about caches, we want to
reflect the distance between CPUs over the up to 4 cache levels.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
