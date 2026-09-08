Return-Path: <linuxppc-dev+bounces-26802-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A43BC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 13:07:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfPP62yWxz2y2b;
	Tue, 08 Sep 2026 23:07:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788872858;
	cv=pass; b=YRMB0JR07U8QSO80WLvQ6TsstPuyXqHS2dtHfNI7QAs2VgitQ/j9RrVNxpHPs4AJydVfx32Zz96sfjZZcLv5hvAcuUA1DMRjN9ja/CB3CaSXgOpsFkfzxA9UCxC6qPVACGj97f/BnqgA9gpQdO+tsx1KeyJmUb8zhQAgWiZLpl0sfzPIOv0cLZiGntrSWc1xg61z5a0Sq/1x1vsM8Qkaw4MJFBageG9hsTwrFKBCHKOK3nDlQctjPkEFSIVavtQPESvgO3VqU1zzXDcdRDwRoojad8E8i+eKLzKAh0rlF17uMBHFBB/cpAcuXDrNkL8PfvogYbocDp7bvyJ/Rh0WLg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788872858; c=relaxed/relaxed;
	bh=MEjauvyT0w/GT73hhhlwoLtKxG4NTOTzFR4d3ry3foQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3Y5fRR9/hS3CJDq9pvw6bIWH32QL2RF9XnjlcsUfGLDNitioEAY75HzKrLUsdto84pgsIqfSNS4nMOKngIQz+0grl4P4nZjrK1AapurFzsMP6fPPyJBnOXkolgAEKyFl+HFLpU6/v6vzE9PubFvrmHC+MtW2v4rrv0Bm8P4FBZJUXaNhrM1z/YAcSnmHBCRMu/M7Q1Brx870338OhAEDbulk8/d8lO7bUJjRVOj2Wvgk+PEmrB0ihEz7R88UNkdpbUPJcYjYkCNofR6zwxRpkpFBDHfOvG654cxK30MwB9XbyzTCKpswM9Q6IhAaLFkQZ5tLuYIZBmbyQTOpVu/hg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZOkHf4XQ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZOkHf4XQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfPP41WHgz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 23:07:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVtbPGcGnk0tZ/mpLCZJighKoFT9cxaoGeV/AnV6O4sNGGhmxkNkjyyGcjmiN9xqRcPGj4LppjjmUAI+Lj2QnIkoI7QualvMhK4gBTgyEKxuhdROfOw/ioHQILfUeo0PHJNA4sNnjXfzilgBAcVE2k7LqH++O/5QJMND51v7U0+XiY5LVl4DMadYyHeaYdnVwKl8j8ayOZotxRgy3FxomoOhnsqgPfrkdfS5fwDQE1kaR/bUydOdcdcS+u3uFlHOciysWLG3xYOuOFFRwOcIUuMfUrfmy2Eq1ZItjIdJIENZMsVoh4boucm3rGvc2OjjDSkEfAoWNdK5wKlKLiOBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEjauvyT0w/GT73hhhlwoLtKxG4NTOTzFR4d3ry3foQ=;
 b=ZFU+Hth9NZGq6jqphhzxFlY7QzhP+wJgt1Fi7rxk08cXm3H99EkCc69AY1cuxzn9DTyMGGlgATe12M14y/bCFQ8Nv4Q0ptN4Z7yV2lfszDxT7lZyaA3Ck2U87Hnjxzyycn0AheuNoukOiokZaW3G0CXsfUZmgy1j1iqxSCHnLTcIQ2+CEpQgQbCZAAa0QL2yAbllf7tX6Ew9HWL0qUyy9+5lkDMS+Sj1A2GVSuFBBncKmUI7C1LKIrUBqP3JmvsdvQXPrzRIHi9Xjgiwl1XDi0c3A/gVEWfLQ4xsZEMuoyAYaFI2P/QF2waKpVxwtyln/ecgpdw+pGc2NmjCZRzaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEjauvyT0w/GT73hhhlwoLtKxG4NTOTzFR4d3ry3foQ=;
 b=ZOkHf4XQiWCUBL2JDhs+nXZNus81jcSKTL4Nfi/ZwIjfHoI0F4BRMZopOVIllYQCHMoBR4aeuJlN6ig5pF7+cVxLUc+YDZm26PqOExsP4MIK7Bef4PiXi/exVVo2x1LJ/4GyMaQ4/DSmEPWalaBosYvc2F051CmdxdVl5Aw5vkGvzUsKHHR1P40b3CnuiAKQ/2kn/0wlGWbRfP2vs01lDe8zHHDZrww1MqpSUcfHUl3XeqSU/Dr6c6SwxWynv9RV5+I8Q+qRaRNZpavUnHPxTL0g1qnRKZbnucHznLt2AVml9kGGISgYhFcjXGnLOtmFV/5aQvvd9PDoqoZ+f6r3zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by MI3PR04MB12634.eurprd04.prod.outlook.com
 (2603:10a6:290:81::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:07:06 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 13:07:05 +0000
Date: Tue, 8 Sep 2026 16:07:02 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH] bus: fsl-mc: register the object drivers after
 misc_class exists
