Date: Mon, 28 Aug 2000 14:05:44 +0200 (CEST)
From: Ronald Wahl <rwa@peppercon.de>
To: Dan Malek <dan@embeddededge.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39A6AF42.323B88C@embeddededge.com>
Message-ID: <Pine.LNX.4.21.0008281358290.1082-100000@goliath.issistance.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 25 Aug 2000, Dan Malek wrote:

> > question again: How can I get an alias mapping (with _PAGE_NO_CACHE |
> > _PAGE_GUARDED) of some already mapped pages.
>
> There isn't anything generic right now.  A few of us are working on
> a solution, as there are other processors affected (IBM 4xx) as well.
> If you look at the uart or Ethernet drivers, you will notice they
> allocate pages of memory, track down the PTEs and set the attributes
> directly.  You can use that as an example.
>
> Don't forget that managing the caches in software (via flushes and
> invalidates) could actually provide better performance for data
> transfers due to the cache bursting available when caches are enabled.

Yeah, that's what i do currently. But I had to write an
invalidate_dcache_range() first. I used the code of
flush_dcache_range() and replaced dcbst by dcbi. Now it
seems to work. Thanks for this hint, Dan.

ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
