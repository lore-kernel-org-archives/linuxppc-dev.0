Message-ID: <3E70D076.7030507@embeddededge.com>
Date: Thu, 13 Mar 2003 13:39:50 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question on howto use invalidate_dcache_range
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de>	<3E70B17E.9090507@embeddededge.com>	<004501c2e989$a10a66c0$020120b0@jockeXP>	<3E70C88B.70004@embeddededge.com> <52k7f3t9ic.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Roland Dreier wrote:

> Is the following not possible:

That's a problem in any system design.  Consider what would happen
if you had an architecture that was hardware cache coherent.
Software that writes to buffers at any time that is also a
DMA target will result in unpredictable behavior.  The system
design for what you described requires a higher level of
shared memory software synchronization as it is exactly the
unpredictability that has to be prevented in any SMP design.

What you described is a real problem with cache unaligned
buffers that has to be avoided in systems that do not have
hardware cache coherency.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
