From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Pantelis Antoniou" <panto@intracom.gr>,
	<joakim.tjernlund@lumentis.se>
Cc: <acurtis@directvinternet.com>,
	"Tom Rini" <trini@kernel.crashing.org>,
	"Dan Malek" <dan@embeddededge.com>,
	"Paul Mackerras" <paulus@au1.ibm.com>,
	"Matt Porter" <porter@cox.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
Date: Wed, 11 Dec 2002 06:41:58 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFCEPEDPAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <3DF70C55.3010709@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >>m8xx_cpm_hostalloc(), if it is anything like the 8260 version,
> enables you
> >>to allocation memory from dual-port RAM. (which could be handy and/or
> >>required for certain CPM related operations) _va() and _pa()
> only work for
> >>main memory addresses. For all other address ranges the iopa()
> function must
> >>be used. (I hope this is helpful)
> >>

snip

>
> Each platform which is based on 8xx defines the amount of uncached
> memory that is expected
> to be used by it's drivers. It's not hard to make a rough estimation
> since most people
> that use the 8xx have very tight control of the hardware.
> We organize then the memory in a heap, which is able to do allocations and
> deallocations properly. That allows drivers that are loaded as modules
> to operate
> correctly and does not fragment (much) the memory.

I almost missed the context change here... Changing xxx_cpm_hostalloc() to
be consistent with other main memory allocation routines would probably be a
good thing. However there is still a need to manage the dual-port RAM, i.e.
xxx_cpm_dpalloc(), where this requirement is probably not practical. The
only way to make this happen is to force all memory regions to be contiguous
both virtually and physically to enable the "simpler" address translation
routines to function properly.

As for a iova() routine, ioremap() will return a previously configured
virtual address when asked to map the same physical memory space.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
