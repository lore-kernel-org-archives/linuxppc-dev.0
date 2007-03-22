Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9DBD9DDF21
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 16:44:19 +1100 (EST)
Subject: Re: [PATCH 2/4] powerpc: Fix 32 bits mm operations when not using BATs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20070322030114.D5B9FDDF2B@ozlabs.org>
References: <20070322030114.D5B9FDDF2B@ozlabs.org>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 16:44:06 +1100
Message-Id: <1174542246.10836.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- linux-cell.orig/arch/powerpc/mm/mmu_decl.h	2007-03-22 13:09:34.000000000 +1100
> +++ linux-cell/arch/powerpc/mm/mmu_decl.h	2007-03-22 13:15:08.000000000 +1100
> @@ -31,6 +31,9 @@ extern void settlbcam(int index, unsigne
>  		      unsigned int size, int flags, unsigned int pid);
>  extern void invalidate_tlbcam_entry(int index);
>  
> +extern void hash_preload(struct mm_struct *mm, unsigned long ea,
> +			 unsigned long access, unsigned long trap);
> +

The above needs to be moved out of the #ifdef CONFIG_PPC32 it's in...

Ben.
