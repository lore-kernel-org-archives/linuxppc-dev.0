Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNW53rxFzDrp3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 21:58:57 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so9542478pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 04:58:57 -0700 (PDT)
Date: Tue, 13 Sep 2016 01:01:05 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>
Subject: Re: [PATCH v14 00/15] selftests/powerpc: Add ptrace tests for ppc
 registers
Message-ID: <20160912170105.GA17588@simonLocalRHEL7.x64>
References: <1473665605-11890-1-git-send-email-wei.guo.simon@gmail.com>
 <1473745750.15800.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1473745750.15800.1.camel@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,
On Tue, Sep 13, 2016 at 03:49:10PM +1000, Cyril Bur wrote:
> Thanks for putting the effort in to get these merged! I have a few
> remarks that apply to more than one patch which I'll say here.
> 
> I'm not sure #defining the TM instructions as .long for the selftests
> is useful. Compilers these days know about the instructions 'tbegin.'
> 'tsuspend.' and the like, I would question anyone using a compiler old
> enough not to know about these...
I agree. But let me check with original author Anshuman firstly.

> 
> There are a few assembly fpu register load functions that could be
> consolidated into those in math/ and even some in tm/
Will rework that.

> 
> Doing while(ptr); to wait for another thread should be 
> 
> while(ptr)
>     asm volatile("" : : : "memory");
> 
> Documentation/volatile-considered-harmful.txt for reasons why.
> Even knowing this I did it your way without thinking in a selftest I
> wrote doing similar things and it turns out that it didn't work [the
> way we both expect it would].
You are right.

> 
> Having said all that, I'm aware that these are selftests and this
> series could be nicer but I won't lose any sleep if they were merged
> almost as is. Thanks for your work!
> 
> Finally, they didn't compile for me, I did a git rebase --exec with my
> build scripts and:
> 
> selftests/powerpc: Add ptrace tests for EBB
> 	[snip]
> 	*** No rule to make target 'ptrace.S', needed by 'ptrace-ebb'.
> (that appears fixed by subsequent patch)
> 
> selftests/powerpc: Add ptrace tests for GPR/FPR registers
> 	Seems to have failed horribly and those problems continue...
> 
> I applied these to powerpc-next at:
> commit c6935931c1894ff857616ff8549b61236a19148f
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Sep 4 14:31:46 2016 -0700
> 
>     Linux 4.8-rc5
> 
> Should I have based on something else?
I didn't reproduce the latter error and I also applied on c69359.
My build script is only one line:
make -C tools/testing/selftests TARGETS=powerpc 1>/dev/null

Did I miss anything with your build script?
Anyway I need to fix that.

Thanks for the sharing. Most are good comments and I will rework that.

BR,
- Simon
