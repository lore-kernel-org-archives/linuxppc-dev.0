Message-ID: <19991216040825.21140.qmail@web306.mail.yahoo.com>
Date: Wed, 15 Dec 1999 20:08:25 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: linuxppc embedded boot problems.
To: bsimon@ctam.com.au
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> This code has statements to invalidate the cache
> before jumping to the
> kernel. Is this the same as making sure lines are
> not "locked" in the
> cache ?

No, lines which have been locked into cache can only
be removed by sending an "unlock line" or "unlock all"
command to the IC_CSR register.  "Invalidate all" does
not remove "locked" lines. 


> I have boot code which does basic initialisation of
> the 860
> (chipselects, DRAM, etc).  This code will eventually
> jump to the start
> of the "kernel loader".  Do I also have to
> invalidate the caches just
> before jumping to the kernel loader ?  This
> currently isn't done.  BTW.
> All caches are disabled at this stage so I guess it
> shouldn't matter.
> 

If caches are disabled, it's a non-issue.  We wrote
our own boot monitor for a custom 823 board
(originally running non-linux code), copying code from
a slow flash into fast SDRAM and swapping chip
selects.  If you are running in a region of memory
with I-Cache enabled, and you copy new code into that
memory, then invalidating the I-cache is necessary.

Brian

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
