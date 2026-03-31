Return-Path: <linuxppc-dev+bounces-19078-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECF81061B2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:30:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQsC0Bnyz2ydn;
	Tue, 31 Mar 2026 22:30:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956622;
	cv=pass; b=SRROXiWVItz5xT8JMJkyKk8ziZIwV0/4q6Qf/ERN0tOmQCgNUl7AwJep7TtCEIiz21WP91pkk0gnhjqQS6z0Yl/6IqjAQ7d1M0e5uQrk700HqopmJzKL16/i9LiD4afnpRSl1kMHba9IYgOKp3Is1gqJcwFNRr7NJUfEgSsUszwR2RHeu85YEBF2KCiiLF+nPj/+esWl13/VZMktayB3TZtxu4VDc7EmxOiIOs4wLV0g5gDhzrkTauCTqPViopBGM6GEwk2HLRz8A05/ujxNoCOrA6XNCCC1tGRehAi71LaSGSgcijCgvt4DrIVwspBXTh0xOsLEKfUg6iby6c6S8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956622; c=relaxed/relaxed;
	bh=WzQ+KWO9NQuMMRcE0+jYRNxdluvpUt367q/0E31+7x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/6M4I49KNBNXfgYGxRhlFNRnuoG4nxY5tIxHaaz2s5FTiMDlclJJh/1rNNbYcxkM3W4r94XVx7DfI35VSH/sZDLPZLqIEuZI70HKo96h47fBGnobPLeVk2iTIH5zqgPUfsZpXvuB4W5dAgZix2ZryE33ORaaw/t71aLw2D+YpXpr9MH6pN2Am1kynF0/s2N2xDEPMPOcLrW/LP+iPUMci1O0lWNdOxfZuIfPyvHDTDjEOREhK6n/+1d1KnZQAjAYz3Zw/GBu+oPdzN1a7S9I5aQaXy2e2sMwY0ZxzhpVjsIaFS5e+9vxYAwUsKOuEMFcq/j+GpJCAMNFHfktpZr1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JwgA6V0Z; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JwgA6V0Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQsB0QlQz309y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:30:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqIiBGLZB0XSTsK/ErePuhldshqOe2LAtYmk+VNT01FIu8bcJllyYsP3tuV3ybaXvvIyWZOZtefYgPhwSUyDXAfSIRmn4xKYNs+fp3nT/SGJnPtcyWWFn3blPMok7+4jGc5JLSIEr4IxyWmOSGn5rtCBIcL7E+qh5TGKdTnJnEJTZ94PnTkeUHE7GtyIEKjvKrCc1x+N4qxIKXNNPd5/xfxz6aDMope95eX99y8MFKhNKozJYRJ8ovOcfvXGx+uA9fRYdjRpJe0jAmXlS4jPEQLyILZr5s92o7vGeyOPGRUW5qiZWP9USWRuHsotMSC0eg6Gy2H78LWHRp1Dzt3neg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzQ+KWO9NQuMMRcE0+jYRNxdluvpUt367q/0E31+7x4=;
 b=OZdB78oJHW9oEa8mTvy+ybn7jK6MgARvBsqlJT0oZucaFqxyZO+gBX8dNU//FOOcJK+R+BhffB2u4+kwbNtoTyGY5jb6PVJcMV9fB5r866YV/ulJMSU+xY6w7Vjhx/3gHIbQCSWO7uw1aiCJoNDsTgAEQVKzDC1E/QTa7njLgW/Vq705Cm0pnlG+DclsrBDZkbZm2n5D6D1rOp5o7CFHrOu1QndHrR/EXMYz0A1oFw/wjUmoq/HeX5B8uzXht6dui+/jLbTTO+XISKDNL/+VSNnfICdvaeMHKdNtRkTxFskzqFWtHEg9eAh5oVT2c9X4XrXRXnKhmGreFsumIMAOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzQ+KWO9NQuMMRcE0+jYRNxdluvpUt367q/0E31+7x4=;
 b=JwgA6V0ZJo1UefJ8xbgGAcDz/wRUgJRehuO3198K4HrwldxAg1unpVvioCbIAaC/tVqs09i8Bi4mD/LsugDGRyc5GnvYjjB3yQl+sEvIUkcGTzfyPSWseKaEjlcnHUlA61NRAXKTUCY+445RpGdWKA+Zn0ziEv/QyvTDArOklcju+rs49TRwtyGw/Lp17J73ryULWMwEHwl9y1dkhTq2GLY9ysOE2u9smy/DTf5Sstf6hms0CT5Xiz0rmJhdW9e4dSF4D/a77V0QFX1okfFhw+to872Yj769HW+etaVefTgFTko0DYsJGVjs3a4e6u304zgoa3wZ2B8iC/orSxKcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DU4PR04MB12064.eurprd04.prod.outlook.com (2603:10a6:10:63f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:30:04 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:30:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v4 net-next 13/14] net: dsa: netc: initialize buffer bool table and implement flow-control
