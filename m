Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 68831DDE01
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:56:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so902088anc
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Dec 2007 12:56:47 -0800 (PST)
Message-ID: <fa686aa40712041256j4d4a79dap776124dd9715d4ee@mail.gmail.com>
Date: Tue, 4 Dec 2007 13:56:47 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: clear data caches.
In-Reply-To: <20071204204915.AF346C18071@mail45-blu.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071204204915.AF346C18071@mail45-blu.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/4/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> This code is needed to boot without a boot loader.
>
> Grant:  I'm not sure where the right place to put this is.  I'm assuming we'll actually need some boot code that is not generic?  Also, note that there is a V4FX errata workaround in arch/ppc/boot/head.S, which probably also needs to get pulled to powerpc.

Thanks Steve, I'll pull this into my tree.  I hope to find some time
to get the raw platform cleaned up to get into mainline.

And, yes, the V4FX errata needs to be merged into arch/powerpc.

Thanks again!
g.

>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> ---
>  arch/powerpc/boot/raw-platform.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/raw-platform.c b/arch/powerpc/boot/raw-platform.c
> index b9caeee..2a5e493 100644
> --- a/arch/powerpc/boot/raw-platform.c
> +++ b/arch/powerpc/boot/raw-platform.c
> @@ -24,6 +24,28 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
>                     unsigned long r6, unsigned long r7)
>  {
>         u64 memsize64 = memsize[0];
> +       static const unsigned long line_size = 32;
> +       static const unsigned long congruence_classes = 256;
> +       unsigned long addr;
> +       unsigned long dccr;
> +
> +       /*
> +        * Invalidate the data cache if the data cache is turned off.
> +        * - The 405 core does not invalidate the data cache on power-up
> +        *   or reset but does turn off the data cache. We cannot assume
> +        *   that the cache contents are valid.
> +        * - If the data cache is turned on this must have been done by
> +        *   a bootloader and we assume that the cache contents are
> +        *   valid.
> +        */
> +       __asm__("mfdccr %0": "=r" (dccr));
> +       if (dccr == 0) {
> +               for (addr = 0;
> +                    addr < (congruence_classes * line_size);
> +                    addr += line_size) {
> +                       __asm__("dccci 0,%0": :"b"(addr));
> +               }
> +       }
>
>         if (mem_size_cells == 2) {
>                 memsize64 <<= 32;
> --
> 1.5.3.4-dirty
>
>
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
