Message-Id: <5.1.0.14.2.20030715164431.03826b28@mail.ebshome.net>
Date: Tue, 15 Jul 2003 16:50:22 -0700
To: Paul Mackerras <paulus@samba.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: RE: [RFC] consistent_sync and non L1 cache line aligned buffers
Cc: <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <16148.36759.265625.268038@nanango.paulus.ozlabs.org>
References: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
 <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:34 PM 7/15/2003, Paul Mackerras wrote:
>If you think about it, you will see that if you are doing DMA to an
>unaligned buffer, and some other unrelated part of the kernel is
>accessing another part of the cache line, you are in trouble no matter
>what sequence of cache flushes/invalidates/whatever you do.
>
>In other words, the driver MUST own the entire extent of all the cache
>lines that overlap the DMA buffer.  There really is no other solution
>on cache-incoherent machines, assuming you want to allow DMA to
>proceed in parallel with the CPU executing other arbitrary code, which
>is really the whole point of DMA.
>
>How to achieve that has been the subject of much debate.  It's clear
>that tweaks to consistent_sync won't do it, though.

So, at least adding an assertion to consistent_sync would be useful
debugging feature.

E.g. we already have BUG() in consistent_alloc when it called from
interrupt context :)

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
