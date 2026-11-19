Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E6606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BDWn91Ae;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BDWn91Ae
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVZsh2szzz2xSS;
	Thu, 19 Nov 2026 21:47:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain="microsoft.com:microsoft.com"
ARC-Seal: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795085224;
	cv=pass; b=bM8+icKKi3drp8NaIgzW0kGvuSgjUgy0Psg/zDZjiTjquSCcz9WqOtVRhfRgc14dKNnjTfnye41SPm9HdQlf80YNoJwr0IomnTCrmbbaL6NW1/EIk2w1efluM9yN5tNXTNbib/jCdZu5luToi56U1SZCOuPn8KdtBP69Cjl+SrgIyTk9+ubPEVYGoY6+ggWPMs1lyyZ6n9SRge5+/3oGMPku9lYZq/sGO3rxfTLGJVv1CIvc6MB9LYAeRmnUf1FRsj23PmFXUmh6yg8zdDc9SLIwRIZ04ZrViOtU1xPsVBuIL9iYjBBSjqTXJU/8SI+XfHYKGkxgUEfC7yEpD+7S/A==
ARC-Message-Signature: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795085224; c=relaxed/relaxed;
	bh=zT6ay0mbRJ+myuyAlaoFbmHgemZeidAL4r+BGUiy5Us=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bk3Wa9nX23v2BnGHkpliS6K/0rHcBXjYLoKslNTlhqJX2fhQ76e0t+cYevbqjjYG4w71dYGgDjL8x5Eyq4WOkLcKHymNKJwng7LA8MdLNP8A5843tw+QrlFyfZ8zyOiAe2FOeiYSKEmoyl/GhQgeGWBH5X5glsgsxLvoUZQYoFq9kArvQPGCBwav0NmGmEvZf9dop1uj1m3vGxt3zuyLUn7zQ4JjPkTLnDG2ojhejEBpZILHPmogohEaAwQooMAiIfpuGa+2vSHPLIFbpBd7P2DeBmD4bS4yYD38cXgo0osTk6HGeO2/29IGzAo+klTzc79Wb9SUue5FHHyruvzlnw==
