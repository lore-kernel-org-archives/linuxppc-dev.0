Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BDD01A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 11:12:25 +1000 (AEST)
Message-ID: <1430183545.7246.1.camel@ellerman.id.au>
Subject: Re: Kernel 4.1-rc1 build fails  on Sam460ex amcc 460ex powerpc
 Canyonlands
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julian Margetson <runaway@candw.ms>
Date: Tue, 28 Apr 2015 11:12:25 +1000
In-Reply-To: <553E16A0.704@candw.ms>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <553E16A0.704@candw.ms>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tj@kernel.org, andriy.shevchenko@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-27 at 06:59 -0400, Julian Margetson wrote:
> Kernel 4.1-rc1 build fails  on Sam460ex amcc 460ex powerpc Canyonlands with 
> CONFIG_SATA_DWC=y
> 
> sata_dwc_460ex.c:(.text+0xa165c): undefined reference to `dw_dma_remove'
> drivers/built-in.o: In function `sata_dwc_probe':
> sata_dwc_460ex.c:(.text+0xa1900): undefined reference to `dw_dma_probe'
> sata_dwc_460ex.c:(.text+0xa1954): undefined reference to `dw_dma_remove'
> make: *** [vmlinux] Error 1

Looks like it was caused by:

commit 8b3444852a2b58129ee68a8dd69fef81ceb902a1
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue Mar 3 22:41:21 2015 +0200

    sata_dwc_460ex: move to generic DMA driver
    
    The SATA implementation based on two actually different devices, i.e. SATA and
    DMA controllers.
    
    For Synopsys DesignWare DMA we have already a generic implementation of the
    driver. Thus, the patch converts the code to use DMAEngine framework and
    dw_dmac driver.
    
    In future it will be better to split the devices inside DTS as well like it's
    done on other platforms.
    
    Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    Signed-off-by: Tejun Heo <tj@kernel.org>


cheers
