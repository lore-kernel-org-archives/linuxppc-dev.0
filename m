Return-Path: <gwshan@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17E191A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 14:59:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@au1.ibm.com>;
 Wed, 3 Jun 2015 14:59:11 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8C67A2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 14:59:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t534wxNp1769826
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 14:59:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t534wYnD027523
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 14:58:35 +1000
In-Reply-To: <1433307179-17020-1-git-send-email-david@gibson.dropbear.id.au>
References: <1433307179-17020-1-git-send-email-david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc/eeh: Fix trivial error in eeh_restore_dev_state()
To: David Gibson <david@gibson.dropbear.id.au>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 gwshan@linux.vnet.ibm.com
Message-ID: <OF4582BD1A.5370252A-ONCA257E59.001B1345-CA257E59.001B4C24@au1.ibm.com>
From: Guo Wen Shan <gwshan@au1.ibm.com>
Date: Wed, 3 Jun 2015 14:58:09 +1000
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



David Gibson <david@gibson.dropbear.id.au> wrote on 03/06/2015 14:52:59:

> From: David Gibson <david@gibson.dropbear.id.au>
> To: Guo Wen Shan/Australia/IBM@IBMAU, mpe@ellerman.id.au
> Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-
> dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, David Gibson
> <david@gibson.dropbear.id.au>
> Date: 03/06/2015 14:53
> Subject: [PATCH] powerpc/eeh: Fix trivial error in eeh_restore_dev_state
()
>
> Commit 28158cd "powerpc/eeh: Enhance pcibios_set_pcie_reset_state()"
> introduced a fix for a problem where certain configurations could lead to
> pci_reset_function() destroying the state of PCI devices other than the
one
> specified.
>
> Unfortunately, the fix has a trivial bug - it calls pci_save_state()
again,
> when it should be calling pci_restore_state().  This corrects the
problem.
>
> Cc: Gavin Shan <gwshan@au1.ibm.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

> ---
>  arch/powerpc/kernel/eeh.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index 9ee61d1..ece4181 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -719,7 +719,7 @@ static void *eeh_restore_dev_state(void *data,
> void *userdata)
>
>     /* The caller should restore state for the specified device */
>     if (pdev != dev)
> -      pci_save_state(pdev);
> +      pci_restore_state(pdev);
>
>     return NULL;
>  }
> --
> 2.4.2
>
