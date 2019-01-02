Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C37FC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 08:16:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5A121871
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 08:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5A121871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43V3m03mC4zDqFh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 19:16:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43V3jl3NdfzDqBc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 19:14:19 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43V3jc5g04z9v0lq;
 Wed,  2 Jan 2019 09:14:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ji2xEjdDqvVd; Wed,  2 Jan 2019 09:14:12 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43V3jc46Xnz9v0ln;
 Wed,  2 Jan 2019 09:14:12 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 5D1D7913; Wed,  2 Jan 2019 09:14:12 +0100 (CET)
Received: from 37.168.207.163 ([37.168.207.163]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 02 Jan 2019 09:14:12 +0100
Date: Wed, 02 Jan 2019 09:14:12 +0100
Message-ID: <20190102091412.Horde.y2c3R1S1rMxnqDcnPLDPaA4@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: [PATCH v5] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
In-Reply-To: <1546446223-17184-1-git-send-email-peng.hao2@zte.com.cn>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wen Yang <wen.yang99@zte.com.cn>, Julia Lawall <julia.lawall@lip6.fr>,
 leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, qiang.zhao@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Peng Hao <peng.hao2@zte.com.cn> a =C3=A9crit=C2=A0:

> From: Wen Yang <wen.yang99@zte.com.cn>
>
> Currently there are some issues with the ucc_of_parse_tdm function:
> 1, a possible null pointer dereference in ucc_of_parse_tdm,
> detected by the semantic patch deref_null.cocci,
> with the following warning:
> drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenc=
ed.
> 2, dev gets modified, so in any case that devm_iounmap() will fail
> even when the new pdev is valid, because the iomap was done with a
>  different pdev.
> 3, there is no driver bind with the "fsl,t1040-qe-si" or
> "fsl,t1040-qe-siram" device. So allocating resources using devm_*()
> with these devices won't provide a cleanup path for these resources
> when the caller fails.
>
> This patch fixes them.
>
> Suggested-by: Li Yang <leoyang.li@nxp.com>
> Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> CC: Zhao Qiang <qiang.zhao@nxp.com>
> CC: David S. Miller <davem@davemloft.net>
> CC: netdev@vger.kernel.org
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org
> ---

In order to ease review, could add the list of changes between each=20=20
version=20of the patch ? Usually we do it at this place so that it is=20=20
available=20for reviewers but not part of the commit text.

Christophe

>  drivers/net/wan/fsl_ucc_hdlc.c | 62=20=20
>=20+++++++++++++++++++++++++++++++++++++++++-
>  drivers/soc/fsl/qe/qe_tdm.c    | 55 ------------------------------------=
-
>  2 files changed, 61 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdl=
c.c
> index 839fa77..f30a040 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -1057,6 +1057,54 @@ static const struct net_device_ops uhdlc_ops =3D {
>  	.ndo_tx_timeout	=3D uhdlc_tx_timeout,
>  };
>
> +static int hdlc_map_iomem(char *name, int init_flag, void __iomem **ptr)
> +{
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +	struct resource *res;
> +	static int siram_init_flag;
> +	int ret =3D 0;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, name);
> +	if (!np)
> +		return -EINVAL;
> +
> +	pdev =3D of_find_device_by_node(np);
> +	if (!pdev) {
> +		pr_err("%pOFn: failed to lookup pdev\n", np);
> +		of_node_put(np);
> +		return -EINVAL;
> +	}
> +
> +	of_node_put(np);
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret =3D -EINVAL;
> +		goto error_put_device;
> +	}
> +	*ptr =3D ioremap(res->start, resource_size(res));
> +	if (!*ptr) {
> +		ret =3D -ENOMEM;
> +		goto error_put_device;
> +	}
> +
> +	/* We've remapped the addresses, and we don't need the device any
> +	 * more, so we should release it.
> +	 */
> +	put_device(&pdev->dev);
> +
> +	if (init_flag && siram_init_flag =3D=3D 0) {
> +		memset_io(*ptr, 0, resource_size(res));
> +		siram_init_flag =3D 1;
> +	}
> +	return  0;
> +
> +error_put_device:
> +	put_device(&pdev->dev);
> +
> +	return ret;
> +}
> +
>  static int ucc_hdlc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> @@ -1151,6 +1199,15 @@ static int ucc_hdlc_probe(struct=20=20
>=20platform_device *pdev)
>  		ret =3D ucc_of_parse_tdm(np, utdm, ut_info);
>  		if (ret)
>  			goto free_utdm;
> +
> +		ret =3D hdlc_map_iomem("fsl,t1040-qe-si", 0,
> +				     (void __iomem **)&utdm->si_regs);
> +		if (ret)
> +			goto free_utdm;
> +		ret =3D hdlc_map_iomem("fsl,t1040-qe-siram", 1,
> +				     (void __iomem **)&utdm->siram);
> +		if (ret)
> +			goto unmap_si_regs;
>  	}
>
>  	if (of_property_read_u16(np, "fsl,hmask", &uhdlc_priv->hmask))
> @@ -1159,7 +1216,7 @@ static int ucc_hdlc_probe(struct platform_device *p=
dev)
>  	ret =3D uhdlc_init(uhdlc_priv);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Failed to init uhdlc\n");
> -		goto free_utdm;
> +		goto undo_uhdlc_init;
>  	}
>
>  	dev =3D alloc_hdlcdev(uhdlc_priv);
> @@ -1188,6 +1245,9 @@ static int ucc_hdlc_probe(struct platform_device *p=
dev)
>  free_dev:
>  	free_netdev(dev);
>  undo_uhdlc_init:
> +	iounmap(utdm->siram);
> +unmap_si_regs:
> +	iounmap(utdm->si_regs);
>  free_utdm:
>  	if (uhdlc_priv->tsa)
>  		kfree(utdm);
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..76480df 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -44,10 +44,6 @@ int ucc_of_parse_tdm(struct device_node *np,=20=20
>=20struct ucc_tdm *utdm,
>  	const char *sprop;
>  	int ret =3D 0;
>  	u32 val;
> -	struct resource *res;
> -	struct device_node *np2;
> -	static int siram_init_flag;
> -	struct platform_device *pdev;
>
>  	sprop =3D of_get_property(np, "fsl,rx-sync-clock", NULL);
>  	if (sprop) {
> @@ -124,57 +120,6 @@ int ucc_of_parse_tdm(struct device_node *np,=20=20
>=20struct ucc_tdm *utdm,
>  	utdm->siram_entry_id =3D val;
>
>  	set_si_param(utdm, ut_info);
> -
> -	np2 =3D of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-si");
> -	if (!np2)
> -		return -EINVAL;
> -
> -	pdev =3D of_find_device_by_node(np2);
> -	if (!pdev) {
> -		pr_err("%pOFn: failed to lookup pdev\n", np2);
> -		of_node_put(np2);
> -		return -EINVAL;
> -	}
> -
> -	of_node_put(np2);
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	utdm->si_regs =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(utdm->si_regs)) {
> -		ret =3D PTR_ERR(utdm->si_regs);
> -		goto err_miss_siram_property;
> -	}
> -
> -	np2 =3D of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-siram");
> -	if (!np2) {
> -		ret =3D -EINVAL;
> -		goto err_miss_siram_property;
> -	}
> -
> -	pdev =3D of_find_device_by_node(np2);
> -	if (!pdev) {
> -		ret =3D -EINVAL;
> -		pr_err("%pOFn: failed to lookup pdev\n", np2);
> -		of_node_put(np2);
> -		goto err_miss_siram_property;
> -	}
> -
> -	of_node_put(np2);
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	utdm->siram =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(utdm->siram)) {
> -		ret =3D PTR_ERR(utdm->siram);
> -		goto err_miss_siram_property;
> -	}
> -
> -	if (siram_init_flag =3D=3D 0) {
> -		memset_io(utdm->siram, 0,  resource_size(res));
> -		siram_init_flag =3D 1;
> -	}
> -
> -	return ret;
> -
> -err_miss_siram_property:
> -	devm_iounmap(&pdev->dev, utdm->si_regs);
>  	return ret;
>  }
>  EXPORT_SYMBOL(ucc_of_parse_tdm);
> --
> 2.9.5


