Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8612AB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 08:36:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E91D8DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 08:36:25 +1000 (EST)
Subject: Re: rtas instantiation when commandline contains mem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090716131246.GB22901@codiert.org>
References: <20090716131246.GB22901@codiert.org>
Content-Type: text/plain
Date: Fri, 17 Jul 2009 08:36:10 +1000
Message-Id: <1247783770.27937.61.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-16 at 15:12 +0200, Benjamin Krill wrote:
> Hi,
> 
> the rtas instantiation (prom_init.c) doesn't work correctly if the
> kernel parameter "mem=" is used. The current code doesn't evaluate
> the kernel parameter which causes the issue that alloc_down
> allocates somewhere in the "real" memory space. So it can
> happen that the allocation space is above "mem=".
> 
> Commit 2babf5c2ec2f2d5de3e38d20f7df7fd815fd10c9 removes the
> evaluation of "mem=".

Ah yes, we don't constraint prom_init.c to mem=, only the kernel

Cheers,
Ben.
