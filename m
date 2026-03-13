Return-Path: <linuxppc-dev+bounces-18184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44846107BCE6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 23:23:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXgWk4wYsz3cHH;
	Sat, 14 Mar 2026 10:22:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773416241;
	cv=pass; b=Tqrlvg8sVUii60AqGD1IUnv3S8IgBIfru28xSkuiRLZaC6dqJbbTRcJ0xeePZ0ywUJZp+doLsSnsbaZZM6dsrqo1k2hGF09AhE6+9Wy6ldHOwa5WpuhUErGnBmV9O+yThqQpj6At6azd7qmvXX6F6poL6/tNxP2af1em0tjQYp0vXMxFN3KdPKjl7+qugW6I9egF/gDyt9DignRDs+NPpcYYFY8JQU1wBe5HNuqk7+aABq/PokK/oaEVVxFRH6sGCwX73IeERdaefuk7j2RvUG1Un7d2EkxF6lmkFzw7Wc7ikd5BMMZScPzazkpwn31CjrP4L//7AM/B6AP7FiNGjQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773416241; c=relaxed/relaxed;
	bh=SnCtm0yzjBseWVLNICpKiuO4CjGyHKEWrxJhQw43Ny8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NEFvAyzWqtjy70w3F91b3Oe3NqlT3U0M/MK7n21UHvyrpwrquO0hvqRwHAR9btcKz5o7kNTWatmC7BGRcRxiq54bMmEfDPugRBvL0l0NQF04EVZnQwh6+EiGMUF3v1/4aRHlAs/0v6vIix7OStkVMIcWPwf04eaCWN2B9W/X2CtgtLoZzMSZq9bGh+3FcxaRHyIZmFptO9Pl/DMxCAIKjr1cqvA8U474Ltp/uzCUq/vn3lB4viX+72JSyZPH+R2Rz8SoctjJogzo4U+tiFNuXLeuzIEDCImThJ+hPADajDM7VI9U1cDxaC/J6FJImHA8r7y/kFwgw63tSkFN1baP8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yavLp5nC; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=jason.andryuk@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yavLp5nC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=jason.andryuk@amd.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXTBR58Wzz30Sv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 02:37:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDKVeuAfwihw/uOaeZtvDlB56BoFnf9jRI4HnSFbsjEJ24WCKaiSM0CenB6hQWxagCknqR/ywDN7rxY10gW505yUOyOZXmYCvUGedZlfGHmrGUbHinJRYbBuVS0mO753tgJxXDEwuSWUnwmdFIZO0VQVf5ffod2QoJHNTMRnAZvYXYaBXxRHjYxmPkPWy+1cvdinkcz2ql+5vVqZG56DwfNJzBzFCr7i8rqFx5EH4fOjIhdIYV5tWrC7fZwPTCS50nyE4uTFu3iNyhZ3KX1pxCuoVhyQO3dXoAUU623aQFD5R6Z5LpfiA9oaj+6dG556+Xbzp2HLNQ6qGnsjOf3qRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnCtm0yzjBseWVLNICpKiuO4CjGyHKEWrxJhQw43Ny8=;
 b=SfETW9KLZVqwM88S9MHc5mxFZrAt96KrGEWT7p2uvoBO+4wXzyZPkxbAivGObRkNXIIH86RuFcmR1HBw9dCUsTUky1D2qLA1695BACSHwK50kNNRKQX48d+Rc0NCMbtW+RsBO2ZE4koZH3yctg7ypwhVJ7yPgYjKStup/JM5EZY7g0I7JrIKthJe9uT6rQsCzk3uTssfnGcFQ9+a9NQ8t1rAGvnIWX9d2/Uuea84d+PHG4n1V7mTabV/b2A9BymcCGCO4QkR/Z/A+1sywPnXliiY99ADwMZtm9jwo0AKFn7Va9dpTPGdRcEgCRz+GAn4v3jFk7gXcLdjujx87/s/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=citrix.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnCtm0yzjBseWVLNICpKiuO4CjGyHKEWrxJhQw43Ny8=;
 b=yavLp5nCpL3xoYcIO2FScReEPua3wDvn+EstUmba8hM22KYHN5ZtX3+1plQOwc/l5R2qsccxsFjzlNNZoEcYkVEechbcko9LM8j9OOJjlLE0CvbPB/HTDoYg+lPnORRYhr/qgQBPntCfRi7v5QHwm/DRRjm+iUQEE9etSA0NDw4=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 15:36:52 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::bd) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 15:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 15:36:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 10:36:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 08:36:50 -0700
Received: from [172.31.96.139] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 13 Mar 2026 10:36:49 -0500
Message-ID: <0552a259-16ee-4b87-834f-def9cadaca1b@amd.com>
Date: Fri, 13 Mar 2026 11:36:49 -0400
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvc/xen: Check console connection flag
To: Andrew Cooper <andrew.cooper3@citrix.com>, Jiri Slaby
	<jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <xen-devel@lists.xenproject.org>
