Date: Sat, 31 Mar 2001 19:51:55 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: I-cache flushing on the 7400
In-Reply-To: <20010331153031.A10946@ibrium.se>
Message-ID: <Pine.HPX.4.10.10103311944390.18988-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 31 Mar 2001, Samuel Rydh wrote:

>
> I recently discovered that the following sequence
>
> 	LI_PHYS( r2,split_store_patch )
> 	stw     r4,0(r2)			// store instruction
> 	dcbst   0,r2				// Flush cache
> 	sync
> 	icbi    0,r2
> 	isync
>
> 	.... some instructions and then a rfi to split_store_patch ....
> 	rfi
>
> split_store_patch:
> 	nop
>
> did not work properly on a G4s (but it did work flawlessly on my G3).
> To make the i-cache flush effective, I had to insert an extra
> 'sync' before the last isync. Consulting my Motorola manuals,
> the recommended sequence for the 7400 (but not for the 750) did have
> that extra sync. Looking at the 2.4.3-pre8 BK source, I discovered
> the 'sync' was sometimes missing (in flush_icache_range and in a
> few places in head.S). Shouldn't the sync really be added?

It should, while actually the isync does not seem necessary since rfi
is a context synchronizing instruction (rfi and sc include implicitly the
equivalent of an isync).

As a side note, this or something similar might have been the cause of a
recently reported problem with 7450 which crash when enabling MaxBUS but
work in traditional 60x bus mode. The reordering of bus operations which
takes place with maxbus makes this kind of bug much more likely to become
visible.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
