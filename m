To: Dan Malek <dan@embeddededge.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question on howto use invalidate_dcache_range
References: <FCEAKDJJAPHPLJFINDAJCELACOAA.Stephan.Linke@epygi.de>
	<3E70B17E.9090507@embeddededge.com>
	<004501c2e989$a10a66c0$020120b0@jockeXP>
	<3E70C88B.70004@embeddededge.com>
From: Roland Dreier <roland@topspin.com>
Date: 13 Mar 2003 10:19:07 -0800
In-Reply-To: <3E70C88B.70004@embeddededge.com>
Message-ID: <52k7f3t9ic.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Joakim> Yes, but you still need to invalidate the buffer before
    Joakim> also or invalidate it when the buffer is freed which may
    Joakim> be possible if you are using your own buffer mgmt.

    Dan> Why?

Is the following not possible:

  CPU has a dirty cache line inside the buffer
  Driver tells device to start DMA
  Device finishes DMA
  CPU writes back dirty cache line
  Driver gets notification that DMA completed
  Driver invalidates cache for buffer

The invalidate above is too late: the data is already corrupted by the
write back of the dirty cache.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
