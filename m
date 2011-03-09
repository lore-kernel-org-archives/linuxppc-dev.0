Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1ABA5B6FC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 00:34:08 +1100 (EST)
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
From: Peter Zijlstra <peterz@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
In-Reply-To: <20110309143152.3cc6c191@mschwide.boeblingen.de.ibm.com>
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins> <1299670429.2308.2834.camel@twins>
	<20110309141548.722e4f56@mschwide.boeblingen.de.ibm.com>
	<1299676769.2308.2944.camel@twins>
	<20110309143152.3cc6c191@mschwide.boeblingen.de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 14:33:56 +0100
Message-ID: <1299677636.2308.2960.camel@twins>
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

On Wed, 2011-03-09 at 14:31 +0100, Martin Schwidefsky wrote:
> > But if you don't also update the cpu->node memory mappings (which I
> > think it near impossible) what good is it to change the scheduler
> > topology?
>=20
> The memory for the different LPARs is striped over all nodes (or books as=
 we
> call them). We heavily rely on the large shared cache between the books t=
o hide
> the different memory access latencies.=20

Right, so effectively you don't have NUMA due to that striping. So why
then change the CPU topology? Simply create a topology without NUMA and
keep it static, that accurately reflects the memory topology.
