Message-ID: <3DF22784.7040502@embeddededge.com>
Date: Sat, 07 Dec 2002 11:53:24 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
	Matt Porter <porter@cox.net>, Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <20021206085909.B17918@home.com><IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se> <15857.15826.513311.884408@argo.ozlabs.ibm.com> <003c01c29def$9b3d5df0$0300a8c0@jockeXP>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Is consistent_alloc really needed?

YES.

> .... All uses I have seen in the kernel for the 8xx CPU can be solved with
> a kmalloc....

The cpm_hostalloc() solves a different problem.  It is used to allocate
small non-cached object so you don't need the overhead of the cache
management functions every time you want to do something like write a byte
to a uart.  It is specific to the CPM on the 8xx, so you can apply the
proper assumptions about io mapping for a lightweight and efficient solution.

I've constantly criticized the Linux VM implementation for having different
functions and semantics for different VM spaces, and I'm always told something
to the effect "...it's the Linux way to make it efficient..."  So, I did
the same thing for 8xx and CPM.  There are lots of places in the Linux VM
where you can apply only certain operations to certain VM objects.  It
seems I've kept up the spirit :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
