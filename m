Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 415FCDDE41
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 18:17:23 +1000 (EST)
Subject: Re: [BUG] 2.6.30-rc3: BUG triggered on some hugepage usages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20090424095116.GB14283@csn.ul.ie>
References: <alpine.LFD.2.00.0904212014170.3101@localhost.localdomain>
	<20090424095116.GB14283@csn.ul.ie>
Content-Type: text/plain
Date: Mon, 27 Apr 2009 18:15:38 +1000
Message-Id: <1240820138.7169.10.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-24 at 10:51 +0100, Mel Gorman wrote:
> I'm seeing some tests with sysbench+postgres+large pages fail on ppc64
> although a very clear pattern is not forming as to what exactly is
> causing it. However, the libhugetlbfs regression tests (make && make
> func) are triggering the following oops when calling mlock() and so
> are
> likely related.

This would be a spurrious WARN_ON().. the test I added in there should
not apply to huge pages. However, I don't see that causing a functional
problem with sysbench+postgres

Ben.
