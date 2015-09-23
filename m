Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 618B51A0210
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 07:38:04 +1000 (AEST)
Message-ID: <1443044256.3100.51.camel@kernel.crashing.org>
Subject: Re: [PATCH 18/31] powerpc/mm: Increase the pte frag size.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 24 Sep 2015 07:37:36 +1000
In-Reply-To: <878u80gf8q.fsf@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442817658-2588-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442823285.2819.1.camel@kernel.crashing.org>
 <87mvwgduuj.fsf@linux.vnet.ibm.com>
 <1442833578.11901.2.camel@kernel.crashing.org>
 <878u80gf8q.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 17:23 +0530, Aneesh Kumar K.V wrote:
> The page that contain pte entries. Or the last level of the linux page
> table. or we could call them pte fragments. We need to allocate one
> full page at lowest level, because we want to use split ptlock. Now
> for keeping the pte_t entries, we will just be using 2K space. Rest of
> the space can be reused. We did that in commit 
> 5c1f6ee9a31cbdac90bbb8ae1ba4475031ac74b4 . Now all those pmd entries
> that have pte page (pte fragments) coming from the same 64K page
> will also end up sharing the same ptlock.

Ok, I'm still a bit confused between what we do today vs. what we do
after your patch, can you provide a clear description (maybe with
ASCII art) of what is used, how, an how much is wasted overall when
not using subpages ?

> >
> > In any case, shouldn't we consider something more like what we do for
> > subpage protection and just segregate the 4k stuff in a completely
> > separate tree which we can allocate on-demand so that we don't allocate
> > any of it if there is no demotion ?
> >
> 
> We could definitely try that. That would mean another set of memory
> allocation only for 4K and I was not sure we want that. For
> example current subpage protection code path is rarely used and we may
> not really be able to find out if we break it.

That's what test suites are for, we should write a test case :)

Cheers,
Ben.
