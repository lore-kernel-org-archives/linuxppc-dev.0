Return-Path: <key@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7CE95B700D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 04:43:49 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 13 Jun 2012 12:43:46 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 524DD3E4004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 18:43:42 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5DIheiM096942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 12:43:40 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5DIhdKl017562
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 12:43:39 -0600
Message-ID: <1339613130.28242.12.camel@key-ThinkPad-W510>
Subject: Re: [PATCH 1/2] drivers: crypto: move nx build to driver/crypto
 Makefile
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date: Wed, 13 Jun 2012 13:45:30 -0500
In-Reply-To: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
References: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-13 at 13:22 -0500, Seth Jennings wrote:
> When the nx driver was pulled, the Makefile that actually
> builds it is arch/powerpc/Makefile. This is unnatural.
> 
> This patch moves the line that builds the nx driver from
> arch/powerpc/Makefile to drivers/crypto/Makefile where it
> belongs.

Acked-by: Kent Yoder <key@linux.vnet.ibm.com>

> Cc: Kent Yoder <key@linux.vnet.ibm.com>
> Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Makefile   |    1 -
>  drivers/crypto/Makefile |    3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 950d1f7..159e94f 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -149,7 +149,6 @@ core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
>  core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
> 
>  drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
> -drivers-$(CONFIG_CRYPTO_DEV_NX) += drivers/crypto/nx/
> 
>  # Default to zImage, override when needed
>  all: zImage
> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> index 0139032..67b4fbf 100644
> --- a/drivers/crypto/Makefile
> +++ b/drivers/crypto/Makefile
> @@ -14,4 +14,5 @@ obj-$(CONFIG_CRYPTO_DEV_OMAP_AES) += omap-aes.o
>  obj-$(CONFIG_CRYPTO_DEV_PICOXCELL) += picoxcell_crypto.o
>  obj-$(CONFIG_CRYPTO_DEV_S5P) += s5p-sss.o
>  obj-$(CONFIG_CRYPTO_DEV_TEGRA_AES) += tegra-aes.o
> -obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
> \ No newline at end of file
> +obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
> +obj-$(CONFIG_CRYPTO_DEV_NX) += nx/
