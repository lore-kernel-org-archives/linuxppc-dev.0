Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZ2Sv4wrtzDvys
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 15:29:35 +1100 (AEDT)
Date: Thu, 8 Dec 2016 15:29:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Sant
 <sachinp@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>, Ard
 Biesheuvel <ard.biesheuvel@linaro.org>, Balbir Singh
 <bsingharora@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linus
 <torvalds@linux-foundation.org>
Subject: Re: linux-next: Tree for Dec 7 (kallsyms failure)
Message-ID: <20161208152935.325120da@canb.auug.org.au>
In-Reply-To: <90c66e73-f7c9-3d48-04b7-0985cce53382@infradead.org>
References: <20161207172432.184970d7@canb.auug.org.au>
 <13d83759-40d3-593b-b53f-f3e75fb05b7a@infradead.org>
 <20161208105607.68810cae@canb.auug.org.au>
 <90c66e73-f7c9-3d48-04b7-0985cce53382@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

On Wed, 7 Dec 2016 18:30:57 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/07/16 15:56, Stephen Rothwell wrote:
> > 
> > On Wed, 7 Dec 2016 15:42:32 -0800 Randy Dunlap <rdunlap@infradead.org> wrote:  
> >>
> >> I started seeing this yesterday (2016-1206).
> >> This is on x86_64.
> >>
> >> Anybody know about it?
> >>
> >> kallsyms failure: relative symbol value 0xffffffff81000000 out of range in relative mode  
> > 
> > I got a similar failure starting a few days ago on my powerpc
> > allyesconfig build.  I was assuming that it was PowerPC specific, but
> > noone has found a cause yet.
> >   
> 
> It may just be an invalid randconfig.  I modified scripts/kallsyms.c and
> I see this message:
> kallsyms failure: relative symbol value 0xffffffff81000000 [symbol: Tstartup_64] out of range in relative mode
> 
> and it makes sense that startup_64 would (or could) be at 0xffffffff81000000...
> especially since CONFIG_PHYSICAL_START=0x1000000 and
> (from Documentation/x86/x86_64/mm.txt)
> ffffffff80000000 - ffffffff9fffffff (=512 MB)  kernel text mapping, from phys 0
> 
> 
> Ard, what do you think about this?

The similar failure I saw in the powerpc allyesconfig build

kallsyms failure: relative symbol value 0xc000000000000000 out of range in relative mode

was caused by commit

  8ab2ae655bfe ("default exported asm symbols to zero")

which has been reverted in Linus' tree today.

-- 
Cheers,
Stephen Rothwell
