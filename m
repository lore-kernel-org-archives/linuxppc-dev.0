Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A771B1007EB
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 02:07:21 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc/cpm1: Fix build with various
	CONFIG_*_UCODE_PATCH combinations
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100708171614.GB11621@oksana.dev.rtsoft.ru>
Date: Sun, 11 Jul 2010 11:07:09 -0500
Message-Id: <AA37EC26-C5D9-45F4-8854-D95669EA043A@kernel.crashing.org>
References: <20100708171614.GB11621@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2010, at 12:16 PM, Anton Vorontsov wrote:

> Warnings are treated as errors for arch/powerpc code, so build fails
> with CONFIG_I2C_SPI_UCODE_PATCH=y:
> 
>    CC      arch/powerpc/sysdev/micropatch.o
>  cc1: warnings being treated as errors
>  arch/powerpc/sysdev/micropatch.c: In function 'cpm_load_patch':
>  arch/powerpc/sysdev/micropatch.c:630: warning: unused variable 'smp'
>  make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1
> 
> And with CONFIG_USB_SOF_UCODE_PATCH=y:
> 
>  CC      arch/powerpc/sysdev/micropatch.o
>  cc1: warnings being treated as errors
>  arch/powerpc/sysdev/micropatch.c: In function 'cpm_load_patch':
>  arch/powerpc/sysdev/micropatch.c:629: warning: unused variable 'spp'
>  arch/powerpc/sysdev/micropatch.c:628: warning: unused variable 'iip'
>  make[1]: *** [arch/powerpc/sysdev/micropatch.o] Error 1
> 
> This patch fixes these issues by introducing proper #ifdefs.
> 
> Cc: <stable@kernel.org> [ .33, .34 ]
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/sysdev/micropatch.c |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

applied to merge

- k
