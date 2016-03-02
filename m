Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FD5B1A01D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:52:45 +1100 (AEDT)
Message-ID: <1456883564.24490.5.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/8] powerpc/module: Only try to generate the
 ftrace_caller() stub once
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org,  mbenes@suse.cz
Date: Wed, 02 Mar 2016 12:52:44 +1100
In-Reply-To: <20160301120011.GB10342@lst.de>
References: <1456737989-8755-1-git-send-email-mpe@ellerman.id.au>
 <1456737989-8755-2-git-send-email-mpe@ellerman.id.au>
 <20160301120011.GB10342@lst.de>
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

On Tue, 2016-03-01 at 13:00 +0100, Torsten Duwe wrote:
> On Mon, Feb 29, 2016 at 08:26:23PM +1100, Michael Ellerman wrote:
> [...]
> > diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
> > index 2c01665eb410..dd095496d225 100644
> > --- a/arch/powerpc/kernel/module_32.c
> > +++ b/arch/powerpc/kernel/module_32.c
> > @@ -294,11 +294,19 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
> >  			return -ENOEXEC;
> >  		}
> >  	}
> > +
> > +	return 0;
> > +}
> > +
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > -	module->arch.tramp =
> > -		do_plt_call(module->core_layout.base,
> > -			    (unsigned long)ftrace_caller,
> > -			    sechdrs, module);
> > -#endif
> > +int module_finalize_ftrace(struct module *module, const Elf_Shdr *sechdrs)
> > +{
> > +	module->arch.tramp = do_plt_call(module->core_layout.base,
> > +					 (unsigned long)ftrace_caller,
> > +					 sechdrs, module);
> > +	if (!mod->arch.tramp)
>
> That should probably read (!module->arch.tramp).

Hah, you expect me to compile my patches?! :)

cheers
