Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYp2p5P7SzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 14:09:22 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id pp5so134820pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 21:09:22 -0700 (PDT)
Message-ID: <1473826155.2554.6.camel@gmail.com>
Subject: Re: [PATCH v14 00/15] selftests/powerpc: Add ptrace tests for ppc
 registers
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, Rashmica Gupta <rashmicy@gmail.com>
Date: Wed, 14 Sep 2016 14:09:15 +1000
In-Reply-To: <20160912170105.GA17588@simonLocalRHEL7.x64>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473745750.15800.1.camel@gmail.com>
 <20160912170105.GA17588@simonLocalRHEL7.x64>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-13 at 01:01 +0800, Simon Guo wrote:
> Hi Cyril,
> On Tue, Sep 13, 2016 at 03:49:10PM +1000, Cyril Bur wrote:
> > 
> > Thanks for putting the effort in to get these merged! I have a few
> > remarks that apply to more than one patch which I'll say here.
> > 
> > I'm not sure #defining the TM instructions as .long for the
> > selftests
> > is useful. Compilers these days know about the instructions
> > 'tbegin.'
> > 'tsuspend.' and the like, I would question anyone using a compiler
> > old
> > enough not to know about these...
> I agree. But let me check with original author Anshuman firstly.
> 

Great!

I'll send through my other emails that I actually wrote before this
one, please ignore if I've repeated myself.

> > 
> > 
> > There are a few assembly fpu register load functions that could be
> > consolidated into those in math/ and even some in tm/
> Will rework that.
> 

Thanks

> > 
> > 
> > Doing while(ptr); to wait for another thread should be 
> > 
> > while(ptr)
> >     asm volatile("" : : : "memory");
> > 
> > Documentation/volatile-considered-harmful.txt for reasons why.
> > Even knowing this I did it your way without thinking in a selftest
> > I
> > wrote doing similar things and it turns out that it didn't work
> > [the
> > way we both expect it would].
> You are right.
> 

Thanks

> > 
> > 
> > Having said all that, I'm aware that these are selftests and this
> > series could be nicer but I won't lose any sleep if they were
> > merged
> > almost as is. Thanks for your work!
> > 
> > Finally, they didn't compile for me, I did a git rebase --exec with
> > my
> > build scripts and:
> > 
> > selftests/powerpc: Add ptrace tests for EBB
> > 	[snip]
> > 	*** No rule to make target 'ptrace.S', needed by 'ptrace-ebb'.
> > (that appears fixed by subsequent patch)
> > 
> > selftests/powerpc: Add ptrace tests for GPR/FPR registers
> > 	Seems to have failed horribly and those problems continue...
> > 
> > I applied these to powerpc-next at:
> > commit c6935931c1894ff857616ff8549b61236a19148f
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Sun Sep 4 14:31:46 2016 -0700
> > 
> >     Linux 4.8-rc5
> > 
> > Should I have based on something else?
> I didn't reproduce the latter error and I also applied on c69359.
> My build script is only one line:
> make -C tools/testing/selftests TARGETS=powerpc 1>/dev/null
> 

I do the same except without TARGETS=powerpc (I test with all the
selftests). The difference I suspect is that I'm cross compiling and
the #include <linux/elf.h> in ptrace.h is the problem. On my x86
machine this includes an x86 version which has different defines.


> Did I miss anything with your build script?
> Anyway I need to fix that.

Its messy but I think the accepted solution for kselftests is to do:

#include "../../../../../usr/include/linux/elf.h"

which I believe will get the headers generated for the target by `make
headers_install` and therefore should match that for which the
kselftests are being compiled.

> 
> Thanks for the sharing. Most are good comments and I will rework
> that.
> 
> BR,
> - Simon
