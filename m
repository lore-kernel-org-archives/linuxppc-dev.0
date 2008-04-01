Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 7EEF2DDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 05:01:32 +1100 (EST)
Date: Tue, 1 Apr 2008 20:01:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH 2/8] powerpc: replace `__attribute' by `__attribute__'
Message-ID: <20080401180156.GA14553@uranus.ravnborg.org>
References: <47F26FF6.8070300@tiscali.nl> <47F27155.1000103@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47F27155.1000103@tiscali.nl>
Cc: trivial@kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 01, 2008 at 07:31:01PM +0200, Roel Kluin wrote:
> replace `__attribute' by `__attribute__'
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/powerpc/platforms/iseries/main_store.h b/arch/powerpc/platforms/iseries/main_store.h
> index 1a7a3f5..976b23e 100644
> --- a/arch/powerpc/platforms/iseries/main_store.h
> +++ b/arch/powerpc/platforms/iseries/main_store.h
> @@ -61,7 +61,7 @@ struct IoHriMainStoreSegment4 {
>  };
>  
>  /* Main Store VPD for Power4 */
> -struct __attribute((packed)) IoHriMainStoreChipInfo1 {
> +struct __attribute__((packed)) IoHriMainStoreChipInfo1 {
>  	u32	chipMfgID;
>  	char	chipECLevel[4];
>  };

Please introduce __packed if you touch this.
See include/linux/compiler-gcc.h

This comment is relevant for all your patches.
We have __used and other similar variants.

So take a good look at include/linux/compiler* and
use the proper shortcuts where available.

	Sam
