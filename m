Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38C8F1A0063
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 17:43:59 +1100 (AEDT)
Message-ID: <1456382638.30375.4.camel@ellerman.id.au>
Subject: Re: [PATCH 02/12] powerpc/module: Mark module stubs with a magic value
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Thu, 25 Feb 2016 17:43:58 +1100
In-Reply-To: <56CE44F8.8070605@gmail.com>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-2-git-send-email-mpe@ellerman.id.au>
 <56CE44F8.8070605@gmail.com>
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

On Thu, 2016-02-25 at 11:04 +1100, Balbir Singh wrote:
>
> On 25/02/16 01:28, Michael Ellerman wrote:
> > -bool is_module_trampoline(u32 *p)
> > +int module_trampoline_target(struct module *mod, unsigned long addr,
> > +			     unsigned long *target)
> >  {
> > -	unsigned int i;
> > -	u32 insns[ARRAY_SIZE(ppc64_stub_insns)];
> > -
> > -	BUILD_BUG_ON(sizeof(ppc64_stub_insns) != sizeof(ppc64_stub_mask));
> > +	struct ppc64_stub_entry *stub;
> > +	func_desc_t funcdata;
> > +	u32 magic;
> >
> > -	if (probe_kernel_read(insns, p, sizeof(insns)))
> > +	if (!within_module_core(addr, mod)) {
> > +		pr_err("%s: stub %lx not in module %s\n", __func__, addr, mod->name);
> >  		return -EFAULT;

> -EFAULT or -EINVAL?

I think we want EFAULT. Otherwise ftrace_bug() will try and print the actual
instruction, which would then fault. (though I haven't confirmed that by
testing)

> I wonder if we can recover from a bad trampoline address.

We can't recover at the moment. Do you mean is there some way we could recover?

cheers
