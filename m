Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33E56DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 20:19:56 +1000 (EST)
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <200809240958.m8O9wM7k010996@sullivan.realtime.net>
References: <200809231743.23828.ossthema@de.ibm.com>
	, <20080915100406.342e027a@bull.net>
	<200809240958.m8O9wM7k010996@sullivan.realtime.net>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 20:17:47 +1000
Message-Id: <1222251467.8277.73.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Sebastien Dugue <sebastien.dugue@bull.net>,
	Christoph Raisch <RAISCH@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-24 at 04:58 -0500, Milton Miller wrote:
> The per-interrupt mask and unmask calls have to go through RTAS, a
> single-threaded global context, which in addition to increasing
> path length will really limit scalability.  The interrupt controller
> poll and reject facilities are accessed through hypervisor calls
> which are comparable to a fast syscall, and parallel to all cpus.

Note also that the XICS code thus assumes, iirc, as does the cell IIC
code, that eoi is called on the -same- cpu that fetched the interrupt
initially. That assumption can be broken with IRQ threads no ?

Ben.