Message-ID: <dvnnk7fnk57x7gf4mc25codec62xtpbe4v7omhjguqxd25ssmu@pqqjwe5xif4q>
References: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
 <fmmf72ypmmooyxszz3l47xabdhvetowgvbmbjmvj6bumuh5onh@pntmny63urbg>
 <ap7mmR_4QV0k88dK@L30177.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap7mmR_4QV0k88dK@L30177.local>
X-ClientProxiedBy: AS4P195CA0009.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|MI3PR04MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: 020231c5-3547-4dfa-a886-08df0daa14e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	EWyeWTWAyetuuPu+uVQvl6l1yRaW92ojPmC7Co2hrxcD90K/mUtl1OIZ5AiCvPuSV9TkIbQkZ2ORhjNqxMxoLMsXQ4zzKYmWquUWIfqzXeDLjndsrrVz7kdPG7uVZiBu907X866M3TTc7jE35M80jRlw50UC/d9M8qKaxh7BCm8bJIL0pXfBeYVM3pIihAuCqLTJpl1hnKjW6ljX3SPfMOv3QfHTyESJ0I75AFbKsWPAtJ1S+rCV/WPyb/n/jeYaPn90hKIOcv9mX5H7Ews1iEhMzLjoPJp8PQV6HYbj6D1Y5+eqygiHI1YmJOHRWaFCFe1Vx76xe0PMjlyBA55uDdpXMO04vj0zPaE7u0vP5N4E3DpWyimZfUqJ+RKqEKwSMYqk4EksrPiwNZExzk6bybNCHNjalJJGjv1OHib1DNe6XqzDZCx62X7W9nVrw5F6rs6+dOwXBgUTK68fx7SaxRKufyNJSDVnJoPKV1ecKOXXsi795zfbTxfnLrhQC8tl+7yuTS6B5sg/DWGNIFsWaCZ68pBbTNB7ujvAMgwhSWWyslWmfZFr+2tRYL/SgodVVBqwnKHvSkW+bdJvjEUAyPVssUoLBxoocnIfFs9pGiTqjo5t2min0xqRp76kHC6MR0rAzmqsp/3lEJ0Kd2Od94KiUrxzsxJUOGoqlqErRQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5hFIu/7lXIcur34XKm+N6ZZDeP58RBirwypMTa40t66uGsEnGDhghdKxRIj?=
 =?us-ascii?Q?RK1f/fBR27zXxWgnN/GJ2mm+jY+fHCh/0WETc6qd+NNygSuQuojSq/Xn/2R/?=
 =?us-ascii?Q?60V/XZf4rHqtJEUF0Joah8JiJxdWWHW6kKuqajde3osUy1TUffdzUivzuzac?=
 =?us-ascii?Q?9bVmjUn3gWxqJK63IcWBLL7EgEGB+BuBCujWejfMzoKdZ92YYopJapv4fShz?=
 =?us-ascii?Q?UpQAGhI3j3kdnEIiLQjS13FrldfT6dcLjT2iGTts+hb+OGUZQ6SwjdpvU4an?=
 =?us-ascii?Q?6HdpkVlD2zbuUCIE5fqu2FCM4ohP1mTxpG2I48DbLPIGDfVmqFAhMbHilYsX?=
 =?us-ascii?Q?JBP6pVNNneRMcCXfSP18Db3uc5Gm0TlqQPlpPPEWzbQUYGh9BRH8/gALiWIG?=
 =?us-ascii?Q?H7j/QWEVnbf4EokMJunqtTSs5n8Z7rXpiWco/EF1GRD5ADzJ/jG5hEuJ0TjL?=
 =?us-ascii?Q?PHvDNkLPYckR2UBn4Lebg7ftBRmYFto8/srulkXUL6ayIHHuktaobDnrE1yI?=
 =?us-ascii?Q?bXsAjXT8DFf/1gK2C6++aMfw9n9hiaR8UFZ8VdbBnDI3Mmtm1uCu9CFZ17N0?=
 =?us-ascii?Q?Hkh310zTIbO2Z+H3BV1Tw7oSjKysFa26YClsreNeYjQOcgndnhK5GA6hkmUB?=
 =?us-ascii?Q?1Kf1IhTGfc9TSG8HBQ3GaBQYZfjI3nyIATmrfed9/tRK1TU3K77Kj2O9RTdE?=
 =?us-ascii?Q?tChurraZMWORSwtWd7iDFDUx93yYx+pr+98M0+p4Jw8d+2k2TqZiWHhjEFpb?=
 =?us-ascii?Q?cP2lNgP5oz6X9wicZ+66rG/RYfh3mqQ4VaL1ww+1p4Pw0hSPmd1d+z7qBM+J?=
 =?us-ascii?Q?ZmdxazJuRvjZ1Dtm7s2eNLoiOj9lR+CoNE6PslkQTJZCPdmtpj9rhfiZn1j5?=
 =?us-ascii?Q?LM6pWAVB4McXwGNDqv8AiErRog+v1z3LSEy4zp4gb74cJPGz5b3P9IMFFRA0?=
 =?us-ascii?Q?BOgckNpp0TNsNWNEEm2LKWgW1IPohjwhSPHQ0rlK3QsEOutiw+JtJ7/HSxyN?=
 =?us-ascii?Q?HyZIw+EFVT8weMZ+yXepRXHMg2ohfJTGLT4Ju1FZCEqEOxqRMIONAeJvhal3?=
 =?us-ascii?Q?eGA5Ouj1YzCK/Qm0wDP09aKbby4xaRQtx7hMcuwwe1p+ZJQ60cpiguXl2pY6?=
 =?us-ascii?Q?H9yNjY45OH3xDq+AE1gS38teJwRtg8pNyyqhMsChLgyIs7SX7K3y+IKaAGrG?=
 =?us-ascii?Q?RmTjw/Q6dBL2fUB2YrospGPCsYywIisRSexvJoriBt83Ck5mO9EU0j0QMKw5?=
 =?us-ascii?Q?jp5pnsQpMbzERdeL6RP2AozYaS7IPBL3sDaliUQdZD4m67eAoooWWLBraSt8?=
 =?us-ascii?Q?1y4MAx05xJAy6IkSdkH8q6LDyLZwmEti970cNPh6s3wMZcdUzRwibh0rRUVt?=
 =?us-ascii?Q?SUjG2HPRAQVyvUXIwb5gebFiJrr+X67/cHLpSWYGe9U5KxFcusVKlO1/vba3?=
 =?us-ascii?Q?7FPoVMwMcvmwXsf4fP+fhuWa9+7CzpUjHeVZbQvRV01YRgOs0MX0/8p8sTmo?=
 =?us-ascii?Q?jsyhtLt6dOsFnMVDicLNuy86P39Yj4wJhmkY81rVMzZe08Geso2bN9FKW8rC?=
 =?us-ascii?Q?8esgSOF5aboI09hHwspBytWGIbOv3SGc1T2uVxXFpuHhuiwu8LNnguh9bWaV?=
 =?us-ascii?Q?NJQWflu7hIQzNARN4e//6SLhvbPYQ2rWKrtXj3JJ0jP6NrQ83K4sXNNhUm77?=
 =?us-ascii?Q?rZHKXfLw3FDvROHme1sEZVoIcfpY0rWR4rh26wsVaXt1V37dOpem/bU48QyS?=
 =?us-ascii?Q?o/J+NupVRA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020231c5-3547-4dfa-a886-08df0daa14e4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:07:05.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1pzR06jUZ6X4Rre2vkF3plGGI7jv3Jsk7+usJHHwnGt3tTniMlcWng2gZkAo7awVHZTFqhvRFB2ahJ4lbzMIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12634

