Return-Path: <linuxppc-dev+bounces-24113-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59513C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 12:48:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzMgr4DBxz2yMm;
	Mon, 13 Jul 2026 22:48:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783946936;
	cv=pass; b=VM1T5HkaNCYOhTNDFDZJ2avlU+gz7ulqaanXkyxjxMPzsSEfg8AshCKsHVPJQWvurkTHAqrSoPeWCZx2Qbu0SPBSeKe2B5LnGyH8KIskXpp0+mOE5dKiQbGMQjEYeuPD8+zs7fWEI55sDaI/xenSdlNgsyot76W5+d2Ddp2YFNzaI3nYJ4s09aDxlclyZJjf7Zhh32syz0bjA8pBu3sjiVgY4Rrq4vk4uPD1v+FuHdYyVvu/ldTQgxIiW+kws3QuWbLSEjERgRM0KitOUs4/2J8Ol7uj7x6NbJGlVFUusB+/uwzUw6oWNZWLWjoKMK3n4Alq++BjN+jxGh8ZPdk4Ig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783946936; c=relaxed/relaxed;
	bh=t4y1sHsk/GPUBGY4gtC4YnP3VmrK8LnUyn+kSH9fnuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i3Bo9ZdsTDrC++hM6+20YIRtO0vXxBQo/nkqmvjBdiRQA9D6xucucIlMvWyL/V6pdMP5YBo0xX+Ro8CNgaDvZmyQ02HUk1eB+beLiChhZwfO2fca95YYhk3JEP9akkesrSr7plhnALEl/U1W1AqYd31rjMBQtM1HRPGWFoLWklDl1m2FuTXB+hhtLknq7859a3aDNA6zIP5uA5kbWQsu9KT2jh7YhJH4p6X2qULl+wnYftUIvEg6965Xt2AJMbYlUFQ1PP8vZJpOIjWd6c/GRzWi9KdhvTm2TnzTMkFnbrGD7CQJhdUA9DHnybi1SehvtDgiKoKaIT3A2hW18B3SLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HDldMNNV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HDldMNNV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzMgp2WGvz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 22:48:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+aF7108NdaMUcAmyfozVV3459ovM0pCHgLENtXfFsgIs7Y0wGfsljvRObvcWHG4YHdz1k+RM13rYuVb5Cr3cpbKXQib3kCKlilZ423cEPTagW9b+FXp21CetWMcRBUFHe84emR5gI9wCKnAjCaabQDMrIbpj/W9bWD8xfLcz9eMczQDVSuohzd/AMeDx8JQ4YA4IUIVwdqNX6dibeKlC+vQXbGdOGKFmW7S9DWOKpsvLPKUVxXNZREMyuDwb5l+xDM34IAqE12bHYEByEtW1u3cf1CIq/n8Upb1M5CrxJXObu6DRnacvQCyvMvpdqmbWadMQGvszvDOx1sW0FkCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4y1sHsk/GPUBGY4gtC4YnP3VmrK8LnUyn+kSH9fnuA=;
 b=ybT3E7cLvJIwA/p2XrxzDTi4ouLkQf2w6KzNaYi/I08sD01thjg9U+/9Honz65K6tk4Sr9BFVuMEupIDI08tc3Cg3eYdISHyd66QP33aex9C/UFUFMrU4jW0eoZxvSEYxAhHVQWS6WrC5/0hWhND4kJ9WKeoDGF0dVyMry4mZ2NWkgbODUT4DNx4Xk06yUDfG/MV06A9U/b6BJvIBFX+XBG1fxlMY+nahBdkC44Q9Kkq5oJUa3GdjdtngOuLMqlId+l3SaYvfPbKJKMUF5/ThcDIHz45Wpmpnc7mIqj7SugE5FuUOLNi/rjhD6Gkw/Cl//Td/lcmdVK6dc+seyJtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4y1sHsk/GPUBGY4gtC4YnP3VmrK8LnUyn+kSH9fnuA=;
 b=HDldMNNVgIubKG6OAZuCjtSTP+iYpKbdBQiKGQ4RgyaieIjoAZ3xUAprL4J7LFB8vZnl60sc8FaGXsf6vl2DTUhQJNHELXUSDxWGwrM7SGxMpksb5SB9mqXlJMbDWV/U2rs0We4RDX48eXucN4IMyZJkrrRjtQgjOu4oA3Tqz0ROfMYm92IbSP7GO+mPC0qG5CcQa36g+wXUq9M9UD9ujOkI0Xpo8EPMYGYZpuayj3ekRKkKtB2Gjwz4JpN631gg6xaue2Udvgzeds5CzQq3UXwLPQuEAtEc/mUk3akZnvlSP0HFeSUqnXYY8TxdODe2xlL5V2pt2pl00la7fwIW7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM8PR04MB7361.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 12:48:28 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 12:48:28 +0000
