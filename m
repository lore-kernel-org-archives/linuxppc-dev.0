Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2KDT4KJXzDvZ6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 12:57:45 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r16so14930713pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 18:57:45 -0700 (PDT)
Date: Mon, 24 Oct 2016 12:57:34 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [powerpc:test 24/28] powerpc64-linux-gnu-ld: warning: orphan
 section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being
 placed in section `.text.save.restore'.
Message-ID: <20161024125734.549354e0@roar.ozlabs.ibm.com>
In-Reply-To: <201610221500.IwR3ltdg%fengguang.wu@intel.com>
References: <201610221500.IwR3ltdg%fengguang.wu@intel.com>
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

On Sat, 22 Oct 2016 15:53:03 +0800
kbuild test robot <fengguang.wu@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git test
> head:   8a4fd950c8ac67ad98135db4107ed6cae412606c
> commit: b09fa228be430ba2745102ac8e668ad869320bd9 [24/28] powerpc: link warning for orphan sections
> config: powerpc-ps3_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b09fa228be430ba2745102ac8e668ad869320bd9
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All warnings (new ones prefixed by >>):
> 
> >> powerpc64-linux-gnu-ld: warning: orphan section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in section `.text.save.restore'.
> >> powerpc64-linux-gnu-ld: warning: orphan section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in section `.text.save.restore'.
> >> powerpc64-linux-gnu-ld: warning: orphan section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in section `.text.save.restore'.  

On powerpc64, ld creates these for us when required, and puts them into
section ".sfpr". So we can avoid compiling in lib/crtsavres.S entirely
there, I think.

When I do that, I see the save/restore functions getting located at
0x8000. That actually works with my .linker_stub_catch patch, but there
is probably no good reason to put those sections there, so I'll change
.sfpr in the linker script to be near the end of the main text output
section.

Thanks,
Nick
