Return-Path: <scottwood@freescale.com>
Message-ID: <48ECF08F.7000400@freescale.com>
Date: Wed, 08 Oct 2008 12:40:31 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dominik Bozek <domino@mikroswiat.pl>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>
In-Reply-To: <48ECC611.3030309@mikroswiat.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dominik Bozek wrote:
> I have done a test of memcpy() and __copy_tofrom_user() on the mpc8313.
> And the major conclusion is that __copy_tofrom_user is more efficient
> than memcpy. Sometimes about 40%.
> 
> If I good understand, the memcpy() just copy the data, while
> __copy_tofrom_user() take care if the memory wasn't swapped out.

There's not much overhead in dealing with bad pointers; it's mostly 
fixup after the fault.

The performance difference most likely comes from the fact that copy 
to/from user can assume that the memory is cacheable, while memcpy is 
occasionally used on cache-inhibited memory -- so dcbz isn't used.  We 
may be better off handling the alignment fault on those occasions, and 
we should use dcba on chips that support it.

I'm not sure why we don't use dcbt in memcpy(), as it's just ignored if 
the memory is cache-inhibited.

> BTW. The memcpy() maybe optimized as it is on i32 when the size of block
> is known at compile time.

Yes, that would be nice.

-Scott
