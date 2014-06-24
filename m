Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57DA81A0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 09:27:07 +1000 (EST)
Message-ID: <1403633050.26908.20.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/ucc_geth: deal with an compile warning
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
In-Reply-To: <1403597935-39952-1-git-send-email-B45475@freescale.com>
References: <1403597935-39952-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jun 2014 13:04:10 -0500
MIME-Version: 1.0
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-24 at 16:18 +0800, Zhao Qiang wrote:
> deal with a compile warning: comparison between
> 'enum qe_fltr_largest_external_tbl_lookup_key_size'
> and 'enum qe_fltr_tbl_lookup_key_size'
> 
> the code:
> 	"if (ug_info->largestexternallookupkeysize ==
> 	     QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES)"
> is warned because different enum, so modify it.
> 
> 	"enum qe_fltr_largest_external_tbl_lookup_key_size
> 	             largestexternallookupkeysize;
> 
> 	enum qe_fltr_tbl_lookup_key_size {
> 		 QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES
> 			 = 0x3f,         /* LookupKey parsed by the Generate LookupKey
> 					    CMD is truncated to 8 bytes */
> 		 QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES
> 			 = 0x5f,         /* LookupKey parsed by the Generate LookupKey
> 					    CMD is truncated to 16 bytes */
> 	 };
> 
> 	 /* QE FLTR extended filtering Largest External Table Lookup Key Size */
> 	 enum qe_fltr_largest_external_tbl_lookup_key_size {
> 		 QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE
> 			 = 0x0,/* not used */
> 		 QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES
> 			 = QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES,        /* 8 bytes */
> 		 QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES
> 			 = QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES,       /* 16 bytes */
> 	 };"
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This needs to be sent to the netdev list and maintainer.

-Scott
