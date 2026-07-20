Return-Path: <linuxppc-dev+bounces-24538-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A0AC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:37:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sl22z4dz2yLY;
	Tue, 21 Jul 2026 06:37:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784579838;
	cv=pass; b=TNd4bukUSaEITDpt2B7IPOVXfbpOM0cA3pscgQDFpiBj4xnVau6D3GHcOvGg1cM0uEIjHD02qLcelaEgabaGcKdDUaX1P28JIpBpO3d6rylF8VnDo9vMnIdJAxoyoZWULTgWD4czYgyyWuGH8SdLcz2ph7Ty0Nr780QAnb2XzOFdw4vSL7JqhNWXo3bLs7g9NwGzAMWZZM2f0PHBQqR1oPCrr7wejnDUOUaPNN3AZueuRG5iClI/VaEz6EwY3CcmjvkJuBjOnUIhGJH+A5bqP0iqBB2Wm78pa2iD3j3beQzmyo6pNdODAPamwJ/Zj+/GNcvBqp9F8FhMQs0KadeOGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784579838; c=relaxed/relaxed;
	bh=VV9jv4KN2UC7juYDomNeD2eX8sNdqXOKJszrQBMikRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PDOPUMcHWGOodqkLjYoHnylBw/uqmSPMsrshISjQeg7zMYB/XZce70HVnv/zJQy1bJz/2GWV53Rh2eHMucR8xyiyqasRh6qutdK1vAG2OLbRsWvr5wXlY7lMifLl0vjLYkMbU+iAg3UWMsnFOSeAkXI06HL53qeEHlxoh4+sptrQN5oK0vhAYu23aR7lq1FAGMAbniCaaRrusFqWj06x9oFDs5XbnpaSpBPHa/t8Ns9dFMQaq80AxtXN+98mFnUYB2z1t2UuJSY5H+oVY7gZRsIAJM3DX6KzHIpRUFkUpeav7xjmJPiuggUAGhCg3ZZHsEeSJE2Sk7s1HGKry1zK3Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UjpFZNzQ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UjpFZNzQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c111::9; helo=dm5pr21cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazlp170110009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sl04nrCz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:37:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJOGKU26PSsJolTOoxgxCo+JBWzhyPHdJT3Fh1SdywXWpnjZfqIl1S6lMGfrK8MQwBSiTHP5+d0BGYEcCfGHr1G3YY2N1j01szxR6nC998aOcjBaL1DOZ656JHHUBojLs59l5SCxZ5wziEpak/O52NPKNUjDfFBFwkURzytXqsiVOXOsknZgtcwBcD1DVol03ul0PBZEjwyuyPH9q6DY3IXnJDDfHWfuXR1lLhUnMNGaU2B5pcfs3RTdTJ/Nyv1R8R+Fslycbnu/mspaOZOn71sH3KSGKlLQv78ae9jeaeZMBVjGrdhNM6QraBSzFXOh9/2Gu/wDfWq6ADcMGri4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VV9jv4KN2UC7juYDomNeD2eX8sNdqXOKJszrQBMikRU=;
 b=hJ7lfQ/UJB9Aldz1DoElXnxE3r0VvLSp53IOSx5XUpMlnM2Af1LwoMt27YfPM1SFq3ewLl/8fD87NMmZ2CRwDVCQXZwMU0x0/y7FXPzepzBxV4sN50Z4zAqeElevxfRYTjGJpMwfQjCKBBrqO8MtaRGQRuYN/28vPn3QqdbHoxiUT59O+Gfk/qmdau8Syg8HAs0ImDbKudxyEdERAa4pyOeb+TipYiFNCx4jphJs37U+E+W/hLb0JIqZgIDbCEpvdEyruUIdQGwRk0L2+Hv/xwWzyQL4et7ptTEB57m/YI1JU+AKYrTJG5d+AKoG/OMqjRLC08Nij8bltF5dl6XIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VV9jv4KN2UC7juYDomNeD2eX8sNdqXOKJszrQBMikRU=;
 b=UjpFZNzQaa29tV9nqxjfHGRhZT8JUZwQ9pW1J36KtDeZsKUkfqlFkUUaMZRrwVqfwHXf85N+Gg/8j8xNt7V/6inmQdci9XwJszK+lG8iXEXQ6CcpmpsgI6mQBh5ppp1EQhl+yfZGvq7ouALu2tBzqtEUbZP+GqT2PWQy3lta5r4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:36:44 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 20:36:44 +0000
