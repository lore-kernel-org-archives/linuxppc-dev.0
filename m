Message-ID: <01ef01c0a062$a80939f0$5ef1d092@chn.agilent.com>
From: "kerler" <kerler@mailandnews.com>
To: "David Edelsohn" <dje@watson.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <200102261835.NAA26566@mal-ach.watson.ibm.com>
Subject: Re: dynamic modification exception handler 
Date: Tue, 27 Feb 2001 10:08:52 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I add sync between icbi and isync. But the executed codes are still the
stale codes. Is cache coherence related with address translation of MMU?

-----------method 2----------
static inline void store_inst(void *p)
{
    asm volatile ("dcbst 0,%0; sync; icbi 0,%0; sync; isync" : : "r" (p));
}
void mdb_flush_cache (const unsigned int start, const unsigned int len)
{
    unsigned int i;
    for ( i = start ; i <= len + start ; i ++ )
    {
        store_inst((void*)start);
    }
}
------------end of method 2------

----- Original Message -----
From: David Edelsohn <dje@watson.ibm.com>
To: kerler <kerler@mailandnews.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sent: Tuesday, February 27, 2001 2:35 AM
Subject: Re: dynamic modification exception handler


>
> The suggested sequence for 604 and 604-derived processors is:
>
>      dcbst (or dcbf)          ;# flush data block to memory
>      sync                     ;# ensure flush made it to memory
>      icbi                     ;# invalidate block from icache
>      sync                     ;# wait for icbi to be globally performed
>      isync                    ;# refetch instructions
>
> The dcbst must be performed before the icbi, because otherwise the
> processor instruction prefetch mechanism could refetch the (stale) block
> from memory before the dcbst/dcbf has actually been written back to
> memory.  The sync between them is required for the same reason, because
> icbi could be performed locally before the dcbst has sent the block to
> memory.
>
> The dcbst/sync/icbi sequence can be batched up to amortize the
> cost of the sync operations, but it should be written so all the dcbst's
> are performed, then a sync, then all the icbi's:
>
>      mr        r5, r3
>      mtctr     blocks
> $1:
>      dcbst     r0, r5
>      addi      r5, r5, 32
>      bdnz      $1
>      sync
>      mr        r5, r3
>      mtctr     blocks
> $2:
>      icbi      r0, r5
>      addi      r5, r5, 32
>      bdnz      $2
>
>      sync
>      isync
>
>
> David
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