Date: Tue, 31 Mar 2026 19:30:24 +0800
Message-Id: <20260331113025.1566878-14-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DU4PR04MB12064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d83c257-0f07-4972-0559-08de8f18daa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NUiW7d9bmLOX4ve+DQaI49KB3LiLF+TfGEWejN6JFbybt0s8dYzs6BGPF28aRyE3ojsodNeIIJ0hqtrRJW4Kydi9/qjCdV9XTLjH2+bj3dxkVJBGosZfMO6Csr0QIUMVs9W93SnWBD6EX07M6rdROTWdjcL1DcE+/SMN2nv56/g4+GBhcdXoA1+pxhZUJB0u/F5u1pskGDsxVTGOf8ant133oXzg6lhglaPilQBZWImIkfpBX6R6sxVbRBsfoaHGcguFEfFrHmmyBXzYY/M3NGz1A6KCXNjrLa9kJ8BFdbShws1mG+XprysXwWNmc5NUChKsnnCrxp8O+zpt7wi5wpBOktc89RQ1/Xo3551+QwUJs64hBb7Huj93JZvGW3s9wCk3I/71TFOkIW3W8vELg45iw5JjeHSn4QrNAxua7b6p1C+8qQ7Lhp0YVpx8AHaeA2ybwEW+2vxkNsSD3IKvVux/AdQvRZTFjfE5ycZZwZlcwKe0KPVSRC3ux4twuPjYzUGrA0oAKNCA/VbUHQP7eFJZM//M5k8Sztwps1HOPatL6z5/EMpCx0Snc2RpJPss4kGWxw36ctKnuwekG25MocPGh8IjzTEEbcBSKwRH33r7psBvXorPAvxTmAQ4wLLJY7Qzr4joXWU7NFh3RDXibqI0xoox/ATiqNHCduJDJ3anzDIxCKje8qeLepaVue2LqZM/CGg0LS5LP1MXKi4fDaCf86LGoPdnUwP0wAIooBzLgRBAlMuOs0er8uGpuoO9iCHhfBpIRnOSCKycPqboVxHRqm6Dwr3nFBOYITbu2ZqlmqRv1yrJk+yeo5ENMJJb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnV6b2E0ZGZXcHhUeGRXa1lnTmdHOGE4YjVkUyt5YXBsNHRaOTdBZzJpdlZX?=
 =?utf-8?B?cHF5NlBKcDlCYyt5ZjZKU3dHM2JMWElUcVg3WW1qTGVJdFhEMFdxb1pXQktH?=
 =?utf-8?B?S2dCK2VqYU5jM0E4WEVCOGw3dWFFMkRuZ0F1YWN6K3ZRbGdCbmJGMVZkcFFT?=
 =?utf-8?B?M2FsWDZHbGhndzBxUTJVRmhlVlV6bDZwLzZvSVhMSWhHRm94U2EwWVZBRXpT?=
 =?utf-8?B?YzZtQmdRTVNtMVZQZnE2cUg5eXNzeXdBbmc3amgrd3lnbVVJeHpYekNabjZD?=
 =?utf-8?B?aHZkN09QVlYzZ0IrUWt0VDB0L0xoUE51RldnczVHWGhFVllLSVptS1VCbjNk?=
 =?utf-8?B?SjZ0R2hON1oyVVk3U0tOU1FvbmVSRUFDaFVRSWxHUXl5TEswSnYxakJ5Tnpv?=
 =?utf-8?B?RmlCTHRuUW1WOEJkMlFueFNqQVlFNVR0K0VDRFJwL2dJZEhUNUtZbGxGK2Rp?=
 =?utf-8?B?bXJDTkw4dGRtSzl0dG1ZaTdEU0dzTVZ6dWFrdU53ZVdrb1gwV012Nm90U3Br?=
 =?utf-8?B?dnRnbjN0ZUUvYlVuUnIxYmg5N09yWVhSdWJJcm5OVGJvdkIrcDNwNmVNR2pD?=
 =?utf-8?B?RFcyWXVNZ29LcnBQWVpPbHZPd0IwblRhVi9PZ2tYdGRXeUdiWGZtTjgrS2xI?=
 =?utf-8?B?UkozTE9TSWowVXIwUm1Hd3hDSDhBNjVrY1V5RGpkRDVFUzd3ZlVVdVhkV1F4?=
 =?utf-8?B?SzNpNDN3MUdCdklOQmhQMk44dkFpYWlsdkJhR2ppZkpicUJWRWtBUmRVNlBm?=
 =?utf-8?B?bGdKblo1VXdla3QzcjJXWFdJa21JR290cmp6Q2ovTzlacW9aQzNYYnFMWkpS?=
 =?utf-8?B?UzJoVlZjME1YTlRCcVBnZ043RVhhNWZ6aFNITXpGQVU3bmxHbzc5dmhTbzJh?=
 =?utf-8?B?bUc4bFFMWFRtWkh4SWp5V29nSkwrK2F1WHdmUHlpNCt5UlJqUDZaTExLblNO?=
 =?utf-8?B?TEs4YnJETWhENmNLWWJkYU1uVysvaFhWanc2UzRXSXVDVmh5Z3hoVHgweThx?=
 =?utf-8?B?V0FFbHk0d215QWs4bDBNZ0lrNUJwdWl1QzlQM0RYMlJxRDI0SWhCK1RUY01l?=
 =?utf-8?B?T0x4RDc3OHZWd1BaTG1pdllXSGFuSG45UDM3U29HWUNZQzBld1EyTEd5YnNF?=
 =?utf-8?B?S2VEbUVyQjVQa1NkNStRVWQ2d0ZHTWZMYzhPSitSVDAva0NjTTJyZVFqT090?=
 =?utf-8?B?WGNpTmE1bGVtTkgzL09Kak5YNkkwZktqWmNrYklEdjBqMEl0b2NoMVNuSTlE?=
 =?utf-8?B?d0FWU0d4WkxQVWM4b1dSUTVMaGZPeFNmQSt2bFZNOTM4VnpiM01ySXBtcTlH?=
 =?utf-8?B?MmZlMnVwNFduY3BSYzhZZGpSZnlxUHVNRnBmdVpZNXYzc1RiR09JbFVWS2JK?=
 =?utf-8?B?bEk1NEkraU1DYWZKK2hjQk10VEFUamU1T3JkVXBkcUdNMnF5RVdMMGFjNzUy?=
 =?utf-8?B?TnJVL2R0Y2w0TW1uUk9IOGIyL3pxdGNLdWM2TkZxK2F1QWp1Y3dqMU4vdlNL?=
 =?utf-8?B?RVRYbFJ3WjRjRk40MytGMjlkeTUxQndqQjE1dDNXYkx2M0lsblNDVmFIelBL?=
 =?utf-8?B?TFBTZ1hkYXlHckpHdkpnR1FlaVNUWnZCamdVMFA1OTA1bjZVbWhkVjBEMzRx?=
 =?utf-8?B?bERQSkRRVXBQTk94d2ZBamRmTDNYZ3RaaWxwaE44QjZ4WmVuSGdnUlMvQnp3?=
 =?utf-8?B?RmtGTVExazJzM0t4cjVncHBkNnNwc0JPbWtNcnBwK2lhU3ZHZTlWdzRiZWhS?=
 =?utf-8?B?emdZVTFObk1vczdyRDRuUjV5bDZ4Z1VWbWYzeXdWclBQb1I2V0MwRVlpcEZU?=
 =?utf-8?B?YlR4U0VTc1dHT0F4Y2ZCQXczRHlwYU9vSVJLWGxwcnYzc3pJeTNIcjBzdEY4?=
 =?utf-8?B?cDZ1M21nVmlxL29kYlZiak5TS3o5MkFJYTNqNWpZMm1aMENNemV3clp3L3Zn?=
 =?utf-8?B?WDZCeUFkU0ZKK1EyeklpWWlUZHJQRGc5dXlsWWNLZ2Mzd3JrR3pLWFZVQmZB?=
 =?utf-8?B?T2t6SjVuUEdGWVl4aThISkh0bXMxV0RSL2MrSEpySzR1ZFExVzR1MzV3TWR6?=
 =?utf-8?B?Qkxxb2I2eVZmVlpteXV3RE4yWXdBZ09ZYVc0NEJIcU5jZ3pmemcxSHRTSXpC?=
 =?utf-8?B?NXY1d0d0VkxZbXVEK0s1NjVxbzJkRUJvcUZFcGZ3ZHJWZnhNMDFjUDZ2ckEz?=
 =?utf-8?B?MEo5ZzZqN094aVdJeVBObkpPdVFKQmdBZzEvQTdlN1RPa3h4bFdaTXUrcHox?=
 =?utf-8?B?cnMxVE5QSmRQa0NROEtLVHVmeW1JdEpKTmtucnpkM0NudG9xcXBUVkZMb3hP?=
 =?utf-8?B?WVNYbFhmRHJ4YnZUNm9WQzdCNWtUaXpjdVRMOC8wSlIwd2JlNys5QT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d83c257-0f07-4972-0559-08de8f18daa2
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:30:04.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJr36oWhe2Nm2UrjA71m+KCYiNaAb6byanmykXxSWa6k9yrxbK9PVGfcOne+UyxXJO7YDcVkxhKrcgz0asZuvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12064

