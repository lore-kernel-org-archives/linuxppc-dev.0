Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C9531A05A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 19:03:05 +1000 (EST)
Message-ID: <541FDDD6.9040009@freescale.com>
Date: Mon, 22 Sep 2014 11:29:10 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, <greg@kroah.com>, <arnd@arndb.de>,
 <mpe@ellerman.id.au>, <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/15] powerpc/msi: Improve IRQ bitmap allocator
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
 <1411028820-29933-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1411028820-29933-4-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Cc: cbe-oss-dev@lists.ozlabs.org, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, anton@samba.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Minor comment inline.

On 09/18/2014 11:26 AM, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> Currently msi_bitmap_alloc_hwirqs() will round up any IRQ allocation requests
> to the nearest power of 2.  eg. ask for 5 IRQs and you'll get 8.  This wastes a
> lot of IRQs which can be a scarce resource.
> 
> For cxl we can require multiple IRQs for every contexts that is attached to the
> accelerator.  For AFU directed accelerators, there may be 1000s of contexts
> attached, hence we can easily run out of IRQs, especially if we are needlessly
> wasting them.
> 
> This changes the msi_bitmap_alloc_hwirqs() to allocate only the required number
> of IRQs, hence avoiding this wastage.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/sysdev/msi_bitmap.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
> index 2ff6302..e001559 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -24,28 +24,36 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
>  	 * This is fast, but stricter than we need. We might want to add
>  	 * a fallback routine which does a linear search with no alignment.
>  	 */

Is this comment still relevant (especially the part mentioning "fast")?

---
Best Regards, Laurentiu
