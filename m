Message-Id: <5.1.0.14.2.20030416130102.02b25178@mail.ebshome.net>
Date: Wed, 16 Apr 2003 13:05:24 -0700
To: Vladimir Gurevich <vag@paulidav.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Are big pages really been used?
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3E9D9A19.3010106@paulidav.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Validmir,

At 10:59 AM 4/16/2003, you wrote:
>Some time ago, during the discussion about module efficiency,
>Dan Malek wrote the following:
>
>>The other thing people probably don't realize is the added overhead
>>of using modules.  They are placed in dynamically allocated memory,
>>wasting memory space and causing addtional MMU overhead on processors
>>where you really want to minimize such things.  When compiled into the
>>kernel and covered with a large page mapping, you are likely to see
>>lower interrupt latencies and less jitter, along with a more compact
>>memory footprint.
>
>I was looking at TLB entries on my 405GP-based system running 2.4.17-based
>kernel by executing "tlb 0 63" command in BDI-2000 and could not see any
>big page mappings. All page entries were 4K in size (and I could see many
>that were clearly covering portions of kernel code)
>
>My questions are:
>   a) Does the abovementioned quote apply to 4xx CPUs

It definitely applies to 440GP, current port uses tlb 62 and 63 (16M)
to map the kernel.

For 40x you can try to use "Pinned Kernel TLB" option in "General setup"
(you have to enable "Prompt for advanced kernel configuration options" in
"Code maturity level options".
Although I don't know whether it really works :)

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
