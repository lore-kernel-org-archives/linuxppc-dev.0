Return-Path: <sergey.senozhatsky@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHrF82BkdzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 01:01:16 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s75so7291417pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:01:16 -0700 (PDT)
Date: Thu, 19 Oct 2017 23:01:06 +0900
From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, James Bottomley <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 4/7] powerpc64: Add .opd based function descriptor
 dereference
Message-ID: <20171019140106.GA498@tigerII.localdomain>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-5-sergey.senozhatsky@gmail.com>
 <20171004092108.GF20084@pathway.suse.cz>
 <87r2ujp3yc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2ujp3yc.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Michael, sorry for the delay. I'm catching up with the emails
after... absence.

On (10/04/17 22:06), Michael Ellerman wrote:
> Petr Mladek <pmladek@suse.com> writes:
> > On Sat 2017-09-30 11:53:16, Sergey Senozhatsky wrote:
> >> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> >> index 0b0f89685b67..94caec045a90 100644
> >> --- a/arch/powerpc/kernel/module_64.c
> >> +++ b/arch/powerpc/kernel/module_64.c
> >> @@ -712,6 +717,17 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
> >>  	return 0;
> >>  }
> >>  
> >> +#ifdef PPC64_ELF_ABI_v1
> >> +unsigned long dereference_module_function_descriptor(struct module *mod,
> >> +						     unsigned long addr)
> >> +{
> >> +	if (addr < mod->arch.start_opd || addr >= mod->arch.end_opd)
> >> +		return addr;
> >> +
> >> +	return dereference_function_descriptor(addr);
> >> +}
> >> +#endif /* PPC64_ELF_ABI_v1 */
> >
> > I would personally move this up in the source file. It is related to
> > the definition of func_desc() and other functions that are
> > also PPC_ELF_ABI-specific.
> 
> Yeah that would be neater. There's already a PPC64_ELF_ABI_v2 block, you
> could put this in the else case of that.
> 
> But we can do that later if you're not respinning otherwise.

will do.

	-ss
