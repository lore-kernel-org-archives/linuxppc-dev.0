Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 578D9DE7C6
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 03:48:52 +1000 (EST)
Message-ID: <4849787C.8090506@garzik.org>
Date: Fri, 06 Jun 2008 13:48:44 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: MPC85xx MDS - Unconditionally select
	PHYLIB for board fixups
References: <Pine.LNX.4.64.0806021019540.22439@blarg.am.freescale.net>
	<484419EE.5040503@garzik.org>
	<1E4EB64C-0618-497E-AABC-74EB7D74B97F@kernel.crashing.org>
	<20080602165422.GA22051@cs181133002.pp.htv.fi>
	<Pine.LNX.4.64.0806021423380.11043@blarg.am.freescale.net>
	<Pine.LNX.4.64.0806061039390.13744@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0806061039390.13744@blarg.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Adrian Bunk <adrian.bunk@movial.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> The MPC85xx MDS board requires some board level tweaks of the PHYs that
> either the eTSEC (gianfar) or UCC ethernet controllers are connected to.
> 
> Its possible to build the phylib as a module, however this breaks the
> board level fix ups because phy_read and phy_write are not available
> if we build as a module.
> 
> So we unconditionally select PHYLIB to ensure its built into the kernel
> if we are building in MPC85xx MDS support.  This was determined to be
> the easiest soultion even though it prevents the user from removing
> PHYLIB support if they decide they don't want it.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> will go via the powerpc.git tree for 2.6.26.
> 
> - k
> 
>  arch/powerpc/platforms/85xx/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
> index 7ff29d5..ecbe580 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -34,6 +34,7 @@ config MPC85xx_MDS
>  	bool "Freescale MPC85xx MDS"
>  	select DEFAULT_UIMAGE
>  	select QUICC_ENGINE
> +	select PHYLIB
>  	help

ACK
