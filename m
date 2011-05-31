Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18339B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jun 2011 01:15:43 +1000 (EST)
Message-ID: <4DE50617.7090509@linutronix.de>
Date: Tue, 31 May 2011 17:15:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Suzuki Poulose <suzuki@in.ibm.com>
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com>
In-Reply-To: <4DE345B0.8020505@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Suzuki Poulose wrote:
> Index: powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
> ===================================================================
> --- /dev/null
> +++ powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
....

> + *
> + */
> +    bl    nxtins                /* Find our address */
> +nxtins:    mflr    r5                /* Make it accessible */

Please don't mix labels and instructions.

> +    tlbsx    r23,0,r5            /* Find entry we are in */

using tabs instead of spaces would make it look nice. Please also separate 
the arguments of the instruction i.e.
	tlbsx	r23, 0, r5


> Index: powerpc/arch/powerpc/kernel/misc_32.S
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/misc_32.S
> +++ powerpc/arch/powerpc/kernel/misc_32.S
> @@ -736,6 +736,28 @@ relocate_new_kernel:
>      mr      r5, r31
>  
>      li    r0, 0
> +#elif defined(CONFIG_44x)  && !defined(CONFIG_47x)
> +
> +    mr    r29, r3
> +    mr    r30, r4
> +    mr    r31, r5
> +
> +#include "44x_kexec_mapping.S"

The way you setup the 1:1 mapping should be close to what you are doing on
kernel entry. Isn't it possible to include the file here and in the entry
code?

Sebastian
