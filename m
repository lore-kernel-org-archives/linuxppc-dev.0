Date: Sat, 31 Mar 2001 15:30:31 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: I-cache flushing on the 7400
Message-ID: <20010331153031.A10946@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I recently discovered that the following sequence

	LI_PHYS( r2,split_store_patch )
	stw     r4,0(r2)			// store instruction
	dcbst   0,r2				// Flush cache
	sync
	icbi    0,r2
	isync

	.... some instructions and then a rfi to split_store_patch ....
	rfi

split_store_patch:
	nop

did not work properly on a G4s (but it did work flawlessly on my G3).
To make the i-cache flush effective, I had to insert an extra
'sync' before the last isync. Consulting my Motorola manuals,
the recommended sequence for the 7400 (but not for the 750) did have
that extra sync. Looking at the 2.4.3-pre8 BK source, I discovered
the 'sync' was sometimes missing (in flush_icache_range and in a
few places in head.S). Shouldn't the sync really be added?

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
