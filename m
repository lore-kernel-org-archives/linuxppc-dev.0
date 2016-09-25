Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shcR34DqXzDrLQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 16:20:31 +1000 (AEST)
Date: Sun, 25 Sep 2016 01:20:17 -0500
From: Scott Wood <oss@buserror.net>
To: David Engraf <david.engraf@sysgo.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20160925062017.GA10754@home.buserror.net>
References: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471877203-29327-1-git-send-email-david.engraf@sysgo.com>
Subject: Re: powerpc64: Enable CONFIG_E500 and CONFIG_PPC_E500MC for
 e5500/e6500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2016 at 04:46:43PM +0200, David Engraf wrote:
> The PowerPC e5500/e6500 architecture is based on the e500mc core. Enable
> CONFIG_E500 and CONFIG_PPC_E500MC when e5500/e6500 is used.
> 
> This will also fix using CONFIG_PPC_QEMU_E500 on PPC64.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---
>  arch/powerpc/platforms/Kconfig.cputype | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index f32edec..0382da7 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -125,11 +125,13 @@ config POWER8_CPU
>  
>  config E5500_CPU
>  	bool "Freescale e5500"
> -	depends on E500
> +	select E500
> +	select PPC_E500MC
>  
>  config E6500_CPU
>  	bool "Freescale e6500"
> -	depends on E500
> +	select E500
> +	select PPC_E500MC

These config symbols are for setting -mcpu.  Kernels built with
CONFIG_GENERIC_CPU should also work on e5500/e6500.

The problem is that CONFIG_PPC_QEMU_E500 doesn't select E500 (I didn't
notice it before because usually CORENET_GENERIC is enabled as well).

Note that your patch, by eliminating the dependency on E500, would make
it possible to build a book3s kernel with E5500_CPU/E6500_CPU, which
doesn't make any sense.

-Scott
