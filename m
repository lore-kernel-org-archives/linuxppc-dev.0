Message-ID: <39A6AF42.323B88C@embeddededge.com>
Date: Fri, 25 Aug 2000 13:39:14 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ronald Wahl <rwa@peppercon.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
References: <Pine.LNX.4.21.0008250907160.1624-100000@goliath.issistance.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ronald Wahl wrote:


> After some further tests I found out that it is the data cache of the
> MPC860.

Yep.

> ..... So my
> question again: How can I get an alias mapping (with _PAGE_NO_CACHE |
> _PAGE_GUARDED) of some already mapped pages.

There isn't anything generic right now.  A few of us are working on
a solution, as there are other processors affected (IBM 4xx) as well.
If you look at the uart or Ethernet drivers, you will notice they
allocate pages of memory, track down the PTEs and set the attributes
directly.  You can use that as an example.

Don't forget that managing the caches in software (via flushes and
invalidates) could actually provide better performance for data
transfers due to the cache bursting available when caches are enabled.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