The buffer pool is a quantity of memory available for buffering a group
of flows (e.g. frames having the same priority, frames received from the
same port), while waiting to be transmitted on a port. The buffer pool
tracks internal memory consumption with upper bound limits and optionally
a non-shared portion when associated with a shared buffer pool. Currently
the shared buffer pool is not supported, it will be added in the future.

For i.MX94, the switch has 4 ports and 8 buffer pools, so each port is
allocated two buffer pools. For frames with priorities of 0 to 3, they
will be mapped to the first buffer pool; For frames with priorities of
4 to 7, they will be mapped to the second buffer pool. Each buffer pool
has a flow control on threshold and a flow control off threshold. By
setting these threshold, add the flow control support to each port.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c      | 133 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |   9 ++
 drivers/net/dsa/netc/netc_switch_hw.h |  13 +++
 3 files changed, 155 insertions(+)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 3609d83ac363..688dceb486c2 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -379,6 +379,8 @@ static void netc_port_set_mlo(struct netc_port *np, enum netc_mlo mlo)
 
 static void netc_port_fixed_config(struct netc_port *np)
 {
+	u32 pqnt = 0xffff, qth = 0xff00;
+
 	/* Default IPV and DR setting */
 	netc_port_rmw(np, NETC_PQOSMR, PQOSMR_VS | PQOSMR_VE,
 		      PQOSMR_VS | PQOSMR_VE);
@@ -386,6 +388,15 @@ static void netc_port_fixed_config(struct netc_port *np)
 	/* Enable L2 and L3 DOS */
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
+
+	/* Set the quanta value of TX PAUSE frame */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), pqnt);
+
+	/* When a quanta timer counts down and reaches this value,
+	 * the MAC sends a refresh PAUSE frame with the programmed
+	 * full quanta value if a pause condition still exists.
+	 */
+	netc_mac_port_wr(np, NETC_PM_PAUSE_TRHESH(0), qth);
 }
 
 static void netc_port_default_config(struct netc_port *np)
