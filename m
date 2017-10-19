Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHfYy4BpkzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 17:45:10 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id i5so5807159pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 23:45:10 -0700 (PDT)
Date: Thu, 19 Oct 2017 15:45:04 +0900
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
Subject: Re: [PATCHv3 4/7] powerpc64: Add .opd based function descriptor
 dereference
Message-ID: <20171019064504.GD449@jagdpanzerIV>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-5-sergey.senozhatsky@gmail.com>
 <20171004092108.GF20084@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004092108.GF20084@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (10/04/17 11:21), Petr Mladek wrote:
[..]
> > +#ifdef PPC64_ELF_ABI_v1
> > +unsigned long dereference_module_function_descriptor(struct module *mod,
> > +						     unsigned long addr)
> > +{
> > +	if (addr < mod->arch.start_opd || addr >= mod->arch.end_opd)
> > +		return addr;
> > +
> > +	return dereference_function_descriptor(addr);
> > +}
> > +#endif /* PPC64_ELF_ABI_v1 */
> 
> I would personally move this up in the source file. It is related to
> the definition of func_desc() and other functions that are
> also PPC_ELF_ABI-specific.
> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

OK, will move.

	-ss
