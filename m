Return-Path: <linuxppc-dev+bounces-28628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309EFCA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 06:53:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwN0G3x4Yz2yYf;
	Thu, 01 Oct 2026 16:53:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790813460;
	cv=pass; b=DMtDK8TbcT2rrTUceOO+ZFd4jJLiZafNvvwOHYxjlQSEDx8gnyRP8F5Vc41DZ16e7PT1HSFwXFSQifG4E9ZDOJWINh8AhiQAbIOL4Dp9Sq9vQpLyyTRESr4xtTFt/qLhUJJgs5IzG7Wj/4YbCWP3aSW3+Sp98+nXR1SfO/3uOr9o4hQYvF+RMjMsxPI0XIUi089Knupfz+ReRaUwdEyKMno9QbqrotX/b0UJ2+tuZ94vaBsCEMcSTadv13c8CTlKzbhFTZERna8LXfueZ6QULUZ8Co2WQUrUdXKkXSgWVh3cIF39tehjOI79n/ak2AuuKD9oAflbF/zG67m1e0pppw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790813460; c=relaxed/relaxed;
	bh=N7a/bp/PO0bjhrDKIhcMe6L/5zm7OEtYBvJsXXJTZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWlo7xT92C20m8qfjZEHgEk0vM2OZxgxy8C5oM/Q4qh5pc3dP5kSWNGi1JkU+A1YW6I6aDNpKBgpkGEkN3V1qRXoziJxWH1SjEouoK/B+yfRYJZR2GVYiwrNmf1ASqLp7va97qjDoxsEDvM1/GDd0sOnTv0S7ElFoeo9ilEv0f8xCheon+JdB2E1rycTPxkMLxwSzuHwSsiLiptBRLYq+X4tfBVifx+Zcvv+btd1MPeQ0kNpSOeQA3EYKzlq/oWOi7RmmJdEuB1c8Vvn/6qLgM4EJuJfoLf115R88iGSGPCLx+UAf6fmKhAWS8BLvX+tAGTX9x0C3qQdqG7Cu7ov/A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=P1/BRXIm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=anthony.pighin@nokia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nokia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=P1/BRXIm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nokia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=anthony.pighin@nokia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwC4L1DJtz2y2Z
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 10:10:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El6qXVv4yaCmXQUl+NK5F1rRvLWi7lwMLdVbGa06/fvnzk5kzEEWlV3DlY7JV5EHvImUcaEq3UeVKb8yM96EDzVpVrf9PeeFZUBCplxBS6akQrXkbRQFq8JET8c2XIQSiJuoJ1q0c1UKATU1vXHq3qUX9p6pVurJg91ZBQ3j40KENwMjwUncjcZScZATTdw6GZJ9Be9JBS0CCt/aNoShahhSUAdyKc13ESmZkYhWFfpk/cJEAxiOFkww/0DCUDXI7vpFQ8j0RmoPRkivQCZwT+yYYryjP/ThUdeIB3swEpV6Pxq0Isj0CHblZaH0E0fqz6mrFgRDIVd9WNN+gHzaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7a/bp/PO0bjhrDKIhcMe6L/5zm7OEtYBvJsXXJTZDE=;
 b=Pz1bu6WQcxGhLHZfFhAhz04ccYG2oajX98Fgy4R+Xsvs/HS4RJsNGQSepC/97RSwjqeA/tLoI87EWxa3iUWmlXBFWKBEukHGFsscVApsHiXZLORbstG2s8R4JN2A2QYbVbZPNpoN3hzHB27mL69Aem44PIvjoXXAbnN0EJwocgNaNbm4oufrpcC5OEDYDIzC62fvnbIUsqf0OwXbSOvlobfVYcvW7AC5tgjUZIFjySpDwMo+tQDuMQ3g48kH4mJLilJzk+roJpeOGkB2sxhj0jsgpo44aBroTlsd+VnH/s8+O4S8CADpf5PjXjuWyy6pg/XJY8hQWBxjEAcE7XAlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7a/bp/PO0bjhrDKIhcMe6L/5zm7OEtYBvJsXXJTZDE=;
 b=P1/BRXImThrpdrP14CtcU8NtrjqnNOQCTSSGKzUwoY3rMyW3fDbQCXwob7RyoPgDFTlx+GUvHYY+7AgzJLLSCV4vhY+xS84Yc4PhBw87ZjXa+g2g3jQKHleXU2lrRYqX0TEoXZOYUbATGM8YS8koqy/UegIASiAMxOemBn9XxmErqaKbg+mb/AIPzQ2i72/EpYwiUX2ICPtYWsp6MO8oD1eEFyA3JF1WJr1LH4EUvuPbD71HYxZ2fiKsicPG1QFKCavg9x0edR4tF5sze9A3Z3HbYaSEQxvI4X8RsrTQY+2Db1wJE0S1xtLV93AlStlo6YfQJG8coXVwR0h/VmPE6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by LY0PR08MB296823.namprd08.prod.outlook.com (2603:10b6:404:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 00:10:33 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 00:10:33 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: Jaidev Shastri <jaidevshastri@vt.edu>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: dpio: publish the dpaa2_io object only after it is initialised
Date: Wed, 30 Sep 2026 20:08:45 -0400
Message-ID: <20261001000845.3627423-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921-mb-dpio-v1-1-9e24539059c1@vt.edu>
References: <20260921-mb-dpio-v1-1-9e24539059c1@vt.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:610:5a::22) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
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
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|LY0PR08MB296823:EE_
X-MS-Office365-Filtering-Correlation-Id: 331335be-d2d8-442e-81ee-08df1f50696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NZBYf3jqe4JKpG9rsmQJRGrkhksv7w/Hj/jB8N4JMrAxjBFjxXOT2cPIq1oBSCgcJLduxV8McXWlEw8iJdEbahDkluZyFrTitbxtKGRGxYWVVb9nWJJGbCmlCeQGXgr4lWMf4hjx6vnocMkNt1LZRMzCxfEQ2Vf8nMRMpw1a/uG8e7+ruHHOe49tKz5D5u2JjixAmtDDK+3ofaFh/eNydaB3Q2mf9h8CsKfWaR5oLCVJdkgByISu6pCqzVGrCmPcuz1cowDtbssFFzOX5I9OlJ8TWQ+zUk4YI/Aide1289ShqmNZt0l5suB40YPAhX027Yjh+WF6SfecdYFNT0mBbYvG5gUwwImEMnKzK+P4PZxA3yHjn/MYfVBgjaCsaSu5kbyNS2PCFTcY9pMX9oyam766x27nhokQBJ4goiUr4+z8Q//Z42BEk+bCwNTOSeXsWsAYtwn/ie+oA55Vg13vPczJkULurTesSyXOOapx9U+D6EB5pyLQ7/w7z+M8NAcu9VtGL99t6CpCrcRgFieQ3bnIepMEhcGCRzCTQ50o+Aefcxlss0ifQzevcpKWHOu1Fe8Af76IFd52BsnWW1xrruIMlbje1U0bTF63TmfSI83l9IWr4th7kTHzhaiQqLBBDsJUWaThlEPyOCrs/UXsggFYAal4eHWHc3mKhwUZddk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEpSaHNCSUJBUVc4dC9jdUtzbTJOZVZXYmVZUzVVUzBYaHdJSDhJc3VsVWIw?=
 =?utf-8?B?bHdiTnpoalBmQkhqcHV5LzQ4akhZcGJnd0VBYUhKSjJYNFJNSkc0MVR0Y3FS?=
 =?utf-8?B?bFVIUmRCNGFwZXpMVktSRVQ1ZUdHSGZGbU9ZSCt3TjhtcEE2R3ZEM3p4RzZM?=
 =?utf-8?B?azM2QmY5eXRYb01kK0VzYzh1RlVzMDdZSGlJTnh5V0dveWo5ZE1aUjdYdG01?=
 =?utf-8?B?VjJKWnVEbGtKLzFNU0FmOG9WcFFSNlBQYW1LOEpxNDg5TjdUaFQzdVFJK3JM?=
 =?utf-8?B?c3dxeU5DakplWjRCWHNHV1ZkZzhNV3ZWeHF4R2ptTjNkdW9lZGtNcVVtaEVP?=
 =?utf-8?B?SWh3QkRKUzlzZDRjdHVFeEplMXlHQUJjdzlBemZuQWUydk4rcmVkenVPU0tD?=
 =?utf-8?B?V3E2VWxtemtyUERhQy9HVDI1NHRlb0lkNXBzVVR5emVFcTlLcmtUWVhhU1Rl?=
 =?utf-8?B?cEx6NjJkd0JEZkthMEtma1ZqaUxUaEU5NlVZUmR3dU1TYU5ybTVGaEI2d1VQ?=
 =?utf-8?B?ZVY1TW5pTDd4OEIvaHZ4ZmViTU42NXFWUWhhQWZPMXdVV0gwSG9GdElEczBU?=
 =?utf-8?B?eWV1ZDNpb3FoVE1uWmRocFFmOENBU2htcFBQTE9nTGRZRmR2YytYbWQ4REdD?=
 =?utf-8?B?RXRlbXRDQ3pnbXFGTUs5TzBRbjRmVmdVTHVLRUNSWXY1akx5UEhhU1lrdlkx?=
 =?utf-8?B?QittN3JWYlp2eU8zRHh0M0pJWFcrR0FFRExKa3hZcXJneGgva1pKN2tqMUZ5?=
 =?utf-8?B?dDBFUWZDOEROOHdQNytFSDNPdk94UnpzWGRjRncwSzlxSkZmbWJvUGFoSGdi?=
 =?utf-8?B?RkpDQzRqNDFzMGtjVVJPeWY3VUJtakVMOHJCdTRWbmRwS0QraDYvZVFDTjJX?=
 =?utf-8?B?NTcxK3A3a3k1TUpESnRnbzNUV0hYK0t0U21SNzQ4VzdCSk9DVEJ1RHVDR0E0?=
 =?utf-8?B?RS9KRVlVcU15QWtuYXgvdnlxUzNLTjdXWUFOalRBcjllZU1rckxXcU50R0t6?=
 =?utf-8?B?RVFYSzRwQlJZa014VkxHQ3MrVUMxakZZOFVabUdtakRKYjJDcG15djFaRlhu?=
 =?utf-8?B?K3FWVzlKK3Frc2UvMEdreG13eEk1L3FRTTNhZDVpWStqQ1BlcE9WZzUzVzBh?=
 =?utf-8?B?VkJISXU3SlZVakFicEJ0ZHZ5RXp5MkNpUUF4T3RsaWpzTmxVTWJHOUZSNFo4?=
 =?utf-8?B?c3dEME5nOEVhSXJrUVJmd2lEVXVrQWh3ZElUbkhtckhKYkVubnJKeDdWemU3?=
 =?utf-8?B?V3hjdW9rS3FjL0dwbFNCNUpsMTR5MStaZDZjMnVwbEVxejNIUDE3dDZNUjJ2?=
 =?utf-8?B?V3ZnTnNPbG1EU01YejFWR3RtRjV0Tmd0azRPQjYxb051NmRJYzM0dUVaL1Ru?=
 =?utf-8?B?Y3JHTnB3endEWUFwZDFsaGszSE5CQTE4V21BL2lWOVBsNnNCNU1DU1phMHkx?=
 =?utf-8?B?bHdtZGNOVS9lcEV2OHVIZTh1MURobUxTTHBTS1RhdzlPNTYyNkJDTW4wek5s?=
 =?utf-8?B?MDh3YU4wYm15VW81MDRqN25BZnZvZmtCRDdhMHF6OE9QL3k5Mkg4MndWeUJG?=
 =?utf-8?B?ZEtqczd2R1J3UXNhRXRBUkE2V1NEaDMwUWZXWWN3eE1BYkJERFN3T25OdDZr?=
 =?utf-8?B?MnJtcDJjK1kyR1BMY2toZjBqL2ZxbmxDRzJ3OEgrSTkrbDJmMnNlTWVEUVpN?=
 =?utf-8?B?OVZCckxNRlRCaUkrQ1p1QjY5akNJblRaeWxVS3F1R0Ntd3BEYmZRWlR0WnRX?=
 =?utf-8?B?Z3FUUERaZUVmajVOczVJUWdNYXU4c2RFQWlPVG0zdlBad2loVmdKUWNVSW94?=
 =?utf-8?B?d25lZlNWbVlxZnY1LzdzSjdPRWJLMlRlZTFVcGYxYkd6RldkL0lkQ2EwUlhy?=
 =?utf-8?B?bkh1SkZxbGNYU0RNWHkxZDQvV28zWFhRTVpFaVk2c2JiMEpCVUtIYnIrRk4x?=
 =?utf-8?B?RkwvS0xRODZGYUtBbFhxc2UxbDJnSkRkRzl3ZWV6eENINEdGZlVGSGg2WXRF?=
 =?utf-8?B?UzRsYTVLUGdHNHBwbkdJWVk1cWVSNkZ3S3dDeks0Q21zVUtDOUhiV3JQMzNH?=
 =?utf-8?B?T2hDay9Lc0J6Yzh6bXZVM0NvZGRVQ3d3QldER1h0eTBpU1hlNFBDb3BEVWdD?=
 =?utf-8?B?RHpMMXJsc3c4QkttdW1WV2JRcGY2NHA2RUQ3bEpmVVpLRVdjOHN2VnJsUnln?=
 =?utf-8?B?U3JsOHl1MnZKdFkySUh2VHIvdG8zb09HSUxOUVZxbCtyRURQZEV0OEpBcmpQ?=
 =?utf-8?B?Q0hEa2o5ZWErV0dZRXMvQjNmMFJjNTdrUlU1M3R1QXdVcTZZRmFWcGN0V1ps?=
 =?utf-8?B?bDFidFpsb2d0TzhkTERNUXozY01sYk9pZzBhMExOZHkwdVpJQnUxQT09?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331335be-d2d8-442e-81ee-08df1f50696f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 00:10:33.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/gUmwuE1V2rk2AS63/l3wG9UIyWgQArZL1cj8D2UvNm6WD2B9+Vf6Rdih25rT/EUVB4gYLWqDpTWuoLahv9YaBM52uFXaqN/GYeu2Fis/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR08MB296823