@@ -617,6 +628,87 @@ static int netc_add_standalone_fdb_bcast_entry(struct netc_switch *priv)
 				       bcast, NETC_STANDALONE_PVID);
 }
 
+static u32 netc_get_buffer_pool_num(struct netc_switch *priv)
+{
+	/* The BPCAPR register is a read only register, the hardware
+	 * guarantees that the BPCAPR_NUM_BP field will not be 0.
+	 */
+	return netc_base_rd(&priv->regs, NETC_BPCAPR) & BPCAPR_NUM_BP;
+}
+
+static void netc_port_set_pbpmcr(struct netc_port *np, u64 mapping)
+{
+	u32 pbpmcr0 = lower_32_bits(mapping);
+	u32 pbpmcr1 = upper_32_bits(mapping);
+
+	netc_port_wr(np, NETC_PBPMCR0, pbpmcr0);
+	netc_port_wr(np, NETC_PBPMCR1, pbpmcr1);
+}
+
+static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
+{
+	int bp_per_port = priv->num_bp / priv->info->num_ports;
+	int q = NETC_IPV_NUM / bp_per_port;
+	int r = NETC_IPV_NUM % bp_per_port;
+	int num = q + r;
+
+	/* IPV-to–buffer-pool mapping per port:
+	 * Each port is allocated 'bp_per_port' buffer pools and supports 8
+	 * IPVs, where a higher IPV indicates a higher frame priority. Each
+	 * IPV can be mapped to only one buffer pool.
+	 *
+	 * The mapping rule is as follows:
+	 * - The first 'num' IPVs share the port's first buffer pool (index
+	 * 'base_id').
+	 * - After that, every 'q' IPVs share one buffer pool, with pool
+	 * indices increasing sequentially.
+	 */
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		u32 base_id = i * bp_per_port;
+		u32 bp_id = base_id;
+		u64 mapping = 0;
+
+		for (int ipv = 0; ipv < NETC_IPV_NUM; ipv++) {
+			/* Update the buffer pool index */
+			if (ipv >= num)
+				bp_id = base_id + ((ipv - num) / q) + 1;
+
+			mapping |= (u64)bp_id << (ipv * 8);
+		}
+
+		netc_port_set_pbpmcr(priv->ports[i], mapping);
+	}
+}
+
+static int netc_switch_bpt_default_config(struct netc_switch *priv)
+{
+	/* priv->num_bp is read from register, based on the NETC block
+	 * guide, its value is hardcoded to a non-zero value. And it
+	 * is greater than the number of ports (priv->info->num_ports).
+	 */
+	priv->num_bp = netc_get_buffer_pool_num(priv);
+	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
+				      sizeof(struct bpt_cfge_data),
+				      GFP_KERNEL);
+	if (!priv->bpt_list)
+		return -ENOMEM;
+
+	/* Initialize the maximum threshold of each buffer pool entry */
+	for (int i = 0; i < priv->num_bp; i++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
+		int err;
+
+		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
+		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
+		if (err)
+			return err;
+	}
+
+	netc_ipv_to_buffer_pool_mapping(priv);
+
+	return 0;
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -644,6 +736,10 @@ static int netc_setup(struct dsa_switch *ds)
 	dsa_switch_for_each_available_port(dp, ds)
 		netc_port_default_config(priv->ports[dp->index]);
 
