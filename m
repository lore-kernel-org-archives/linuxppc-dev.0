Return-Path: <linuxppc-dev+bounces-20188-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D33FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 18:39:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4C6Q2HZLz2yqq;
	Tue, 28 Apr 2026 04:39:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777315198;
	cv=pass; b=N4BlFKvwH0psBz9ogi4DkpmiEnoXOqHp1NxY1f/MWDbWnm0bc6+Do8sVy4PTXStZRK0iP0GLZFHjHF9Lo8/+8eTEO7xQtgwO4V0YkSrBlFgjslHq/eXxxhgx7RKli5Sn24sJ4MuuFZrSHcw+5gRoqg6a3wErNi3njPZxHcv/H//LDwuTL326unwQSa2sVx8HQgrvh/Lzr34bQW3XBbllif0WL/v7CFEC7/u9leHwSotTUqt+qStmj9LbrOwj4jb+GABN3ZUfHh1J2ySMyIbOfx6YYsdkNNAhawBqiBv7XEbgwL+K/Jj0dETF7Usg5SBtguvZSNjw74kLKFXWzJWd0A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777315198; c=relaxed/relaxed;
	bh=nALNUxvPaXzFesZYqSMaFrytkX4CgELDa/JWTp7Lw8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G+7FL+Qzzghl/cVtivQt88gY3PNwHUtOzgY34Q2MM0vXQmOMXbkF/zEJCOOqyNPgwO7ulRm1d/XdDT9YT7sZD2fe2QTwhAtOBAZLq+cIWOl37NrYTP35P9vDaNMXZ6w216impWDerjv4bhICAGE5O+8Qg+Bz+851RYhowfc+QbmSKzRQLwWEeUdCq0p+2p0AxsYyT3IYFPugD1/eE94S9WVJr2jErjsYq1L0nivXCn9pX22+wN92oE9PWkMKD0p8NtSb/FWUY2e+qz28DO65HbU9EawO8fWFbq1ok81T5kUj+58PAdTfaE7bs+bGtYR3iLnae4/FZIrBlM+12QqynQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pmvWhp/o; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pmvWhp/o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4C6N1dptz2ypk;
	Tue, 28 Apr 2026 04:39:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQeGa+YdNTuEb823qdZS8Hpotu2r72E0T7L133DkAjYdxm4sXHNsSUmdDgfuLqSgZ8ptJqXAaawtnWfzbuYE9JgTht/7aoE/UBY4fb8CsN7gCBIZfgKE1at/fpNpM0xSdAZJWuaUqRa0tqhI+N/yx9xph7PK0K68mzfAl3ULUBoKMqt7kO8SmQqIRPQp/EyHUjaf8pVm2IKhXkERYsuE6sazi1OyFGe8w6Tpyc067R/wsyQcV3mHt7zG29uYi1UdlBEBwV7zkb5+etoOikaMn5emW16FR/V0uWFWi+xABha/3wJBSOsptBb5XuUEJ0gI46UsoZZATZeItdPD4X+E7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nALNUxvPaXzFesZYqSMaFrytkX4CgELDa/JWTp7Lw8s=;
 b=px9mAWIgpW1g8A++4bB0b0HuBTVzWQKUHx38Lv15RAJgY6RPeHYUnILh/TwEOgn2886PJ4HV1v36kbLLG0HxUFAomMviDfWTHNqC74F0NXfW2B6flkUGEtIYX1KuG62cISJfxDrgdMABrDWp6xVA2MUygcqCtHSOnaMZ5ZNilmoI++yqNmdF0OaD0k2KfXGmE6cSPLaiwtfXftefCRmJeENOcw80UlNkg4EMTulJcftI1iU27D4XyjUiX2sDWu2PtYSLmYIgPWNxczRp1XfiNZwvXibbYm5a4muPrwHvEBOL77eyyAZhWYd43uPx0Y5scO9gl7o17mc1PxH3v/Hq8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nALNUxvPaXzFesZYqSMaFrytkX4CgELDa/JWTp7Lw8s=;
 b=pmvWhp/oxEcxQMryFRvqYtTB0A/GaOLun2mURAQK9jJXjqt4Nrc84ZfAfdVzaosEdXMWAP59oi4+UbMy4mec1KbzWHAyoF57I8DflvmrAbfhIb57bYv5qY2FGaPKUQk1zJRQQp9CqnyFj5VocFwyiXwUgS9FNTnrrFLeiZOJ1G9JrF4fAHR8lxFNj5/FwsIq3FU1ajVbQb2H+3//9zc7t+U20kMXMalri61t8NRsJ5k3/mDo4BdG+GEoyoHOcMDJdBMl8UX3LCr93JIqZbyQOPZZ1D/mW+4NjIfkYIV4DzD/8KPPzEEOg0Q59M3wKfLfO1wJ1sZJFQP38+wbciAclw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 18:39:19 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 18:39:19 +0000
