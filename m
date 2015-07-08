Return-Path: <corbet@lwn.net>
Received: from vena.lwn.net (tex.lwn.net [70.33.254.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D0611A198F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 07:17:54 +1000 (AEST)
Date: Wed, 8 Jul 2015 15:17:50 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko
 <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH V3 3/5] mm: mlock: Introduce VM_LOCKONFAULT and add
 mlock flags to enable it
Message-ID: <20150708151750.75e65859@lwn.net>
In-Reply-To: <20150708203456.GC4669@akamai.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-4-git-send-email-emunson@akamai.com>
 <20150708132351.61c13db6@lwn.net>
 <20150708203456.GC4669@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Jul 2015 16:34:56 -0400
Eric B Munson <emunson@akamai.com> wrote:

> > Quick, possibly dumb question: I've been beating my head against these =
for
> > a little bit, and I can't figure out what's supposed to happen in this
> > case:
> >=20
> > 	mlock2(addr, len, MLOCK_ONFAULT);
> > 	munlock2(addr, len, MLOCK_LOCKED);
> >=20
> > It looks to me like it will clear VM_LOCKED without actually unlocking =
any
> > pages.  Is that the intended result? =20
>=20
> This is not quite right, what happens when you call munlock2(addr, len,
> MLOCK_LOCKED); is we call apply_vma_flags(addr, len, VM_LOCKED, false).

=46rom your explanation, it looks like what I said *was* right...what I was
missing was the fact that VM_LOCKED isn't set in the first place.  So that
call would be a no-op, clearing a flag that's already cleared.

One other question...if I call mlock2(MLOCK_ONFAULT) on a range that
already has resident pages, I believe that those pages will not be locked
until they are reclaimed and faulted back in again, right?  I suspect that
could be surprising to users.

Thanks,

jon
