Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D29F1A2ADC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:11:41 +1100 (AEDT)
In-Reply-To: <20150205193604.24669.67159.stgit@localhost.localdomain>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>,
 Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>,
 lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Colin Cross <ccross@android.com>, <scottwood@freescale.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v5,1/4] powerpc/nvram: move generic code for nvram and pstore
Message-Id: <20150323031141.5E9B9140142@ozlabs.org>
Date: Mon, 23 Mar 2015 14:11:41 +1100 (AEDT)
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-05-02 at 19:36:04 UTC, Hari Bathini wrote:
> With minor checks, we can move most of the code for nvram
> under pseries to a common place to be re-used by other
> powerpc platforms like powernv. This patch moves such
> common code to arch/powerpc/kernel/nvram_64.c file.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/nvram.h       |   50 ++
>  arch/powerpc/include/asm/rtas.h        |    4 
>  arch/powerpc/kernel/nvram_64.c         |  656 ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/nvram.c |  665 --------------------------------
>  4 files changed, 714 insertions(+), 661 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index 34f7c9b..42e5c6a 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -26,6 +26,9 @@

...

> +/* Derived from logfs_compress() */
> +static int nvram_compress(const void *in, void *out, size_t inlen,
> +							size_t outlen)
> +{
> +	int err, ret;
> +
> +	ret = -EIO;
> +	err = zlib_deflateInit2(&stream, COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,
> +						MEM_LEVEL, Z_DEFAULT_STRATEGY);
> +	if (err != Z_OK)
> +		goto error;


This fails the build for ppc64e_defconfig:

arch/powerpc/kernel/built-in.o: In function `.oops_to_nvram':
nvram_64.c:(.text+0x12148): undefined reference to `.zlib_deflateInit2'
nvram_64.c:(.text+0x12178): undefined reference to `.zlib_deflate'
nvram_64.c:(.text+0x1218c): undefined reference to `.zlib_deflateEnd'
arch/powerpc/kernel/built-in.o: In function `.nvram_init_oops_partition':
(.init.text+0x41e0): undefined reference to `.zlib_deflate_workspacesize'
make: *** [vmlinux] Error 1


It used to be OK because PSERIES selects ZLIB_DEFLATE.

I decided to just force ZLIB_DEFLATE on for PPC64. That will add ~22K to the
ppc64e kernel image.

Scott, if you guys are bothered by that let me know and we can add some #ifdefs
to avoid it.

cheers