Date: Mon, 27 Apr 2026 14:39:16 -0400
From: Yury Norov <ynorov@nvidia.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/9] uaccess: Convert INLINE_COPY_{TO/FROM}_USER
 to kconfig and reduce ifdefery
Message-ID: <ae-tVFVfx72oCC_i@yury>
References: <cover.1777306795.git.chleroy@kernel.org>
 <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fe875d2f55af59c12708336c571a46038528678.1777306795.git.chleroy@kernel.org>
X-ClientProxiedBy: BN9PR03CA0924.namprd03.prod.outlook.com
 (2603:10b6:408:107::29) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d3e4e6-a43d-4919-49fd-08dea48c4adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TPoVweG6k+dJJz5MfIFVzAwybwz2jm9fSNM7cxd69vHJE9UR7v6gWyNzsADjvW7ykt1GxFh4Loi1ek62Aro4GaYSpAgmWTn2FafAKuzv9brpXCmKrPkRpx9DEAPIV+O5dQy3egB7SEzayZhdD/hWFuNZI6/aSgi9lHWX7gRMsSsQ+hETpWZ33SUUr8PWk26gfuJDFv6mOEW2uC2BXHmIXUBpyDzOLTJkWEZLidp+7/nea6eckeX0OWVi4bEZfR9vET0pIew0s/JD7Zz/RgAl3L1OS3LR+WDk0Cj+9xRSjoZt6hvaQHTWsroBoiVTErBG9cZcE6iDBPvkBn6JALg+xzh67RQUZnSxe3dpsNnBDx7CyfIbDUoxU3lAu9QNZYDT1pjKtmsR0xUxypUJz8heZAAejUX+cI5zyhEOMCfbZhYDfC8lL5HRKEb55UhgnG1W7/6v/FhxkMwqKMlyWokoOjOY4UTekvoZ2YoBlTz/0SexmXJCV8GlzzJCCy3Y1wJ/gnGl1oiAmGAyfo29/0sdy3H4BAYwxQB+IiP82ASQGpLESNwitwXe5+qlNSYOiiNPhvXQr7YPxg9TQ20Ipo3dS/oLszmjrr6IMeWdSIzAycLxAjM4ybcGKoHCvx/iHvz1ya1/Lu6sN7VNJ7G92kgR4XUfztSnUa/+T4Ty1oGleBPJ/1/eGU/xx0C11jRZy6aMFQ1qLzVFXPf+Rw3f5XbXFGlI7ibkCm1ybi3SLvQHJsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oib4bKcV8LA5vdjLqJ8bgcxtg+HiGQmptbpLOggOnOXMP8WzMNQrzTBLxW0t?=
 =?us-ascii?Q?J/O13Po8omZAsmm/pQpy/oqttV579odYMQrIVxXSjgf18STek1XRrKGwVmp0?=
 =?us-ascii?Q?l0BU1ufe1EiXFQOU6+6botm2sdTbVj9guzWn35tmDPDQr3Dwwmyjq5n/e4XI?=
 =?us-ascii?Q?SzRjxH/T3DI21r6vl4cCl334Ew2ij5/yQJC8A/DRNX+V7pyzPYuZovSr9F/H?=
 =?us-ascii?Q?Wgm4eMo8ZKAXBaCC+JcutRhN7eAH9v+cW52Q3ahFRH6xBK3C4/Z3i735rmIV?=
 =?us-ascii?Q?aMfpxHZ0SFW7fKav66AdZnuwM6sLZ9JgRxdV6lUM7BH/+pQ+3Pt5OuxuIF7P?=
 =?us-ascii?Q?wOEzXGgLg/FCQyv3W40kHRzWP2soqwyli3M0yrSc+NSjlNU55HajGFi1JvaI?=
 =?us-ascii?Q?tiNl9ri9lNxc+qE7KdAVPFL/2e+CEWg2vZahotUnAp3114m5sQG/4rVIg4gm?=
 =?us-ascii?Q?gd9zXeVaEsINZnTiz1qVCTLSKFcxLzulAejw8jMwtJRbeGBzK4ZC1e7VOCW+?=
 =?us-ascii?Q?aKVYJaES/nOjEprimIme29LeOa01vmBbY6+qz+yCseVYOQCq9CdDX7e1deoV?=
 =?us-ascii?Q?zaTnta1O/6L4nX1080PXzmu9mTtYtJNQO3DF9ovWHiONsmGP4U11bu49laOs?=
 =?us-ascii?Q?B0UU9IxLtWutiJxYBVD0KN4xfooNicHXXZR6LrmeOgPpcSsKDeGO2BnYG9lv?=
 =?us-ascii?Q?jdgN60ENdKBvmSOFTzCRkCByFYt+/x7RaSBTKsrsbJl8Enat/5Q9rpxaSuYv?=
 =?us-ascii?Q?Hk0QJmiBMLq/XaaCVVftv/lOLZiG1rfq9bJc6AGkJ7Be2P6481HfBvkVoSKm?=
 =?us-ascii?Q?7dS46V0SCDnMF6O9L5WMOGcQF3/JmPJwDC3bbG0KXyXraugzFpO2I2A/zirX?=
 =?us-ascii?Q?a/CdkcxQ4G6IILYhs8aeRubhtiJ4TjMT/T5Mn38f6As5actrgh5OSaby7k/P?=
 =?us-ascii?Q?p/eP1WrTDycIQ7kQbNn0vPkAk/h7ELW35FbH3Phz+HVj/qsyPVuI3ZrMXUag?=
 =?us-ascii?Q?WAN4DeGhJIVi4hPoLtGwda6uakBNXByYqWFG6Y8WSZFrAuFMwEgvc3vSyFyl?=
 =?us-ascii?Q?Dx5n3nRrxw1RgZUiiAKDP0rwsC7WGhhl7rCLYH8tGf3cooY4z46us5fwXFjC?=
 =?us-ascii?Q?wNTDl7f7oWOaDilXo0Jux13wM3eh0BtH51CgLCN9tDrJnzsW7ZyZvcKQk5Tn?=
 =?us-ascii?Q?O9ixfPU/YHVSwPfjb9gBof+EiT69zyPNYsZE4X2O8CyU4Z8XVVbkKhgMngy9?=
 =?us-ascii?Q?YRDPa867pPjQhJc3j8j98MgOVgWGheyih5q5W+m9AMvdBEneu+a9dnByQyMn?=
 =?us-ascii?Q?qCLgefyIDgxtIR+PcNMkMkPhjugjUNVEanta6lIV/gHJ2JE334rR3ZB3QcoQ?=
 =?us-ascii?Q?NbJNKCyplpSmz2mdkoBN9xHWSzQA2d2/nRHmtmEYPxzVHY+pAEBbGSLUGA+G?=
 =?us-ascii?Q?n7hhnzbzDtnl+NVWD79E8VDdTdq6sg4VE3PrKKvMdORAmzEkarJh1RDPehzr?=
 =?us-ascii?Q?rf0jUwl/4QGQHSZRpxkK/lDw7l5CdWKgWv1KnfHZnVpP43iLu8DuyVVHQL2R?=
 =?us-ascii?Q?VCkeADDpChtUpYBLJdlINE5FPPK7QdiOkkbRoLE8VBbhAFo5vAXH2E7YlciW?=
 =?us-ascii?Q?k0gtUjR84c84anx2yV2+7D9n2SuoEUaYGM1OOv9cl/uolZtt2Je3yiYv7HTI?=
 =?us-ascii?Q?yD9W0nKiIOg27gfW0ZUuL7Zq68OzdAmeaqD7+UqqyPO6Vm6rjH2beLlolKD3?=
 =?us-ascii?Q?NnU9q5OrFzP7EEzyxKROJwYEahtrjRNUQfGufTekFC1cKWXYO/DQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d3e4e6-a43d-4919-49fd-08dea48c4adf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 18:39:19.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EMi8W1U4wKLqFUR+2jNWxP3McH9TdZjJFX+Py1zekodl7uM/ruq8Dm5SoHnnrACMPwMaK2iGgbUgpHPN2cF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

On Mon, Apr 27, 2026 at 07:13:43PM +0200, Christophe Leroy (CS GROUP) wrote:
> Among the 21 architectures supported by the kernel, 16 define both
> INLINE_COPY_TO_USER and INLINE_COPY_FROM_USER while the 5 other ones
> don't define any of the two.
> 
> To simplify and reduce risk of mistakes, convert them to a single
> kconfig item named CONFIG_ARCH_WANTS_NOINLINE_COPY which will be

We've got a special word for it: outline. Can you name it
CONFIG_OUTLINE_USERCOPY, or similar?

> selected by the 5 architectures that don't want inlined copy.
> 
> To minimise complication in a later patch, also remove
> ifdefery and replace it with IS_ENABLED().
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Andrew has taken my consolidation patch for INLINE_COPY_USER:

https://lore.kernel.org/all/20260427085814.7ca0b134603b8d5813e23396@linux-foundation.org/

Please base your series on top of it.

I'm not sure this patch is relevant to the goal of your series. Maybe
send it separately?

Thanks,
Yury

