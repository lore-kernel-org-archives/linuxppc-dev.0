Return-Path: <linuxppc-dev+bounces-29060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3954CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 14:02:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0sBL5RQzz30TY;
	Fri, 09 Oct 2026 01:02:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791468138;
	cv=pass; b=X5JEaKDdb75aPfxl24jODA5XWuFrs9Q94V20iRnZ86WI4fFZtxHVDPvg0QzUPD9+g1KFTai2jLFVOZaUbSF62tt/oMkxWlNUf0J63mftHus0GK5nz4LRKAadlDSIxs1lSL3Wn+emiSxX3OOx3ihDV0ac5GVxTuxXCNMmgQNmP9o1O+U90RtoZSjbj2BoQUuoU7Xo7nHF9z4+3Pz5bmUBrmYwq0OEPZ0CzAJfIPpJaunIJSjBZrv1reqUfeNzcO0CP//0fVZUNkbVSODlqr6MjPAUTCoF0m6fO9/0dyE9lJ5chwWJ/MDhbXE3iQxO9AhXZ4/79RHiAusRrjvN0EqhDg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791468138; c=relaxed/relaxed;
	bh=F9Nh5+DMSqtllKtgoyq4B2P0bzw2yMbsUyPt2F4ZETE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iVMErM9JZkPlOD2YP9cECWAJ9W2ZzPUNFEeBahdvWRmVZhsamv76POunGt1lYkxgaVP0t7kGetT1iKN28n699xXiq4Ip55F/IDQGa7y79j8gHDYFRCq4xvX52lz4HQuN1oyA3/jahIEip472PbeFe1XgTjf4KgXNVh0C5LKkEJvAuLsLYTCaukYg8Z5BCnAw0RXnz2ACbD21XYJsAbmRLZHUgDYZ5WETaAAgZ1GH2jpPhRGR9S/qS+KDGdnZM//8yoItS9Sb5nakmXGyT0uJVbEKRH/jVJbIwEl/2ftkuQg83rHEhAk/K4D44Uq9MhaCOU8QR3AIBk63ikye3wljOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=k4PCedRW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=k4PCedRW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0sBJ6SBPz2yqs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 01:02:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+fGWcrMsV7Jknj1luhXv7GHxBkb7D3es95zMYEm8svAD1WvDZfd5O9zPAn8BYZH/Cs0eqz2Glmv2aCWdnuPJVE9AvC/2JdUcZJGtSa+n6eIkdJflgUYhnP2BW0aPKFRrnK510/S2ftiZV3D46MCAmIRQCoHzoQjiTPAWx+S/VoBkt5uw+7iWD+DB0T/3FluKw9BLNPKtWf1LxZY6mpSa1ZTHyJC60RYZR/pXXrNUlH+PyoJZFqd0bNOTvC9rP3cg6XdIop9fBfMC12hUlCYPfsXfmJUlMeLSEyjd03tA1cBSHaw+fcrlvvPGlNZthe+My+wOOrUY7PmgTpUk7YiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9Nh5+DMSqtllKtgoyq4B2P0bzw2yMbsUyPt2F4ZETE=;
 b=xQ/Jea+6sWJeft75kFePz4pJMCa2TXkj3FFfJ1f2maQY3XN/2jdWfj7yu0v4QhqQXT8Vl+N/9yiPBSqHryUNxdMplNeDtG3sUY0F99cbPAfqYIvhLi0EuLSPu/NNdinUHukw7R5rzhZl3GxQG3yP0M3Gs2hN0polmwWO1TVQTGOXJBc+IvLMofKKs9AKTNxGbCTtGlsO7RjQFYqEX04mE6V5aD4KsmP8MEsmrjsyJHnqpBC4fQJnqLvxW42wZROhXj0/Qb7Kd6iFvSDOiU3w1KDOSQvq7kS2AX5HHCvPsOneEjiJEGAkzsbGRkMCmgJXu+AcwvkKON6vGQj4O4wDuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9Nh5+DMSqtllKtgoyq4B2P0bzw2yMbsUyPt2F4ZETE=;
 b=k4PCedRWhCczF8PNj3CnTpyd+M3ty4m4XUlO+r39X/alU9rJJWnExO59vqg9GEndTlGz4Qa43HhUi7J65h4oIVN4+bfTQDWxAFDomQMNWsJ0iWttwv2UxluhqwOLkclWRS6uUnXkRmDR3Ao/XF+OaZBg5F5a4rj7GJsJMQKcNNNg/gsAGHBYtQ2JeXgfENb7Oar4Nuy6RzYIX65wo09nvo/HC1EW0LnfbH/UV3Yb0dVDnZ34g3EWsYI6mdcQZiXuM4eH8mLjI0Laa18gRVCbIndLtZn6gdUrMTa1dLhNrMSBxzcxtdp3xb8xg3o5S16MMj/sM8XrMaL7FJnD4L1lsQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by AM8PR04MB7796.eurprd04.prod.outlook.com
 (2603:10a6:20b:243::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 8 Oct
 2026 14:01:46 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 14:01:45 +0000
Date: Thu, 8 Oct 2026 17:01:41 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Josua Mayer <josua@solid-run.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Horia =?utf-8?B?R2VhbnTDg+KAng==?= <horia.geanta@nxp.com>, 
	Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 2/3] crypto: caam/qi2 - skip isolated CPUs
 when setting up queue pairs
