Return-Path: <paubert@iram.es>
Received: from marchena.puc.rediris.es (marchena.puc.rediris.es
 [IPv6:2001:720:418:ca00::4])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B4CBD2C00A8
 for <linuxppc-dev@ozlabs.org>; Mon, 13 May 2013 23:13:04 +1000 (EST)
Date: Mon, 13 May 2013 15:12:37 +0200
From: Gabriel Paubert <paubert@iram.es>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Message-ID: <20130513131237.GA16647@visitor2.iram.es>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
 <1368441187.24723.38.camel@i7.infradead.org>
 <1368441493.24723.41.camel@i7.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368441493.24723.41.camel@i7.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 11:38:13AM +0100, David Woodhouse wrote:
> On Mon, 2013-05-13 at 11:33 +0100, David Woodhouse wrote:
> > 
> > On Mon, 2013-05-13 at 09:33 +0200, Gabriel Paubert wrote:
> > > Actually, I'd swap the two mr instructions to never
> > > have an instruction that uses the result from the
> > > previous one. 
> > 
> > Bad GCC. No biscuit.
> > 
> > Should we file a PR? 
> 
> Maybe not. If you tell it to tune for an in-order machine like Cell, it
> swaps them round. Although now I'm confused about which of POWER[567]
> were in-order:

It was Power6 IIRC. On this kind of fine point, don't rely too much
on what GCC produces.

> 
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32  | grep -B1 mr
> 	rlwimi 11,3,24,16,23
> 	mr 4,11
> 	mr 3,10
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 -mtune=cell | grep -B1 mr
> 	rlwimi 11,3,24,16,23
> 	mr 3,10
> 	mr 4,11
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 -mtune=power5 | grep -B1 mr
> 	rlwimi 11,3,24,16,23
> 	mr 3,10
> 	mr 4,11
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 -mtune=power6 | grep -B1 mr
> 	rlwimi 11,3,24,16,23
> 	mr 4,11
> 	mr 3,10
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 -mtune=power7 | grep -B1 mr
> 	rlwimi 11,3,24,16,23
> 	mr 4,11
> 	mr 3,10

I don't know of any processor in which putting the mr 3,10 first can cause stalls, so
even a generic tuning should put it first.

	Gabriel
