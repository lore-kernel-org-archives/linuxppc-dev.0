Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm08J2rz8zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 22:18:56 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qm08H5YhKz9s9N
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2016 22:18:55 +1000 (AEST)
Date: Thu, 14 Apr 2016 14:18:48 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 3/5] powerpc/livepatch: Add livepatch header
In-Reply-To: <1460552003-15409-4-git-send-email-mpe@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1604141417310.10605@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <1460552003-15409-4-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2016, Michael Ellerman wrote:

> Add the powerpc specific livepatch definitions. In particular we provide
> a non-default implementation of klp_get_ftrace_location().
> 
> This is required because the location of the mcount call is not constant
> when using -mprofile-kernel (which we always do for live patching).
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/livepatch.h | 54 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/livepatch.h
> 
> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> new file mode 100644
> index 000000000000..ad36e8e34fa1
> --- /dev/null
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -0,0 +1,54 @@
> +/*
> + * livepatch.h - powerpc-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2015-2016, SUSE, IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef _ASM_POWERPC_LIVEPATCH_H
> +#define _ASM_POWERPC_LIVEPATCH_H
> +
> +#include <linux/module.h>
> +#include <linux/ftrace.h>
> +
> +#ifdef CONFIG_LIVEPATCH

We don't use these guards in our header files since 335e073faacc ("klp: 
remove CONFIG_LIVEPATCH dependency from klp headers").

> +static inline int klp_check_compiler_support(void)
> +{
> +	return 0;
> +}
> +
> +static inline int klp_write_module_reloc(struct module *mod, unsigned long
> +		type, unsigned long loc, unsigned long value)
> +{
> +	/* This requires infrastructure changes; we need the loadinfos. */
> +	return -ENOSYS;
> +}

And this is not needed anymore as Jessica pointed out.

> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> +{
> +	regs->nip = ip;
> +}
> +
> +#define klp_get_ftrace_location klp_get_ftrace_location
> +static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
> +{
> +	/*
> +	 * Live patch works only with -mprofile-kernel on PPC. In this case,
> +	 * the ftrace location is always within the first 16 bytes.
> +	 */
> +	return ftrace_location_range(faddr, faddr + 16);
> +}
> +#endif /* CONFIG_LIVEPATCH */
> +
> +#endif /* _ASM_POWERPC_LIVEPATCH_H */
> -- 
> 2.5.0
> 
