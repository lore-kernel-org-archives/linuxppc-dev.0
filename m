Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADA606A323
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CEVCSt52
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQGKC0zjWz2yLY;
	Thu, 12 Nov 2026 21:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794478047;
	cv=pass; b=dk9MFC3QknJeRzfynIy3YZysIsj3O5aMQb7pEJAQEBKqhGdCg8WgXx8jVPJZH9PN7DMFsFt1kQE6MtzgsZ8YCxhV1RusCjdsyJKVin7Sf5pJfYltv8szskusnzU+YDYMUkAZuRSslGfISV5wQ2G/X0KMnHzn7wr2JnUxgk9t8K2y1D8uKs/8YhshHJ9mbfCa/yHMkfg6DZ4Kjd6dDUVDz8x61murI+syPJqd/OQwBob6QGJhmRPHUi2477OXjTIOcl+VRfdaPDxxW6qQ7vsGHipi4ta4Io88569hiQZ/J2s1u7UGCRSBVuFE/abRVTcQy/sQ4gVK+D6vUjohzPkBnw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794478047; c=relaxed/relaxed;
	bh=H4bAaTrCqmctSADeFqQQX+kGXr4lncxWKiQe5n9FcE4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PBQzcEjoZLw1CW9QLXPpRcnLNpzN9SfNRvSMcDQlVWd+3S32De777DjAmKiuvFfA91/ouEOzAHmxG3CWYsahioRiYmke3Px06eSoJ+rn2xrRfBT94RltHdUomI9+KLFLnrJMudXqV/iAOC+/DY6MJOATnfaziafNLV4DzdndErff1r4XSxIlyZLhVmaCAajlKXw6XciuXiNw/8e3Y423nKutYNposQ0Eo60ezbYAR6Fi1/74hpusdg09GSKfLBBgaVzB3UrGV0TeSN70UiWwyPwAsNJCJ8lZEnhTaLV/so71sYV/1UhUYR/+9RXoj+5ggLwsLm6EITjpunqlsRRW3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CEVCSt52; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CEVCSt52;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQGK90p7Tz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 21:07:24 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqWbAD7nEoMXpFOO5RWD3j8ACtrf8j1SS/YPrJblLyGnswgziV0pXva58cL8rOb7XXS/z5za2dabXr/0K5DbqLEbhMsHsrINV9MTraqEKj/gZgW4Sgmj9daCabg6QgXuyydmma5nCkTH5LOAyU8Zxk1UQq8e+yUxxZiVrQbrRFaHBE0gwYeeFA3yUudCJJUsELqQdfYPyIFRxLdgeoBMtPBpN1OIzR4bSuT8wD3mCMwkTPbCFyvDNbU37HLa+9csvZqo8/MduK3H2chOivjPfN6TnwRbPV1jvcOj9lq7bRZ0kaZVy3Juaw3H2ahQz+ytonhKJ95dJ/vve2KYYzfkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4bAaTrCqmctSADeFqQQX+kGXr4lncxWKiQe5n9FcE4=;
 b=ACcL8aUs+o2NyFA+37rq6Wr5PZE5VUPZTJ7/4ph74l/UZBPp9yVFzR9N8erWQ+pu0hngBYGNbIW+3828HxN3a3v0KyhInm87RoA/kvH7+vjXuCnKRDCiG2+dZ/6WoRS6GMD5VUwyDnxY8aFzQ4xXIFSdFQTePAOWZwYcofw+AR+Zpqz3945CZCe7qoNVsQq0ZG69yZ9kWMzBXYo2MuWydWFbCs34z03eU4kQV2Iq1wiaYqT+hEzRCX2avOQup63wi8A4TpOoeyA0zVx4NErt3ivsioizVT+L5D9+b4WHMcAbEcMfWYpJUxC54ymmhOGofeY9T1/EY3qC91YJISsEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4bAaTrCqmctSADeFqQQX+kGXr4lncxWKiQe5n9FcE4=;
 b=CEVCSt52akwimUvq7ADgNOHRcXKt+sbxLb1oTDO8WxTWL7eD3DMaqblmQYFe1bVQKEUCQDXP5cloE0kx/2cM1MzPIr1SeAC81fkwBdOQzc0TwYFT66Z+lO4XipMMvD1fmjo9JCxHiRIBTVNP5FoARxgpZQfO0lOuMFpAe4ur53zRqCmoOIQQ6c/TT3EaH6dqj2/tx2y1gDV+6TPlls6ifM8u5Gnn88NBQVGWOpjJABlX5TFhH6EJtRLrluofmgV83wEjAnoQUeFXlHWeaVvCJ4aHXjGvZ9pFanmivLPsmRAMHJ+EaQu5rtbcgCzoF/L/bVpUoE6MxkUcjMDP25rQkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 10:07:03 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:06:27 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH v2 0/5] ASoC: fsl_asrc/fsl_easrc: fix memory safety issues