References: <20260312173845.47235-1-jason.andryuk@amd.com>
 <8e5974b1-da6d-4718-9140-1f943cdd2404@kernel.org>
 <ff1cce61-abb4-463d-adce-0e5fc0a326df@citrix.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <ff1cce61-abb4-463d-adce-0e5fc0a326df@citrix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fca0ed-e9b1-4812-9aa0-08de81165936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	79occZ3Y9ko3ZJ8eeFxzhz73g+Q/h0JrJ10HQCkC+FJIBve88L72RnZ3J2BXPxIDuqmhnefDDpbyepszyI7ubqj9B0LazhfcX7buwaYrFmvAy2Tx0F1RTdfcA4DTvrkUdabuDX4m74OJkgzKd8k39G6wZxSCNzJU5x5/ZUkZxXPLnqZlHv9Yi6Nhz18PW3SiOsuUpz1KhKp33hyiQKiPAYkqJNyUc/MdHkclM0OajfJkpc1FCG4PZi7FdiuCNdGLDO/TTDmzEtJPlmUfyjI/2X+WFybURmCVT1+Bl15aaQMbwhQ7ka3gnzWqjP5WkBqMNzOBpRUHSS2DFkV6lK9AwcZYnwq70r/OrE83cA1KZqK0PCAxaGfG/Ia1AZTHCICrIdIjyb0dGgbgvpf0h90o19IEsYYgINcQPq9tyD94IF7q/v9Zj3u6K0+V7gSUeWHRDNXFvU02YQXpr/UnT/QRf2dIpglmWghGKsnf37Nh8UlsnitrBPcncGG70b5bLCVQfiyxrBqwjx91f1fsm392FyShTWcKEChmw/jnny3sNoEteOvpn0kcH5wgYxw3/r8uZbSElwQTaCHhFJijxw/wYyIjpkGv1ztYfi+VcJDaNEGGXf9f3IJB+4ac618ZXoN2e/l1wHMTVxaVMdD7BHRs5PgK7X5jG20oYAvNJxnd0Qld+TyQWWcHXrdVDgIzD0K3RZFKSFU9oV0vjG7M/aaVhZhLk0SyVRE3ND1Whmjbg8ILvccJr+2tl4FZnvjp6SiZfRHf3YArBugF/MgjBldXmA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cStaS04QRskcp2qCnjBqvqiQxCvNWJpfc650XJqlTRqrMpDTt0KBWlI2Fjq6YtdNqNkZqhQLilKP2Ge8AhYQ3qGlHuLOlm0WytxXMPlbT/a7PDC/sZLU48jukTtFfe8tzJSJOyTquxTwS9UBBlhxH3xVtrpcEgKt7g/Kj/HqEPZoit3UZiq53jphXcboSzMD7RZ8fpLnj4JMSbS4k0FHJQMnRKArSUCPbBO6hF/beX9uN/+lMu2tKFd+2/QMLWkPRxroy2ysm/2azLZDPWqINvBVN8b8mLbCRHS1pZzLXLANPQKDcrMWA2rtPi3o6UD5PrVJfoclutT3Mxb0ewcbRXSbye2vYsliT1BkhtgQ3L/wJHzEDxWCHHKH6fN5ZZwZ9ssb/Rorj54p8Xgo0QgPhhXI3Tezlzc024qyIcTMjj+AyB5Sw5U2hB2VyD0djCya
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 15:36:51.8471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fca0ed-e9b1-4812-9aa0-08de81165936
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718

On 2026-03-13 06:44, Andrew Cooper wrote:
> On 13/03/2026 8:33 am, Jiri Slaby wrote:
>> On 12. 03. 26, 18:38, Jason Andryuk wrote:
>>> --- a/include/xen/interface/io/console.h
>>> +++ b/include/xen/interface/io/console.h
>>> @@ -19,6 +19,19 @@ struct xencons_interface {
>>>        char out[2048];
>>>        XENCONS_RING_IDX in_cons, in_prod;
>>>        XENCONS_RING_IDX out_cons, out_prod;
>>> +/*
>>> + * Flag values signaling from backend to frontend whether the
>>> console is
>>> + * connected.  i.e. Whether it will be serviced and emptied.
>>> + *
>>> + * The flag starts as disconnected.
>>> + */
>>> +#define XENCONSOLE_DISCONNECTED 1
>>> +/*
>>> + * The flag is set to connected when the backend connects and the
>>> console
>>> + * will be serviced.
>>> + */
>>> +#define XENCONSOLE_CONNECTED    0
>>
>> This all should be an enum. And you can document it using kernel-doc
>> properly then.
>>
>>> +    uint8_t connection;
>>
>> And type check as well.
> 
> This is a non-Linux header file being re-sync'd with it's original source.
> 
> It describes an ABI between VMs, where things like enum are forbidden.

Yes, it is as Andrew wrote.  I included "Update the console.h header to 
bring in the new field." in the commit message to try in indicate that. 
"Sync console.h from the xen repo to bring in the new field." would 
better explain its origin.

I only brought in the needed part.  There is an emacs variable block 
that is not synced for other headers.  There is also an ifdef block for
XEN_WANT_FLEX_CONSOLE_RING that isn't used by linux, which I did not sync.

Thanks,
Jason

