Message-ID: <002c01c0a202$ed6ecdb0$5ef1d092@chn.agilent.com>
From: "kerler" <kerler@mailandnews.com>
To: "David Edelsohn" <dje@watson.ibm.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <200102261835.NAA26566@mal-ach.watson.ibm.com>
Subject: Re: dynamic modification exception handler 
Date: Thu, 1 Mar 2001 11:49:06 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

The last codes I used is in the following.
The "i < len + start + CACHE_BLOCK_SIZE" in for-circle is for the situation
that the range of memory may not align with cache block. This is one of the
reason that my codes does not work well.

thanks very much.

#define CACHE_BLOCK_SIZE 0x20
void mdb_flush_cache (const unsigned int start, const unsigned int len)
{
    unsigned int i;
    for ( i = start ; i < len + start + CACHE_BLOCK_SIZE ; i +=
CACHE_BLOCK_SIZE )
    {
        __asm__ __volatile__ ("dcbf 0,%0"::"r"((void*)i));
    }
    __asm__ __volatile("sync");
    for ( i = start ; i < len + start + CACHE_BLOCK_SIZE ; i +=
CACHE_BLOCK_SIZE )
    {
        __asm__ __volatile__ ("icbi 0,%0"::"r"((void*)i));
    }
    __asm__ __volatile("sync;isync;");
}


----- Original Message -----
From: David Edelsohn <dje@watson.ibm.com>
To: kerler <kerler@mailandnews.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sent: Tuesday, February 27, 2001 2:35 AM
Subject: Re: dynamic modification exception handler


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


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
