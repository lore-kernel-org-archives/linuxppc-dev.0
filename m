Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41K5ZS19fWzF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 22:06:23 +1000 (AEST)
Date: Mon, 2 Jul 2018 22:07:29 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Mathieu Malaterre <malat@debian.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] macintosh/via-pmu: Fix section mismatch warning
In-Reply-To: <CA+7wUsyfkC3FvbFyt9JRdBas3s+52tp7OH8h2jiJM9z+ynoyyw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1807022143570.13@nippy.intranet>
References: <cover.1530519301.git.fthain@telegraphics.com.au>
 <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
 <CA+7wUsyfkC3FvbFyt9JRdBas3s+52tp7OH8h2jiJM9z+ynoyyw@mail.gmail.com>
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

On Mon, 2 Jul 2018, Mathieu Malaterre wrote:

> On Mon, Jul 2, 2018 at 10:25 AM Finn Thain <fthain@telegraphics.com.au> 
> wrote:
> >
> > The pmu_init() function has the __init qualifier, but the ops struct 
> > that holds a pointer to it does not. This causes a build warning. The 
> > driver works fine because the pointer is only dereferenced early.
> >
> > The function is so small that there's negligible benefit from using 
> > the __init qualifier. Remove it to fix the warning, consistent with 
> > the other ADB drivers.
> 
> Would you mind copy/pasting the warning you are seeing.
> 
> Make sure you have:
> 
> 58935176ad17 powerpc/via-pmu: Fix section mismatch warning
> 
> Thanks
> 

It's true, the section mismatch warning from 'make' has disappeared since 
I wrote this patch, but that doesn't mean it is wrong.

Before this patch:

$ powerpc-linux-gnu-objdump -xda vmlinux |egrep -w "via_pmu_driver|pmu_init"
c0711c84 l     F .init.text     0000001c pmu_init
c05eb408 g     O .rodata        00000028 via_pmu_driver
c0711c84 <pmu_init>:
$ 

After:

$ powerpc-linux-gnu-objdump -xda vmlinux |egrep -w "via_pmu_driver|pmu_init"
c038e42c l     F .text  0000001c pmu_init
c05e1e58 g     O .rodata        00000028 via_pmu_driver
c038e42c <pmu_init>:
$

I gather that commit 58935176ad17 ("powerpc/via-pmu: Fix section mismatch 
warning") has moved via_pmu_driver from .data to .rodata, but I'm afraid I 
don't see the point of that change. The commit log entry doesn't explain 
it either.

If .rodata is not discarded then the dangling pointer remains, right?

-- 
