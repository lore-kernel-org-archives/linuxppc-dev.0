Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3FB9A77C.3030101@kienhoefer.com>
Date: Mon, 17 Nov 2003 21:00:44 -0800
From: Juergen Kienhoefer <juergen@kienhoefer.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cache coherence problem
References: <3FB972E8.5090701@kienhoefer.com> <1069122238.7168.63.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Guys,
Thank you very much for the ideas.
Basically, what I need to do is:
dcbst
sync
iccci
sync
isync
for every 32 bytes of the memory block I put code in.
Right?
Cheers
Juergen


Benjamin Herrenschmidt wrote:

>On Tue, 2003-11-18 at 12:16, Juergen Kienhoefer wrote:
>
>
>>Guys,
>>Look at the folloging test program. It mmaps memory, puts some
>>instructions in it and executes it.
>>Sometimes it works, sometimes it crashes with illegal instruction.
>>This smells like cache problems.
>>Should the kernel clean the instruction cache for these addresses
>>in mmap system call?
>>Thanks for any thoughts!
>>Juergen
>>
>>
>
>It's your duty to ensure cache coherency. Actually, the kernel
>will eventually clean the icache for newly mapped in blank pages,
>but it will certainly not enforce flush of your writes to memory.
>
>You need to first flush the data cache to memory using dcbf or
>dcbst, then sync for this to complete, then invalidate the
>instruction cache, sync and isync.
>
>Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
