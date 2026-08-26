Return-Path: <linuxppc-dev+bounces-26094-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2706EC61DC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:22:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVK1M4Lzhz2y32;
	Wed, 26 Aug 2026 19:22:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787736151;
	cv=pass; b=RDMnoumL6A3+pLdOrNnDKJE63ErCtdghZ2Gw49GTziNY34SC+xBrQRPrPWxyFmgzCm6hgmVeybsYTC5AGVpodyhIvmYOsXQ/P4aSmSIVyT6/Qer42apgvqGuG9Ax1b1WO+jFHgloSgfy3SOXUG8a5OFUWacyjFHs3ruDicegXeFLIb3oT5yySiKPHSn/GhvoZg4vnAmmVsfCkLHhdXYHZMyZBGJtOkQQ66uWXXba0Uk4JUuKchnhyjhwx+Voywi0JRkD6BN+6QZdWBqg+rzLoShrJHp/m7f7F6/QW8RnjRLBFkkz+GCCxBe/IhNAyoQDGkxYZDnzS32FaqN+NqSAlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787736151; c=relaxed/relaxed;
	bh=8Td7tzNl8jHC9SEFY0PZNAjhSnuN0IhVu5X+XSAcPsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QHKJuD8xaIExpWgKNKvihYdoCAz8RzlS8DryO3yabNKZLI1IslYBtkxCRQP8nDCgbNaeuMBY8tFj8IVAsrIUxSOFKp8G+FmHsTmbmgs1fRDIHWD1GEWA55m5PmjLdoruSq5E5Ii213Jal7lF5pFbxgCxlaMeSjQnxH2b6Si0fMhmvPRg6NE+f+heL66EcV5dzKlyW9OURxs0L6gkwKPQdgOk+iN4Jyb/2h1egPJWzPhrfzoZdNukgFxIVKcnI0P/cJ/5O65g7NUPhgNsnMFrvgTlc657CzOITWkZjOXycX/1IC2UNbNGwdnYH5i+4woOhXvAZJpmQikS3t3f6dkSUQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qcf5VRNM; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=icheng@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qcf5VRNM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=icheng@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVK1L3hsgz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:22:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEkHo4mfGxHVcDKtSH6/ORdnwa/RCyUKH8p1K6Ty3P0Qmwd4txeOaj8YZrWFgHZk7B4MohPNxtglylQN/Ju/Wi280NrOmRODVzsME9tqpQBP8XrgnpCyMBPAvvzPSvA5vcsYapgJgFm8bMnFQjIa+4GZ2xp+AZGamoonSF/Xh+jpSe0cFcWeYW7E81y/Mu0pu1TQWFPrEiQlTezS2d2EnRocLIJgNugRrppKveGOCtiFfoxkNsgZM1UGhryDGqZGK9RUO+aOQQ1TGgRxG4HzCTz62ABZBRSAorOgu3m6gNCMRg9npCLUMFYMGCq26wbSi2+aLF3n6fPGmfoLDunE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Td7tzNl8jHC9SEFY0PZNAjhSnuN0IhVu5X+XSAcPsI=;
 b=h3GRnl12n9MFZWerKkh5O/tgomYZecKoHzXfLgt2JsttRatTE5DEqpvRQc9tQ2HyCwFULgsnvrmE/tdBDoS7P17Tvtmx2J1xz6jnP2c+l7SZQVUx3rJLARkWjpha7dIs2yJx9uieuDFyj8/f7ySoWr2O5zLH7mNDtGCi5E+HsOOy66bRJkqPFNOU8uKFoNcp0qN3Hw9V/vebp0aLA08wp0OVaUjCEhqYOGhR+M58W2tmzclCSUKHiySoqYI6OE9k49Vp6Tr1eX3nfmU8413Gn2Wm+ct02ZtAvRdGe/8QXHyO6elBfidDWLLBpsGISrjL1UNVtZyglPHDD80lhH9ezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Td7tzNl8jHC9SEFY0PZNAjhSnuN0IhVu5X+XSAcPsI=;
 b=Qcf5VRNMyqj805g+KGkpIP+iKqMzjRzZhVhDnkvBaWfzU9fLNs/qhRRITCLKOLa8lzzMHuVhZ+BSOR02GXtTADFKg3nSFKkQ7d5PSqpWRsW5PQhfRt4M4/veC9kPt9mL8QUAOLKVva9OdUk6POgkmzKKKV4BEZEjjkYiD65iz9PoqE61XBjuc6Gmk6tA3yKRn5jD11vuArMPQGJFFHqMiLNV9X4TGmyf5xxIuS1zvlMnH++VOCjfLAc9nuJdVyQrrdJReEHwBLhzu3THxZCx3q4EUBibnNFL5P998Maph1E+bsL5Oa3tF5jUMj0rg4203z76amw+bUn1D5KbvVpRHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 09:22:06 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 09:22:06 +0000
