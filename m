Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFD0B1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:48:16 +1100 (AEDT)
Message-ID: <1456397295.15739.16.camel@ellerman.id.au>
Subject: Re: [PATCH 03/12] powerpc/module: Create a special stub for
 ftrace_caller()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Thu, 25 Feb 2016 21:48:15 +1100
In-Reply-To: <56CE4616.9080100@gmail.com>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-3-git-send-email-mpe@ellerman.id.au>
 <56CE4616.9080100@gmail.com>
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

On Thu, 2016-02-25 at 11:08 +1100, Balbir Singh wrote:
> 
> On 25/02/16 01:28, Michael Ellerman wrote:
> > In order to support the new -mprofile-kernel ABI, we need to be able to
> > call from the module back to ftrace_caller() (in the kernel) without
> > using the module's r2. That is because the function in this module which
> > is calling ftrace_caller() may not have setup r2, if it doesn't
> > otherwise need it (ie. it accesses no globals).
> > 
> > To make that work we add a new stub which is used for calling
> > ftrace_caller(), which uses the kernel toc instead of the module toc.
> > 
> > diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> > index 9629966e614b..e711d40a3b8f 100644
> > --- a/arch/powerpc/kernel/module_64.c
> > +++ b/arch/powerpc/kernel/module_64.c
> > @@ -671,10 +671,56 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
> >  }
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +
> > +#define PACATOC offsetof(struct paca_struct, kernel_toc)
> > +
> > +static unsigned long create_ftrace_stub(const Elf64_Shdr *sechdrs, struct module *me)
> > +{
> > +	struct ppc64_stub_entry *entry;
> > +	unsigned int i, num_stubs;

> How about some comments on r2
> r2 is still pointing to the module's toc, will be saved by ftrace_caller and
> restored by the instruction following bl ftrace_caller (after patching
> _mcount/nop)

Yeah I'll add some commentary.

I think the change log describes it fairly well but a comment is also good.

cheers
