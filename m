Message-ID: <3DF70C55.3010709@intracom.gr>
Date: Wed, 11 Dec 2002 11:58:45 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: acurtis@directvinternet.com,
	Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <IGEFJKJNHJDCBKALBJLLAELIFIAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLAELIFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>>
>>>>2. I have a requirement to have my drivers loaded as modules.
>>>>m8xx_cpm_hostalloc has a very simplistic implementation, which
>>>>makes it unsuitable for something like that. I have some patches
>>>>that fix both m8xx_cpm_hostalloc and 8xx_cpm_dpalloc by implementing
>>>>a proper heap, with free space management and coalescing.
>>>>What is the proper way to push them, and to whom?
>>>>
>
>It would be great if the new fucntions could work with micropatch.c as well.
>If the microcode is loaded, then those microcode area should be reserved and
>not used by 8xx_cpm_dpalloc.
>
As a matter of fact, this is another patch that I can submit
that take into account the area left by the micropatches so that the
dpalloc functions can utilize every last byte of the DPRAM.

At the moment I'm swamped with work, so it will take a couple of
days to clean things up and submit them.

>
>>><buck passing mode=on>Dan Malek still knows the most about the
>>>8xx-specific portions of the kernel, so he should really speak up here
>>>when he gets a moment</buck passing>
>>>
>>m8xx_cpm_hostalloc(), if it is anything like the 8260 version, enables you
>>to allocation memory from dual-port RAM. (which could be handy and/or
>>required for certain CPM related operations) _va() and _pa() only work for
>>main memory addresses. For all other address ranges the iopa() function must
>>be used. (I hope this is helpful)
>>
>
>_va() and _pa() used to work for m8xx_cpm_hostalloc() and I like that better. _pa()
>is much cheaper than iopa() and there is no iova()(I think).
>
>Why was m8xx_cpm_hostalloc() changed to use consistent_alloc()? alloc_bootmem_pages()
>should still work(I am guessing)
>
>BTW, m8xx_setup_arch() still calls alloc_bootmem_pages() and
>the new m8xx_cpm_reset() does not take a ptr argument, but m8xx_setup_arch()
>still calls m8xx_cpm_reset() with cpm_page as argument.
>
I think it's safe to assume that there is large amount of confussion at
this subject.
FWIW I dislike the use of iopa(), and I would be forced to duplicate the
code of
consistent_alloc() class of functions in my tree.

Could we at least have a m8xx_cpm_hostalloc that works as expected?
How about the following approach:

Each platform which is based on 8xx defines the amount of uncached
memory that is expected
to be used by it's drivers. It's not hard to make a rough estimation
since most people
that use the 8xx have very tight control of the hardware.
We organize then the memory in a heap, which is able to do allocations and
deallocations properly. That allows drivers that are loaded as modules
to operate
correctly and does not fragment (much) the memory.

How about it?

>
> Jocke
>
>
>
>

P.S. I have posted by QMC driver to the list, but there has been no
response.
Please if anyone is interested in the QMC, give me some kind of feedback.
Even negative feedback is OK.

Thanks

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
