Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E25842C0087
 for <linuxppc-dev@ozlabs.org>; Mon, 13 May 2013 21:00:37 +1000 (EST)
In-Reply-To: <1368441493.24723.41.camel@i7.infradead.org>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <9813.1368428999@ale.ozlabs.ibm.com>
 <1368441187.24723.38.camel@i7.infradead.org>
 <1368441493.24723.41.camel@i7.infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc: provide __bswapdi2
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OFF1D09F16.1BCB0BD6-ONC1257B6A.003B73C6-C1257B6A.003BB127@transmode.se>
Date: Mon, 13 May 2013 12:51:59 +0200
Content-Type: text/plain; charset="US-ASCII"
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

"Linuxppc-dev" 
<linuxppc-dev-bounces+joakim.tjernlund=transmode.se@lists.ozlabs.org> 
wrote 2013/05/13 12:38:13:
> 
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
> 
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32  | grep 
-B1 mr
>    rlwimi 11,3,24,16,23
>    mr 4,11
>    mr 3,10
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 
-mtune=cell | grep -B1 mr
>    rlwimi 11,3,24,16,23
>    mr 3,10
>    mr 4,11
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 
-mtune=power5 | grep -B1 mr
>    rlwimi 11,3,24,16,23
>    mr 3,10
>    mr 4,11
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 
-mtune=power6 | grep -B1 mr
>    rlwimi 11,3,24,16,23
>    mr 4,11
>    mr 3,10
> [dwmw2@i7 ~]$ powerpc64-linux-gnu-gcc -O2 -S -o- bswapdi2.c -m32 
-mtune=power7 | grep -B1 mr
>    rlwimi 11,3,24,16,23
>    mr 4,11
>    mr 3,10

A bit rusty on the ppc asm but can you not remove the mr completely:
                 rlwimi 10,4,24,16,23
                 rlwimi 11,3,24,16,23
                 mr 4,11
                 mr 3,10
to
                 rlwimi 4,4,24,16,23
                 rlwimi 3,3,24,16,23

 Jocke