Date: Thu, 12 Nov 2026 12:01:00 +0200
Message-Id: <20261112100105.123845-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::18) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6763a21e-4807-4ccd-3e8e-08df40a469c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|10067099003|11063799006|260925021311599003|260925022911599003|260925021911599003|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	G8ektGFkcl2RXMwlAMzlWEXRJs/oKQXqvhd0G3QVhDDZSH0k9W0lgUK+S4L83OSeCu8R/B5HsPifDIOekTdZU0j/e0el4g2bt2TrQF/7Ny3ChL95q6Cxjdi/uV11h0MujJ7M1VF2WP+h5tfC3f+PrxglyhebmV8dgo+RpNiCI6Z/UIEViML/nw7QG1ozSu7r3H1l8JUenmaItd+Spwn+Paaf97qw8mQt001EWSa0OhT9ckfSbwMPMd0ddt6/n8x0fxvqVRUvlMV0CwJFRt/GLQ6mYpxf8cKQsCsPeOuPgYjPHHCgyOC4wAQpcBeA1lXCLJuT2GH6by/ucm0RC5qgyxfnHq/VesqRfx1bMMsiz2VQpRloHDzYkW1lXoN9juKVMoOQ7ckUKchX7MwlBozNxB0piH1iVIUIDmdrZXppVwuguLlwgZQWYTh/zqcRnXfLLy3mUgIuhxOvr9I8gbH6iqo11Qfk714TFVYu+WJyrqK/WiCOR9p/4i3mSgjjKidJCjePKc+KhHUqzGAqsyFGNufccSKwj+u3TyoKDtllVxvmU11zc9ZHqWZJXOOQL7DkZlFY/xPVBbZUfBv3RvsAFhQlqLU+0y/7r5ToQHyDFXvtA4KHBrWfOP4DDYLcBirF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(10067099003)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGphgyIYDe1o7/i/+86hEfYUIIU8L6VmfIlmSPLyanA3cGzLFMU8zKW9NNgg?=
 =?us-ascii?Q?gW/1nYXbAyiODZlAu1n5LGUv3V5qrp2zrzbKnCLz4Y0b84Y4jne6QIuRLvVA?=
 =?us-ascii?Q?pshYMGvDaeQKpleRsFiEVRSDKz/YEqfXMU1zcE+QWzi46AxtuTf46UM0px69?=
 =?us-ascii?Q?2rz+hY3R45N+8NIY5uclcYf2RBU+ZVjHHd5IXKSO4hBaJhXcd0OPUwN+efWY?=
 =?us-ascii?Q?zeStef1K62DcwXVhzRjxmzJ4cbRzTOlASWsYBaoIPtPcoSz8XFG3+qZaLKgL?=
 =?us-ascii?Q?YK4f1aeS71JiDwF0vDrM4xqVce75b23ijbasayDlvZ46qMKOyPmuj3UvFthd?=
 =?us-ascii?Q?icUjmW+v6yiZZnNR7VTyNHIHjoEgPAZ4S7fD73VkXQrZR35LpW5FZIGKLZm/?=
 =?us-ascii?Q?tos7pF2P47b+OITTTX7UnldUoMiTS/Pwj0D96dJn2jUxw8d523Ms6sgvOq07?=
 =?us-ascii?Q?FxVjPFpHO+n94y3mon1wDrTTQncCj8ExaC8eQo/WAaGSVXpYfd8DVeBeTtGz?=
 =?us-ascii?Q?rkh8P4N3Lvq6Uyv0n+vMbOjIu43J/S8OldKB3LH4fnHrFNpWk4LxBT2Dms3B?=
 =?us-ascii?Q?PbsYxNVGQuVTPQ81pm6qf5pwj0oYEXtbvGpJLD9dmjMnjhCrL7esQmNCdDgW?=
 =?us-ascii?Q?sB0B41S5GxkMoFJqo3ymnjrno58TJoAhl8r2JniDq/oJyGiaUMHWFCS/jF3n?=
 =?us-ascii?Q?KDbBGyB5QQnug+1sJJKQjLDDs5ZX+gkIauUWqRmseW7q8y8GsL3hnSHioY2g?=
 =?us-ascii?Q?5Xe24xYsl2oSDo7WRBuDCKvWj1Hv45MH4R6Ph8hPjJkN8IMaH9R8OCWR7/ts?=
 =?us-ascii?Q?l+sR6JhW9xF17Rhr3aeWpd3xQER/wzFXtUumG6+R0quvauFKTpxxmDacy328?=
 =?us-ascii?Q?bvGzgG3ByxISZLxPhCrWsPh390GEyAq6sD8u9jkdc00Lg8+2rlFPHSQrAZgc?=
 =?us-ascii?Q?ClNr+C5NhHi6VZzhN1d2LG5yM4sdUyeXBE+qG7EWuagFvzprvx7esenbEwGk?=
 =?us-ascii?Q?pycReadjpTfflHO4FxxHZ4sttOqMbp3wCQdoXEb9mNWo9aNTbQvyn811yD3b?=
 =?us-ascii?Q?z5HmkT0mMPpwbsAKsZoiX2YXC+HGN+R6yc5clBm2xRz0JRPTTY9whAWMZ/1F?=
 =?us-ascii?Q?olDgMng7taIx1aOkmk43nAl7o90BeWJeOS7n9G2ItRPfvdZ2seAn4V3kTdMH?=
 =?us-ascii?Q?F5BFZ4Cw5b+j1ipgDy9v/HsveGMH4zM/wY9VQ4eLAvsfbx8THV/tJXyjPV3r?=
 =?us-ascii?Q?XQoSNO7jUOL/wU/Awgcrzr0f0bs4SuF/FeeDJO6bta5xw2j9Qp+hJKq8GK88?=
 =?us-ascii?Q?XlxrfS/Jol11nRApB8tPoyorjR8/I5L0XR+9+6TPuFMTjXwcRfASrfJOH1oh?=
 =?us-ascii?Q?cpz9qnrCfCQ+OnAaCi8CBv/gwgC0J+QTiMJG3TScRH0vkguFlzJGzDuVUmQ1?=
 =?us-ascii?Q?j94ZvhBFHgSgrjoXNYBx3Ql/l/gucs+t7j//kRdUVQHb4nDzVCn6JCj0fS4W?=
 =?us-ascii?Q?A5H7BqMWqjMaPhSqyGY4mhcUZijBHveJQpsXlzAqyQq+8KfVV+I/NbqxRCmd?=
 =?us-ascii?Q?sTNX37pROiS8UQJL2NlAhkkb7LBxzJLZgYoxLTRljjheisLW3vIxe/7L8jiA?=
 =?us-ascii?Q?HlUHjp1Gla3m0UcjDR+ZzoyCzdbR3RKwPWBp3uaSfMuyNfw5YcrkZyBY+dag?=
 =?us-ascii?Q?3DZSUyRVIQERSDaEyozO0A7l9piwBuujVOMTOImLIHu0bThNZLmHJ9d2aZOv?=
 =?us-ascii?Q?eV1AWjh06g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6763a21e-4807-4ccd-3e8e-08df40a469c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:06:26.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+sCYKlCzmGMI+EUey3GzNYYVta/g/NZ/35RmKawPlgSfQJTHPWDKF6mFxKzcqrGeIisMKFJg9KZwzORsI7Ndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes memory safety issues in the ASRC and EASRC drivers
