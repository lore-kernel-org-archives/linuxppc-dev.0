Return-Path: <horia.geanta@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ztGTg4D7bzF1sh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Mar 2018 04:27:47 +1100 (AEDT)
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
CC: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 17/18] crypto: talitos - chain in buffered data for ahash
 on SEC1
Date: Fri, 2 Mar 2018 17:27:41 +0000
Message-ID: <VI1PR0402MB3342BDF9D4E389B4E296A53298C50@VI1PR0402MB3342.eurprd04.prod.outlook.com>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
 <28d351a973d31d140239c7e7e64999d95a011e8c.1507284818.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/6/2017 4:05 PM, Christophe Leroy wrote:=0A=
[...]=0A=
> @@ -1778,6 +1814,36 @@ static int common_nonsnoop_hash(struct talitos_ede=
sc *edesc,=0A=
>  	if (is_sec1 && from_talitos_ptr_len(&desc->ptr[3], true) =3D=3D 0)=0A=
>  		talitos_handle_buggy_hash(ctx, edesc, &desc->ptr[3]);=0A=
>  =0A=
> +	if (is_sec1 && req_ctx->nbuf && length) {=0A=
> +		struct talitos_desc *desc2 =3D desc + 1;=0A=
> +		dma_addr_t next_desc;=0A=
[...]=0A=
> +		next_desc =3D dma_map_single(dev, &desc2->hdr1, TALITOS_DESC_SIZE,=0A=
> +					   DMA_BIDIRECTIONAL);=0A=
> +		desc->next_desc =3D cpu_to_be32(next_desc);=0A=
Where is desc->next_desc initialized for the !is_sec1 case?=0A=
Memory allocation is done using kmalloc(), and since desc->next_desc is che=
cked=0A=
in some cases also for SEC 2.x+, it should be initialized to 0.=0A=
=0A=
Thanks,=0A=
Horia=0A=
=0A=
