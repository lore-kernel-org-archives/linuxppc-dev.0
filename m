Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D004CDDDEE
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 03:17:53 +1100 (EST)
Date: Wed, 3 Dec 2008 17:17:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Fix compile warnings in mpc85xx_mds.c
In-Reply-To: <1228318727-29863-1-git-send-email-galak@kernel.crashing.org>
Message-ID: <Pine.LNX.4.64.0812031716330.30629@vixen.sonytel.be>
References: <1228318727-29863-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 3 Dec 2008, Kumar Gala wrote:
> arch/powerpc/platforms/85xx/mpc85xx_mds.c: In function 'board_fixups':
> arch/powerpc/platforms/85xx/mpc85xx_mds.c:244: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'resource_size_t'
> arch/powerpc/platforms/85xx/mpc85xx_mds.c:250: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'resource_size_t'
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index 2494c51..915e8d3 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -241,13 +241,13 @@ static int __init board_fixups(void)
>  		mdio = of_find_compatible_node(NULL, NULL, compstrs[i]);
>  
>  		of_address_to_resource(mdio, 0, &res);
> -		snprintf(phy_id, BUS_ID_SIZE, "%x:%02x", res.start, 1);
> +		snprintf(phy_id, BUS_ID_SIZE, "%llx:%02x", (u64)res.start, 1);
                                                            ^^^
unsigned long? u64 differs for 32-bit and 64-bit.

Doh, if you would put the whole resource range there, you could use %pR ;-)

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
