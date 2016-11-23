Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNlw10KXxzDvnB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:02:25 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i88so2270903pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 18:02:24 -0800 (PST)
Date: Wed, 23 Nov 2016 13:02:10 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the powerpc tree
Message-ID: <20161123130210.72c35b76@roar.ozlabs.ibm.com>
In-Reply-To: <20161122212114.45ba8b17@canb.auug.org.au>
References: <20161122195832.0f031e62@canb.auug.org.au>
 <20161122212114.45ba8b17@canb.auug.org.au>
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

On Tue, 22 Nov 2016 21:21:14 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Tue, 22 Nov 2016 19:58:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the powerpc tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > Inconsistent kallsyms data
> > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > 
> > Which is a vast improvement.  I'll try adding 'KALLSYMS_EXTRA_PASS=1'
> > later and see how it goes.  It would be nice not to need it, though.  
> 
> It build with KALLSYMS_EXTRA_PASS=1 on the command line.
> 

Yay!

The inconsistent kallsyms data is not something we're doing wrong or
toolchain bug so much as an inherent flaw in how kallsyms are done.
Basically the allyesconfig kallsyms section expands the kernel so much
that a subsequent linking requires even more stubs, which adds more
symbols, which means the next kallsyms will be a different size, which
means or offsets will be wrong :)

In theory I think it could actually be triggered on smaller kernels if
the size was just right. I'm sort of looking at ways to fix it:

https://patchwork.ozlabs.org/patch/684910/

Hopefully will get something in 4.10. Worst case we could detect the
kallsyms size change and do another pass in response without slowing
down the case where it's not required. Hmm, that might be the best
thing to do for a first pass.

Thanks,
Nick