Date: Wed, 26 Aug 2026 17:21:59 +0800
From: Richard Cheng <icheng@nvidia.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/13] Make SBR work for CXL Downstream Ports
Message-ID: <ao6tOronSmLlU17B@MWDK4CY14F>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 1766a462-c6e8-4c0f-a7ff-08df03537eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u7CjVG11Y3nneLaXDfTDkV6GgD3tfwPJH0Er3d6QGo1JInQ6Sr/++dJWFCeM0ILoYd2ZOgrYl0Hh3hIQ4Zt9fc/ki6wgbhXB+6feeK6K92S7dTkoD1N1jPixqPJwhlkSJll0ExQrGAU8NFU9I1uIVe0uiKyWQrLK5GifLZAvk2FlcPjI6gzUcPpz9nU7cZzOGgaG9pFh2TV/LWetnu64K1+JdX1SLQKBs7BT9W41imKfpWcHc0YLtP8hTkXwaglXSkdzxJkkvek5Bo3YJiShawm7qWnkuTguAeenHwOhgSk+6hJM9Yjx1uF8zz9dZpRjfheXojuJ8GMNMl3RYZHFFZXKa2ipauX1s4CRj+pO8nofhEz7g4HaGDYucD0+OuG+7gjopy3ZRjhe2rppGHK2Q95bZveaiNQuOCc8i9vnYUlDcsTUKc+TWJ0Vn9lDcslrNiNPn22lKomOUjlCLvvtgKEWbPYnqZcoLMewk9L2lbOlpqID3hq/XnTNdUf89d/bHJB/uL1t1900wkzM7Mzol/P9JT2k8SrOIfqN0qnENt1HLHvUcgQnziYrfSarehgiPZUqqYPsCpGW+EpavRGjY12Ahxk0RIgt22xhC7juAAHfFa+aXB0H5w5zOMK2NEiXQ+gMj9t35MVLJ+eo+G2tAUcbKrq2JeOTViKeMzwTofc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iE08vbf1YPVI+9ph1W47ApvGfbRmz2O1Yb9kSNyau/SYOVJT2sbjRnekEZ6r?=
 =?us-ascii?Q?RDQe8R8xG1YxfamBhKbvnWy1eHLxqw3U9ad6JyNlvSYfBYpw2PmnRcNyZRZZ?=
 =?us-ascii?Q?9USf9IV3+wu7K+V8Wa8yua7rJlqYlNgwAyQXKSGGp7BtCI8x4vUFpPgix0Gt?=
 =?us-ascii?Q?dzyRwZLiW2dFN/DN+T8TsVm5irmRY31E1kC6M5pjgy4Mew+oLfkgM4eQ+JMq?=
 =?us-ascii?Q?fIyrn41C/l9i7/7SEsdPpp6gDGPRiLt8hAwd6m79bonGOvvf/T3JNbg9I9Yc?=
 =?us-ascii?Q?gm6yL1HxcaY0/lR5CbyKV2PNrLgv53wCPiiq8xHP/Tr8ryt7yx8xGIH7crVZ?=
 =?us-ascii?Q?Ohn1evDYlm42TIk0iLu3gTxjr1WtcoM96Trfbo6XkwZMJ+Yoo5tKZ5gPApCx?=
 =?us-ascii?Q?rm9bXK/3aFkh+GfArEwr0sq1rZmtkCOeDkaG87m4Rt0wkLZlBVv+3WU57qAc?=
 =?us-ascii?Q?pcfWwz/YlN3vkUCehAtPtPU58XvbeJw0YV1GCueaJgGRuLrW/BtYmDcIW7mf?=
 =?us-ascii?Q?g4D5zkl1NhQy6IzQBS896dnFwb9Fcr5tuRxbkh7gneZwt9TYbjYGSD0iTGbX?=
 =?us-ascii?Q?yLc8RgmwyOr79PczXELksPdjF+l3P7l+aA7Tz7YFEFlHCWeeUMO5Ieft4oKa?=
 =?us-ascii?Q?d3wrxoNkYQ4cZDG3dVYKzIDiLmg+6YJgqBnTa5PHmO2ONYvZJDYTJI/mmobY?=
 =?us-ascii?Q?r7Ao4UZwYF4YK1Rpuv/YvF1DFSPhBZ9Q+HHnq5mzGmgmV/u+pDytkDyIHQwU?=
 =?us-ascii?Q?XPIa4W5OFy4/t5XPsqg3Fvr/TPuMMtQvMfLnoxvJs5eEvlDB/CfEBPzqS7CA?=
 =?us-ascii?Q?wEXeSiePRJTzYaN23pFdX8PSD6/H5C0AulFFJWJkiO2PVd9SLNfmnxJaZLvs?=
 =?us-ascii?Q?weq7wiEYp0VY26bMJZsrklFjo0tmHYbr/LM48nEcBRCyOVmuOxec4Ra14DRG?=
 =?us-ascii?Q?DWy2CB/tbK8hXvb9dNlw9mxV/LIt5WTihN1n4g1mtQRuCQ3xFrOeBWXJuCuU?=
 =?us-ascii?Q?XpPdQYsmrAhVXZ/JOzGdpkuNJkRiyJKbmIhcNKS/2xUphEJCo3OK39hIT+FO?=
 =?us-ascii?Q?iSlxn7wg0Wy4bMv58ls4zTeVbXCbmw23yM4HR2Tk/7ylkFsTrWXY3T7jxPGN?=
 =?us-ascii?Q?eqtShS/noOXabwtErPA/1OR/PZuXP3dwsh+ZtlIsV88+nUglXiXN/JnSf5tE?=
 =?us-ascii?Q?1jdI3bTTf5BDJvjDSmgEiosTUd3eLTL/nt5ruPhneS2aX3MPWNCcbPXhKxd2?=
 =?us-ascii?Q?nAad7Q5SQR8MXBiE3Bj7n8ON4+KzUs/WIgg+YSiQ5VQ100xcIEeuG7MBXwqd?=
 =?us-ascii?Q?4ORhJSWbNEefZg2JqeIDMTcA5VhJLpG0DlhoH5C9Iz/OWSJWLrtUhi8aMSCT?=
 =?us-ascii?Q?0qFS6tkUPXYHY/LN5ndxGomQSjSUxsx4eS4108YbAng2b7sRIZ1e06yK4g2j?=
 =?us-ascii?Q?2zJvwuT/CJtazL0EqgrTRaD8qdslORouEhc0BQA0D/lx9HoXIg6tYMOTTCi8?=
 =?us-ascii?Q?g7epZjfn9hNtN8G5weef0d1lC94Pkq0xi8u9uD9//hqZp49pBDF8imza8L8U?=
 =?us-ascii?Q?DURaTA4IAp2/dFWn8XkocacBokUZY9X+BgFw7TERSHNbq+WEijuKtity8qZF?=
 =?us-ascii?Q?ZTbFFX0JVMCX17Y/1OKe+T2ub+xZkW99H2gwC0HjJE4p16gzCQGTxUGkTa4T?=
 =?us-ascii?Q?zw6Q/yzdYtyVzt9mYXEhOsMWs5ZTT1iExKnnF0wvFLBdwmRYL4Mo2RnUZhQW?=
 =?us-ascii?Q?Y2iEyZe4zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1766a462-c6e8-4c0f-a7ff-08df03537eef
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 09:22:05.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIQOZt6KzaAL3zesnaIj/HaqQz74OznzAkburBfxqOIfx5ke/8aMo+CA7Q8GKWOtVMO4wqU11zGZUMlWnMoQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

