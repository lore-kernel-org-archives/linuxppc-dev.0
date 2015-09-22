Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0113.outbound.protection.outlook.com [65.55.169.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53E531A0152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:17:10 +1000 (AEST)
Message-ID: <1442888219.19102.213.camel@freescale.com>
Subject: Re: [PATCH] powerpc: fsl_pci: cast the regs->nip to void * when
 passing it to probe_kernel_address()
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 21 Sep 2015 21:16:59 -0500
In-Reply-To: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
References: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 17:22 +0800, Kevin Hao wrote:
> With the reimplementation of probe_kernel_address() in commit
> ecc83243e1d4 ("uaccess: reimplement probe_kernel_address() using
> probe_kernel_read()"), the explication of the cast for the addr
> parameter has been dropped. So we have to explicitly cast the
> regs->nip to void * when passing it to probe_kernel_address() in
> order to fix the following build error:
>   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_mcheck_exception':
>   arch/powerpc/sysdev/fsl_pci.c:1002:4: error: passing argument 2 of 
> 'probe_kernel_read' makes pointer from integer without a cast [-Werror]
>       ret = probe_kernel_address(regs->nip, inst);
>       ^
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> 
> This is against linux-next.

I don't see ecc83243e1d4 in linux-next.  What tree is it in?

-Scott
