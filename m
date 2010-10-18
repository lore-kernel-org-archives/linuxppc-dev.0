Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 319B4B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 06:39:14 +1100 (EST)
Date: Mon, 18 Oct 2010 12:37:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
Message-Id: <20101018123750.ef7d6d48.akpm@linux-foundation.org>
In-Reply-To: <20101018113331.GB30667@csn.ul.ie>
References: <20101013144044.GS30667@csn.ul.ie>
	<20101013175205.21187.qmail@kosh.dhis.org>
	<20101018113331.GB30667@csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm@kvack.org, pacman@kosh.dhis.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 18 Oct 2010 12:33:31 +0100
Mel Gorman <mel@csn.ul.ie> wrote:

> A bit but I still don't know why it would cause corruption. Maybe this is still
> a caching issue but the difference in timing between list_add and list_add_tail
> is enough to hide the bug. It's also possible there are some registers
> ioremapped after the memmap array and reading them is causing some
> problem.
> 
> Andrew, what is the right thing to do here? We could flail around looking
> for explanations as to why the bug causes a user buffer corruption but never
> get an answer or do we go with this patch, preferably before 2.6.36 releases?

Well, you've spotted a bug so I'd say we fix it asap.

It's a bit of a shame that we lose the only known way of reproducing a
different bug, but presumably that will come back and bite someone else
one day, and we'll fix it then :(