On Tue, Aug 25, 2026 at 04:26:15AM +0800, Fabio M. De Francesco wrote:
> A Secondary Bus Reset (SBR), a Link Down or a Downstream Port
> Containment (DPC) event on a CXL Downstream Port clears the Downstream
> Component's captured Bus Number. CXL r4.0 sec 8.1.5.1 notes that, if the
> Component then sources its Power Management (PM) Initialization traffic
> with Requester Bus = 0, a Port with Access Control Services (ACS) Source
> Validation (SV) enabled may reject the Component's CREDIT_RTN IP2PM
> message, PM Initialization may fail to complete, and that "another
> Secondary Bus Reset alone will not facilitate recovery". PCIe r7.0 sec
> 6.12.1.1 makes the rejection an error that is reported as ACS Violation.
> 
> The Implementation Note under sec 8.1.5.1 gives the sequence that avoids
> it: save and clear Bus Master Enable and ACS SV, generate the SBR, wait
> for Port PM Initialization Complete, restore both bits, continue device
> re-initialization. This series takes a step further to a preventive
> measure that avoids the ACS Violation in the first place, not after
> failure.
> 
> Patches 1-5 restore HDM Decoder registers below a reset CXL Downstream
> Port.
> 
> Patches 6-8 disable and re-enable the CXL Regions around the reset:
> offline memory, invalidate CPU caches for its range, collect the set of
> regions the CXL DPort which is SBR andunbind the driver.
> 
> Patch 9 disable and re-enable CXL regions across a Downstream Port reset
> and registers the CXL region callbacks for a Downstream Port bus. We
> want the reset to be called only when the CXL driver is loaded.
> 
> Patch 10 calls the CXL operations from pci_bridge_secondary_bus_reset().
> 
> Patch 11 issues the same sequence from dpc_reset_link().
> 
> Patches 12 and 13 gives root a sysfs attribute that conrols whether the
> SBR is allowed to be unmasked and prevents kernel from unmasking SBR on
> its own.
> 
> What user space finds after an SBR of a CXL Downstream Port: the dax
> device returns under the same name, the region's HPA range, interleave
> geometry and decoder programming are restored, and the media content is
> unchanged for PMEM. System RAM comes back registered but offline.
>

