Return-Path: <SRS0=QoOO=KS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16B6C47080
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 May 2021 13:25:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D1661175
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 May 2021 13:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D1661175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fp1Lb5qRKz3bt9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 May 2021 23:25:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fp1LC4Vp4z2xZD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 May 2021 23:25:19 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4Fp1L224XdzB6pT;
 Sun, 23 May 2021 15:25:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsG_czGrW-V2; Sun, 23 May 2021 15:25:14 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4Fp1L212RgzB6hw;
 Sun, 23 May 2021 15:25:14 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id C951716D; Sun, 23 May 2021 15:29:37 +0200 (CEST)
Received: from 37-164-13-85.coucou-networks.fr
 (37-164-13-85.coucou-networks.fr [37.164.13.85]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Sun, 23 May 2021 15:29:37 +0200
Date: Sun, 23 May 2021 15:29:37 +0200
Message-ID: <20210523152937.Horde.5kC0kzvaP3No5BC63LlZ_A7@messagerie.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] ethernet: ucc_geth: Use kmemdup() rather than
 kmalloc+memcpy
In-Reply-To: <20210523075616.14792-1-yuehaibing@huawei.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: rasmus.villemoes@prevas.dk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, kuba@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YueHaibing <yuehaibing@huawei.com> a =C3=A9crit=C2=A0:

> Issue identified with Coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c=20=20
>=20b/drivers/net/ethernet/freescale/ucc_geth.c
> index e0936510fa34..51206272cc25 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -3590,10 +3590,10 @@ static int ucc_geth_probe(struct=20=20
>=20platform_device* ofdev)
>  	if ((ucc_num < 0) || (ucc_num > 7))
>  		return -ENODEV;
>
> -	ug_info =3D kmalloc(sizeof(*ug_info), GFP_KERNEL);
> +	ug_info =3D kmemdup(&ugeth_primary_info, sizeof(*ug_info),
> +			  GFP_KERNEL);

Can you keep that as a single line ? The tolerance is 100 chars per line no=
w.

>  	if (ug_info =3D=3D NULL)
>  		return -ENOMEM;
> -	memcpy(ug_info, &ugeth_primary_info, sizeof(*ug_info));
>
>  	ug_info->uf_info.ucc_num =3D ucc_num;
>
> --
> 2.17.1


