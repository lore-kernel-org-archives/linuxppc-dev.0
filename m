Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DDA82B6F8C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:54:54 +1100 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20110309144636.3f0899d1@mschwide.boeblingen.de.ibm.com>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299670429.2308.2834.camel@twins>
	<20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
	<1299676769.2308.2944.camel@twins>
	<20110309143152.3cc6c191@mschwide.boeblingen.de.ibm.com>
	<1299677636.2308.2960.camel@twins>
	<20110309144636.3f0899d1@mschwide.boeblingen.de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 14:54:39 +0100
Message-ID: <1299678879.2308.2987.camel@twins>
Mime-Version: 1.0
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

On Wed, 2011-03-09 at 14:46 +0100, Martin Schwidefsky wrote:
> On Wed, 09 Mar 2011 14:33:56 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Wed, 2011-03-09 at 14:31 +0100, Martin Schwidefsky wrote:
> > > > But if you don't also update the cpu->node memory mappings (which I
> > > > think it near impossible) what good is it to change the scheduler
> > > > topology?
> > >=20
> > > The memory for the different LPARs is striped over all nodes (or book=
s as we
> > > call them). We heavily rely on the large shared cache between the boo=
ks to hide
> > > the different memory access latencies.=20
> >=20
> > Right, so effectively you don't have NUMA due to that striping. So why
> > then change the CPU topology? Simply create a topology without NUMA and
> > keep it static, that accurately reflects the memory topology.
>=20
> Well the CPU topology can change due to different grouping of logical CPU=
s
> dependent on which LPARs are activated. And we effectively do not have a
> memory topology, only CPU. Its basically all about caches, we want to
> reflect the distance between CPUs over the up to 4 cache levels.

Right, so I consider caches to be part of the memory topology, anyway,
if this all is very rare then yeah, that works out.