On Mon, Sep 22, 2026, Jaidev Shastri wrote:
> obj->dev is assigned after the lock is dropped, so a reader can pick the
> object up and pass a NULL supplier to device_link_add(), which fails
> with -EINVAL and fails the consumer's probe.

The object comes from kmalloc(), so obj->dev is not NULL but whatever
was left in that memory. We hit this on LX2160A boards as an
intermittent boot panic, with the deferred dpaa2-eth probe racing the
DPIO probes.

  Unable to handle kernel paging request at virtual address deadbeefdeadbfd7
  pc : device_link_add+0x80/0x700
  x20: deadbeefdeadbeef
  Call trace:
   device_link_add+0x80/0x700
   dpaa2_io_service_register+0x40/0x120 [fsl_mc_dpio]
   dpaa2_eth_setup_dpio+0x128/0x468 [fsl_dpaa2_eth]
   dpaa2_eth_probe+0x1dc/0x908 [fsl_dpaa2_eth]

Widening the window with an msleep(50) after the spin_unlock() makes it
panic on every boot. With this patch applied to 6.12 and the same
msleep(50) kept after the spin_unlock(), five boots in a row were clean.

Since this crashes real systems, could v2 say so in the commit message
and carry these tags so it reaches the stable kernels?

Fixes: cf9ff75d15a9 ("soc: fsl: dpio: store a backpointer to the device backing the dpaa2_io")
Fixes: 69651bd8d303 ("soc: fsl: dpio: add Net DIM integration")
Cc: stable@vger.kernel.org

Tested-by: Anthony Pighin <anthony.pighin@nokia.com>