+	err = netc_switch_bpt_default_config(priv);
+	if (err)
+		goto free_lock_and_ntmp_user;
+
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
 		goto free_lock_and_ntmp_user;
@@ -1195,6 +1291,41 @@ static void netc_port_set_rmii_mii_mac(struct netc_port *np,
 	netc_mac_port_rmw(np, NETC_PM_IF_MODE(0), mask, val);
 }
 
+static void netc_port_set_tx_pause(struct netc_port *np, bool tx_pause)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int port = np->dp->index;
+	int i, j, num_bp;
+
+	num_bp = priv->num_bp / priv->info->num_ports;
+	for (i = 0, j = port * num_bp; i < num_bp; i++, j++) {
+		struct bpt_cfge_data *cfge = &priv->bpt_list[j];
+		struct bpt_cfge_data old_cfge = *cfge;
+
+		if (tx_pause) {
+			cfge->fc_on_thresh = cpu_to_le16(NETC_FC_THRESH_ON);
+			cfge->fc_off_thresh = cpu_to_le16(NETC_FC_THRESH_OFF);
+			cfge->fccfg_sbpen = FIELD_PREP(BPT_FC_CFG,
+						       BPT_FC_CFG_EN_BPFC);
+			cfge->fc_ports = cpu_to_le32(BIT(port));
+		} else {
+			cfge->fc_on_thresh = cpu_to_le16(0);
+			cfge->fc_off_thresh = cpu_to_le16(0);
+			cfge->fccfg_sbpen = 0;
+			cfge->fc_ports = cpu_to_le32(0);
+		}
+
+		if (ntmp_bpt_update_entry(&priv->ntmp, j, cfge))
+			*cfge = old_cfge;
+	}
+}
+
+static void netc_port_set_rx_pause(struct netc_port *np, bool rx_pause)
+{
+	netc_mac_port_rmw(np, NETC_PM_CMD_CFG(0), PM_CMD_CFG_PAUSE_IGN,
+			  rx_pause ? 0 : PM_CMD_CFG_PAUSE_IGN);
+}
+
 static void netc_port_mac_rx_enable(struct netc_port *np)
 {
 	netc_port_rmw(np, NETC_POR, PCR_RXDIS, 0);
@@ -1256,6 +1387,8 @@ static void netc_mac_link_up(struct phylink_config *config,
 	    interface == PHY_INTERFACE_MODE_MII)
 		netc_port_set_rmii_mii_mac(np, speed, duplex);
 
+	netc_port_set_tx_pause(np, tx_pause);
+	netc_port_set_rx_pause(np, rx_pause);
 	netc_port_mac_rx_enable(np);
 }
 
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 4b229a71578e..7ebffb136b2f 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -32,6 +32,12 @@
 
 #define NETC_STANDALONE_PVID		0
 
