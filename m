Return-Path: <linuxppc-dev+bounces-23637-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EEBC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 14:52:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gv6lm5dwGz3bps;
	Tue, 07 Jul 2026 00:52:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783349556;
	cv=pass; b=LO83mqYN+iTiCUrjvMWHrMM2nkU34knYvbNobiD8GXnLAs7MCw7WRofWX/RuR4FFqRG4NHzcSVX+Xh/ta11nsXkDb/rQLCIbGUWAIVVmXdyGahWM3DdNPXS6dv+GjRSCQ9ubLzl3wdNMf4OTSUZSmCB8eM6uh/x+jlfaYfSqmFZu7YwuXpNEWYGDuShYlSaxmZI6HXi8495LwGBX+jOWiFhPtCECxqaLFZW4ib8d4EQP4/+r57CqhrOv0fiWVF/iJhN0W9G/2Wrd/CHfOLbt2y7wy4bs0Eh5NGJQuPuUqnTtD8cq1Ohvo+7DRKJeqWBCC+3zXIoI/6x7ozPfj6swlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783349556; c=relaxed/relaxed;
	bh=bmQ0Zr5S8SGkSfP6QoQE3EeZPaKf1seTjeiSYjfs+F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cIXpYvvhlqRmuzjPcYEPQg3/hH/YZj9rL1tivrtj1LpB+qMixi6gJeVoQ48M/H32Y32eMeb/XP8WxzOKee1ZqXLrFCwqe7i/s3L570xWkbvPYd+QRee9G1xEFtgbbU+++i0l+PrSThwr8AkvQBSe4GqOyT/dGiI7vvVH/BPRSzyodRFyn/08zom58MFtMyiKB/dudI6TLFJd28lLMH84iYlW8O7Zh3fSBj/RAZZwKFhPUAaJUCCe3HB8ScaJPn/Dwit2PHwbL7zFtifuRJUtN3FerVzFIhZyTeZCAGgKdbg8m6e2LwuiWQ89rAzw0cgqbqpvenAbe6Pl5FBWrSZHOw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SaKpzDgg; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SaKpzDgg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gv6ll48gCz3bp7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 00:52:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d84dOjduQBNr6R3MQLtXTeWrMFoFzqcW/ebXq14oquL1PC3qxZ/rcZKowOa9ywjkBl/p86ksI4/uWrlaiOMJWhUG8bA58c/ekYodAFOM5Qdfuz3wdyHvrcz3+8C6HC/jI7oTyQS9CRYswWyumJ9O/N4V524jknl2NSNxXlfbJR/0lcIpsqHiqG5tWBsBeXrnAVrWUxASdmobIpeSEFuOTNCHj3jZ8qzVwas5P0rzumKbibh5uIXiTHqXfzqCPa5zW7/Lb2ACEW02gwx0/hTy7HhXf8NCsrFSDi6D3yoE35EK0UqUKlh/ky0IexKcn2y8Dco8x1lE3jtDufwylwh1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmQ0Zr5S8SGkSfP6QoQE3EeZPaKf1seTjeiSYjfs+F4=;
 b=Ofztn4bGE2wzojZkpi/ewuTHjhG8CxvhPRXaPs9pz0zXhPT/a+ggy3JVhsmCq6TCHhMdS0FzTpsoUwyrtja/22uZfM4PyCI6yIioMfL7wY7jYSRqxC/iZdqMpLvRUxn6UV0wmEBYZWtH2CpOEfOvfqRqA7+B3V/EGTa3kblHdJ0K46cb7HAWCCWB5C5NDWw4vL1itVafrS3k7pXp5xeoqbaa6V0LXykGobIaeNSsmFUxI+o58x4etrRC4X0kzO0II4GG78WManOe74ZHYJ6iWzhIuYrAVf7JkP44UgRdxC2ORaHbsGUG4m9q0cMz0od+TZUeWOoHXyaHmT7Q3ruP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmQ0Zr5S8SGkSfP6QoQE3EeZPaKf1seTjeiSYjfs+F4=;
 b=SaKpzDggSumgOUZ4V/mNLvLE6qCdZTXw/Hs3X2uo8tNBOVBA+7AFm2d/hXFR+VAyU9PgxZQNFAhKaSiTeIPFsiX16HSW/BPiUIoB+1BFPg5vm4sdra4dziU0L7Kpad1IpOLp91KCog2TlvQE7+vCAgM7Rz0vI2Tjk9wkyndZqOUqcPAxgB1NVG+XOLyDOJO/OnmzYecj3gtsmcRCMHjatIvJVADkuEPHXvm8p19xjNmBJA/YeVPRxcKEetcpHwvCY8alqBfaAT6T8d+EIUcVDJGsb9mYiancH1HYUeK6nnlVx44Tr/MBqC6kgaWATFcJw6zRXdJv7Spkkk399n5YTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10699.eurprd04.prod.outlook.com (2603:10a6:102:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 14:52:10 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 6 Jul 2026
 14:52:10 +0000
Date: Mon, 6 Jul 2026 09:51:47 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v3 09/20] iommu/fsl: use platform_device_set_of_node()
Message-ID: <akvBA1ATCKKYgYkb@SMW015318>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-9-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-pdev-fwnode-ref-v3-9-1ff028e33779@oss.qualcomm.com>
X-ClientProxiedBy: PH8PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10699:EE_
X-MS-Office365-Filtering-Correlation-Id: bc55ae94-b642-49b6-d6a0-08dedb6e27d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	R50DnXEdYb7zS5J9XBIFE1bkQUV4giQH59J0GB+J14IWYEEMyq3Ud5DVvsLPiYgTFvT1vmHlS6p8UmJ8vQBd19MiZ4mja5DM34ahtWt9gDJg55ynfsj9Syuw/LXD1klMaQT7P0jvrz9B6raRStMjfl7LVUEhg4MvGp0Apv5vog3RZm5vxleF4EBUXGqUVTC9ng93D5U2/vX5tceGOsKP+GZImQ4Lpllq6/VS6YILhfqlOpkDd8EmvNFjI6huJNEY7XpRZHDKMN+PVaaagFnDLQQB/cqWkXK2H1K61xjjo6QfoXUIrk0kOHsXI6vfPv/+eKcRjzPnRX6Qx0LgLNBTF7osSck59vRFFsbQiZ8YKI98QU3Mfb1929EPen8i6lUXGSpF3QfT2wnrXUWYBypfregsP9XuvFr3NeKbbwcvu9MZdAJGUmkIPhaQ9Gqa17R+aC0hjKKLROntM809zhP3BA869251LsOJp/xa9mGB3//q8TIYcSURaWXJsx95RY7T25VXGAlGFpAtvjBdR9UpariflmlUAsNn3E+oUEYGqAQg2t0Zz+KZNzr2Ua5OtEvjXwFHqYSBq6pyChkuq+HzeIoJ9AH2oUgNs8sCzpXQu7sK237m7qoJdpSCsWlwiLSlialhzEvHQbbmZiI3gGN2+MDpOQTZ5w4ApB9TMiTTs6c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqKq3Wr99DnxteEC3svflGigikw3HshYAQEaScYwmybLtGuPzQyrDg2fzv8R?=
 =?us-ascii?Q?3jpK6unUXT+6aB9iDHErg2CGKRQDHKbEIJwEq/Ic8nb9FSFkmMZOIP9h8Fud?=
 =?us-ascii?Q?+zfhs5O0tp93UWXJoVFKNMvEAT7D9DyQOwPBkmzpn7m8dfMNeWRyFWKKeEE2?=
 =?us-ascii?Q?zsFlOYvigQOQW3mrjhcUaG2JbUyz6oZp2ej1IT+7aqqrs8cWg/Kra52kwW63?=
 =?us-ascii?Q?hqg/4Cn7gWe5dDWtPnGThQ3YSXToWKOCZ2/jeJAmSNmoUrIZ5aHxa4UIp/X1?=
 =?us-ascii?Q?4JUvK+xTEIq9Ky3BZBaQVpAAk/0PzbtFZ6ITQt3Vt0BKmLk7LeojY7w1Yymt?=
 =?us-ascii?Q?qHYr8zNVlZHrkPhdpNkrzIP1oBENe80GukGAz5miO1th81nY3dGkCKBDqRcf?=
 =?us-ascii?Q?5UeVoJYSjnFhWSZcnojM3Cj/3uPdtitxi3Yj8mvWbuc8RhjfsGz3J93gfym1?=
 =?us-ascii?Q?E6SGPX7axOSBwIgJg+9aeamxcKjW7LhS3CTSNdnUfIw/qU3xP2nyfLUVBSWc?=
 =?us-ascii?Q?mD7011LJlIQGZFQWUClVx5/yIM52A+Zu57VuJ4ahdBRVqDPbvDPZ/q9vNVrH?=
 =?us-ascii?Q?1rB67CD4NJZIb9ZJjHqEFQ4GvTMqFhVT7wzn/G5urBZWresYHw9EoBOSp77X?=
 =?us-ascii?Q?KTwt99E4BpCtSAgy6Lm25I0BPT7gMp+7sj2QYW3qtlJXdcERbDLUlmxWPTFD?=
 =?us-ascii?Q?WC8BEz7lkV/ggEixOX5VJ9x6bH3QJKzW00uyXUfvanFjpKcsBfWv6cU4Nwqa?=
 =?us-ascii?Q?L4aTefU2GgGGyH6q5guPjmM7m2pH9xCzQKB7WJb1l6efopUNazvl99ydrdUZ?=
 =?us-ascii?Q?HQAncBpvZyXVAjpZ2fCSNHGikzFUQ+YWh8OyelaR8alRZOUnjKGvnzdlFNu4?=
 =?us-ascii?Q?jntg3SS0m3kDHqmXpeJ50ftN1ZquT69mAZ4n3EQPM6YqkddDDtHnvo35nAW6?=
 =?us-ascii?Q?T4V7T6rLYPzFlnBsF3NCXtBSIYl4kQT7I9IbuuZr/Lpbn5bzewSHGPWyHb4b?=
 =?us-ascii?Q?Kkzh4VE6JZSPGCTZspQwQt/UwoZzkAlOUzQ7OEMDffFKpzWwXse361UAXIM4?=
 =?us-ascii?Q?/HyQEuz7z5e2jQNizRO+LWm5RjpF/MA1wzqGZmdTWJdFCvB1ySLwNyIyaOI3?=
 =?us-ascii?Q?U7iMtsabAqRJBQsvfGUPV7KibumRq4UdTEz/JXFSpcwptR3HGNIrHVvkSduR?=
 =?us-ascii?Q?aDmSIQihZu8hUJYbImTZZl7IMWie4LL3YXSy7N7GrNyGLMKPqUWFMDa/Dhwy?=
 =?us-ascii?Q?1Iquem1G+zRhcx3zgfJ5wI4Mtr95JIJzAMLAfu92PLAlZi0j5b40TwWDb8H3?=
 =?us-ascii?Q?kuNGiQ/T9GKOPhtOegHg/nUEka7U4Q9gay4c9Km8lRcXxziazXa4xct60dny?=
 =?us-ascii?Q?C7wxisVS3O8tOUNQKreaPLo8Tab9zajGfLY2Ll2Cv0pF+GrE/CPZjTvdobDY?=
 =?us-ascii?Q?UkyiTwvvk3MCVHyKT4ThCNgFIv/fg34Fy9N33mQpr03QFPANYL3VrORiXbpi?=
 =?us-ascii?Q?RqYENQX0BKOmvmI7eehbWEZTFiUnkiIqKVRwUPoSEljc0Qx0S9i/DQBcJFd/?=
 =?us-ascii?Q?t4S97cq4Sw0qLi4Zon4WoGO7jHQ2MfgzFnjqOkfoUNlGeNyRO6yQxo7nsDtG?=
 =?us-ascii?Q?8HrAJzcIVx3yJ1OwaIVax4wKv63oC3m93Dwmvaz8C5AjIxv+AytQJ11qZRsq?=
 =?us-ascii?Q?nDo2SorRG+gwaXEWlJ3pUC5BJeeDXioBEXlEnbFr2EUBf+M5RkE8pBDQ5RtN?=
 =?us-ascii?Q?YEGsBVvqdZ88Gd1xbrcCG9jRmWtL1qEM+4jPL3ba4LLomQkhApOr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc55ae94-b642-49b6-d6a0-08dedb6e27d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:52:09.8924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIKtRlDx2pT3kbZXRTpAdCXKj5n0g0mxkPT5RRA07IPPy0IDauTXThljzjMgXT95pc4rkH5M8cHSJB6ncRAaCTVRnFYWQUakFUto5Xmgw4CWwjllLn8rnx4YQq5Cr6ev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10699

