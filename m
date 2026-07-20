Return-Path: <linuxppc-dev+bounces-24532-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB38CC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:12:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sBR47sgz2yLY;
	Tue, 21 Jul 2026 06:12:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784578351;
	cv=pass; b=WlXrUNMFgO+qjWHmY0fqcSSy3l6yFOCzH0EpCrgcAU27rCEg6+ev+aEMqG5wqulAkJ80bcNygB0RMv4KhOnyFx44HGc+2v6JYn0FrHXgzUvBmUVGv6e0/Md+LmcCv5LAVjVHfyPJTvykReX2/Zbp0lop+LmEim0FhpYQrERsw/spCitQHrEMonLX3c/hiwKKgw2rb48lDR1a0TojS1SW6hRkg8L+pCEyXEUjq6huUUKDhVDWeaNJCbgzg8EtVcAyJTTZTGo6v7wO+LOG/E9ukp4HSfgWSvxWzdpW/0yaQVwoTe3XIXqmKNJ8SA3vU2dxNGN9PzXjY06lPSdqspgiFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784578351; c=relaxed/relaxed;
	bh=ks726F+FffDq3liCKZmcamqRPugLB0ycvaB7QOPPiFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jn74MqxQNcfKMA0/tetqRSBZWOI3FHFmrhI3dzhEaOpRWs3LlukcLdOSP84ScxWQIO+6KYGDt0QvrTIix/B7WMnzmsZ7GrULFPFsUALTyXvjfAPi/vdmRJLyjvpwzckUn63qgF7fuWvoedfeZJIYQnJ5x5KbTN03SrmAc9CDi9oXwm4efGCSPz4Dsl77wSLNDhHIVJg+PtalQNYnzrmXTUa8YUQzZ6RfYdchvm9kMdNcDSUfghOJqzGEBBPU9/CbRJirgemcl7t59vIOfUHl6nRk4bTon50yuQ86SNVDoDSUJK9B8j9LGGsB4dW07Vzwg4SYNJhMU7n7vAZ+hNKiSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=B8dc8xAO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=B8dc8xAO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sBQ0k8sz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:12:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYlt3RJFFSXeXPOnJXr29jZLhe/VtTsE5w6om8Ks68p/QXusMcYqRqlwHecxbmgeqUoOp/kmsBzHR6ota6Unf8+M+jedBM2vankfPyxZbKTNcdNj5DMAs7qt7VzCduqL3yb02pFlhavqV9rDXth6jJtkNQ8m0Ho3JmIFFbM0wLZs14uv/AMZRdXmMAKD4AQgSyX0krNnZFYf83q3C8eBMxnM9p/seRwyS5oBxkFmG1BuZUii3D9ZBsIB0JEbSz1j+9gQoQtjv2Y1EP+d+DJbqfQTxusd6tUH2EwY6x4Va8ctaGITUcAh/Dx8OESRbbXaeKlp/tA9+ATNuZVdTI7r8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks726F+FffDq3liCKZmcamqRPugLB0ycvaB7QOPPiFc=;
 b=QY/ASNERVaYGC6ppEdXD+piD89AtrrBrDI6JcIbds0vMCGTN4BOIP1c92Ne+lHf85rzdilz3zD00uVGHk/NVv4CRQYF0SnH4A12JQPzKsd/r4GUFc+PYXmdlwCiijVhA1RInVhq8hZT9jIAkHDh2dXw2T4DOS92j43SKxjK6FvIXevh5TWAoLgt3+u1iUAsDvdv/nvmmuwAb4VbyBnCzv7a7iamdISE850HgPML3stHYxDActOiT/e8KTcwPHCidVnqakYQFKVvNULxdlqhUrQ62HLA8zGB+wqXBdSjXZaT5qmJ3M5+appk61B42S8cwycRYx88v/SYWZKbaP+dIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks726F+FffDq3liCKZmcamqRPugLB0ycvaB7QOPPiFc=;
 b=B8dc8xAO2tq/+ouVUK6WJIHX5op/AipJqifluA0WefY6h7JaGk/RWnnOm9a6jeLZd2vx3DIiwXmjY73GRXHhED2W6Blg92kj7mtwq1g43zP7oM6rkQrdvspkTm6o+X+KyPX8yVEO6E5zjuCWAuvNxba/+6fJr5g0RlUHyjzeEv9z6QBpGjKOPG37aEZuK0KyYWc+NS06DPBmtJy4Gpl03WTtihYS6Ipf/JZbDPANMvx25Znmt6cektTFV52jwPq2puTNaPYADzHFB64p+zymPzQgckPgChHEnnEjLSsqJOTt1TjrlEbBko9P2lWihjBhdfv9jEZ19/vcFN6+60jwHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU4PR04MB10385.eurprd04.prod.outlook.com (2603:10a6:10:56d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:12:04 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%5]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:12:04 +0000
