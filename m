From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15287.32258.397730.448586@igor.jsc.nasa.gov>
Date: Sun, 30 Sep 2001 15:18:10 -0500
To: linuxppc-dev@lists.linuxppc.org
Subject: flush_tlbs bug in arch/ppc/kernel/head.S ?
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In arch/ppc/kernel/head.S (for linuxppc_2_4) the "blt" branch in the
flush_tlbs procedure doesn't seem right.  If the intent is to
invalidate TLBs with effective addresses from 0x0000_0000 -
0x0400_0000, then the "blt" should be a "bgt".  Am I crazy/stupid ???

flush_tlbs:
	lis	r20, 0x40
1:	addic.	r20, r20, -0x1000
	tlbie	r20
	blt	1b    <--------- Shouldn't this be bgt ???
	sync
	blr


--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
