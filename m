Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D14A71A003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 20:01:58 +1100 (AEDT)
Date: Thu, 11 Feb 2016 10:01:54 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Torsten Duwe <duwe@lst.de>
cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v8 6/8] Implement kernel live patching for ppc64le (ABIv2)
In-Reply-To: <20160210174505.54234692C8@newverein.lst.de>
Message-ID: <alpine.LNX.2.00.1602110958290.6655@pobox.suse.cz>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174505.54234692C8@newverein.lst.de>
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

On Wed, 10 Feb 2016, Torsten Duwe wrote:

> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> new file mode 100644
> index 0000000..44e8a2d
> --- /dev/null
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -0,0 +1,45 @@
> +/*
> + * livepatch.h - powerpc-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2015 SUSE
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
> +#ifndef _ASM_POWERPC64_LIVEPATCH_H
> +#define _ASM_POWERPC64_LIVEPATCH_H
> +
> +#include <linux/module.h>
> +#include <linux/ftrace.h>
> +
> +#ifdef CONFIG_LIVEPATCH
> +static inline int klp_check_compiler_support(void)
> +{
> +#if !defined(_CALL_ELF) || _CALL_ELF != 2 || !defined(CC_USING_MPROFILE_KERNEL)
> +	return 1;
> +#endif
> +	return 0;
> +}
> +
> +extern int klp_write_module_reloc(struct module *mod, unsigned long type,
> +				   unsigned long loc, unsigned long value);

It would be better to make this one static inline and move 'return 
-ENOSYS;' here. Thus there would be no arch/powerpc/kernel/livepatch.c. 
See s390 code for reference.

> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> +{
> +	regs->nip = ip;
> +}
> +#else
> +#error Live patching support is disabled; check CONFIG_LIVEPATCH

Change the error to

#error Include linux/livepatch.h, not asm/livepatch.h

please. See 383bf44d1a8b ("livepatch: change the error message in 
asm/livepatch.h header files").

Thanks Torsten,
Miroslav
