Message-ID: <3DF75343.3060005@intracom.gr>
Date: Wed, 11 Dec 2002 17:01:23 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: acurtis@directvinternet.com
Cc: joakim.tjernlund@lumentis.se,
	Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <NCBBIINEHIPFGJPLBEIFCEPEDPAA.acurtis@directvinternet.com>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFCEPEDPAA.acurtis@directvinternet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


acurtis@directvinternet.com wrote:

>>>>m8xx_cpm_hostalloc(), if it is anything like the 8260 version,
>>>>
>>enables you
>>
>>>>to allocation memory from dual-port RAM. (which could be handy and/or
>>>>required for certain CPM related operations) _va() and _pa()
>>>>
>>only work for
>>
>>>>main memory addresses. For all other address ranges the iopa()
>>>>
>>function must
>>
>>>>be used. (I hope this is helpful)
>>>>
>>>>
>
>snip
>
>
>>Each platform which is based on 8xx defines the amount of uncached
>>memory that is expected
>>to be used by it's drivers. It's not hard to make a rough estimation
>>since most people
>>that use the 8xx have very tight control of the hardware.
>>We organize then the memory in a heap, which is able to do allocations and
>>deallocations properly. That allows drivers that are loaded as modules
>>to operate
>>correctly and does not fragment (much) the memory.
>>
>
>I almost missed the context change here... Changing xxx_cpm_hostalloc() to
>be consistent with other main memory allocation routines would probably be a
>good thing. However there is still a need to manage the dual-port RAM, i.e.
>xxx_cpm_dpalloc(), where this requirement is probably not practical. The
>only way to make this happen is to force all memory regions to be contiguous
>both virtually and physically to enable the "simpler" address translation
>routines to function properly.
>
>As for a iova() routine, ioremap() will return a previously configured
>virtual address when asked to map the same physical memory space.
>
>
>
>
I'm sorry but I don't follow you there. The sole reason for the existance
of xxx_cpm_hostalloc() and xxx_cpm_dpalloc() is to provide support to
the drivers that deal with the CPM. I don't see why is there any need
to be consistent with any other allocation routines in the kernel.

Lets assume that we force the memory returned by the xxx_cpm_hostalloc()
and xxx_cpm_dpalloc() routines to return contiguous memory both
virtually and physically. Is there any negative impact?
Every driver out there expects precisely that.

Regarding the dual-ported memory, keep in mind that there are members
of the 8xx family that are very constrained.
Better allocation routines will allow us to utilise even the gaps
left between configured parameter areas. Yes it is horrible
but that's the way that the hardware is designed.

As I already mentioned, I have some patches that fix IMHO these
problems. Allow me some time to clean up and I will post them.

Regards

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
