Date: Fri, 14 Jun 2002 08:39:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>, Dan Malek <dan@embeddededge.com>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: consistent_free()
Message-ID: <20020614153954.GL13541@opus.bloom.county>
References: <20020614042928.GK26146@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614042928.GK26146@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 02:29:28PM +1000, David Gibson wrote:

> In attempting to make consistent_alloc/free() work sensibly on
> processors which are cache coherent I ran into a problem.

My only concern is that is it a good idea to make a 'consistent_alloc'
and 'consistent_free' functions for  cache-cohernet processors, which
aren't doing what the name implies?  The only possible caller of these
are pci_alloc_consistent and pci_free_consistent, in a cache-cohernet
processor.

[snip]
> I suggest we change consistent_free() to take the virtual addresss,
> size and the physical address (dma_addr_t), which will make our
> consistent_free() match the one on ARM.  I know we don't need the
> third argument in any existing situation.

I wonder if ARM couldn't just call vfree() like we do..

In fact, I wonder why consistent_alloc/free seem to have some minor
differences (__get_free_pages vs alloc_pages seems to be the only real
difference aside from style things).  Dan?  Can we get some more insight
into the workings of your mind? :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
