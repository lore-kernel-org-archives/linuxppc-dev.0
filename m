Return-Path: <cl@linux.com>
Received: from smtp108.prem.mail.ac4.yahoo.com
	(smtp108.prem.mail.ac4.yahoo.com [76.13.13.47])
	by ozlabs.org (Postfix) with SMTP id 7DA50B6FBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 04:00:03 +1000 (EST)
Date: Mon, 13 Jun 2011 12:59:57 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] slub: fix kernel BUG at mm/slub.c:1950!
In-Reply-To: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
Message-ID: <alpine.DEB.2.00.1106131258300.3108@router.home>
References: <alpine.LSU.2.00.1106121842250.31463@sister.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 12 Jun 2011, Hugh Dickins wrote:

> 3.0-rc won't boot with SLUB on my PowerPC G5: kernel BUG at mm/slub.c:1950!
> Bisected to 1759415e630e "slub: Remove CONFIG_CMPXCHG_LOCAL ifdeffery".
>
> After giving myself a medal for finding the BUG on line 1950 of mm/slub.c
> (it's actually the
> 	VM_BUG_ON((unsigned long)(&pcp1) % (2 * sizeof(pcp1)));
> on line 268 of the morass that is include/linux/percpu.h)
> I tried the following alignment patch and found it to work.

Hmmm.. The allocpercpu in alloc_kmem_cache_cpus should take care of the
alignment. Uhh.. I see that a patch that removes the #ifdef CMPXCHG_LOCAL
was not applied? Pekka?
