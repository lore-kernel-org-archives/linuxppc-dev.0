Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJXsD6p2bzDqYf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 09:29:52 +1000 (AEST)
Message-ID: <1464650992.16938.8.camel@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc: Avoid load hit store when using
 find_linux_pte_or_hugepte()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 May 2016 09:29:52 +1000
In-Reply-To: <1464523432-12605-3-git-send-email-anton@ozlabs.org>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
 <1464523432-12605-3-git-send-email-anton@ozlabs.org>
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

On Sun, 2016-05-29 at 22:03 +1000, Anton Blanchard wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> In many cases we disable interrupts right before calling
> find_linux_pte_or_hugepte().
> 
> find_linux_pte_or_hugepte() first checks interrupts are disabled
> before calling __find_linux_pte_or_hugepte():
> 
>         if (!arch_irqs_disabled()) {
>                 pr_info("%s called with irq enabled\n", __func__);
>                 dump_stack();
>         }

Should that be a VM_WARN_ON()?

cheers
