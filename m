Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQtv94sYrzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 03:23:17 +1100 (AEDT)
Message-ID: <1458231790.19333.7.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: luigi burdo <intermediadc@hotmail.com>
Cc: Trevor Dickinson <contact@a-eon.com>, "matthew@a-eon.com"
 <matthew@a-eon.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Thu, 17 Mar 2016 11:23:10 -0500
In-Reply-To: <DUB117-W90A8E7C5DFE0D4D6781F55C88B0@phx.gbl>
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
 ,<1457482205.5360.114.camel@buserror.net>
 ,<DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
 ,<DUB117-W6931726DAC4EB1D528591DC8B40@phx.gbl>
 ,<1458081467.12370.31.camel@buserror.net>
 ,<DUB406-EAS2759FE0784777D029FB586BC88A0@phx.gbl>
 ,<1458186445.19333.3.camel@buserror.net>
 <DUB117-W90A8E7C5DFE0D4D6781F55C88B0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Freescale P5020 cpu will be kvm-pr?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-17 at 14:38 +0100, luigi burdo wrote:
> Hi Scott,
> this is my Kernel 4.5 dmesg 
> 
> dmesg | grep -i MMU
> [    0.000000] MMU: Supported page sizes
> [    0.000000] MMU: Book3E HW tablewalk not supported
> [    0.000000] mmu_features      = 0x000a0010
> [    0.000000] MMU: Allocated 2112 bytes of context maps for 255 contexts
> 
> dmesg | grep -i e500
> [    0.001787] e500 family performance monitor hardware support registered
> 
> 
>  dmesg | grep -i hypervisor
> 
> [    0.396726] ePAPR hypervisor byte channel driver
> [    3.240020] Freescale hypervisor management driver
> [    3.240024] fsl-hv: no hypervisor found

None of these messages are a problem.

"Book3E HW tablewalk" is for e6500, not e5500.  fsl-hv is for the Freescale
Embedded Hypervisor (Topaz), not KVM.


> i attached my kenrel .config
> 
> My qemu-ppc-64 crash, note i have the same crash 
> 
> qemu: fatal: This KVM version does not support PAPR

You need to tell QEMU to use the appropriate CPU type (e5500) and platform
(ppce500).  PAPR is for book3s, which is what QEMU defaults to.

-Scott