Hi Fabio,

I think overall the recovery sequence makes sense, but I have some concerns
about how the state of one reset is represented.

In your current design, if I'm not misunderstanding, the state of one reset is split
across several places:

- PCI keeps ACS, BME, and Port Control in its local cxl_sbr_ctx
- CXL keeps HDM state in a global xarray keyed by the Downstream Port
- disable_regions() collects a region set, operates on it, and then discards it
- enable_regions() collects the region set again after the reset

There's no single owner that remembers exactly which regions and memory blocks were
changed by the corresponded reset. The set collected after the reset should be the
same set that was disabled, but I don't get where does this guaranteed ?
Collection or decoder restoration may fail, but enable_regions() can't report failure
and may still reattach regions.

IMHO, maybe have an opaque per-reset context, something like

"""
prepare(dport, mode) -> context
reset
restore(context)
"""

The context should hold
- Ref to the exact affected reegions, ports, EP
- The original bound state of each region
- The original online type of each memory block changed by preparation
- Cached HDM Global Control and decoder state
- The current phase and which preparation steps completed

I think PCI core doesn't need to know the contents of this context, it only pass it
to CXL core. This can allow the recovery path to dinstinguish 3 outcomes
- Preparation failed before SBR
- SBR and restoration succeeded
- SBR was issued but restoration failed

This can also avoid the need to recollect topology after reset or store operation state
in a global xarray.
Separate resets would naturally have separate state.

Does this model fit the indended flow ?

Best regards,
Richard Cheng.

 
> Fabio M. De Francesco (13):
>   cxl/pci: Make the HDM and Mem_Enable writes callable from cxl_core
>   cxl/hdm: Add cxl_decoder_recommit() to restore one HDM decoder
>   cxl/hdm: Add cxl_endpoint_enable_hdm_decode() to restore CXL.mem
>     decode
>   cxl/hdm: Reprogram the HDM Decoders below a CXL Port
>   cxl/core: Restore the HDM decoders below a reset Downstream Port
>   drivers/base/memory: Add cxl_offline_memory() to offline a physical
>     range
>   cxl/core: Add region disable and enable for a Downstream Port reset
>   cxl/core: Collect the CXL regions routed through a Downstream Port
>   PCI/CXL: Register CXL region callbacks for a Downstream Port bus reset
>   PCI/CXL: Clear ACS SV across an SBR of a CXL Downstream Port
>   PCI/DPC: Issue the CXL recovery SBR from DPC without offlining memory
>   PCI/CXL: Add cxl_unmask_sbr to permit an SBR of a CXL Downstream Port
>   PCI/CXL: Refuse an SBR of a CXL Downstream Port without the unmask
>     consent
> 
>  Documentation/ABI/testing/sysfs-bus-pci |  16 +
>  drivers/base/memory.c                   |  36 +++
>  drivers/cxl/core/Makefile               |   2 +-
>  drivers/cxl/core/core.h                 |  28 ++
>  drivers/cxl/core/dport_sbr.c            | 374 ++++++++++++++++++++++++
>  drivers/cxl/core/hdm.c                  | 341 +++++++++++++++++++++
>  drivers/cxl/core/pci.c                  |  19 +-
>  drivers/cxl/core/port.c                 |   4 +-
>  drivers/cxl/core/ras.c                  |  10 +
>  drivers/cxl/core/region.c               |   6 +-
>  drivers/pci/pci-sysfs.c                 |  31 ++
>  drivers/pci/pci.c                       | 254 +++++++++++++++-
>  drivers/pci/pci.h                       |  15 +
>  drivers/pci/pcie/dpc.c                  |  46 ++-
>  include/linux/aer.h                     |   9 +
>  include/linux/memory.h                  |   5 +
>  include/linux/pci.h                     |  16 +
>  include/uapi/linux/pci_regs.h           |   2 +
>  tools/testing/cxl/Kbuild                |   2 +-
>  19 files changed, 1193 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/cxl/core/dport_sbr.c
> 
> -- 
> 2.55.0
> 
> 

