Return-Path: <htejun@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 7C11A67A0E
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jun 2006 06:31:16 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i11so807037nzi
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Jun 2006 13:31:16 -0700 (PDT)
Message-ID: <4483417D.8060109@gmail.com>
Date: Mon, 05 Jun 2006 05:24:29 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com>
	<20060602163035.05ab7c71.akpm@osdl.org>
	<20060604161124.GA7587@martell.zuzino.mipt.ru>
In-Reply-To: <20060604161124.GA7587@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexey Dobriyan wrote:
> Are there some other fields that should be marked?

Yeap, prot and rx_cnt of sil24_prb should also be marked __le.  Also, 
all fields of sil24_port_multiplier

Thanks.

> [PATCH] sata_sil24: endian annotations
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/scsi/sata_sil24.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -37,7 +37,7 @@
>   * Port request block (PRB) 32 bytes
>   */
>  struct sil24_prb {
> -	u16	ctrl;
> +	__le16	ctrl;
>  	u16	prot;
>  	u32	rx_cnt;
>  	u8	fis[6 * 4];
> @@ -47,9 +47,9 @@ struct sil24_prb {
>   * Scatter gather entry (SGE) 16 bytes
>   */
>  struct sil24_sge {
> -	u64	addr;
> -	u32	cnt;
> -	u32	flags;
> +	__le64	addr;
> +	__le32	cnt;
> +	__le32	flags;
>  };
>  
>  /*

-- 
tejun
