Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E622B6EE7
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2012 11:53:25 +1100 (EST)
Message-ID: <1326243199.23910.81.camel@pasglop>
Subject: Re: [PATCH v2 0/3] ppc32/kprobe: Fix a bug for kprobe stwu r1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Wed, 11 Jan 2012 11:53:19 +1100
In-Reply-To: <4F0C01BA.3040302@windriver.com>
References: <1323946810-4868-1-git-send-email-tiejun.chen@windriver.com>
 <4F0C01BA.3040302@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-01-10 at 17:15 +0800, tiejun.chen wrote:
> Tiejun Chen wrote:
> > Changes from V1:
> > 
> > * use memcpy simply to withdraw copy_exc_stack
> > * add !(regs->msr & MSR_PR)) and
> > 	WARN_ON(test_thread_flag(TIF_EMULATE_STACK_STORE));
> >   to make sure we're in goot path.
> > * move this migration process inside 'restore'
> > * clear TIF flag atomically 
> 
> Ben,
> 
> Is this series OK?

Not completely sorry. I was about to send you some comments a couple of
weeks ago then had to leave urgently and forgot about it, then started
rewriting your code and didn't finish :-)

I'll give you some more feedback asap, sorry about that. It's getting
there but there's a couple of things I'd like to see done a bit
differently.

Cheers,
Ben.

> Thanks
> Tiejun
> 
> > 
> > Tiejun Chen (3):
> >       powerpc/kprobe: introduce a new thread flag
> >       ppc32/kprobe: complete kprobe and migrate exception frame
> >       ppc32/kprobe: don't emulate store when kprobe stwu r1
> > 
> >  arch/powerpc/include/asm/thread_info.h |    3 ++
> >  arch/powerpc/kernel/entry_32.S         |   35 ++++++++++++++++++++++++++++++++
> >  arch/powerpc/lib/sstep.c               |   25 +++++++++++++++++++++-
> >  3 files changed, 61 insertions(+), 2 deletions(-)
> > 
> > Tiejun
