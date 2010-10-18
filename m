Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82A77B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 08:00:36 +1100 (EST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <20101013144044.GS30667@csn.ul.ie>
References: <20101009095718.1775.qmail@kosh.dhis.org>
	<20101011143022.GD30667@csn.ul.ie>
	<20101011140039.15a2c78d.akpm@linux-foundation.org>
	<20101013144044.GS30667@csn.ul.ie>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Oct 2010 07:59:10 +1100
Message-ID: <1287435550.2341.7.camel@pasglop>
Mime-Version: 1.0
Cc: Yinghai Lu <yinghai@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pacman@kosh.dhis.org,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-10-13 at 15:40 +0100, Mel Gorman wrote:
> 
> This is somewhat contrived but I can see how it might happen even on one
> CPU particularly if the L1 cache is virtual and is loose about checking
> physical tags.
> 
> > How sensitive/vulnerable is PPC32 to such things?
> > 
> 
> I can not tell you specifically but if the above scenario is in any way
> plausible, I believe it would depend on what sort of L1 cache the CPU
> has. Maybe this particular version has a virtual cache with no physical
> tagging and is depending on the OS not to make virtual aliasing mistakes.

Nah, ppc doesn't have problems with cache aliases, it all looks
physically tagged to the programmer (tho there's subtleties but none
that explains the reported behaviour).

Looks like real memory corruption to me.

Cheers,
Ben.
