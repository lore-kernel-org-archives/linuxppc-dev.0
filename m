Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 406A1DDF37
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 19:02:45 +1100 (EST)
Date: Wed, 17 Dec 2008 09:02:11 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/iseries: viodasd needs to depend on CONFIG_BLOCK
Message-ID: <20081217080211.GB32491@kernel.dk>
References: <20081217171649.f3cd7c96.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081217171649.f3cd7c96.sfr@canb.auug.org.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 17 2008, Stephen Rothwell wrote:
> Otherwise you get lot of errors like these:
> 
> drivers/block/viodasd.c:72: error: dereferencing pointer to incomplete type
> drivers/block/viodasd.c: In function 'viodasd_open':
> drivers/block/viodasd.c:135: error: dereferencing pointer to incomplete type
> drivers/block/viodasd.c: In function 'viodasd_release':
> drivers/block/viodasd.c:184: error: dereferencing pointer to incomplete type
> drivers/block/viodasd.c: In function 'viodasd_getgeo':
> drivers/block/viodasd.c:209: error: dereferencing pointer to incomplete type
> drivers/block/viodasd.c:214: error: implicit declaration of function 'get_capacity'
> drivers/block/viodasd.c: At top level:
> drivers/block/viodasd.c:222: error: variable 'viodasd_fops' has initializer but incomplete type
> drivers/block/viodasd.c:223: error: unknown field 'owner' specified in initializer
> 
> Discovered by a randconfig build.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/iseries/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
> index 45ffd8e..ed3753d 100644
> --- a/arch/powerpc/platforms/iseries/Kconfig
> +++ b/arch/powerpc/platforms/iseries/Kconfig
> @@ -9,6 +9,7 @@ menu "iSeries device drivers"
>  
>  config VIODASD
>  	tristate "iSeries Virtual I/O disk support"
> +	depends on BLOCK
>  	help
>  	  If you are running on an iSeries system and you want to use
>  	  virtual disks created and managed by OS/400, say Y.
> -- 
> 1.6.0.5

Indeed, looks good. I trust the ppc folks will carry this one? If so,
feel free to add my acked-by to this.

-- 
Jens Axboe