ARC-Authentication-Results: i=3; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BDWn91Ae; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BDWn91Ae; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BDWn91Ae;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=BDWn91Ae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVZsd2fQCz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 21:46:59 +1100 (AEDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=p8uCvKO7dng2mZPES7zF6PnYw6KJDecauTb8dvyBkEvP3aIXRR0cx2ARKgmr4wj+CMtHWBri7VUWqNfvAgp1/U/iHPpFX7+m6q7MQMG+L+Z15TZp0RSyHC9OKEmzu8dMO0pPZ7JIzIbnPhURNKNSDacUkouUVlM0R3Gj8t0ClOLG5Mpxlx1y0gT9ahtKeS4f3uOwJlKrj2lhjBiDGFlN7prq/sb2ILV+wxII6EgZBdyDY3mTgjkQQ0oYzMiv7V9hyMQCjHExW+xUX0oKnsZ/YPFvNkY6JrRpcEZJK746+DCTZ+UHXDclRhrGTVrW8AWg+ov/8jNC/mjWljA6BE69Sg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT6ay0mbRJ+myuyAlaoFbmHgemZeidAL4r+BGUiy5Us=;
 b=WhC7P5nrhz4iv4O7OnAZl8KPqRRuKd66xUm7ep23oeSaaHmT1XtwbrHVELeftOzTFxEG+fHiYD/dnviLydDvcX4ja9DMWXSGsR+GbTLycmdbszFeNlNpBGrehQNSXP2cwgpgP9fp/eVWZtYW/xxbOUqInmQxwD6bSxCAqpOtI8Fi1xXr5bE0vBQp19Sn8iGZ9jfui87fIpv5gNynP3OPKRvnvGMySVogh8rWSc6w2+tQRRzB7FYe5tJRqy7r62IkWZrvRBOxkhHnaHUyWtAhuMGrfuiHk3mXKe4ftop8LbXq0qya+3SCjQwssD4GDQQ2pYtcrPVhTfgqL/krYfjWlA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT6ay0mbRJ+myuyAlaoFbmHgemZeidAL4r+BGUiy5Us=;
 b=BDWn91Aema5HfRL0OA5RnFHlqCKAY2rtuISbDn0LoWpkXmu69QBjVPhMg60B7OK8r3GQQE/0AteIbfBw2ZejD69tmwwy4eD0oHcwv4/efTYmdu3LIXxEHkm+blb3210FJb1KHVbknKwEKC84WRkeLmADkWYqKB4gAY5n72Hz9hQ=
Received: from PR3PR09CA0014.eurprd09.prod.outlook.com (2603:10a6:102:b7::19)
 by DU0PR08MB9080.eurprd08.prod.outlook.com (2603:10a6:10:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:46:38 +0000
Received: from ZR1PEPF0000E6AF.eurprd05.prod.outlook.com
 (2603:10a6:102:b7:cafe::a) by PR3PR09CA0014.outlook.office365.com
 (2603:10a6:102:b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 10:46:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6AF.mail.protection.outlook.com (10.167.241.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 10:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eLnkFn/8UjoN42v6Niz8y/fAPi8KeZZ4E8tGLsMmzqhHBBLM8fdMYc2ElmuJdNyElqgTkLw+ARX31MIRIKMAtD6QGHihJ8yNZ9nXPJa6cmwvgZZtIokfLe57x7mHRyszSeDajXwHttjvqBlyEMebqvmgviQLQImtBPbxvhA1GXgCbfsHu9I01Owf6BOIRbSPifLiwJ9n4k4yYqHxvcNt/ZzDbWJbxo2tYOLv8mzEfjct198HXBQ4vj/x/fMgKIiuAd/9LI1YZHg2eF+52ZiGgsDxZTj2ioTksJZNxSoi1pGmnyyiuB1kCZVqU+9oYAtDNTvC9efjODQHPMLR3q0Q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT6ay0mbRJ+myuyAlaoFbmHgemZeidAL4r+BGUiy5Us=;
 b=dWFfg3kSl2mPxRpK9jKdTpj0P/fX3o/NzutAoMvyGoQQFfHfsqqSR6iFsy9ZcFb1ZlQ1mlnrleJDgpEWFxRz8taR85VoFsHfwIcVbH8FoR0gLvOvTWDLFKXvmUE4SioIz8Gcp6uHv4kfTc8yB0pY6kgg/QUYEDNT754WKIJya46+8JduBe6rd5JXDOZkyKVf6wcCoWGZ1+ZfQ9852Vmb7PBgoRF3NxSTk3jgfLkcIm7LAKufWOdiHbarL89WvWm5XBwoNSoFW/QjChGP/LAgBGq436Q0JaBJB2JGzz/VFiZmtNMsgjs1qg5Kxx5RbM8lFsO63WswK3uCej9Y78kxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT6ay0mbRJ+myuyAlaoFbmHgemZeidAL4r+BGUiy5Us=;
 b=BDWn91Aema5HfRL0OA5RnFHlqCKAY2rtuISbDn0LoWpkXmu69QBjVPhMg60B7OK8r3GQQE/0AteIbfBw2ZejD69tmwwy4eD0oHcwv4/efTYmdu3LIXxEHkm+blb3210FJb1KHVbknKwEKC84WRkeLmADkWYqKB4gAY5n72Hz9hQ=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by PA4PR08MB6223.eurprd08.prod.outlook.com
 (2603:10a6:102:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 10:46:01 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 10:46:00 +0000
Message-ID: <5e9f7439-fe57-4802-afab-2c4fd2c15850@arm.com>
Date: Thu, 19 Nov 2026 11:45:57 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 01/19] x86/APEI: Extract common CPER memory error
 reporting helper
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Radu Rendec <radu@rendec.net>, Avadhut Naik <avadhut.naik@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>, Breno Leitao <leitao@debian.org>,
 Dan Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-2-pierre.gondois@arm.com>
 <20261118185406.21700e81@jic23-hlaptop>
Content-Language: en-US
In-Reply-To: <20261118185406.21700e81@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|PA4PR08MB6223:EE_|ZR1PEPF0000E6AF:EE_|DU0PR08MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cbe025-e86f-4ab8-1e0a-08df462a633b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|5023799004|10067099003|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info-Original:
 3zbcUQHg9YqIWJEpKBR2Ot0kyLBh+oZ/fuGRHeTNh28vgOUyMUvgTD0SNwt9X6IxoCHxw4GIiONX/VYOYKw4kNEJP5kO7nXjiyYfS4oIq3nFDGBtP3w7bU5Qi0j/rWOjO72cMWHTqYUbzSAAYp8ZTrvb8cSYFEOIyLLPmlHHZFQ6lqqV1yNCw1t6lKCD64RqAfOUynQTTFRdKowktVTzdgOrAY8AOiRmg9L1CcIT8eDSXzGPSRXErlS48MCJniAh2k+yYq50pfr+38l2U+FJDoHV6r25vqGZ+A1N5mbupBU8/jAabcOTlvhtc2i3xjJQiNFrYv7255LUxxX1VthhLcHxCpusurpYy66wABEG90as1pw2nvRrI6+i1l9Cic7WAZ2Ru4iaPeCX1XgqjtsXaM/cVIpn4Az2E9Ety1zpzHfOX7l/FwhRbFDHrYjWQmshGEzb2BEFFEoD+FZleQC5LZbvaBkQlMT7pLyyQnas9gO+Q7YCUG7mGEQ9R8JQ29UAT20/FstBcLH0UVjJg1fGxq22dAlWkAJOGTPyYRfZ6bp/u+RqdWz6fv8uL3wRTsQ35TfMIZtQx/EcgsTEIOJ0/w4jYgmcpAJkq/a0rNxIThD9Vt5K/CjyjTdWrqWN7knaRIyEEGmGOuLr7xnluCwxmgV1P+27aZeFsb8nd1q9ll0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(10067099003)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 qE+fQydr05tm0K93v+Kp39wIH78CUNmFF1LWIgjMhdbgbJ/KL7er0loEVE2QiACcN5EtoB4xhRhVzhwEx54DhD5U4acOuPtasAzMdABCRa+6iYbcl/1gFAfm0O70aWwbL7xn+T4fBJwf1mDwHSj73mN2nYBTDn9B3sq9roB1Ak3474Jrbi6ZC0vZf7cGUxKDb3SRomJQgcNE5MvsVmKZ7YWXwVkhznyEC1vAF6u7z/YQryrw3zJf+ZN80V1p8U6hE8c/Mno2cLt6t7d9nc6D+XXaXm4JnvmXmPn4c5Wb4atm7eofYADzn/h7ed5pBdV20svPwcB2TYl7buW6OhAa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6223
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6AF.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	55cb7ad4-d20e-48c5-9ff3-08df462a4caa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|35042699022|23010399003|14060799003|18002099003|22082099003|261009223027099003|11063799006|5023799004|56012099006|4143699003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lfu4tzU55LcyHP1kW7moOg8NzV9houPFJojTkKTL6s2/9oFK+Rts2URen8FdnqCU/Ph6lIkmt1Dy1Dq7G85A15lnm8xCWJ2wK+N1gK7lzprNAMEhjL58ejwKBzoKayAgTNtXYskaQjdCdUpvQmUvcHvvYlgoKhCEVVYSFOcNiZTY2XeyA8jz+5bNhx5rEshG+KuwGnfEhHwjembIComiyzbGf+m0sQ56QHV85DGxlO/5Cx9PIl7pkCP9qkCfm4BNllj4nRkjuexYuT5gexJ7NK6JkJqvA3rtTo9LvX1bRQ1yLyF3L920rdnMOuMjzg3AAqRCcyrtuHjJ0whMQB0frfKCfkePWJo6beR4cxmelmcKvKBdxoZUUcFMlzs3RVXOmmPB0SfoQj6OCdPzwM+XdlC8bfR3Zd+r3bJvHBZJG6jj/o7mfIdjbazCa6Zy4r9P5jo8Rn4FhIY8vrdwRg55tncbDo6A1EdfpdNrSnf4wqvk5X0E+Zk9w1TIX67Y0c60Ob28o86ilmD0iXMbP/b2/TEI4GfU2Qc/dJfb28PPZ6wNCi7ii97IAhrG47ZIczFHO1WAuj5f5Wt/EG8qtoAnr5SCmd0Udi++hFJ4isJX/JLgXHjfapYFBKL3Fmpd1iqvTczER3bYYFk1IhudSoyGJ8b+MmRuE2d9yo1tc4mMKKcggUwv/ziCQDWVmm8GNKsb3vcdgmGFw3TSZ++bWp2rTQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(35042699022)(23010399003)(14060799003)(18002099003)(22082099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(4143699003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WDXhWDErUJrb2BFP7Wn3pZSIBXz25TUznDhd5TKmZptshvDoWkC8wj7z/S34oQqz2bMU4L/0v5sHqX61EXVivSqwcHfvCL9EO/nY/h+1pG7XwgyPom34lx1WpVk1YJkTKXD4K7yAITj6G0UCbrqu2XgUFxUYEv67U21nL3xrBJdWxdF0AG01KGyqJRnW6RcYKXcTTTXc9p6C1yXB7U8mBkRpu/fd9PjJm61h8qgRNxU9tbkMN4jxjEbXxbdUrgfjhJpsp0x6KD6GH4JFqGOl3FdW6EBdirrYCu1pRFn7SwR3nneICOYq68LrobCIsgkxq/ztYlJi81tP7OcjCcH3ztE2bfaj6B96yyearrcL1k6jbiekTYcfnbIHXpiCCixDQolxtZmefUhbK+w7MmwIvHLmb8MUXE0GEDoJIJNQC9kVxSW6/VenOyM9ItQivy8u
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:46:37.5923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cbe025-e86f-4ab8-1e0a-08df462a633b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AF.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9080
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Jonathan,

Thanks for the complete review !

On 11/18/26 19:54, Jonathan Cameron wrote:
> On Tue, 17 Nov 2026 12:10:11 +0100
> Pierre Gondois<pierre.gondois@arm.com> wrote:
>
>> Prepare for reporting CPER Memory Error Section 2 records through MCE
>> by extracting apei_mce_report_mem_error_common().
>>
>> No functional change.
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
> One curious question + trivial comment inline.
>
> Otherwise, this is a simple refactor and seems clean to me.
> Reviewed-by: Jonathan Cameron<jonathan.cameron@oss.qualcomm.com>
>
>> ---
>>   arch/x86/kernel/cpu/mce/apei.c | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
>> index 0a89947e47bc8..b993ac78a3b36 100644
>> --- a/arch/x86/kernel/cpu/mce/apei.c
>> +++ b/arch/x86/kernel/cpu/mce/apei.c
>> @@ -26,24 +26,15 @@
>>   
>>   #include "internal.h"
>>   
>> -void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>> +static void apei_mce_report_mem_error_common(int severity, u64 physical_addr,
>> +					     u64 physical_addr_mask)
>>   {
>>   	struct mce_hw_err err;
>>   	struct mce *m;
>>   	int lsb;
>>   
>> -	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>> -		return;
>> -
>> -	/*
>> -	 * Even if the ->validation_bits are set for address mask,
>> -	 * to be extra safe, check and reject an error radius '0',
>> -	 * and fall back to the default page size.
>> -	 */
>> -	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
>> -		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
>> -	else
>> -		lsb = PAGE_SHIFT;
>> +	/* Missing or zero masks default to page granularity. */
>> +	lsb = find_first_bit((void *)&physical_addr_mask, PAGE_SHIFT);
> Silly question.  What stops it being bigger than a page?  I appreciate you
> aren't changing what is already here but it made me curious.  It's 8 bytes
> so limiting it to page size seems odd.
>
> That larger usecase came up last year for how to handle error injection
> into a VM that was running smaller pages than the host.
>
> I guess on x86 it simply isn't ever bigger than one page?

I also don't really see why we could not operate on multiple pages
at the same time.



