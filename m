Message-ID: <3DD992E1.6040000@iram.es>
Date: Tue, 19 Nov 2002 02:24:49 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Tim Seufert <tas@mindspring.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
References: <IGEFJKJNHJDCBKALBJLLMEBJFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund wrote:

> hmm, I think you are right. The practice seems to be invalidate_dcache_range(start, start+len).
> But then the interface should be invalidate_dcache_range(start, len) instead, IMHO.
> I guess it's too late to change it now.

Probably. I don't know why it is this way since it would in most cases be
better to do the start+len in the subroutine, saving almost always one
instruction in the caller.

>
>
>>This said, the first instruction can be removed:
>>_GLOBAL(invalidate_dcache_range)
>>  	rlwinm	r3,r3,0,~(L1_CACHE_LINE_SIZE-1)
>>  	subf	r4,r3,r4
>>  	add	r4,r4,L1_CACHE_LINE_SIZE-1

of course this instruction should be an immediate form: addi and not add!

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
