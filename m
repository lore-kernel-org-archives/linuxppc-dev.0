Return-Path: <linuxppc-dev+bounces-24867-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D428BC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 09:55:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7v9Y2875z2ygn;
	Mon, 27 Jul 2026 19:55:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785146145;
	cv=fail; b=OZsGN5x3GKDn5wcLOfkTrmuV/NCvTwSRCj6MLz847SSdDOmsFmeOl1Wym7QNC4rLeOg42uzf+OjVfT0S/9/HuuLx/0iZQUljTEh2rabLOSwitTD8tFcWYVk0o9xkzPCXq0Q9oR6li2PXgUL7mnFOGlKeowoh4jT75qsWd3GfoS48zdmfAlv0UBDWxvlC6iq2xmptx+mVMmS/GVyDfnkdCcJI1vM9IrKYTROKuw5hZjuSJf0uKEYoQwaYphV3rgFVSxKihW5g1w1p2ccpQhXzlbWh1YJzyfd4eymNN8xMiVmWm6Et3pKGidx0G2JJx+R2lW2EV18rcUocGXolphN36w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785146145; c=relaxed/relaxed;
	bh=GxO3WB+yesZpl59WOxdJoD0DVE5nFgb16wZ142JZEWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D3ESqaj2phhXE/n3QUksNSSrYbdrp1Up62z9UhEJhr/8FolFWRTzFHOM9nik62JaFxDfSU6C7JdLD53R/BIywDI028HXarOVS4RqyTkY12oakT7hbFIWTb+Uh0/yBEIk2cMj8UTCgEMmOTuUEL1iti4NI3nIsTLn3dxuzecxyZ4j0yHBjZyhPSC5EpWtntDXm212Y2vKVWPfTiqKEHdwjemeSHLbkRy44kPRpM0z3/vWkQSOEKzCYocMl/a6WeXZBKNphrwmLGwB6nTjH+GWoe/8M5Bfo5earDAFry62Y4CYbsuMKt7bXhXGeH/0WmAeBa2m85XzyXY2MT2HPMSOTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com; dkim=fail (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oVn3QZPI reason="signature verification failed"; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=oVn3QZPI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7v9W2lQsz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 19:55:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeZ7vNekK4ARcgUoa5/n6opi2keH8/eWOHKIPbKWV9SCp6XFVa0MAkvurAHSGc6BaxXxli/UeD/rkrxfaqUi4QotDeVIIVcQBfdrq3kLX7RnmoHtq+3GSMdUk1L81ZsLdid/JoAZZWx5vWZ9yRLFxDyPC6q/2iR/MNOKn/xg3jt1agmPCExeAg7LuqOFD6hHLr7D7YdtIQ3znMAqkteacsug4APxL2qbLpWCwo0sIoIEtml8ZRuxoKvZHUDUEM05Bk2YjzdFJxXExn1AR8Tx3tIjzs1NewEGLwBgK5EpLyunlM8xe/rkhiwEWXoBpFA3v5UBBnvsuk3XZuUuse5ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYEkoSoMzlSnS237NZxHA/xyujM7ClNKdQae16f4kwU=;
 b=PzWRp9b+6YG+crO2JtazTx4UEiV1+9emtiJ8gbtcfwui4tLQWar92EqbTM5NAK4KkdLjFuo0271GAiTTCPvTMNoOAyoDltqtEy2E+KrXRvBVOOB+THK4laGjVrVXt78B86wILsOgDw8xR2CWE4VheiMaep70Eio50iNcclh6RFSlIWGotUMIysCCmM8KHQicW/Ts4c7cjf5sVNGtlc/HpXBDzMu202nqzOSM5WVQynWM16Qwmx9mjpVSwrAc4CfcNo6GE89sQKkIQCew9WSxKghiafR/7iXZcpAZsWn4gMTdCPBmP+01cNR9dde+Ur0MEJOVISoQFYNnnSqGY+X37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYEkoSoMzlSnS237NZxHA/xyujM7ClNKdQae16f4kwU=;
 b=oVn3QZPIsdxoXQ686pYkXSiYlUV3Vo9/v2Ovfp5b+OI8DpWYVDvWOVt0eXcKuMvdl27kbRgTNpzMd1o05ufAhkE9jeBTedGOp/X+fKl4qiC9fkAP6vS0D5Zc2uYjD/gBZ0NLBo/tCVhS1LqNIv4I+DuaK70QUskaq26E2UNJqXQIdfeDEHAa3VVUTeE7V/TCG2CaoCWzxB2ijWFdFiYd5mD/dzvXglc+3yJD5T+SKVXm+JJuRVV6+J0O24S8+Jp9hEHH8fT5wRn7EwkIO/nVZpyIjyPkEL160auv3Yk6kJJDENSacFJ4ZmlVHFm7BiEbkRx7hATQ3+khjjfB+08g4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DBBPR04MB7660.eurprd04.prod.outlook.com
 (2603:10a6:10:20f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 09:55:18 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 09:55:18 +0000
Date: Mon, 27 Jul 2026 12:55:14 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Pan Chuang <panchuang@vivo.com>, Roy Pledge <Roy.Pledge@nxp.com>, 
	"open list:FREESCALE SOC DRIVERS" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:DPAA2 DATAPATH I/O (DPIO) DRIVER" <linux-kernel@vger.kernel.org>, 
	"moderated list:FREESCALE SOC DRIVERS" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: fsl: dpio: Remove redundant dev_err()
Message-ID: <ulsxkv24z6u2eeccgpgb2ijskrxfmoaw7jf7y5m2jmgehfnbrh@k66mkm375cuk>
References: <20260723024748.30105-1-panchuang@vivo.com>
 <877f0d7a-6eb9-4305-be24-20e97bb3edcb@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877f0d7a-6eb9-4305-be24-20e97bb3edcb@kernel.org>
X-ClientProxiedBy: AS4PR09CA0009.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::12) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DBBPR04MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc03633-b23b-4a2f-e0b5-08deebc52a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|19092799006|1800799024|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6nBSizglX3nI6/etvOg7B03TADMJ4sjruXPYQYcPtTk2MErZ9xxr+mlD21cf+kLB26duQBGCGg2GtAuNqGpRCgdXichYg9xcwXd9a5p3IGTAsT4Iitb6f/0rhEZwf0BVUp1phiAdH/IrW3jcGhdr8sTHJDCqTY9apqmnwGbJ7jgXXEEIZXCyrqLijBtue+hZSQNMonIYu+Za0LOy8yCk4nIPomCDd3geKW8B5b8E2lGqPr9oUUXwVWkmPEXr47CWbawHWeVk6mD70/krztZl+0qnAWgOklD22TlYwxHWhPF2Ofhac2xk/eN5eyTDC3611WJO5FONcDdARmdR4QIoPRAOeay714lhL/eReu5F3zSmGaRS1SvpwHHpVUGRnG8RGtJr8nvXIqossUk0In/H40Ff3mTQsJ3o4j46SQ18+XTB/VhCKYKV1C6UzaW7RCZO5y71ufR7wV43GnOcRe+pQ8AI6rHiPM+M3PUoOwNOG8LYEOd9sc2LMR7CHn1hDpxdeV9fEZqWWTWOVWs6OEM0+7WToZNzcF4dLJlQZnoRLFjmP5zkCb380TXnntp3igm2MiHfodBjHcC+c3SWjXZFHplBUMJ/aGO8SKn/zAaWaIRu9gdUvL4VTP/rTNRe6xXJRzm1cPXzMQRQVpPY5Q1yGcBCWQPENcCKpyZJsWTdb48=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(19092799006)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Smp/ha8g+PBFGbImOZhR5qAnoUnhWqnnphER8kDoIstDs0Ci2lUzUUjoGb?=
 =?iso-8859-1?Q?5C2SlJ5c+bs8zn7BLls+0iaHDdXBN7t1n3s/kH1FjoDd0HrwfkUE1vJ+z1?=
 =?iso-8859-1?Q?yHS5Hdx84RulVjMR8T7a37dPVSera7uz/b3wYFSRkWnflLRi++HScyV+PO?=
 =?iso-8859-1?Q?0TkzTQab+7PLders6O6gt9YRNh6BGPgoH/jI6mb+gK8OTqlRMz50NoinVa?=
 =?iso-8859-1?Q?GQUAZk6y5SCEwzRkY84oR5IdzNAvWtLG8CUqDi31L5BCSl/1pJrf+WQayr?=
 =?iso-8859-1?Q?l4h7PTXmDnEZzxinLyXrK+821+akJdLrExhFVyNAPbV/MK5GnMXmTGSRl8?=
 =?iso-8859-1?Q?7P7m4EyyLh0epbcQBxYChV9w3Xmod0Rp1+9WqJdAwwyCx1zwDuMAcGcY4R?=
 =?iso-8859-1?Q?qPJBo1SO1ErON/Ghfi2Bcwvc3RKQBTeBHz4AES2QzEK/+YgintPq4A9Bcr?=
 =?iso-8859-1?Q?idICdYL6+6mGHBtr+0DZQT0Bogo5aQAjHOZ5rppF1fpPMzPFmU2EfffJj1?=
 =?iso-8859-1?Q?xC9sED+sVF0VLZ3AfeOMKfcp6XGC/pfNDxljhU7xXJJjPxt+pBuWJrUbMm?=
 =?iso-8859-1?Q?eJdAo6rdeSHf1vthEf4aUMEQx8zh56UdSwKpyaUShnb6KZ9inWIheBnzi/?=
 =?iso-8859-1?Q?uswNdJ3dtpqP1jApjF08ycc3qKC8Y3GCnN0VAOTnFD9QMwhIQJkOlDfimf?=
 =?iso-8859-1?Q?gBC8+prnKHSQuS8QGoKpSScKNdf0r75+uYUzJUWSoh272EVTIkT4UToQUN?=
 =?iso-8859-1?Q?+SQsSgLO1aeLpg5r6l5WdAcB/r/WbSVN1heDHqm8SvlROVvzus5mUDrgJd?=
 =?iso-8859-1?Q?jeFBYeYRn1X+TXSP2tHd7RAT8Y4k4fpdz22TsD5zk9kNi7nO9ppPO7lodg?=
 =?iso-8859-1?Q?+7CdMGvrFHMKt4zBCl0c4qrdK2Zh0yj4gkZ7lTXHQ9DeTY+ZHBjlpQBs8O?=
 =?iso-8859-1?Q?EzdREdfOzFfzQSo9k69b56OTNOi2pqEcjh3cNnUygN6t73op+qMol1Qgs+?=
 =?iso-8859-1?Q?EqpoMh8RBo+8MEhbV4aSp7KEEVyLGZO03uHCooH+1Zus4Y60JgXhE7HRcE?=
 =?iso-8859-1?Q?wuJl5mu49Q0iFwKDAauECbsszNFxfRDqcm4WyNJOYMQDqgSu02260pHvcl?=
 =?iso-8859-1?Q?BFlqmVWDxZNBJR7E7gon9EpGziUXPPDyBWrVQbu5EJAtZP6ty2jDIDfqrW?=
 =?iso-8859-1?Q?Fx9FNAazVTdli22sAmfOokohUbhC0aE7ka7t8RDKKbaUKZ4ooyEOjmxwLx?=
 =?iso-8859-1?Q?79iHQ/YhTBr99BLAPSQXm8muPMsKZ7dv63t0tAkGb4ZF38oMWeeCtAT1g+?=
 =?iso-8859-1?Q?h+I+50P7PZrLwF7pV/0zG5PerLBoqBFpvLI2A4l9c5mpSgBe1PP5ohJJF3?=
 =?iso-8859-1?Q?xDouxhmzL2ebN3PQ/K7dMMNUilV7vftf2VvsPIK92d37IcX2a8TMXbWocZ?=
 =?iso-8859-1?Q?+U4UefqXmcPsCTKt8BKeUm9DDYKTfiZ1mN7OySx6NR+A5wO40kv1gVzdbq?=
 =?iso-8859-1?Q?bgbxYH/Gdmy9Qr+yFmdA4zPrjSdlktYFmb/A9wV42TftD4SRJ4Qchz5c1e?=
 =?iso-8859-1?Q?twLt0DcknuF3QHmGLOnf91oeEMxlhGNAjNk4ZjrZaHL4nO0lNNRpz/sHdl?=
 =?iso-8859-1?Q?d6QhfWN83UZnYOJRQapXk1Ra96PUeZ/stSr4DYOXLXfLlZR+wHxt2pHrR5?=
 =?iso-8859-1?Q?U7MiZT+WaJlaO/7HVEwR36M2Ty4puhrscDYwsWcsOpAVzbKtmOB3iZEqMn?=
 =?iso-8859-1?Q?3HrJAezV5cHtdiNznz8oc/EpfIiLZtdxuTs610USPRpeFtm9mjTOyHhX75?=
 =?iso-8859-1?Q?DsvArlYJBA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc03633-b23b-4a2f-e0b5-08deebc52a03
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 09:55:18.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iaz7Vqu8l2vaHxdhXyrKZ8bQ8d1t1hH+z7BRv4LoF2ZprEXdMphDLMZ9zSgjG+z18lIo1vkNSxHe4wb6vlgbVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7660

On Mon, Jul 27, 2026 at 11:47:02AM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi Ioana,
> 
> Le 23/07/2026 à 04:47, Pan Chuang a écrit :
> > Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> > devm_request_*_irq()"), devm_request_irq() automatically logs
> > detailed error messages on failure. Remove the now-redundant
> > driver-specific dev_err() calls.
> > 
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> 
> I plan to take this patch for v7.3, do you agree with this change ?

Yes, you can take it.

Acked-by: Ioana Ciornei <ioana.ciornei@nxp.com>