Message-ID: <kcyo2qvl5qnjydmsntrmk36rdp6e44ti7rijduh6qsor5avqxp@eyglumj7ib4f>
References: <20260930-dpaa2-isolcpus-v1-0-66c13f4fd75b@solid-run.com>
 <20260930-dpaa2-isolcpus-v1-2-66c13f4fd75b@solid-run.com>
 <cozavqeupdtr7cyn33nvtfqoqkw3sop5tffou6753vwg63hgwf@jr6gx236yblx>
 <6d6f2e02-afd3-4e24-8b54-68cb93ce8174@solid-run.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6f2e02-afd3-4e24-8b54-68cb93ce8174@solid-run.com>
X-ClientProxiedBy: AS4PR09CA0020.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::7) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|AM8PR04MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 22de3b17-5059-4e35-bcf3-08df2544b065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|23010399003|376014|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	uXPTUYJifgQQbGfTFrb6/2F+LjM85al0SLlpIsJYfvBMXAWiAWj/+4oHJiqS4uNrM5IlgATTlnorlerd1AAEdq8CKDYRcxrnzA27Bd2aTxyb7qWTo9WCrIZHkER349/saC9+qIkobjSyPqoXEk651HaLHbLFyS+lrIPxB6srUxs04WV/dnx3wldTSmOhg5bgE9pSXR2CR9X5VbCs7LUQ3N8Fc5n4rmi52xr6nVaouBV7q0QU1AucMpJFboWlsJYwAiHkn6tFRs1ea9dizZ2Vce6sODN3kKMjXD6qkDDEJrZ7R7OjZo1CQOtqHToKDdXLPYV0SJbMROlCWso/thRwQk8R7KYB05PjXx/4UILk6PM8Mu4xGBnDjKHMehLnrDcLTd+hB8txolIx2pGoJpDYWuqAbMrpS89p1HQj8JWcpqqPkI2mQ44J6rkgqJCCcuAcjYPoMa8/WIDEBFVr0HVLLbvqDmSDdYOEnK5L6nptJiFLM9NOFKNs3WfksXj5PJbsO/+zBo1Tqc/gyXDNUdryjNlpzw9ovEnuYIOcR9ML9F5mraQzTDM24h4hGxivTliQNdI+C9IJJKrSBErMx9UrIiZD+LzE4DV9VH82RCpUjfDNkHi+VHLHJYXTWczMYsprIwKynTmRfWA1836rR8VjjeGC5C12fu2ww3qXd/S3Pbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzlNfKAqnSk8aZEs3RtuQupN3jBkRqakOd0KgXLLu/WYv95GSQlV8bn3L9Yy?=
 =?us-ascii?Q?2OoRXanXRSfofqRklFFgq3voRIjo8OwbWGpyIXmMpUCAhU7VO7ZwyQ5x2dNm?=
 =?us-ascii?Q?POcM2bnBxW5F2HXUp6wMK69BYqTETEAis2RNKxyembgTqJowivUt8Szu9AqY?=
 =?us-ascii?Q?glDE2dlINWqJZH/I4PdlV9iJg5WozNYnzLMhD7R4+8CZJTPhleDjXuPJFo92?=
 =?us-ascii?Q?rXUQO96nSYOp+JWZtdMlMUubio9lLnD6I8FGN7KgFaXNLZmFNOlK6r8XedG8?=
 =?us-ascii?Q?nWytaXceaswSDxHIKbkyDNctnHSDIJbugOaT0GxkRn5r3mxfOdwo8kV44/GX?=
 =?us-ascii?Q?Y/ph8NByjFDxg3v1GEFNtFlh29CoKg4lrCePb1KKZEXuxglNj8rjPwKLxtMR?=
 =?us-ascii?Q?p7ue2GCJJZldGqYlu503eyVu0SlHoUTM9DYvd5I8ZhZVImqRS/Ykyp3m2NaM?=
 =?us-ascii?Q?+47bP2AbXnrc7WRNR0OZcYqiQVSjfROn+IyOh3l4wmUK5/74ALIHjoOyCGQ9?=
 =?us-ascii?Q?etVEz7gWAgimO6SLCNBfk2mn0EcwkIPc5uC9/enmU2Cc1s03FhPZoIMofzSj?=
 =?us-ascii?Q?FLLG9B2TrINP6vzOB492mgH8WpJCskQBi8I7majtOm+MIVLpeU0MWDWM5U7f?=
 =?us-ascii?Q?5QcRQsGQSDLfU2hW3Y7NcnKh4DCvZYdEhT7BVEG7UPRqZL1v4nbA2AcvrU+T?=
 =?us-ascii?Q?0vwpbY/bK61TSdHNW0yrHCDR99sxviF6G/SZs8OAej3OciwrlITYXU3FJL08?=
 =?us-ascii?Q?3hiWX0IwnnzYjZVXHxrddbdJe3rSpim3V43WptuH5z++yCayU/i53qVFrRoA?=
 =?us-ascii?Q?Wl+uJUB6LkBvIM583XjnU/vip07fuLSrpuQp2bcHhEX62zsj+BP3DPX7CU2M?=
 =?us-ascii?Q?BvusQVttsDsqWjRH7sBf3PJ3ejvUWrvyVMIqZuNIPbweyCadSEoWeQbC1Gbz?=
 =?us-ascii?Q?DxNNqL4Gm66mAR7TgszEZzxoGsTauyUkNnMjOkkTYA+UdO00Joz9/vbcIUYr?=
 =?us-ascii?Q?YjpfBaB7H0amnuh6GO0IMA3tiyPHnl7WyMLDtrmqsTsBax6acfeCxjaJGDOv?=
 =?us-ascii?Q?oT58lQHvXhqpONOfLf3AHYKwYtVT0AOQaWD5d7q8hn3EbCoYMdCUiuY87j0G?=
 =?us-ascii?Q?hSQU/YrkeDBix08Dca5FgsyuY1OZKuoo6rmH7k+JoxoMxX5BxvJSu4txQPE9?=
 =?us-ascii?Q?MRLJZTRiCEdtkvmglZPzvUw1s8bUCgEM/HQiJgZOhfXW0Vtrr2cRNX5eOpPG?=
 =?us-ascii?Q?V/BI2QrLXWhUHSDSIz6msxcJcMOoQNsJX0q9eiUqUpl3shpG7vddyJAo9OrE?=
 =?us-ascii?Q?nmQ57NPP8gsRn99TkhZGyar8UyeVWGNiT2VEBeNSUBQxqevm4zBFAtnhpTWy?=
 =?us-ascii?Q?MNiZvWhq8mzssAY1X1NVi9nzdnszyhOawiYinkHFq5ZukGg6V1ydrfyyy6C9?=
 =?us-ascii?Q?2iG8bJHZ9AmaWHC3EXWuqDRZ8+h3EPu13Bavqres3bQDuM9jneZc2J4rsprn?=
 =?us-ascii?Q?b08BJ+/LbTLeico1veaaXUla/CRu7VpomjepoYmu59dr6YkiRiVVt7VyBQvG?=
 =?us-ascii?Q?3BwGVcrvaxuOHCpXxh2rL1m5hNpBstTy30fZECzCpakuJ6ukjs57WS1FZcj9?=
 =?us-ascii?Q?e0fTSFQRao8JTnOTAUifL0a81ZJhQQ/jknn2ty4r2o0n84QjmRUuy/Hi1w7i?=
 =?us-ascii?Q?yYUI8mjaT7s7/j3hWvA61HU7napN81ZVcXAiwM6RSADCROCcaBaS+mlXAHLR?=
 =?us-ascii?Q?xckvWyYJNQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22de3b17-5059-4e35-bcf3-08df2544b065
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 14:01:45.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3LrEOpwtNnca2IRtK665XY2qSP8PfDETpvC6JsPyLnZf1N4rgEWH8B9dlVlwL3dnTtAa9JUlP38CEGcJHVp3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7796

