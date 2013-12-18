Return-Path: <mpe@ellerman.id.au>
Message-ID: <1387341927.20735.1.camel@concordia>
Subject: Re: [PATCH 8/8] powerpc: Fix endian issues in crash dump code
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Date: Wed, 18 Dec 2013 15:45:27 +1100
In-Reply-To: <1386824381-14032-9-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
 <1386824381-14032-9-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Ulrich.Weigand@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-12 at 15:59 +1100, Anton Blanchard wrote:
> A couple more device tree properties that need byte swapping.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/kernel/crash_dump.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
> index 779a78c..11c1d06 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -124,15 +124,15 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
>  void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
>  {
>  	unsigned long addr;
> -	const u32 *basep, *sizep;
> +	const __be32 *basep, *sizep;
>  	unsigned int rtas_start = 0, rtas_end = 0;
>  
>  	basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
>  	sizep = of_get_property(rtas.dev, "rtas-size", NULL);
>  
>  	if (basep && sizep) {
> -		rtas_start = *basep;
> -		rtas_end = *basep + *sizep;
> +		rtas_start = be32_to_cpup(basep);
> +		rtas_end = rtas_start + be32_to_cpup(sizep);
>  	}
>  
>  	for (addr = begin; addr < end; addr += PAGE_SIZE) {

Not my favourite colour :D  What about this instead?

We could also add of_property_read_u32(), with an implied index of zero?

I don't like the rc handling, but couldn't come up with anything I liked
better.

cheers


diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index 11c1d06..60fd0aa 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -124,15 +124,16 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
 void crash_free_reserved_phys_range(unsigned long begin, unsigned long end)
 {
        unsigned long addr;
-       const __be32 *basep, *sizep;
+       u32 base, size;
        unsigned int rtas_start = 0, rtas_end = 0;
+       int rc;
 
-       basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
-       sizep = of_get_property(rtas.dev, "rtas-size", NULL);
+       rc  = of_property_read_u32_index(rtas.dev, "linux,rtas-base", 0, &base);
+       rc |= of_property_read_u32_index(rtas.dev, "rtas-size", 0, &size);
 
-       if (basep && sizep) {
-               rtas_start = be32_to_cpup(basep);
-               rtas_end = rtas_start + be32_to_cpup(sizep);
+       if (rc == 0) {
+               rtas_start = base;
+               rtas_end = rtas_start + size;
        }
 
        for (addr = begin; addr < end; addr += PAGE_SIZE) {
