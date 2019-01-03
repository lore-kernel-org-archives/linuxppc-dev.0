Return-Path: <SRS0=6Lu7=PL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64764C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 06:54:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4922073D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 06:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ktXFNGJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4922073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VdvL43XQzDqML
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 17:54:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.82; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=madalin.bucur@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ktXFNGJS"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20082.outbound.protection.outlook.com [40.107.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Vdsf57GKzDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 17:53:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/diXMrTZOKddgVwCMLOnxuklzjP3qtNFpJFmOyNhus=;
 b=ktXFNGJSgmePSQvieKI6jff/MDDTUgOA7BAb85ttMvRpkgaR2HLYjAgVxJavW1hybRwuwF6dt6OWS2RX4OlZ0t+cjfJ7fwQEgWfKs/46HQyGnXCvXAWe5V1zfaZYxNfroHZT4AJq04IPe8Ti2wkp9nmnN8NaVbdeyULBspPRLHo=
Received: from VI1PR04MB5567.eurprd04.prod.outlook.com (20.178.123.21) by
 VI1PR04MB5919.eurprd04.prod.outlook.com (20.178.205.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 06:52:58 +0000
Received: from VI1PR04MB5567.eurprd04.prod.outlook.com
 ([fe80::4982:5d2d:5e69:f502]) by VI1PR04MB5567.eurprd04.prod.outlook.com
 ([fe80::4982:5d2d:5e69:f502%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 06:52:58 +0000
From: Madalin-cristian Bucur <madalin.bucur@nxp.com>
To: Scott Wood <oss@buserror.net>
Subject: RE: [PATCH] fsl/fman: Use GFP_ATOMIC in
 {memac,tgec}_add_hash_mac_address()
Thread-Topic: [PATCH] fsl/fman: Use GFP_ATOMIC in
 {memac,tgec}_add_hash_mac_address()
Thread-Index: AQHUnkReVZ6jM9OncECw8Orp3X4qQ6WdJU5A
Date: Thu, 3 Jan 2019 06:52:58 +0000
Message-ID: <VI1PR04MB5567D128DDAE6038923677E2EC8D0@VI1PR04MB5567.eurprd04.prod.outlook.com>
References: <20181228002909.GA24228@home.buserror.net>
In-Reply-To: <20181228002909.GA24228@home.buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5919;
 6:eI2T79STviCdlEroYmZWEpoKlLMCecchmHbGWCqdfMvpRfsUj7tgm7LVTegyEO+cf+in4GkW2TnvVY76qG8P2tBAuVRM4m3ed7MFQbbljF+5kj51mddMUDxHJk287aXnfa9p+07xctGEuYbasN2W80mJfMwWsYCcBL1gOv/Ixtcpqg2l8HJnFeUiimsSiC+zWgUB7hVTbgXciO87D2M4R6PUvn065ybGP1b/ZI3Y8F6q6R44vb/ctIgEz8wlfuOu6/hsXGBfkz8b4Za6J1GJJox262Manh0BXd4FRXu3OnJYD3PPzizPwKPzqZdrCzYOXOeIJTve/LFPhE1EywVzsI8sFqskTVHQqPHrcC0u99AMI5dPy3n0WRuKuzCb1edgWpdldarhXdnzl+pkHr5UDFUTqdWfHtHDRHvxneQebWz8MKLp7FYLPUbdga6QkMmzbk6xckTgvH3FoRRfslfssQ==;
 5:zjhHkrcxsy7QCjWHntYI7wVM4xm4EqesBvq4an1pvsu8fqv6mzFLvgsU3sOVBQ64Ah8v6NHsMvDN6QjRjugbtjs3H6UBedzw4SGL/18P21Y53ryucENgfQf/nR7as28MuOA+f4cU88CSuUv23JytjkPpzwf+2ek9FAWTM3oVTf94jaCPu4Mc9w9nBj3gj6y9OmTtK+Mzkrn8zBwCntqO4A==;
 7:bhnLiIrbF0krAyAXAvOc4Vwg7Q3u8YMoy7b+phZ6/8fBzYAGzwniR6xsWVm1QCTqXnbVnjSUKruN3RfH17RNLnNOrAskkIGM9SYiBYAIu8rPbjzx0nnLyQI5Y0iORMxFEC7bo7Dd+0gC/0XUlGEYag==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ecc31ca6-2c5c-4055-e883-08d6714818db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5919; 
x-ms-traffictypediagnostic: VI1PR04MB5919:
x-microsoft-antispam-prvs: <VI1PR04MB59194570E736CDA036E8F821EC8D0@VI1PR04MB5919.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5919; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5919; 
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(13464003)(6246003)(6916009)(25786009)(7736002)(305945005)(71200400001)(53936002)(4326008)(5660300001)(26005)(186003)(14454004)(6506007)(53546011)(81156014)(8676002)(33656002)(106356001)(102836004)(81166006)(8936002)(105586002)(7696005)(486006)(9686003)(71190400001)(476003)(74316002)(11346002)(446003)(76176011)(97736004)(6436002)(478600001)(229853002)(3846002)(99286004)(6116002)(55016002)(2906002)(14444005)(256004)(86362001)(68736007)(66066001)(316002)(54906003)(142933001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5919;
 H:VI1PR04MB5567.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oiNGn0mN7RHs2UFNBP0TqXaF8qfNZvUHkRfB8Q18oYQK7ok6sieXWpK1O8RafwjpW+DUSYfdBf9Uk/WM2d+EgJ2E5MuWJijC4yiPK9ie+1JTGoVrqTgqk1xkO3yR7E7KG7e039ct0fQH9l6VpaCvY+TwlFDJyl8lNjbP37WUSJIWS82fNV8y05CDYSCMChwFi+fd+CHsf31RllPDp4tJoWR941lZ39CivmQ9uGnehPSp5zkSLlExVMf3h6OA1UzgeUasDlWUpeQr56iZeB3fH1GvcY53blHryIvQFtzOxwQyTnRkuR2awNmqgkn+oTmQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc31ca6-2c5c-4055-e883-08d6714818db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 06:52:58.6361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5919
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> -----Original Message-----
> From: Scott Wood <oss@buserror.net>
> Sent: Friday, December 28, 2018 2:29 AM
> To: Madalin-cristian Bucur <madalin.bucur@nxp.com>
> Cc: netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: [PATCH] fsl/fman: Use GFP_ATOMIC in
> {memac,tgec}_add_hash_mac_address()
>=20
> These functions are called from atomic context:
>=20
> [    9.150239] BUG: sleeping function called from invalid context at
> /home/scott/git/linux/mm/slab.h:421
> [    9.158159] in_atomic(): 1, irqs_disabled(): 0, pid: 4432, name: ip
> [    9.163128] CPU: 8 PID: 4432 Comm: ip Not tainted 4.20.0-rc2-00169-
> g63d86876f324 #29
> [    9.163130] Call Trace:
> [    9.170701] [c0000002e899a980] [c0000000009c1068] .dump_stack+0xa8/0xe=
c
> (unreliable)
> [    9.177140] [c0000002e899aa10] [c00000000007a7b4]
> .___might_sleep+0x138/0x164
> [    9.184440] [c0000002e899aa80] [c0000000001d5bac]
> .kmem_cache_alloc_trace+0x238/0x30c
> [    9.191216] [c0000002e899ab40] [c00000000065ea1c]
> .memac_add_hash_mac_address+0x104/0x198
> [    9.199464] [c0000002e899abd0] [c00000000065a788]
> .set_multi+0x1c8/0x218
> [    9.206242] [c0000002e899ac80] [c0000000006615ec]
> .dpaa_set_rx_mode+0xdc/0x17c
> [    9.213544] [c0000002e899ad00] [c00000000083d2b0]
> .__dev_set_rx_mode+0x80/0xd4
> [    9.219535] [c0000002e899ad90] [c00000000083d334]
> .dev_set_rx_mode+0x30/0x54
> [    9.225271] [c0000002e899ae10] [c00000000083d4a0]
> .__dev_open+0x148/0x1c8
> [    9.230751] [c0000002e899aeb0] [c00000000083d934]
> .__dev_change_flags+0x19c/0x1e0
> [    9.230755] [c0000002e899af60] [c00000000083d9a4]
> .dev_change_flags+0x2c/0x80
> [    9.242752] [c0000002e899aff0] [c0000000008554ec]
> .do_setlink+0x350/0xf08
> [    9.248228] [c0000002e899b170] [c000000000857ad0]
> .rtnl_newlink+0x588/0x7e0
> [    9.253965] [c0000002e899b740] [c000000000852424]
> .rtnetlink_rcv_msg+0x3e0/0x498
> [    9.261440] [c0000002e899b820] [c000000000884790]
> .netlink_rcv_skb+0x134/0x14c
> [    9.267607] [c0000002e899b8e0] [c000000000851840]
> .rtnetlink_rcv+0x18/0x2c
> [    9.274558] [c0000002e899b950] [c000000000883c8c]
> .netlink_unicast+0x214/0x318
> [    9.281163] [c0000002e899ba00] [c000000000884220]
> .netlink_sendmsg+0x348/0x444
> [    9.287076] [c0000002e899bae0] [c00000000080d13c]
> .sock_sendmsg+0x2c/0x54
> [    9.287080] [c0000002e899bb50] [c0000000008106c0]
> .___sys_sendmsg+0x2d0/0x2d8
> [    9.298375] [c0000002e899bd30] [c000000000811a80]
> .__sys_sendmsg+0x5c/0xb0
> [    9.303939] [c0000002e899be20] [c0000000000006b0] system_call+0x60/0x6=
c
>=20
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  drivers/net/ethernet/freescale/fman/fman_memac.c | 2 +-
>  drivers/net/ethernet/freescale/fman/fman_tgec.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c
> b/drivers/net/ethernet/freescale/fman/fman_memac.c
> index bc6eb30aa20f..41c6fa200e74 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_memac.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
> @@ -928,7 +928,7 @@ int memac_add_hash_mac_address(struct fman_mac *memac=
,
> enet_addr_t *eth_addr)
>  	hash =3D get_mac_addr_hash_code(addr) & HASH_CTRL_ADDR_MASK;
>=20
>  	/* Create element to be added to the driver hash table */
> -	hash_entry =3D kmalloc(sizeof(*hash_entry), GFP_KERNEL);
> +	hash_entry =3D kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
>  	if (!hash_entry)
>  		return -ENOMEM;
>  	hash_entry->addr =3D addr;
> diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c
> b/drivers/net/ethernet/freescale/fman/fman_tgec.c
> index 40705938eecc..f75b9c11b2d2 100644
> --- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
> +++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
> @@ -553,7 +553,7 @@ int tgec_add_hash_mac_address(struct fman_mac *tgec,
> enet_addr_t *eth_addr)
>  	hash =3D (crc >> TGEC_HASH_MCAST_SHIFT) & TGEC_HASH_ADR_MSK;
>=20
>  	/* Create element to be added to the driver hash table */
> -	hash_entry =3D kmalloc(sizeof(*hash_entry), GFP_KERNEL);
> +	hash_entry =3D kmalloc(sizeof(*hash_entry), GFP_ATOMIC);
>  	if (!hash_entry)
>  		return -ENOMEM;
>  	hash_entry->addr =3D addr;
> --
> 2.17.1

Thank you
