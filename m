From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15833.45182.639413.720952@argo.ozlabs.ibm.com>
Date: Tue, 19 Nov 2002 14:31:10 +1100
To: Gabriel Paubert <paubert@iram.es>
Cc: joakim.tjernlund@lumentis.se, Tim Seufert <tas@mindspring.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
In-Reply-To: <3DD92C01.7080906@iram.es>
References: <IGEFJKJNHJDCBKALBJLLEEBFFIAA.joakim.tjernlund@lumentis.se>
	<3DD92C01.7080906@iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert writes:

> I don't know this code, whether it is correct or not depends on what you
> pass in r4. If it is invalidate_dcache_range(start, start+len), the code
> is correct since start+len is one byte beyond the buffer. If it is
> invalidate_dcache_range(first, last), then it is buggy. The former
> definition of parameters is more frequent in practice.

That is correct, the `stop' parameter is the address of the first byte
after the end of the range that you want invalidated.

> This said, the first instruction can be removed:
> _GLOBAL(invalidate_dcache_range)
>   	rlwinm	r3,r3,0,~(L1_CACHE_LINE_SIZE-1)

Huh?  I'm guessing you really mean to say:

	rlwinm	r3,r3,0,0,31-LG_L1_CACHE_LINE_SIZE

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
