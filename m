Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17189.15274.167010.792875@cargo.ozlabs.ibm.com>
Date: Mon, 12 Sep 2005 18:26:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Liu Fred-a18596 <fred.liu@motorola.com>
In-Reply-To: <AD266326EC54D9118CE700110A9E2BE2069F5B90@zch07exm01.corp.mot.com>
References: <AD266326EC54D9118CE700110A9E2BE2069F5B90@zch07exm01.corp.mot.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: A bug in div64.s
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Liu Fred-a18596 writes:

> I found there was a bug in arch/ppc/lib/div64.s.
> 
> The original div64_32() function would produce a zero divide
> exception in case of div64_32(0x100000000, 0xFFFFFFFF).

Thanks for pointing this out.

> Here is the bug-fixed new div64_32()function.

A patch would have been more helpful, so we could see immediately what
you have changed.  Also, notes (or outlook or whatever mail program
you are using) has completely munged all the spacing of the code you
posted.

Anyway, I have some comments on your proposed fix:

>                addc.      r9,r4,r10 # rounding up (so the estimate cannot

I understand that the add that I had here can overflow in the case you
pointed out, so we need to preserve the carry.  But why did you use
"addc." rather than "addc" ?

>                mfxer   r12                    #
> 
>                rlwinm. r12, r12, 3, 31, 31    # XER[CA]
> 
>                cmpwi   r12, 1                 # carry ?
> 
>                bne     5f
> 
>                ori     r9, r9, 0x1            # carry !

I think just "addze r9,r9" would do instead of these 5 instructions,
wouldn't it?

Paul.
