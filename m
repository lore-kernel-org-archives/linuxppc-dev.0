Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 496841A0212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 12:08:18 +1000 (AEST)
Message-ID: <1442887697.18408.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: fsl_pci: cast the regs->nip to void * when
 passing it to probe_kernel_address()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kevin Hao <haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>
Date: Tue, 22 Sep 2015 12:08:17 +1000
In-Reply-To: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
References: <1442827370-26854-1-git-send-email-haokexin@gmail.com>
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

On Mon, 2015-09-21 at 17:22 +0800, Kevin Hao wrote:
> With the reimplementation of probe_kernel_address() in commit
> ecc83243e1d4 ("uaccess: reimplement probe_kernel_address() using
> probe_kernel_read()"), the explication of the cast for the addr
> parameter has been dropped. So we have to explicitly cast the
> regs->nip to void * when passing it to probe_kernel_address() in
> order to fix the following build error:
>   arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_mcheck_exception':
>   arch/powerpc/sysdev/fsl_pci.c:1002:4: error: passing argument 2 of 'probe_kernel_read' makes pointer from integer without a cast [-Werror]
>       ret = probe_kernel_address(regs->nip, inst);
>       ^
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> 
> This is against linux-next.

You should be sending this to Andrew Morton, the author of the patch that
caused the breakage. Or at the very least CC'ing him.

cheers