On Mon, Jul 06, 2026 at 02:44:21PM +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/iommu/fsl_pamu.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index 25aa477a95a95cb4fa4e132727cde0a936750ee2..c83bbc3faad56d6ee1c89b0a7f74028af02c81e9 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -8,6 +8,7 @@
>
>  #include "fsl_pamu.h"
>
> +#include <linux/cleanup.h>
>  #include <linux/fsl/guts.h>
>  #include <linux/interrupt.h>
>  #include <linux/genalloc.h>
> @@ -933,7 +934,6 @@ static struct platform_driver fsl_of_pamu_driver = {
>  static __init int fsl_pamu_init(void)
>  {
>  	struct platform_device *pdev = NULL;
> -	struct device_node *np;
>  	int ret;
>
>  	/*
> @@ -955,7 +955,8 @@ static __init int fsl_pamu_init(void)
>  	 * PAMU node would require significant changes to a lot of code.
>  	 */
>
> -	np = of_find_compatible_node(NULL, NULL, "fsl,pamu");
> +	struct device_node *np __free(device_node) =
> +			of_find_compatible_node(NULL, NULL, "fsl,pamu");
>  	if (!np) {
>  		pr_err("could not find a PAMU node\n");
>  		return -ENODEV;
> @@ -964,7 +965,7 @@ static __init int fsl_pamu_init(void)
>  	ret = platform_driver_register(&fsl_of_pamu_driver);
>  	if (ret) {
>  		pr_err("could not register driver (err=%i)\n", ret);
> -		goto error_driver_register;
> +		return ret;
>  	}
>
>  	pdev = platform_device_alloc("fsl-of-pamu", 0);
> @@ -973,7 +974,8 @@ static __init int fsl_pamu_init(void)
>  		ret = -ENOMEM;
>  		goto error_device_alloc;
>  	}
> -	pdev->dev.of_node = of_node_get(np);
> +
> +	platform_device_set_of_node(pdev, np);
>
>  	ret = pamu_domain_init();
>  	if (ret)
> @@ -988,17 +990,11 @@ static __init int fsl_pamu_init(void)
>  	return 0;
>
>  error_device_add:
> -	of_node_put(pdev->dev.of_node);
> -	pdev->dev.of_node = NULL;
> -
>  	platform_device_put(pdev);
>
>  error_device_alloc:
>  	platform_driver_unregister(&fsl_of_pamu_driver);
>
> -error_driver_register:
> -	of_node_put(np);
> -
>  	return ret;
>  }
>  arch_initcall(fsl_pamu_init);
>
> --
> 2.47.3
>
>

