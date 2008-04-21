Return-Path: <heukelum@fastmail.fm>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by ozlabs.org (Postfix) with ESMTP id 58DF3DE188
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 23:07:15 +1000 (EST)
Message-Id: <1208783233.25773.1249008469@webmail.messagingengine.com>
From: "Alexander van Heukelum" <heukelum@fastmail.fm>
To: "Paul Mackerras" <paulus@samba.org>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <20080421191231.41a34aef.sfr@canb.auug.org.au>
	<20080421095102.GB1666@elte.hu>
	<1208776790.4613.1248992953@webmail.messagingengine.com>
	<18444.34002.74202.564600@cargo.ozlabs.ibm.com>
Subject: Re: linux-next: x86-latest/powerpc-next merge conflict
In-Reply-To: <18444.34002.74202.564600@cargo.ozlabs.ibm.com>
Date: Mon, 21 Apr 2008 15:07:13 +0200
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Apr 2008 22:13:06 +1000, "Paul Mackerras" <paulus@samba.org>
said:
> Alexander van Heukelum writes:
> > Powerpc would pick up an optimized version via this chain: generic fls64
> > ->
> > powerpc __fls --> __ilog2 --> asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r"
> > (x)).
> 
> Why wouldn't powerpc continue to use the fls64 that I have in there
> now?

In Linus' tree that would be the generic one that uses (the 32-bit)
fls():

static inline int fls64(__u64 x)
{
        __u32 h = x >> 32;
        if (h)
                return fls(h) + 32;
        return fls(x);
}

> > However, the generic version of fls64 first tests the argument for zero.
> > From
> > your code I derive that the count-leading-zeroes instruction for
> > argument zero
> > is defined as cntlzl(0) == BITS_PER_LONG.
> 
> That is correct.  If the argument is 0 then all of the zero bits are
> leading zeroes. :)

So... for 64-bit powerpc it makes sense to have its own implementation
and ignore the (improved) generic one and for 32-bit powerpc the generic
implementation of fls64 is fine. The current situation in linux-next
seems
optimal to me.

Greetings,
    Alexander

> Regards,
> Paul.
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - I mean, what is it about a decent email service?