Date: Mon, 20 Jul 2026 23:12:00 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tanjeff Moos <tanjeff.moos@westermo.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 phy-next 8/8] phy: lynx-10g: use RCW override
 procedure for dynamic protocol change
Message-ID: <20260720201200.w6kq2uz6zhwu2zem@skbuf>
References: <20260720133642.136324-1-vladimir.oltean@nxp.com>
 <20260720133642.136324-9-vladimir.oltean@nxp.com>
 <al5ODzYhpE-wHSSN@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5ODzYhpE-wHSSN@vaman>
X-ClientProxiedBy: WA1PEPF00005B89.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::637) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU4PR04MB10385:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f17b984-5319-4ec9-4ae8-08dee69b2a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|19092799006|10070799003|18002099003|22082099003|56012099006|11063799006|10067099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	C5p13TU18LHU2HVMM1p9ZHMUkLm2tOSxeY2FrMcY6XFmpIaIVD9cDxybUsnyUe/bQAYcrqpS8rHQZ8jV+5UyANXcniJ6B0ZWR7X6pIkus+UHQ4ASGiKGZBu1Y9dYT7pV+8j8lhI30vPgGQK5anxHJEsuqgUtGgJoQaCi3pgIT7lGw/O0NtBKM8YOET/8/MG+hZmmeLGw95QHWvp2QWr3vjAK8cCeK3Rw6PGGxzuOBD7KXn5FAgkRRbUYJ5EshclhG0gp1hzRl7eV9ByY2QuJF9nFjikk1uloz5sr4iSyt50dJR/uCiftlUdo7q47L0m4gGvZ53IpAsfk40HLIoMiHoFHzhopcWkmGM0w4BkNmW7fDbDqO8/F0ccklN6CqGBIbVTbZWNaJYlw7wd/SwsuR3OPNsaH2OVj2eGyCCV7WuHhEasd+K3CszLPDzp+ubarEOVOSNwg95XvNYkErTejvo0eR6t9VW/f10p9yWRICau7NBl8uAa5XrHnTEuTTxbVB7WlEPPSuLnx8do+HHLp+jfuAedj2VYzB79JR2eja1WYGQNjBbsUcSFDa+XFAcrOGsi9dDtiwBHafwnwQrpt2mbVL4b2GzG3qOvSMCWbGSDdc7o8lXDVRfKWM9c2P0yEUQNa9I1aJppYlU6BT4eLZVth808YuBOZTadwlrWEF4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(19092799006)(10070799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WeeWRPyz1E9hL0vuHawNahGfXyYxT0F68oOD+V2xR5zCp2HNwmqVnhkYd9fc?=
 =?us-ascii?Q?bu0eU1F84KSjv5rOH2GydWNwkdU0mukS/qbevpBz3/ZbUA68zj5Zt4WXO4iW?=
 =?us-ascii?Q?206HZo5BPiTg/+9kq21PlJzssnShsAEVNjUNNXySVx+sN73EHEApSzXHXg7o?=
 =?us-ascii?Q?wgaNgfjFUu0LP61GBDA6KcKBL+KZVNTVfXsh6UzDrkIReNuERSA3O8RyG8/d?=
 =?us-ascii?Q?D3npyKc7g1XMvDeI5TltZshE8X+UvWaHK66tI7yuzFQgzeharPDGPsuAgoYh?=
 =?us-ascii?Q?inwilGYzQKV89TXm3nSYnOUMspriME2rWuTcIqRXIU+n4rhdpkmYejGvb+jR?=
 =?us-ascii?Q?UeZcT4/TRZkKP7f82kGCQOMX0a32DFR+afd4Ui1Fh5w59j6Y3D/wYmD43Qk3?=
 =?us-ascii?Q?BpNNXVa3NqG/WFykmDG2km3dJHV/MIT8u+AR8qJuPeseUYp/aLQ6rxScHro3?=
 =?us-ascii?Q?GI5ZZVA/fCyvho9Y2rVImayJH5ZhJ12zWdNgWzX91P1TmMDVz1wPbhVpAUx6?=
 =?us-ascii?Q?KqJYxDLzKL6QYeNN17pr3jDXSIH6qIo21L193L1GrGVIGi+g2oMmDO+LlzUZ?=
 =?us-ascii?Q?eA8LI6WdvSkLSMT4bkQMZUQtDLnL6eF1D4Q+bcSaEOhUhmGtmIal6T0WhkAa?=
 =?us-ascii?Q?kgj1G7L0jLWM8OjL2E7UE8UlKTDxaqLp4CWQmgxuTzbsErR+q+NbEWiKaURM?=
 =?us-ascii?Q?pDtP/oS6r9y8KXiFTz0kxR8hhyXy3OBmA3T05xHe+G+wzhG4z5+1LbCNThdL?=
 =?us-ascii?Q?Q00SEQuggkvoOHT7W3Ldr0bSynJy6MWfzTIdcE3qS3Y7qVV6f081+U/po/j+?=
 =?us-ascii?Q?qJTw51i7UgulW7+FAxJqWqFfU0JllhhMUcphTrGlwk+89vzqHnY3Gar1IHPI?=
 =?us-ascii?Q?BHOq4AIV+Oqb9RfmrM+SYRumfVKhiOcQxNHiLN/9ua/i9duohk1teA9pYZqN?=
 =?us-ascii?Q?HYIDVmlYWG67LFATR4ZFqBXmWTlf8QueeH08r7ahhuXWGgDLV+PgiY3yExin?=
 =?us-ascii?Q?Hjv2sXTRoWVkmidmEzMZ6KCDQJrSodm+R5kMgPyllelnPTVaxwRvb6t+d6S0?=
 =?us-ascii?Q?EF3+cj9up/x/mDv1oZa05gI2GZHWwRQHgqYXPAZEJl6xKZvQVoSWWDXt85q+?=
 =?us-ascii?Q?9Kppq8VWHeJxizM95hHfgCrU01QLY0H3azL5e11Y3PgJkqfjxJRB7tSxP9Ya?=
 =?us-ascii?Q?ARRZbubd6F5JXiiUs1vPTN4HVe/Z9Z4zl/qbfeofiyRA9t7S4tyJY2oJUICw?=
 =?us-ascii?Q?LydGI0SQJt4+okKZqYK4W/VMfTShp47QglY84AO3gRw0oHu1ZF5hxiyABR7J?=
 =?us-ascii?Q?VivQVnZzUU4uP+aedvPnqOaTMtnBL9k89yPeFKL8XDDRclE2l9LmSl9McUdx?=
 =?us-ascii?Q?YeKViMzbXv7a4ZVtQ8xgH6S8dxfEvCP7QdEEZiD4WNaq+YdXTBCocOTexO9I?=
 =?us-ascii?Q?vyVpn6jwCgCnSMhFS0vtcmE8V0qhNvskXLUjqGHxkDdRKSLuvEto52e+RqNQ?=
 =?us-ascii?Q?q3hkyCgXhBKmSXQyrC7fW1yTbE0Y+Y7//wkfUIWi8bQUYfQsLYcCeD/hO6GC?=
 =?us-ascii?Q?JO/rINQdk3BeL3ilI5OtoDmKjbEF2oC3hEjDW37SrvThebALYYTon8zkbTh2?=
 =?us-ascii?Q?seQ+7ZUnHMwIweWNpkqtNH0gCPrg0qs6laOF6zjpxhrvlewF7z5jshan2Xft?=
 =?us-ascii?Q?rGA8XFFyy4hl/FSYOxaBztaFblt+opCxUq8/ALAufh/APiq3A22k6logtW/b?=
 =?us-ascii?Q?yty2+E8veOZIf/IAGjJnvBqSK77fnMBvmEKOllXJfWXC9Velg7+7T/cYlg+5?=
X-MS-Exchange-AntiSpam-MessageData-1: u1r+vTLN6uopO7TDpah4D1W+CTjfdx6V8Cc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f17b984-5319-4ec9-4ae8-08dee69b2a72
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:12:04.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RceXMpIQEoov8zwSi5bt0LW9FU6WzCKBYUchYWqUfJagMKgI8EIts5BvPWT68Wuq+ZvmgulU2E/ZBSwemFESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10385

Hi Vinod,

On Mon, Jul 20, 2026 at 10:04:23PM +0530, Vinod Koul wrote:
> On 20-07-26, 16:36, Vladimir Oltean wrote:
> > Up until this patch, the only protocol change supported was between
> > 1000Base-X/SGMII and 2500Base-X. The others require an RCW override
> > procedure which was lacking.
> > 
> > Since now the guts driver provides the means of applying this procedure,
> > make use of it and remove any comment which mentioned the limitation.
> 
> lgtm, is there any dependency. If not I can pick it
> 
> -- 
> ~Vinod

There is no other direct dependency, but I need to send a v4 tomorrow
due to some valid Sashiko comments.

There is also this patch which seems to have been forgotten:
https://patchwork.kernel.org/project/linux-phy/patch/20260612125731.133330-1-vladimir.oltean@nxp.com/

Thanks,
Vladimir

