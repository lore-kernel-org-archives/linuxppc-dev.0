Return-Path: <linuxppc-dev+bounces-19524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD2E9DE62
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2026 08:07:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frsxK3NsYz2ygf;
	Thu, 09 Apr 2026 18:07:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775722069;
	cv=pass; b=QkJ1weopBv0Q5y1MlXATO/PgUx86UlwA2YUpWd/X6TWwTN9hPpxjc6uF/am8t/+0ZJ91roLfuPuvNEvFfXIIz5bUSSZ+gTthWxxazMLDGwqMejeM5CGpwqz0/S/oKdsJGtxtgZ54+Ekzl/DV3njX0BiYQSM44FNJprshS1t07FXApP8Y3o8IlV5XUJsJddswMYDCTVg9quHMx4fCX+Qrjr2To8nRRMQzjQLrMy243i+B0xjyVb0FUlSm/XDJNSuKZKOgdw2rNxPjamalJV1Z4WNdCVX3vopxhpSRk5eJHfra6BUCpiW36UjjjvL65kkLhLfcUHyaKMYVk2+aOc5uVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775722069; c=relaxed/relaxed;
	bh=qM/m6AwdwyIVhFOQUbXvoZabKUxpr7rQVsJRUNxy+y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e9NX24PrYiHDX/ShdX4yhXDaahbB5ktDXEy7TSovQ6Adtuq14V6NcOGtvhLtwC7tJ9KZzyV16cueQ3eXa0Gc2tJT9w/23AOr4GnlHNKdtk1bE1t67/I8kQlqjsf1YiT50oHIGFcE+ZPFzQmltJss7ix0YJpFykARvBtx8zh8fWxb+xsaOLfYDmeaYmKHHHe540MErk+dfu0DGHPQ1BeA690UGAN44HDH4C+3FSUv3K65jbWm68FqX1gsNgoAKgcRn0t3o1ioVn3igqbsMeFHtYy3gSk9iiFRxsfaMIjh5tGGVYTOtCMNSPbmYzdQy6HCRHil7fBEP1Zjl7mIlUf5JQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WLc68t38; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WLc68t38;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frsxH4zhQz2ySc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 18:07:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0qqScQjmGnBFCQ/4DTrD/Q7lD8U3xp5of6LZpBjpKNJNDkFz78QztAsCLLIIGHwhkx4pQNZuEdgPYtwbtTfPVg6L9nBfvSfQFzUdKYX6rCr27+ZSWIjRofO96j42MmSxNIjF64Q/5IruLgAfMe9vrDvapliksu5VngG/whjZYkkoMQyBS5CjK3+G3+9y6A5mIiVdwgRqNFNEg4Py0NTFeWx+Gt8Nb/l4/ZH4ui6qHwkBf+4eRQkEyKmiK99Whr8yh5QOg6XEEdCWlsnmWnOYPp0oNFuSoig/bou4TVPWrNDFBuNSqVGkF9a4TH8+4/vKVryVVpNcW3+fN4hb6yduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM/m6AwdwyIVhFOQUbXvoZabKUxpr7rQVsJRUNxy+y0=;
 b=ihosazG6zqpq3ug88ve/Ql9nWdUG4G2sm3GFnab++GwwBeBhgf00A0TTtG2JUBZsIBzmhdukQ08ED3ekIsOCITAkZ9tjZ8o5SPoCT4Td1tiLfbJo4aDKzWyRFvvewIJ6rHAeiX+8BR1nKLy7M2uhsyYfLa5t+AJ0mq0sYVutc5ghjBrNxkOUJ7trOfQHadEs2Rr5YV/G31UBq1S3Or/vWuOcp5xxok//TvBDg5JcsRWmnbIXP5KZ3xlPCkmstYTC3uYuxtQVJRoXyDlCuJ0hVnAIrRb5hdXVPSRVu7sR9njxM+6HYIQiQP6Tqcn+3qUqRGKiZJcNqXtlkZRbfKr94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qM/m6AwdwyIVhFOQUbXvoZabKUxpr7rQVsJRUNxy+y0=;
 b=WLc68t38Vhp/E1ld5dqmuoseYXX1JKanlBM9MpkffOI/WV2Fno0Pr1M3wwEU/Zr1Qruujw0dyy79+txWHrORyg0v/GWC/7Ied2vd1Jos4HkNGmloRI+vTjedgjEm2bypq7Rj8Co3T3KW5aIs4zVWxpnGmKN38P1MipC/LyxfVh4nmR9+dKfVrYj2RO4d+/BEwH9wQkY03ZGPgekMyFz9nB/OLWvOgdmeq7dnF0bz9dUwKPOEOjTwAS2py9ePdrsPbbEER3gIT5C+wy9ITglfDa1awaSjvahmLU8yYLusaOpKrPhgi9/gkMBtCfK/Fn1TJd6N7Z8t1iXQjWmjJvjuNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI2PR04MB10288.eurprd04.prod.outlook.com (2603:10a6:800:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 08:07:16 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 08:07:15 +0000
Date: Thu, 9 Apr 2026 11:07:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	Frank Li <frank.li@nxp.com>,
	"chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v4 net-next 10/14] net: dsa: netc: introduce NXP NETC
 switch driver for i.MX94
Message-ID: <20260409080711.j4kmavt7utef2kil@skbuf>
References: <20260331113025.1566878-11-wei.fang@nxp.com>
 <20260403011738.1795644-1-kuba@kernel.org>
 <AM8PR04MB72840DBFC7F3FD578DFF6AF8885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8PR04MB72840DBFC7F3FD578DFF6AF8885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI2PR04MB10288:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d29ac3-c40e-47bd-64b0-08de960f02ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P4Y9azEzIgp0cSA25iHKurtbnqBTcZYM61C1Z6YiXtt+vcc6xOp6CkDSs4TKyxqfRiJCzFwgoMCiR5qmgrQi+GZ6lxOHk3GrwOfiB939iqxW99YddzVAQp9ohsvWajgNpfIPQpBgu+PAcHq/P+yksDTptDqzUausOwaBr5Qih3jN6SLL68VMDUeeff/dWKAPXXNto7od+p4DHYig0L2S/Ir6oeSCOQdt/hR8diF6CaLi3NexT47jFcOxitqSm1kXiw9qCCbHNeRnCzbOCUmFhl/l9yTtrsj24Hy+jQ+JnDK0BvRdMmwWGvIBK86vumOHAo8/tq4iZApmawdntcHdrNLC0brreNFvacz+0942gqEUNjj/oSDRPt68SFXcxl/kFUKUxLFq9cH74APCpJhycmbQFgSWvhR0uwrroXfg2m4ss8P7DW+HGs45EyRZ7AmYFwA7cW4YJ+SkJubwUMQpX3/1p/of6tn2x9LKNFIRRKBcSoU/G0jcONK1kWQ/P8nc5zG8J1P9PjnMh3prlRDsyI239NuZ2/QMJ+FiS5VskvOveeDiSv92E0NcubhQITjz0aCe+2X/C7oOTSk5BK91aWv5BJglxE3wkNljmmqXga5PF88fjqp7U3ADvxXymtveeZKvwvdjMwW0mJvk1GzWNVTwU3VxZbj/GdYFDN+p7E5GYk7xiHDVTv/IdtMkDmtYx7ZXlgZPiFjHNkrsSoseur5PCCc4VZiJYTfgQO8Ldw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(19092799006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipTUrx/RuadnRFQ22K3ej6zrK1dHL6fDTxReEQUCtENUneU/WdXYFQCSy5lg?=
 =?us-ascii?Q?VjUFhJCdkjCoAo8nPI9JpdtV4bPa3G6zXJb9N2wpNKzU58dRew1hrBS6PN6W?=
 =?us-ascii?Q?wuSESS0R2Wgd+PjYwMwQQRLn1QpVIPdwOpid+5rHm1pmt2/mOsNqZssHq3qB?=
 =?us-ascii?Q?nEp2rEnkSjbZaUSBtTz4f7EwFwERsMr1PP47l3bBJhCCIO7ksuLaICXrYXMs?=
 =?us-ascii?Q?vwqSrkFMNsDPPqLIeUvbpc3L6tOdNuoLeUGfSe8LktHyyqMW2M0n+CGpd4+e?=
 =?us-ascii?Q?nV7iqglNQ1FcpPynuyh+xIM9G0kaH7FP/Qql0G7vSFmW6hMJ+BaMJQHokoWE?=
 =?us-ascii?Q?08+QtkLxsxHbQmDP2f4FwzqZvTAS21lPXO8/2b2Y6xZ8Zjipc/dxsqraLcxU?=
 =?us-ascii?Q?y5mn0FCNbT4oIBTL5o7Vlz2guuRGKQOIeD5MrdAwX0RG0rtNQ8c9tK8r5/01?=
 =?us-ascii?Q?dBMC/vhR1TrB5lbaTv9EkpI2FhbrL3NMDFHVsg3kFoz7EdqGavGcxPNYHH9d?=
 =?us-ascii?Q?MAvN2zyfAEZqiBr1O8gQ7Fn/XYstT2j0ZPldKlJz7RW5zGWTWam6nALvpCLN?=
 =?us-ascii?Q?okzcWswOTaTJ19FLX9hAbUbwdg/EKqaJ5TVRP9uJ4xa2QlexrhaUQfqGEw57?=
 =?us-ascii?Q?h0JVAmxccCRp7OtcIwETfVBg8rys8vvpJrRY84Gq24qANVNT9QHIjR9ddHTa?=
 =?us-ascii?Q?3eDzhXEApMbicNoa2/IETW7WVhkB/WD4kwx75DoGnwuCrDn3fQiCsGOPwu1I?=
 =?us-ascii?Q?dQyF5FPmHvYRghG4oL24GylLIep5nGygx8ghCAh4Jvld439Mml7Ycq8nv8Gz?=
 =?us-ascii?Q?YolLxH9R6oYmgCkCG5XSuoTzGgUIo65SUA596ZTX6A+FelCz5O1FHitL2ase?=
 =?us-ascii?Q?nliUoxBEB6lNo76lHGxtcU7NaR8iVaZ7Rpb/7MbNiNZeYsn7Ze3D6pXKseyC?=
 =?us-ascii?Q?2R662Ds7n9zh68fEbbZRs+XpvfqZh85vRIpOTGkTk2+XUEMl45XujeWyc3d8?=
 =?us-ascii?Q?SKl8v0pk/Eyu3LtUjKyR4M15s48g1q8R4kYHF0mu8g0ani/j6DCrmRFzsMB8?=
 =?us-ascii?Q?vCRPMl6za1gRSMiuAp7/kwz6GvElwzTibI6OF+9vsXdP9Mnv6mVhNhTCekRt?=
 =?us-ascii?Q?rlr1em0/UXthsaqg9BPe18oLqogdSK+narhyP7s5l3lFUFYDxM+DfzrN0kJg?=
 =?us-ascii?Q?K1/tQoZPKPir/0Wvodxn8kTphHzSupZsYIXq1vMKy3SOsQ+HdS2n9v+OIR1u?=
 =?us-ascii?Q?dhtDpe8I+fnlZmE3txcEUGP0gdbaypOY1NI/AwuXfqOvvfSEOS1pHLNqiEVI?=
 =?us-ascii?Q?HdYV3GH5ZrcivnUJgy02Q9bTHIkuV3+nfcxOeZdtISUEVpu2OaWEgHweCsMg?=
 =?us-ascii?Q?uzg4NG6ddnh8vcNacKMcP7RBWPZ9Y8o+4Bhwrjl5nMGLcD3VY5LDb1QpvHvF?=
 =?us-ascii?Q?uziBnMESvFuIfmrKBoGNvSRxQ6JBAhN53ixQxS0qdv9Ui0Vb+njOZNwglEWP?=
 =?us-ascii?Q?MlrBtpORLj3ynGvb0vjH1cOW+Gg/jvI8ZL89vSoU2d4jB6CHLo9HKc0i3IJE?=
 =?us-ascii?Q?EhSlxvEgquc42HPFAIh90M591SMSou7geysvz7ZWZwmeze8XOjJ60JLoM/1i?=
 =?us-ascii?Q?b5BRY9cCQurkr7syAj8Su885+e+rNJH2JGuBgyIKxZmUN74fY+qqjR/SJtZH?=
 =?us-ascii?Q?eJceswGmG22tA5JomBqUrl8wALCRfLqo0Q1eb2iLK/qCSm8aJvFKfF2rvJIW?=
 =?us-ascii?Q?ymGXb+kB389HZkmYiyC9cPcc0kVBU1Jn2LUL4mhV6jdpJEaz+ycnvXuv1g0C?=
X-MS-Exchange-AntiSpam-MessageData-1: tvBi4CkyNFc5kQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d29ac3-c40e-47bd-64b0-08de960f02ed
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 08:07:15.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m341qPkSwnkfn3BWMo8jXmdmAwWRCplUNejKDA4j0VGb8KXWPNQDDoJ7c92ivslT7oC9kmnca+7TQ44TzcLAeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10288

On Wed, Apr 08, 2026 at 11:59:24AM +0300, Wei Fang wrote:
> > > +static int netc_init_switch_id(struct netc_switch *priv)
> > > +{
> > > +	struct netc_switch_regs *regs = &priv->regs;
> > > +	struct dsa_switch *ds = priv->ds;
> > > +
> > > +	/* The value of 0 is reserved for the VEPA switch and cannot
> > > +	 * be used.
> > > +	 */
> > > +	if (ds->index > SWCR_SWID || !ds->index) {
> > > +		dev_err(priv->dev, "Switch index %d out of range\n",
> > > +			ds->index);
> > > +		return -ERANGE;
> > > +	}
> > 
> > Does this check cause the probe to fail unconditionally for standard
> > single-switch topologies?
> > 
> > The DSA core typically assigns ds->index = 0 by default for the first switch.
> > Because !ds->index evaluates to true for index 0, this setup function will
> > always fail unless the dsa,member property is explicitly overridden in the
> > device tree.
> 
> As I mentioned in another mail, we added the 'dsa,member' property to the
> netc switch DT-binding doc, specifying that the 'member' (switch index) value
> cannot be 0. And 'dsa,member' is a required property for netc switch.
> 
> > 
> > Could the driver translate the hardware ID internally, for example by writing
> > ds->index + 1 to NETC_SWCR, rather than forcing this hardware-specific
> > restriction onto the software DSA index?
> 
> The current approach is based on Vladimir's suggestion. I need to confirm with
> Vladimir which approach is better.
> 
> Hi Vladimir,
> 
> What are your thoughts on this suggestion? Is this approach better?

I maintain it is preferable/simpler the way you are doing it, with a 1:1 mapping.
The LLM's concern would be more valid if the switch were discrete and every
board DTS author would have to remember to place the dsa,member property.
But the switch OF node will live in an SoC dtsi.

Maybe you could put something along these lines in the commit message,
hopefully the LLM will pick it up and stop complaining.

