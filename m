Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7E35B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 00:49:05 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shan Hai <haishan.bai@gmail.com>
In-Reply-To: <4E22E4AC.7040600@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins>  <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop> <1310900561.13765.22.camel@twins>
	<4E22E4AC.7040600@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 00:48:37 +1000
Message-ID: <1310914117.25044.216.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-07-17 at 21:33 +0800, Shan Hai wrote:
> 
> On ARM you could not protect pages from supervisor-mode writes,
> isn't it?  That means, all writable user pages are writable for
> supervisor too, but its not hold for at least x86 and powerpc,
> x86 and powerpc can be configured to protect pages from
> supervisor-mode writes.

That doesn't sound right... how would put_user() work properly then ? A
cursory glance at the ARM code doesn't show it doing anything "special",
just stores ... but I might have missing something.

> Think about the following situation,
> a page fault occurs on the kernel trying to write to a writable shared
> user page which is read only to the kernel, the following conditions
> hold,
> - the page is *present*, because its a shared page
> - the page is *writable*, because demand paging sets up the pte for
>      the current process to so
> 
> The follow_page() called in the __get_user_page() returns non NULL
> to its caller on the above mentioned *present* and *writable* page,
> so the gup(.write=1) has no chance to set pte dirty by calling 
> handle_mm_fault,
> the follow_page() has no knowledge of supervisor-mode write protected
> pages,
> that's the culprit in the bug discussed here. 

Right, the problem is with writable pages that have "lost" (or never had
but usually it's lost, due to swapping for example) their dirty bit, or
any page that has lost young.

>From what I can tell, we need to either fix those bits from the caller
of gup (futex code), which sound nasty, or more easily fix those from
gup itself, possibly under control of flags in the "write" argument to 
avoid breaking code relying on the existing behaviour, expecially vs.
dirty.

Cheers,
Ben.