+#define NETC_IPV_NUM			8
+/* MANT = bits 11:4, EXP = bits 3:0, threshold = MANT * 2 ^ EXP */
+#define NETC_BP_THRESH			0x334
+#define NETC_FC_THRESH_ON		0x533
+#define NETC_FC_THRESH_OFF		0x3c3
+
 struct netc_switch;
 
 struct netc_switch_info {
@@ -90,6 +96,9 @@ struct netc_switch {
 	struct ntmp_user ntmp;
 	struct hlist_head fdb_list;
 	struct mutex fdbt_lock; /* FDB table lock */
+
+	u32 num_bp;
+	struct bpt_cfge_data *bpt_list;
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index c6a0c0a8ff8a..1e1c0d279a21 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -12,6 +12,12 @@
 #define NETC_SWITCH_DEVICE_ID		0xeef2
 
 /* Definition of Switch base registers */
+#define NETC_BPCAPR			0x0008
+#define  BPCAPR_NUM_BP			GENMASK(7, 0)
+
+#define NETC_PBPMCR0			0x0400
+#define NETC_PBPMCR1			0x0404
+
 #define NETC_CBDRMR(a)			(0x0800 + (a) * 0x30)
 #define NETC_CBDRBAR0(a)		(0x0810 + (a) * 0x30)
 #define NETC_CBDRBAR1(a)		(0x0814 + (a) * 0x30)
@@ -138,6 +144,7 @@ enum netc_stg_stage {
 #define NETC_PM_CMD_CFG(a)		(0x1008 + (a) * 0x400)
 #define  PM_CMD_CFG_TX_EN		BIT(0)
 #define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
 
 #define NETC_PM_MAXFRM(a)		(0x1014 + (a) * 0x400)
 #define  PM_MAXFRAM			GENMASK(15, 0)
@@ -145,6 +152,12 @@ enum netc_stg_stage {
 #define NETC_PM_IEVENT(a)		(0x1040 + (a) * 0x400)
 #define  PM_IEVENT_RX_EMPTY		BIT(6)
 
+#define NETC_PM_PAUSE_QUANTA(a)		(0x1054 + (a) * 0x400)
+#define  PAUSE_QUANTA_PQNT		GENMASK(15, 0)
+
+#define NETC_PM_PAUSE_TRHESH(a)		(0x1064 + (a) * 0x400)
+#define  PAUSE_TRHESH_QTH		GENMASK(15, 0)
+
 #define NETC_PM_IF_MODE(a)		(0x1300 + (a) * 0x400)
 #define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
 #define   IFMODE_MII			1
-- 
2.34.1


