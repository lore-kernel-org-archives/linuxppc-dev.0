Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AD1CDB7BE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 17:21:44 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B627DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 17:21:42 +1000 (EST)
Subject: Re: lmb: Remove __init from lmb_end_of_DRAM()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <200908271959.n7RJxNvV008624@hera.kernel.org>
References: <200908271959.n7RJxNvV008624@hera.kernel.org>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 17:21:28 +1000
Message-Id: <1251444088.20467.169.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-27 at 19:59 +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/linus/4f8ee2c9cc0e885d2bb50ef26db66150ab25213e
> Commit:     4f8ee2c9cc0e885d2bb50ef26db66150ab25213e
> Parent:     cf481442f2e086316ed8a1b3046f00ad23632ac4
> Author:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
> AuthorDate: Thu Aug 27 17:20:30 2009 +1000
> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Thu Aug 27 12:25:26 2009 -0700
> 
>     lmb: Remove __init from lmb_end_of_DRAM()
>     
>     We call lmb_end_of_DRAM() to test whether a DMA mask is ok on a machine
>     without IOMMU, but this function is marked as __init.
>     
>     I don't think there's a clean way to get the top of RAM max_pfn doesn't
>     appear to include highmem or I missed (or we have a bug :-) so for now,
>     let's just avoid having a broken 2.6.31 by making this function
>     non-__init and we can revisit later.

And another brown paper bag for me ! Patch is fine, but doesn't do the
job because some idiot (me) didn't actually test (it looked so obvious)
and didn't notice somebody had the strange idea to also put __init on
the declaration in the .h file ! Ugh.

I'll send another patch later, have to run home now.

Cheers,
Ben.
