From: acurtis@directvinternet.com
Reply-To: <acurtis@directvinternet.com>
To: "Tom Rini" <trini@kernel.crashing.org>,
	"Pantelis Antoniou" <panto@intracom.gr>
Cc: "Dan Malek" <dan@embeddededge.com>,
	"Paul Mackerras" <paulus@au1.ibm.com>,
	<joakim.tjernlund@lumentis.se>, "Matt Porter" <porter@cox.net>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Regarding consistent_alloc
Date: Tue, 10 Dec 2002 19:52:40 -0800
Message-ID: <NCBBIINEHIPFGJPLBEIFMEOMDPAA.acurtis@directvinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20021210174911.GB14786@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > 2. I have a requirement to have my drivers loaded as modules.
> > m8xx_cpm_hostalloc has a very simplistic implementation, which
> > makes it unsuitable for something like that. I have some patches
> > that fix both m8xx_cpm_hostalloc and 8xx_cpm_dpalloc by implementing
> > a proper heap, with free space management and coalescing.
> > What is the proper way to push them, and to whom?
>
> <buck passing mode=on>Dan Malek still knows the most about the
> 8xx-specific portions of the kernel, so he should really speak up here
> when he gets a moment</buck passing>

m8xx_cpm_hostalloc(), if it is anything like the 8260 version, enables you
to allocation memory from dual-port RAM. (which could be handy and/or
required for certain CPM related operations) _va() and _pa() only work for
main memory addresses. For all other address ranges the iopa() function must
be used. (I hope this is helpful)

With that said, I would be interested in your modifications if you are
willing to share.

THX


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