Date: Mon, 13 Jul 2026 15:48:24 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: "open list:QORIQ DPAA2 FSL-MC BUS DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:QORIQ DPAA2 FSL-MC BUS DRIVER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] bus: fsl-mc: Remove redundant dev_err()
Message-ID: <423333cre463l7eaxmpelo44qzqc6ah76lpmgh5mgwlbaccrrr@tdgjp3zac6s3>
References: <20260710110930.462109-1-panchuang@vivo.com>
 <20260710110930.462109-2-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710110930.462109-2-panchuang@vivo.com>
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: a586a6bc-dc64-4608-05e4-08dee0dd093c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	JQ3OJPzPlxRpLVYmPAcexXU+snf+QInVr5vypLWoSy+QisqkuPRurnLqcOZw2BAOSNuBFRDB87pqFdGLNRtyoybwPJ7mMSMIIgZQf3QZ0JvRpY7sUbPdXpBJGK42qyp/kk01xYVPJoKw2Py6iGqRgLv1Z7HU1MNRdkpr1qsmaZ+QYL1CMlq03DvvMKHo3g2ZS+yeOcbMZE1WPOQr0eVFMCZfiodbClw6ykM1+02JEKPaPwMWf+GbG5I2jBkmIqXbaUj7GONT/vmSNAUb1bNuk30B0v586ildus/VhndeorDLaCZZWIAB2D4SkEFBUXRIecmEh2L7zaIvKsRbjRHLg2CFst3KhlJop5Y9BDmxJqOtueLcqtekzjHFEoyKbaEjURSrm1GDRwyBDVEeFOrNOAhylxBxbbAB/Fj0V0xrORLOxAZxZ56z0Ay3yyOBaT5R29t5jrnaT2TSoHuOkPQC19NbqchtEt8oWQIPm/OQzJMMqmszyYOy5kQOzHtuIHj2sX1xaOZlcHvJ/OgkBI7+dF1gR4pDUla3fxCjsIanXXt0W3R/1MRwipJ23tG0yFzJ0Temubbh+hV6ol1QHmrhEr/+8XdsqEwaQ2SwsTFNXUMUne2Z4Wf+C3yKWpQr7mkh0w+BlV2oX4dJQlWT8ISTQPZiQ45pl4uMPN9CglWlOv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X+9P/fZROmo2mi8VmPdGk/Sm/W1DsiTBEJOTJAmOcsi0VMFjePglokbW95Bg?=
 =?us-ascii?Q?FFz66lZ4fvNNV3TeO+Zp4qnaM3WLPHXQ7I3kqc5m+LtYjKazjsmORxQfnUEF?=
 =?us-ascii?Q?NIGNLIlxxfdFm6jaJ41CpvQXql0bPwckyvqbLoXjKFc69Xne7+znRIoXJETe?=
 =?us-ascii?Q?ciLFEqmoniEyKFNsop9O9UwiITygXeMUr3DIaJFbmgFUvNBXmgJIivetfIve?=
 =?us-ascii?Q?4ycGBWQhNwJzwLlP72DqnKXLDjK3UE0e6O6LIRCqUUOYFT3C/oRFVw7V6ldQ?=
 =?us-ascii?Q?B0fKJ2wjLs3o7lW7mo7WY0Q+a1QGlzNBSaFa3YqXhaxcXGqAlUgScQNDPj4W?=
 =?us-ascii?Q?6Q5UyWNjzrZr9jLdd7seqp0EWGgV7p7cnkiGaCsSjOdB38mrFdq4ct3K51rn?=
 =?us-ascii?Q?lDkP4vxF8jN5RPFDDSieE+3CIdFdQQvfrr5nJJSULeh/syZyVwYD0Mdo8fjO?=
 =?us-ascii?Q?yQwzVG1j4V5Wq2q7lIYkhYDj00bcanK7AXJW5Tg78P4eNv4O+YTuAYH3P3Bm?=
 =?us-ascii?Q?G2d547sVfiK4whqZYcEVnAtND9QUPfxVzZV9R3uo03qAO4J926DlwO7x2geO?=
 =?us-ascii?Q?J1xIpwE45sKct3HCbXl/dEEqCEdLUp3JDxtdou3+8lIdgIkkPaGiPjXINss1?=
 =?us-ascii?Q?jKEknpkM97u15r0oiWubQ2Aab7GhPm1rESvFeZdKuZV6OJpzxa7hFZvzvh+C?=
 =?us-ascii?Q?SKCIvDbFxY6b9kNy/9Tvsgq05qTIeCJtogXdVKZe3TQoF0ZqccFiJAP+eY5D?=
 =?us-ascii?Q?Ny6c97YtlvPnDqiN4BSz7Az7wIkeKiCu5WNDQ8oE/zX4jggTA1yGhUEPF7wG?=
 =?us-ascii?Q?1cjO0w+D+yQrpFkG4ySOA7twC+BrR3XrjfsYa6zyQbF//AWyCM1d3LMKNmLj?=
 =?us-ascii?Q?8STYgXi4Nb8ZLT7/E26rJ390JCvx647GGkpt5MJXCilGk2BniRk0SijNiCyp?=
 =?us-ascii?Q?1h2fML70cUSJVg6wAj68DmtW7OlCyk1WnNE2CpLMD3MpsVaTN4hSgKmO5h0p?=
 =?us-ascii?Q?W78e6iQwZBirlaaVp1yt6jYES3MKF8CIJZMDRpMdlnfp5hn8GlJAlex6K+0f?=
 =?us-ascii?Q?BTLQc5JIChY76MEoosuSEZH4rFsZpNT6fP99QrSegUbcv8lCEmybcEUF/1Zc?=
 =?us-ascii?Q?wf+RIjeQGFLpM2c5GI4zVPVdCcw5YC25TTM5mtFK5D0/CjVjYPXXrsed2hmj?=
 =?us-ascii?Q?I8zqCzZEv4ul/Dl/+8fELFZsO8FYqggqFvyEedvHQIhq0yXRXAvyZcUW4xHx?=
 =?us-ascii?Q?fmE76kaUJcThwVUYVs5SjviOUGWUhXSEmWgyGyUVkH5hEE9HLu6+8PcfMBqX?=
 =?us-ascii?Q?aa2XdfnDBe4YB8lqNC55cFPLFQwymGypyhS8jNpTypbwCDbh1G/jrAVqOo3b?=
 =?us-ascii?Q?/bzgZk6+DsCqyhQENX+uINyEW8+e9/I3CKkqos1cDNekbarruzrL5mhZYrcd?=
 =?us-ascii?Q?yWCYQEceJYLieSIDymSG0ja1zwutnZSdSJBrjKEdXh7e3NCn9qJ1E1M+NAsy?=
 =?us-ascii?Q?7DSZPd7HkZOp1TtATsrtuRxMiFEYuUy19Y0fTlAEn3o5hULHQd+KRVTVko5P?=
 =?us-ascii?Q?wCKWO4mtVHefLtD9zOXFZT2EGnslh2+5z3KbsMggpVz+Z4iTj1U/YdYiFkix?=
 =?us-ascii?Q?8dpP/uWUKRs75GqfF21lTucqOQtMjR2pvbfuPRflHCuobH8nmj0i0PcjGgo4?=
 =?us-ascii?Q?LRThKLcj5SzNxWhFn0jW33uZ7iWWP+YDaaoZtXC9TEk4LpBq961KGH0ILjlF?=
 =?us-ascii?Q?b3Ye4ClWgA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a586a6bc-dc64-4608-05e4-08dee0dd093c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:48:28.1900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xxEhKzid8x3duXlw7vwZWOD/+hoVaqPQytup6mYrcxffV+KcmlXZPuOHY3R1e9AUlzCDSwOU+y2gVZ222jWsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

On Fri, Jul 10, 2026 at 07:09:26PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