that can be triggered by a user with access to their PCM or compress
devices:

1. fsl_asrc_m2m: the output FIFO drain can write past the end of the
   output buffer.
2. fsl_asrc: a repeated hw_params() leaves a stale asrc->pair[] entry
   that points to freed memory after close, and hw_free() after a
   failed hw_params() can release the pair of another stream.
3. fsl_asrc_dma: DMA channels are leaked on a repeated hw_params(), and
   released twice after a Back-End configuration error.
4. fsl_easrc: the same repeated hw_params() issue for EASRC contexts.
5. fsl_asrc_m2m: more than one task per compress stream leads to double
   DMA channel release and a stale pair entry.

Patches 2 and 4 make the pair/context release ownership-checked; patch
5 relies on them. Please apply in order.

Validated on i.MX8MP (EASRC) and i.MX8QM (ASRC).

Changes since v1:
- Patch 1: drop the 8-bit output path, ASRC does not support 8-bit
  output (Shengjiu Wang).
- Patches 2-5: add Reviewed-by tags, no code changes.

v1: https://lore.kernel.org/linux-sound/20261110120743.6301-1-stefan.ghetu@nxp.com/T/

Stefan Ghetu (5):
  ASoC: fsl_asrc_m2m: fix out-of-bounds write when draining the output
    FIFO
  ASoC: fsl_asrc: fix pair ownership on repeated or failed hw_params
  ASoC: fsl_asrc_dma: release DMA channels on repeated hw_params
  ASoC: fsl_easrc: fix context ownership on repeated hw_params
  ASoC: fsl_asrc_m2m: allow only one task at a time per stream

 sound/soc/fsl/fsl_asrc.c     | 22 ++++++++++++++++++++++
 sound/soc/fsl/fsl_asrc_dma.c | 27 ++++++++++++++++++---------
 sound/soc/fsl/fsl_asrc_m2m.c | 30 +++++++++++++++++++-----------
 sound/soc/fsl/fsl_easrc.c    | 10 ++++++++++
 4 files changed, 69 insertions(+), 20 deletions(-)


base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
-- 
2.34.1


