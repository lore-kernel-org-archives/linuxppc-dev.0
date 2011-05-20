Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 223E9B6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 08:15:46 +1000 (EST)
Subject: Re: [PATCH 2/7] powerpc/mm: 64-bit 4k: use a PMD-based virtual
	page table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20110520155719.32e51635@schlenkerla.am.freescale.net>
References: <20110518210528.GA29524@schlenkerla.am.freescale.net>
	<1305754435.7481.3.camel@pasglop>
	<20110520155719.32e51635@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 May 2011 08:15:36 +1000
Message-ID: <1305929736.7481.188.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-05-20 at 15:57 -0500, Scott Wood wrote:

> I see a 2% cost going from virtual pmd to full 4-level walk in the
> benchmark mentioned above (some type of sort), and just under 3% in
> page-stride lat_mem_rd from lmbench.
> 
> OTOH, the virtual pmd approach still leaves the possibility of taking a
> bunch of virtual page table misses if non-localized accesses happen over a
> very large chunk of address space (tens of GiB), and we'd have one fewer
> type of TLB miss to worry about complexity-wise with a straight table walk.
> 
> Let me know what you'd prefer.

I'm tempted to kill the virtual linear feature alltogether.. it didn't
buy us that much. Have you looked if you can snatch back some of those
cycles with hand tuning of the level walker ?

Would it work/help to have a simple cache of the last pmd & address and
compare just that ? Maybe in a SPRG or a known cache hot location like
the PACA in a line that we already load anyways ?

Cheers,
Ben.