On Thu, Oct 08, 2026 at 10:49:57AM +0000, Josua Mayer wrote:
> Hi Ioana,
> 
> Thank you for taking a look at my patch!
> 
> On 10/6/26 11:27, Ioana Ciornei wrote:
> > On Wed, Sep 30, 2026 at 06:54:59PM +0200, Josua Mayer wrote:
> >> The driver looks up the affine DPIO and sets up one Rx/Tx queue pair for
> >> each online CPU, up to the number of queues. Response notifications and
> >> NAPI polling are handled on the DPIO object's assigned CPU. All online
> >> may enqueue requests.
> >>
> >> When isolcpus=managed_irq is used to reserve CPUs for latency-sensitive
> >> applications, those CPUs are expected to be free of routine device
> >> interrupts.
> >>
> >> The DPIO driver assigns affine CPUs only from the HK_TYPE_MANAGED_IRQ
> >> housekeeping mask, leaving isolated CPUs without an affine DPIO. This
> >> defers caam qi2 probe indefinitely once DPIO setup reaches an isolated
> >> CPU.
> >>
> >> Restrict queue pairs, notifications and NAPI polling to the online CPUs
> >> in the HK_TYPE_MANAGED_IRQ housekeeping mask, so that isolated CPUs are
> >> skipped and don't defer probe. Isolated CPUs may still enqueue requests,
> >> with responses handled on housekeeping CPUs.
> >
> > Don't you need to also change the for_each_online_cpu() from
> > dpaa2_dpseci_setup() to take into account only the housekeeping
> > managed_irq cores?
> I initially thought no, because of the "Allow all cores to enqueue"
> comment in code.
> >
> >
> > Something like:
> >
> > --- a/drivers/crypto/caam/caamalg_qi2.c
> > +++ b/drivers/crypto/caam/caamalg_qi2.c
> > @@ -5101,7 +5101,7 @@ static int __cold dpaa2_dpseci_setup(struct fsl_mc_device *ls_dev)
> >          }
> >
> >          i = 0;
> > -       for_each_online_cpu(cpu) {
> > +       for_each_cpu_and(cpu, cpu_online_mask, hk_mask) {
> >                  u8 j;
> >
> >                  j = i % priv->num_pairs;
> 
> Correct.
> 
> The loop is doing two things in one: assign tx queue to each cpu,
> and assign rx queue to each cpu.
> 
> Only rx side is an issue for isolcpus. Do you have any idea why each cpu
> got a tx queue assigned, and if this may be changed?
> 
> 
> Here is a copy of the complete loop, with inline comments on the
> control flow:
> 
> > 	i = 0;
> > 	for_each_online_cpu(cpu) {
> > 		u8 j;
> >
> > 		j = i % priv->num_pairs;
> >
> > 		ppriv = per_cpu_ptr(priv->ppriv, cpu);
> > 		ppriv->req_fqid = priv->tx_queue_attr[j].fqid;
> Assigns a tx queue to the cpu, one tx queue may be assigned to
> multiple cores due to modulo above (if i >= num_pairs).
> > 		/*
> > 		 * Allow all cores to enqueue, while only some of them
> > 		 * will take part in dequeuing.
> > 		 */
> > 		if (++i > priv->num_pairs)
> > 			continue;
> After this i <= num_pairs.
> > 		ppriv->rsp_fqid = priv->rx_queue_attr[j].fqid;
> > 		ppriv->prio = j;
> Assigns a rx queue to the cpu.
> This is the case which causes issues with isolcpus, and it should
> be avoided for non-housekeeping cpus.
> > 		dev_dbg(dev, "pair %d: rx queue %d, tx queue %d\n", j,
> > 			priv->rx_queue_attr[j].fqid,
> > 			priv->tx_queue_attr[j].fqid);
> >
> > 		ppriv->net_dev = alloc_netdev_dummy(0);
> > 		if (!ppriv->net_dev) {
> > 			err = -ENOMEM;
> > 			goto err_alloc_netdev;
> > 		}
> > 		cpumask_set_cpu(cpu, priv->clean_mask);
> > 		ppriv->net_dev->dev = *dev;
> >
> > 		netif_napi_add_tx_weight(ppriv->net_dev, &ppriv->napi,
> > 					 dpaa2_dpseci_poll,
> > 					 DPAA2_CAAM_NAPI_WEIGHT);
> > 	}
> dpaa2_caam_enqueue unconditionally accesses ppriv->dpio per-cpu
> and ppriv->req_fqid, not gated by any checks, percpu (any cpu).
> 
> This causes two issues:
> 1. each cpu is still expected to have a dpio object
> 2. each cpu is still expected to have an assigned tx queue
> 
> I don't quite understand how we get into dpaa2_caam_enqueue,
> I suppose it can legitimately happen on any cpu core whatsoever?

I don't have any experience in the crypto area but from the looks of it,
there is nothing limiting on what cpus crypto_aead_encrypt() could run on.

For example, one of crypto_aead_encrypt() callers is the macsec software
implementation. In that case, I would expect that the macsec's
.ndo_start_xmit() callback could be run on a non-housekeeping, which in
turn means that caam_qi2 needs to be prepared to run the enqueue() from
any cpu.

Ioana