On Mon, Sep 07, 2026 at 06:30:17PM +0200, Vincent Jardin wrote:
> Hi Ioana,
> 
> > Do you mean that the above error messages are triggered by an unbind and
> > bind sequence like below?
> > 
> > $ echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
> > $ echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/bind
> 
> Yes, same sequence on the root DPRC
> 
> > I am asking this because I cannot seem to trigger it myself. There is a
> > misc_deregister() which should remove the char device upon unbinding the
> > root DPRC.
> 
> It does for every normal misc device, but not for this one, because the
> root DPRC's misc device is created classless.
> 
> You can check the states with:
>     grep dprc /proc/misc   # e.g. "256 dprc.1"  -> registered
>     ls /sys/class/misc/ | grep dprc
> 
> If dprc.1 shows in /proc/misc but is absent from /sys/class/misc, its
> misc device is classless and the unbind/bind should collide. If it is
> present under /sys/class/misc, it was created after misc_class and the
> sequence is clean on your setup.

Yes, it is present under /sys/class/misc.

	$ grep dprc /proc/misc
	260 dprc.1
	$ ls /sys/class/misc/ | grep dprc
	dprc.1
> 
> fsl_mc_bus_driver_init() is a postcore_initcall, it registers both the
> platform and the dprc drivers.
> 
> The fsl-mc DT node is populated at arch_initcall_sync, so the root DPRC
> probes synchronously.
> 
> dprc_setup() -> fsl_mc_uapi_create_device_file() -> misc_register() runs
> before misc_init() does class_register(&misc_class) at subsys_initcall.
> 
> misc_register() does not fail in that window: device_create_with_groups()
> with an unregistered class creates the device with no misc_class
> membership and still returns 0.
> 
> -> So at unbind, misc_deregister() -> device_destroy(&misc_class, devt)
> cannot find the device within misc_class, it returns without removing it,
> and then it leaks the device + its /sys/dev/char/10:<minor> link while freeing
> the minor. The next bind reuses the minor and dies on the
> duplicate /sys/dev/char/ entry.
> 
> I guess, from my setup, it happens when the root DPRC's misc device is
> created during the early probe, which needs CONFIG_FSL_MC_UAPI_SUPPORT=y,
> fsl-mc built in (not a module), and the root DPRC probe not going through
> EPROBE_DEFER.
> 
> If it defers, the retry runs after subsys_initcall, misc_class exists,
> and unbind/bind is clean -> which is probably what you are seeing.

I am indeed in the case in which the uapi support is builtin but the
dprc.1 probing is deferred, thus it will get executed after misc_init()
had a chance to run.

The deferral happens because of_dma_configure_id() returns EPROBE_DEFER
since it waits for arm-ssmu to probe. How did you get past this
deferral?

> 
> I started to face this issue when I did try to restart
> the MC from Linux userland instead of uboot in order to be able to adapt
> with some DPC changes during the runtime.
>  see https://github.com/vjardin/lx2160-sdx/blob/main/src/lx2160-mc.c
> But I guess this issue should be quite generic.

Can you reproduce it without restarting the MC: boot to prompt, echo
dprc.1 > .../unbind, echo dprc.1 > ..../bind ?

Ioana