Message-ID: <15afee5e-403e-4ab4-a1aa-2677a9c0ca5c@amd.com>
Date: Mon, 20 Jul 2026 15:36:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
To: Dave Jiang <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-2-terry.bowman@amd.com>
 <9c371c59-c871-4988-83d7-2aa780d8e6c4@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <9c371c59-c871-4988-83d7-2aa780d8e6c4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:610:e7::20) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: f465fc29-2ff2-4c14-c0f4-08dee69e9cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	88HLLGzt3zrFOiFsRPaMHH6EJ8QYxiU4Woop+jbAEKOHcjrtHc5fGO+dCyAcHokxIfrWDlAoV7paE9Hl/Ea4dvl6HcUgnjSAgoZ4RZs6yjIIw/euwcQAyg1wFJlUEY/tSgUt5JyZlVg1mnwW3nZg3rUimqIg1QMTfif7NzKMrh+u+0654KeqlUyWX9+6AgmYWjt8nNLJwkDfbODjwMrTgtBRLLTWVUub3r3ezgWS8XOTrJCfRCHmzRJOZ4kukb6bx7scUidulbm6Qh36Kwpr0JP3Mx1Qi1bqWiXKcT+q6DH6gnEUnxf1+MX6KRElhooSaFdRI9EaLRl3kg6Vz/2a82pGXhgLWLvS+F6ME6Ik1IINYenRv8b7ZrRa3l9KsxvSrNFzbzJyZdrUJcADwkH2c98jLXtuCnIRaNdCIDo2/b58c3ZoMnjrfdeAQ21sSG5vAJ871kTxCF2BcKcm7R53WE1hSSncb8RMi71g61U1MJ/gptZ+BD6nfdEHq5ssVYB6pykHK0gWM4c2jVuB41R50LfIJeg+xZwkNS+eBj+MoYDy6ZB8xgC36Pg2bBwCjiT60hkEpNCQPZl6YOwI/DqRBVDxC3u7ypvrlem0AgJDig2jw1EI3hyuJgYxHuLRoAXKpMJFzKypCWeFhxKMf9NsSJlpO/zahStdQPdaUIQgsdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTh1UmJwc2JpekNUUU5UTGI4cnlqbmF0eThoVmZzMkdDSThvR1plSkI2b3Nl?=
 =?utf-8?B?eVFFZ0lxc25HVWxBQW1aSnNWaGRmTk5ZWkpuK3l0Z2NSZ0FQeFk2bWc1aUJx?=
 =?utf-8?B?SGR1TnJYbnkvVllhZmJabEtsa2JoSXJqNzdTOWNVNVVtK2t1d1o5em5JZ3lY?=
 =?utf-8?B?ZlkxSXErR3IzQWtWempqQlpQY29PdVRsQUQwQnZoLzJIQ0Naa0tNWmdiWXp3?=
 =?utf-8?B?amt0ZVVJNUJWYVFHbXdMVk00SjRmVjUxei9Qb2NPTjQyTHUzUUM5VW5nc2NR?=
 =?utf-8?B?ejYxZXBzaW5QSlkrdm5zb3Y5YVdTY054MG05ZHVPRWJGK1AvTmpWblBrTXpL?=
 =?utf-8?B?cXFVUFA0OXluNHBHV09sN1FjbC9vS2wzVEVQUklEZUZqcmZ0N3MzQnVxS054?=
 =?utf-8?B?VFJyTDFTellYNDhFMnQrK2NoeWpsRExvNUdHbjhVT1FXdXBDV1pBZzZxTElm?=
 =?utf-8?B?QTdiRjBoNFZHR2JBRFFwOFVmMGkxaEVWRnF6TUpMVmRySEMzcHNua3hIOURY?=
 =?utf-8?B?dVZDTGhUWXNsL0sxcHdNejA4Yzk1d1hIRjc1b3RKalNyN3JDUTNGeEZOMXZP?=
 =?utf-8?B?UHUzQWNXSVIvUTdnaG9mTEZIS0p6My96NnQ0QmhjQlFsUHFsN1pDVkRqR1l2?=
 =?utf-8?B?ZlZvZUtGSGhLSGl5RW94dE1rN2F4QzBxOGJIWktvdjU4MnVhMHRLVW9kWCtl?=
 =?utf-8?B?Z01ZK3pTOXplUkJsc0tzTmoyZFZpYU1icWZFWVNBL2dPVVFmbG9CdWphT1JL?=
 =?utf-8?B?VXFaa0Zua2REOXg3OS9OaGFGWTRGK01oeU8xekgwdmdzdTZxazhWaU5IRi9H?=
 =?utf-8?B?ZE9kMm1XS1R4b05qeHQwbkthZWpaWEloWkZnKzA4ZEZCSWl0Z2V1ZkRmKzJq?=
 =?utf-8?B?TTRpKzdqUkpKdW9ESTNvVW1iVzl3a1ZjSDZkM0kxYmZ1YXQwcEpiL3d1VGh1?=
 =?utf-8?B?enZFbHdMbVVHTzN3OEtjckM1aWdXTVE1TUtBaVJQZXR5VW5sSGRtTnIzandX?=
 =?utf-8?B?ajc3cWNkbXhxQ2tKalBNM2NoY0s0TzB1Wjgya0NkT1YyZnV0c3JMVHZRWE1J?=
 =?utf-8?B?UUJ0L05OdU5DVEZsQnNFL0tyNXlZWm90akx5dUgzdWFpM2oxZUVkbHJCcTNN?=
 =?utf-8?B?VXFqSzZkOTFiR1B5VFFmbFlEVDVwLy81cmRuRWozTVFTVTErdjU5LzNDbzVQ?=
 =?utf-8?B?ZzVmQWN1cWpEYXpEVGJ6M2JuN1FkdEllNS8xbTZHVzI5M2VUTENCVkNCeDh4?=
 =?utf-8?B?QUs3Y3hxNGJ3K2RCN2JQOG1Cc2ZZYjhMbHdwbFlTMG1TVE9ZeURrbG56d0gv?=
 =?utf-8?B?TGxhTXdBKzBKUkxpK0F5OCtSSGNDc2VsQVRIWWRBOUFQYlE4TzlmTS9kVWdt?=
 =?utf-8?B?cFJWRlJjeVoyWVBLWVhpcnVuU0ZrNnNjb0FoM3NoVFE4U0xrWmlneW9veVpp?=
 =?utf-8?B?OHBkM0U1YUxBckdEdTRHUm1tZnZDVENsTVZNZktXd2FQMEpvdkpZMlczMU8r?=
 =?utf-8?B?MHlMNzI2YmQyNHpIODl1NDdtRk9PL1Y3Kzc2cElXdit5WmlsSi9GekhSQVQ2?=
 =?utf-8?B?VUZiQ2N6WkRUZDBlQUlYeWlLdUJvZE9ic0p3MWNzMi9QdVNKWFVuK20waVFt?=
 =?utf-8?B?Z0lPVFowZ2Y4SG5xNyttRnVTQld4bXdSNWFtNUx3OXlPeHd0T2srazI1cXhq?=
 =?utf-8?B?K1h1U2d0TGNXSXJiM0JTMHJWSzNSdTFDTWpIZjVjSVhvTWtXbk52aEVITTVZ?=
 =?utf-8?B?QTRud28vbUVTR0FLaWpmZnJ3TXhWcy9TMlh6ZTZJSjQzeW9ubVpIOGVlUUJ1?=
 =?utf-8?B?WG9iVDNxRXpYcHVkNjl2bTcwYXBNUDNJaE1nakRPb2hLT2VxelJoUDdOQVcz?=
 =?utf-8?B?dzNCSW9DTWlsdnZFREcvK1gweWxoalZmWmFPM241Y0pHbUMxUWlXdjh1REts?=
 =?utf-8?B?WnBSdnRZRG1UZ1ZPSFFQb204eGt6UGhJdEpTTHpnZ2Jna0ZQejh2d3BScjEz?=
 =?utf-8?B?OFV3WVBVOFQvcTJpbU96a1hjbzdBRGpXU0t2NmN6NTVvRlp5MGNud0IyVTdh?=
 =?utf-8?B?eDZVTjI5STErMHQ2d3JSQmlCWHE4bWJDNTB5N25Rc2xseGtZNHEyK1NIbU9J?=
 =?utf-8?B?bVBnVU8zdHVnOTZtZlVNbWZHVHRlVUJBNjRUQzMwR01mZGFCNjJxZXc5anFW?=
 =?utf-8?B?RTl3ajhVMmtJalgwbDlPZmZ6OTB3RWFXQXhHditVYWpvUzJwd1I5S0sxdTVT?=
 =?utf-8?B?alhhaFlocVJoMVZPR3N6WXRyRE1qSmpqTXV1SHpFSFJCMElIb3ZtQzJXTi9F?=
 =?utf-8?Q?SI9lDDFaIjUOxNLA15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f465fc29-2ff2-4c14-c0f4-08dee69e9cac
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:36:44.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gYjYizdXSp20gA7uhL5CT9lDfDU2O8QfukgWbS5um2+6d5DZdkbDWlfMmp41gqpY/bDC1ba+bFq01GF7IDwug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

On 7/20/2026 3:09 PM, Dave Jiang wrote:
> 
> 
> On 7/17/26 3:26 PM, Terry Bowman wrote:
>> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
>> errors as fatal or non-fatal by ANDing uncorrectable status with
>> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
>> Root Error Status register bit (bit 6), not a severity bit. ANDing it
>> against uncorrectable status tests a reserved bit and produces incorrect
>> severity classification.
>>
>> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
>> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
>> Error Severity register indicates whether the corresponding error is
>> fatal (1) or non-fatal (0).
>>
>> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> This can be picked up ahead looks like?
> 
Yes.

-Terry

>>
>> ---
>>
>> Changes in v17 -> v18:
>> - New patch.
>> ---
>>  drivers/cxl/core/ras_rch.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index 0a8b3b9b63884..44b335d560708 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>>  				     int *severity)
>>  {
>>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
>> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
>> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &
>> +		    aer_regs->uncor_severity)
>>  			*severity = AER_FATAL;
>>  		else
>>  			*severity = AER_NONFATAL;
> 


