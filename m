Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id F137BDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:58:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3 of 3] [KVM POWERPC] PowerPC 440 KVM implementation
Date: Tue, 8 Apr 2008 04:58:17 +0200
References: <b07f3049f16483f80322.1207601614@localhost.localdomain>
In-Reply-To: <b07f3049f16483f80322.1207601614@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804080458.17783.arnd@arndb.de>
Cc: kvm-devel@lists.sourceforge.net, kvm-ppc-devel@lists.sourceforge.net,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 07 April 2008, Hollis Blanchard wrote:
> --- a/include/asm-powerpc/kvm.h
> +++ b/include/asm-powerpc/kvm.h
> @@ -1,6 +1,55 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA =A002110-1301=
, USA.
> + *
> + * Copyright IBM Corp. 2007
> + *
> + * Authors: Hollis Blanchard <hollisb@us.ibm.com>
> + */
> +
> =A0#ifndef __LINUX_KVM_POWERPC_H
> =A0#define __LINUX_KVM_POWERPC_H
> =A0
> -/* powerpc does not support KVM */
> +#include <asm/types.h>
> =A0
> -#endif
> +struct kvm_regs {
> +=A0=A0=A0=A0=A0=A0=A0__u32 pc;
> +=A0=A0=A0=A0=A0=A0=A0__u32 cr;
> +=A0=A0=A0=A0=A0=A0=A0__u32 ctr;
> +=A0=A0=A0=A0=A0=A0=A0__u32 lr;
> +=A0=A0=A0=A0=A0=A0=A0__u32 xer;
> +=A0=A0=A0=A0=A0=A0=A0__u32 msr;
> +=A0=A0=A0=A0=A0=A0=A0__u32 srr0;
> +=A0=A0=A0=A0=A0=A0=A0__u32 srr1;
> +=A0=A0=A0=A0=A0=A0=A0__u32 pid;
> +
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg0;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg1;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg2;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg3;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg4;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg5;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg6;
> +=A0=A0=A0=A0=A0=A0=A0__u32 sprg7;
> +
> +=A0=A0=A0=A0=A0=A0=A0__u64 fpr[32];
> +=A0=A0=A0=A0=A0=A0=A0__u32 gpr[32];
> +};
> +
> +struct kvm_sregs {
> +};
> +
> +struct kvm_fpu {
> +};
> +
> +#endif /* __LINUX_KVM_POWERPC_H */

Since this defines part of the ABI, it would be nice if it's possible
to have it in a platform independent way. Most of the registers here
should probably become "unsigned long" instead of "__u32" so that
the definition can be used for a potential 64 bit port.

Also, I noticed that you lump everything into kvm_regs, instead of
using sregs for stuff like srr0 and kvm_fpu for the fprs. What is
the reason for that?

	Arnd <><
