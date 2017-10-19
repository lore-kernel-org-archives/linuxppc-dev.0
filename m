Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHfYC50jNzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 17:44:31 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id e64so5799381pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 23:44:31 -0700 (PDT)
Date: Thu, 19 Oct 2017 15:44:25 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 5/7] parisc64: Add .opd based function descriptor
 dereference
Message-ID: <20171019064425.GC449@jagdpanzerIV>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-6-sergey.senozhatsky@gmail.com>
 <20171004104016.GG20084@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004104016.GG20084@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (10/04/17 12:40), Petr Mladek wrote:
> > +unsigned long dereference_module_function_descriptor(struct module *mod,
> > +						     unsigned long addr)
> > +{
> > +	unsigned long start_opd = (Elf64_Addr)mod->core_layout.base +
> > +				   mod->arch.fdesc_offset;
> > +	unsigned long end_opd = start_opd +
> > +				mod->arch.fdesc_count * sizeof(Elf64_Fdesc);
> 
> I know that this is used in rather slow paths. But it still might
> make sense to have these section borders pre-computed and
> stored in struct mod_arch_specific. I mean to do similar
> thing that we do on powerpc.
> 
> Well, we could do this in a followup patch if parisc people
> wanted it.
> 
> 
> > +	if (addr < start_opd || addr >= end_opd)
> > +		return addr;
> > +
> > +	return dereference_function_descriptor(addr);
> > +}
> > +#endif
> 
> Otherwise the patch looks fine to me.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

let's do it later, if need be.

	-ss
