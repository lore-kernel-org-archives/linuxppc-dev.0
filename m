Message-ID: <3DD9CD90.7080901@iram.es>
Date: Tue, 19 Nov 2002 06:35:12 +0100
From: Gabriel Paubert <paubert@iram.es>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: joakim.tjernlund@lumentis.se, Tim Seufert <tas@mindspring.com>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: csum_partial() and csum_partial_copy_generic() in badly optimized?
References: <IGEFJKJNHJDCBKALBJLLEEBFFIAA.joakim.tjernlund@lumentis.se>	<3DD92C01.7080906@iram.es> <15833.45182.639413.720952@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> Gabriel Paubert writes:
>
>
>>I don't know this code, whether it is correct or not depends on what you
>>pass in r4. If it is invalidate_dcache_range(start, start+len), the code
>>is correct since start+len is one byte beyond the buffer. If it is
>>invalidate_dcache_range(first, last), then it is buggy. The former
>>definition of parameters is more frequent in practice.
>
>
> That is correct, the `stop' parameter is the address of the first byte
> after the end of the range that you want invalidated.
>
>
>>This said, the first instruction can be removed:
>>_GLOBAL(invalidate_dcache_range)
>>  	rlwinm	r3,r3,0,~(L1_CACHE_LINE_SIZE-1)
>
>
> Huh?  I'm guessing you really mean to say:
>
> 	rlwinm	r3,r3,0,0,31-LG_L1_CACHE_LINE_SIZE


No, since a long time gas admits a special syntax of rlwinm and friends
with only four parameters: instead of 2 bit numbers giving the first and
last bit of the mask, you simply write the mask value. Very handy when
writing assembly code.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
