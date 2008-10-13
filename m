Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FF7DDE8C7
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:46:20 +1100 (EST)
Message-Id: <F51E4B63-C0B1-4394-872E-3C8A3C0C0BB4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ehrhardt@linux.vnet.ibm.com
In-Reply-To: <1221546450-15761-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/3] kvmppc: add hypercall infrastructure - guest part v3
Date: Mon, 13 Oct 2008 11:42:49 -0500
References: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1221546450-15761-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2008, at 1:27 AM, ehrhardt@linux.vnet.ibm.com wrote:

> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>
> This adds the guest portion of the hypercall infrastructure.
>
> Version 3 now follows the beat ABI, but proposes a new  
> implementation style as
> static inline asm functions instead of pure assembler code. That  
> should allow
> the compiler to be more flexible and therefore a better optimization.
>
> If people agree on that new implementation style we might merge this  
> code.
> The current implementation of beat style hypercalls can be found in
> arch/powerpc/platforms/cell/beat_hvCall.S
>
> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> ---
>
> [diffstat]
> epapr_hcalls.h |   59 +++++++++++++++++++++++++++++++++++++++++++++++ 
> ++++++++++
> 1 file changed, 59 insertions(+)
>
> [diff]
>
> diff --git a/include/asm-powerpc/epapr_hcalls.h b/include/asm- 
> powerpc/epapr_hcalls.h
> new file mode 100644
> --- /dev/null
> +++ b/include/asm-powerpc/epapr_hcalls.h
> @@ -0,0 +1,59 @@
> +/*
> + * This program is free software; you can redistribute it and/or  
> modify
> + * it under the terms of the GNU General Public License, version 2,  
> as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA   
> 02110-1301, USA.
> + *
> + * Copyright IBM Corp. 2008
> + *
> + * Authors:
> + * 	Christian Ehrhardt <ehrhardt@de.ibm.com>
> + */
> +
> +#ifndef __POWERPC_EPAPR_HCALLS_H__
> +#define __POWERPC_EPAPR_HCALLS_H__
> +
> +#ifdef __KERNEL__
> +
> +/* Hypercalls use the beat ABI */
> +#define KVM_HYPERCALL_BIN 0x44000022

Any reason this isn't 'sc' ?

Also, can we make this "sc 1" so its works when we have HW hypervisor  
support?

- k
