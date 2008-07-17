Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 678ECDE8CE
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 03:39:48 +1000 (EST)
Date: Thu, 17 Jul 2008 12:39:30 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] elf loader support for auxvec base platform string
Message-ID: <20080717173930.GG9594@localdomain>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<20080717000951.5f8cab37.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080717000951.5f8cab37.akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, roland@redhat.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> > On Tue, 2008-07-15 at 18:58 -0500, Nathan Lynch wrote:
> > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > index d48ff5f..834c2c4 100644
> > > --- a/fs/binfmt_elf.c
> > > +++ b/fs/binfmt_elf.c
> > > @@ -131,6 +131,10 @@ static int padzero(unsigned long elf_bss)
> > >  #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
> > >  #endif
> > >  
> > > +#ifndef ELF_BASE_PLATFORM
> > > +#define ELF_BASE_PLATFORM NULL
> > > +#endif
> 
> Please add a comment which explains what this is.
> 
> Please also add a comment telling the world in which header file the
> architecture *must* define this macro and then ensure that that header is
> included into this file by reliable means.  asm/elf.h looks OK.

Okay.


> > > @@ -172,6 +178,19 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> > >  			return -EFAULT;
> > >  	}
> > >  
> > > +	/*
> > > +	 * If this architecture has a "base" platform capability
> > > +	 * string, copy it to userspace.
> > > +	 */
> > > +	u_base_platform = NULL;
> > > +	if (k_base_platform) {
> > > +		size_t len = strlen(k_base_platform) + 1;
> > > +
> > > +		u_base_platform = (elf_addr_t __user *)STACK_ALLOC(p, len);
> > > +		if (__copy_to_user(u_base_platform, k_base_platform, len))
> > > +			return -EFAULT;
> > > +	}
> 
> >From my reading, this change will result in no additional code
> generation on non-powerpc architectures.  This is good.  If poss, could
> you please verify that theory and perhaps drop a note in the changelog
> about that?

That was the intent, yes.  However:

$ scripts/bloat-o-meter vmlinux-x86-{before,after}
add/remove: 0/0 grow/shrink: 2/0 up/down: 18/0 (18)
function                                     old     new   delta
init_mm                                      784     800     +16
load_elf_binary                            11946   11948      +2

(x86_64_defconfig, gcc 4.2.3)

The init_mm/mm_struct bloat is expected (although I'd like to avoid
that), but evidently it has some small effect on load_elf_binary.
