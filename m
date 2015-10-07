Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D4411A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 21:10:56 +1100 (AEDT)
In-Reply-To: <1444194460-13584-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <michaele@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>,
 Ian Munsie <imunsie@au1.ibm.com>, stable <stable@vger.kernel.org>
Subject: Re: cxl: Fix number of allocated pages in SPA
Message-Id: <20151007101055.BDE1D140D68@ozlabs.org>
Date: Wed,  7 Oct 2015 21:10:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-10 at 05:07:40 UTC, Ian Munsie wrote:
> From: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> The scheduled process area is currently allocated before assigning the
> correct maximum processes to the AFU, which will mean we only ever
> allocate a fixed number of pages for the scheduled process area. This
> will limit us to 958 processes with 2 x 64K pages. If we try to use more
> processes than that we'd probably overrun the buffer and corrupt memory
> or crash.
> 
> AFUs that require three or more interrupts per process will not be
> affected as they are already limited to less processes than that, but we
> could hit it on an AFU that requires 0, 1 or 2 interrupts per process,
> or when using 4K pages.
> 
> This patch moves the initialisation of the num_procs to before the SPA
> allocation so that enough pages will be allocated for the number of
> processes that the AFU supports.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Cc: stable <stable@vger.kernel.org> # 3.18+

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/4108efb02daa09cbb5db048a

cheers
