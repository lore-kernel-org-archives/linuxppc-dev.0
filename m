Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54BD606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Tp/ovCJW;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JO3IcEDN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbB9p5c2Zz2y8W;
	Fri, 27 Nov 2026 09:31:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.165.32 arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795719950;
	cv=pass; b=EsOQkzPF1UuMA/7QdsDl1v8SPX/U5/UX5qfiUxiaOSXTfKb1vZOwO46gU1u9XwILiesDRSZMzw2BDMkYWxr7/vutEGnXI4tpfHVgnGWsIWz2cqwA5fivG+JaEV3duGgl646MaVfaisMvOhzOQqAN3lxxfwQrRPRniNl2WgBz9Tog5fJKxJ9fMPAAGZMPCmBb51qi6WNqhHrV9BYaUjrESI9Ijgb3Ghq4fLdPaJdKE+LeB1l4J56aA5E0ZcpZGtYJVGxrA7Nq6rCME6cYSVNC/6Qv8Sr0ALA95S7KzKNVNw0PhNqYSQR5gbCC4nsl5BG9L6xpK+70vFVSYCsTfl49gA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795719950; c=relaxed/relaxed;
	bh=1cmVIf7hF5zP5kUhlh8XOZ9SOLsEDVDQuBXjNmQcG94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gU02wcikgya4AvbiXRWFUxaAFpDzezHRBZJ0qLHzSgyZ57g4D8nx6UNR8wNORxjT1DTXQUpx886kdQhaBeoQPCHhD5iPEkL15/iscoI1VbBMhEVndAHTtMPO7VqkPZjSx+w13Y/L0mj/9QL/jdUSdfYqLzUt+1FMnWikp15n9W57wzmTH0+RF7jHgxN8Xs19/Qpv7UtZ1aBK341R9pON7/FbnazEgrOaT9Zr05FbdOb3qcv6zKtef16Hc/MyMHYCyWM7VZcgemxy8HpZZwk20F2zIXPIfLWsBVZzT83NtC0F2PcNdwkYXcj+Ct1l48n648P/O4evyqRD86GPcroYfQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Tp/ovCJW; dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JO3IcEDN; dkim-atps=neutral; spf=pass (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=liam.merwick@oracle.com; receiver=lists.ozlabs.org) smtp.mailfrom=oracle.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2026-11-19 header.b=Tp/ovCJW;
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=JO3IcEDN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oracle.com (client-ip=205.220.165.32; helo=mx0a-00069f02.pphosted.com; envelope-from=liam.merwick@oracle.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4582 seconds by postgrey-1.37 at boromir; Fri, 27 Nov 2026 06:05:49 AEDT
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jb5bx3nFDz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 06:05:48 +1100 (AEDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQCmvxZ4150389;
	Thu, 26 Nov 2026 17:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2026-11-19; bh=1cmVIf7hF5zP5kUhlh8XOZ9SOLsEDVDQuBXjNmQcG94=; b=
	Tp/ovCJW0FeQ8wYfbzJOsD4yNpdw552uej3WFUj8IXyztw2NAqoBGel0NNSw5ilS
	McUv/NAZ4fMk6IVzTV2hOe+IXLQ1QSgrhhSGfRiWcXxLrXyHzGOA4OhKlw5hAXhI
	6VyuGGFmtK6bKe86BitPelwDJVEGOKX8A9Sn7yD6Mw+tIohNYhDCEQoriG/hQkaB
	kc6CCxKYpTXBKBku9sKsixu9EaEwmqxG9J9nkVf4EdyIF8l0y14DrP417uW7+4x+
	GpZreA+csB0toKBUeSlNHI1qD+IFnK9NVfzdAX/kYWwTcpbU2pzEiqCx8qt6bvAD
	SKXipBa3a7gdDFf8s3nsEw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j34r6yrv2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 17:48:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQGLSYb2353694;
	Thu, 26 Nov 2026 17:48:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4j6r7gjdr3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Thu, 26 Nov 2026 17:48:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtOXu048LGqHEUkq8NNL0AUQy4oNcSWHqvcGcTwZq+xT16DDTyfsiQiaOsKULW0QN0XRwRgps7vG7er7aNmQ/+HSefJA5oFg5CwNxislXXIn7ZyaTwOoS74FQllLy0BraYwoyntGN9XoVCFIz+AIVJw0GuHugwW8Oyo9Ygs08yY5tuhnZ9d+zi39fsHNhcEVXEvpNL+Fyj8gW1hjDFYfeYcHEeTJs0ZF46jKMMiL2NP1qQgl4VE3Q2i1abHzFOotRo9iMoakCZN154CkF+qLy0jgGfg5BVN3qHh4K6bwaO2tve4Ne+V/S2IOWlYrevlMiDnsGQwj/g0xW7rqhtvdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cmVIf7hF5zP5kUhlh8XOZ9SOLsEDVDQuBXjNmQcG94=;
 b=QApMGMXfPvPpCrDFLvF4QOyNTp+c7naX1FBlpzePWX1Fb1/aY8fV5wTFtm2Ri8CZyCS4QNziSF5el+QDEDlEZuf+tbJihpI4bn0FShcD1Krc5nJuRI+dIvWY/sWXI3c0+AMdwy3rlGceXwC0WMAtMk+VJ+23UnMeL8wThwk5NBzUhc3LW3lAYcHFQ/fddT1DUR+EGvLdcLtUXltt9d9HJRqyxA9AzDUQyToH6IiPyLLEBXnUPABe0FadteLgpnMS4nN88yu8uOkAr58eAmC4kf0J9LvnnBKfMy2F80EoBoNRtPxHicaEeCxxMHQopPKVFDje8MPL6BtSicxZt7J0Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cmVIf7hF5zP5kUhlh8XOZ9SOLsEDVDQuBXjNmQcG94=;
 b=JO3IcEDN5FCmgrsxhh8pV5prreb33UdIN4MaQ+tYCV9aey9AwwzmKtX8cbivHxVyZtDmGrpeH9zv8e8btKfmp9+iGZQ9puEfxq+hmWo8I3/W9u4lYgjl1Apukp6s9ouXG9ox9Y0ykRazSJW0tfrbksyvVzymi84ejgWyuqJuggI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5380.namprd10.prod.outlook.com (2603:10b6:208:333::14)
 by CH3PR10MB7532.namprd10.prod.outlook.com (2603:10b6:610:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 17:48:52 +0000
Received: from BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::a93f:a5f1:22ab:bd68]) by BLAPR10MB5380.namprd10.prod.outlook.com
 ([fe80::a93f:a5f1:22ab:bd68%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 17:48:52 +0000
Message-ID: <60d1b66a-7d58-4946-a468-3f19ffe916d4@oracle.com>
Date: Thu, 26 Nov 2026 17:48:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/60] kvm: Introduce struct kvm_plane
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, ashish.kalra@amd.com,
        michael.roth@amd.com, nsaenz@amazon.com, anelkz@amazon.de,
        James.Bottomley@HansenPartnership.com,
        Melody Wang <huibo.wang@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        x86@kernel.org, coconut-svsm@lists.linux.dev, joerg.roedel@amd.com,
        liam.merwick@oracle.com
References: <20260608144252.351443-1-joro@8bytes.org>
 <20260608144252.351443-10-joro@8bytes.org>
From: Liam Merwick <liam.merwick@oracle.com>
Content-Language: en-GB
In-Reply-To: <20260608144252.351443-10-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0016.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::21) To BLAPR10MB5380.namprd10.prod.outlook.com
 (2603:10b6:208:333::14)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5380:EE_|CH3PR10MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 020370a2-1e0a-4194-b80f-08df4be588ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|18002099003|22082099003|56012099006|4143699003|261022105027099003|261022075727099003|261102123227099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IYXq2udbOWiIfZ7ybAwa4tQWMTsajQLolZjbPHFbvl5VpAU8RgZj1PkJqiqb97kfwXoA4d3Pok6/qxOD3qxth/4Zxvyk1CRHpPBTPKWmkMjc1J43tY32tpi3HWxlRphg1oF3ItqxcDqSWgCA6UibibiG2XV8xK5hvPAfPMDFDnb9hgaezXfmxVuqaWWSIAIfQrQNNyTRlRML9YQWbDb3GndoOshXkOKTQWK8cfIAgg94nmNxCGIYrqLdTLdnqYQtoE11W7eSpK1LJdDF/WtbHKYMgTGKOlvVALKKCWuYT0AQ4vdqAbtFpDRLP13gW9FeiDb67YHarr3+fCA1+gPL5F7kqfeByHMFgkOo2u+lpK5RGAWv71eQMlzdMFlL6Ow52j73hHd48zieaSBXOP1fEpdwit1a8CKpETkFHzeO2HoucS+pBx4RWPbeSDnQ6UBCj8bgNLuxn9yHdQ69LCJVbEUCn1MxWbDPLhHQSfLnfFRSCdYyY1QJNS5dZ1/MeKa6rh4S+uFiUGDQshgilkGn97P3tFYxwQaKZyzFtu8Y8g7YWWOncWiChI2lGVMyx8GyIsCfnGbPH7h88us643VEkZA6GhiiNeU1h2iO4CWVZhnAtROVjvcW4Q6zdXMKk9004g75iAKXPiH7DGNF60JDye/iykUC5BgpOPns0xtOTBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(261022105027099003)(261022075727099003)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZktlSFBMZEhPT2tTQTd2TGIzZm90ODlHdWdtMmRMalRLbnJFZE1kOE5SZ0Nu?=
 =?utf-8?B?cGhlcTlXOXZlWW44MEhBc001M0FSUzlqREJtZWsvZlFSTEYxUHRVKzFDQmc3?=
 =?utf-8?B?bzM2UURlUEJEOEVrNG1nYTNpNlJsZnF3OXhMUHEwUUZnL3kwS3F2K1BESFd5?=
 =?utf-8?B?VEYwVEpla1Z2WGZJSW1pNWM3UWxhdXBMMGlud0JnZ3pzWUFZMWNuK0R5cEEy?=
 =?utf-8?B?dWphOXUzcEtHTDl0K3BwRzZrenJvaElvMm8yV1J4M0ZjVXlzWGlXQ0VyaGV2?=
 =?utf-8?B?eUR1YzE5b2gySVA4YThZTFZOdmR0TEtxRndkeFpmOXBVbXV1UUpDamIycHhO?=
 =?utf-8?B?U3RrMGJPK2tXNm1JTEZMRHRLMVN3bWdpODNPa3dGcXRrTDhvcDQ5R2w2ZGJv?=
 =?utf-8?B?dityYTRBSU42QzUyQ2ZDSUQ5b1o2VXJNQ0VHUThuZ0l2TlN5Q3Eva2RheTdW?=
 =?utf-8?B?SE9mWkllWTA2ODBDZmFoK0MvVHBQeHFuUVJ2YkZ3R1AySUZiK1hvTjlNL3cx?=
 =?utf-8?B?NU9nYzRHTXVBQzNYVmI5VXErM1Fndm9HS0NrcnJ2WW9ua0wwcW50ZWtRckxt?=
 =?utf-8?B?eWN3SE5WbnRUUC8xaDJqQzBwWGZwR25uYVBrVWJoelNEeTVPalFDQ0IzMW5j?=
 =?utf-8?B?QURhUHZ0UzRhOHFJdGdIZGVrcU12QUlHVzBYQ3R6SWNIUjhjSzJGMlVNd1F4?=
 =?utf-8?B?U0dpaWd1K1hHS21rTmUvZEpIY0pWM1RMdmpXbGV0UDhkRTZLRGhLUVhhaktm?=
 =?utf-8?B?YWxWakpQQWpzUVhtUWxnYmZOV2wveWx4TmUraXFOK1ZPZmJXNENqa0hLTWJS?=
 =?utf-8?B?RTFoV2N4dHVXN2V3V2ZQZW1mLzNacHR5MDgrN1ZJNi9KRE1paGtnNHlMODhP?=
 =?utf-8?B?OFZiQ2NBMzBsbFpiREMrdFBJTFlKdUFISTBEV0tsR3ZWUVN5T0RXa1FqU2Uz?=
 =?utf-8?B?V2I5UFVVK1FFa1NLRVd5N1dQWmRsNjhmZ1grakxtRXBhdkNWRGZwUEtRM0lm?=
 =?utf-8?B?V2NNSXlaSk1NYk5uZmRHR29KT0xXN3FnY2U0M0czT3NCQUsvdENKQTIvZjlo?=
 =?utf-8?B?UmorZUowOFhndUhoUnpmb2JMYVlwbjRmcTlXcnd6cTVxbUlidUJqa0dDRDVG?=
 =?utf-8?B?TnVtVXlybUFSOEtDVStZU3QxTEh5V09QeGxWOUtoNWIwNzBIQ0hETEE3UDIv?=
 =?utf-8?B?YzZsUFRXVEorWEJwZmZJcUFyNW96TXVReWg2bEhZRUZDN1RNRWN2TlhMUi85?=
 =?utf-8?B?cEQ1Vlp1U1Ayd3RHSDZ3WWdDNFpqZWIzUWxUVEIxcnlKOWFMblRkQ2gvR05T?=
 =?utf-8?B?eldYWHJRV0x4RFpnWWNWeEp6VnVXNDIxS3VsSlJ4Snlxck5OaFAzTXN2djFH?=
 =?utf-8?B?eUkrM2w2cFBTZnJmY2wvZG54NzBjQ216TWpEVDBjOXQrRzRVdUpWV0oxWFNJ?=
 =?utf-8?B?NTZ2bEordytkVW9ybWJuSVR5SzhoMGp1QS9JcW01NExKRWJtUHFHc3pUWk5K?=
 =?utf-8?B?MU1OczcyTHVtZ2N4NnFqYUFuR0hVZ0cxTGMwSVdyT3pXcjk5TDdYTVRwNGpB?=
 =?utf-8?B?WWYwaUwrVXVuOGc5azZCMXFreFlySHJwd0p3cU9pZDVLN09Zd1I1OFJ2RmhR?=
 =?utf-8?B?KzRCTUY2N05FRDNGUWovNHdrbjQ4ZWxvUDczQURkV2F4Zm9PRENSK2JySFBY?=
 =?utf-8?B?b3BaQ3c4TGt1elloRy8rR1IxaTI0N2hoQkw3TDdENnBNQzRvMENPSW9iZHhW?=
 =?utf-8?B?NnlwYXZDVkxLTjRJKzFmeW1Ec0pBdzhwT3Fob09EVnpEaDVoeWlrbE9YdHNO?=
 =?utf-8?B?V3BEYzBIQUpFbWxkS2wzUm5zWkwzeXQzazYwY3l1UFBhcGptc3M2TGRjV2Z6?=
 =?utf-8?B?a1kvRzJyOE1iQStZVVNjOTI2bFdoZ3VNYVJCUlJlNXQ2TytaZ3FaTUNTTSt0?=
 =?utf-8?B?bHhFU2h5TXhjbXR1WVUxUjFGSGtpcTdUM0hjd3dZN2YvS3RxNDEvQStiMm9B?=
 =?utf-8?B?UDIzNDc3U2dQT21pRmE0eDhUdklFY0toNnpQQnhVWkgwbDBqd1ZTRk9NSnlP?=
 =?utf-8?B?T1BjZzRZRjZ5NlUvVW13UmJSWDFzRUhoRFdsakNZTFhrQzUrdDFSSHRwQjBq?=
 =?utf-8?B?aUpJOGZZL0NndUFFRHBvUDFFL2FJMkQwVllGRUt6VnZoR0V6T0hTN01XNDBj?=
 =?utf-8?B?Zzk4T2k1MXNHZ2VtUEd6c0RDNlFBOGNGbWhKYkQvWXczWjAwTjg0eUZTRC9Y?=
 =?utf-8?B?Ry9JZExIWE53UlZPTSt3SU5vSitXVEx5NE1zTGQxMGdCQVRhaldOM0xJSDE5?=
 =?utf-8?B?YUJXbksxL28rNUUwZEg1bkFnMnNhMzh5UXN6bHNham9PYnhmWjJNQT09?=
X-Exchange-RoutingPolicyChecked:
	HG4ElIY3lrAwUh5Dw7jA7iWi6j1KUcM+/gc91/ExnPPLH90wB9yhILVbHxorSlXkLdpSFQFYlTaBpO+24tGhJ6eji90mmFDvGp/zlfloiKiEGrVyrQBFf0AOG7GGwb/Gfo0bbptJgxU9ATtAi56nZuZK16JMVYg6B4gx2tFaqMXJRuzxwnodde7biKm3ZKskAqew6r4jEMzLxG8ZlDQ1ECoUhMSfUjdrgDBanYWRhm+ivgfhezngnMCh3VnmKOKPdv8TEDE7A3HcUKRG06pJpugHid0D1HAdGhQiTFbe4Wo+YtemyxhPvY0G57cW1Cv3XLh/WTSbbblJS4zb/ra8IQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oTZ2s8bkg5+6axYJttgvK0AQUbgS+oETyEZqYL867fVi6oZ0m3xYR3Wks92oyvkP2nHibwj891Aoy7faZ4R6rqFQSQcUqEO2KwYMikLOjI2NpJ3LyAKoxsgPeResMs3Mp2Pa8z5bUeaGaSLU3ktpBmb0qA6/4zL5rcFBdaFAGlY3jRQL5yobWvdRSqnts5KZGAcy5W6/LbcKSmvNMl57uEqE2FIhnHzwbb3e11XX38V8vM+axQ86xpy4tQvlBXVLOip4iow1zlqRhegi5TetGRBHMJHr7s6M2rE0MTdJaWnA+BQlkw62GG4wZenSYMx7dZWxJT9p8MfPJauecHaCO6jdmhoDst4pU5Mio4+SernnGnQsrqoMygKa0VXF1hDEeOiFeBTOU3tAEqlWmjqUL8kYGaEE0ZsXItfX09UrNJuYVqorwvKL7B/3tNHlT05akkVQamyPBlzLEtkFHlaCilWT4broTSrBbxP5wuqxtdRtieA2QmzkEvrXGvLhJ10ErE/9hVfM+0TxoUfR4dx0fd0+km388Fc33Akk6/QVEMXH0QWehLtZQWJnTq7RyK5q3gIlj8iUDLuOCtHeYx0MJLt1N6PgPQ6tpLiG2Pvfwbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020370a2-1e0a-4194-b80f-08df4be588ab
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 17:48:52.3719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WNpZXLs/kScq6TCgbtoEUmDZ48byGjryCl9yZ+QZnm2T2zhh+Y3P2Jcp/nABNQxR17QoL8jJD6OohXw9iKQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7532
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_04,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611260069
X-Authority-Analysis: v=2.4 cv=M5bYuCws c=1 sm=1 tr=0 ts=6b087108 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=20KFwNOVAAAA:8
 a=zd2uoN0lAAAA:8 a=DizFviZhuovN16Mn01gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA2OSBTYWx0ZWRfX0Rfe2+HjdtH0
 1eFiuIEgPbr0IueO/8+UXso9xO7CQDUTbTQytPXKVPHDwyzJXtSbiyYe20s9rxU/F9EMFQMgv7g
 B7LpucQlSVxupJS/zIzSnmHCH0lrR2/zUhxKeU2+d0MFAEe9YqibvwWkvYcbjlEPnrIfq3yquxK
 /qkbrzw00hZd1nmcAAbDHXzQsFfdtIhpzgeVkXJgSIEt6Coys1edGuw3kKBcxAs6TMEB73eekHL
 vo31Kefkq4U12SmY4AterXcZgNLkcI1Wj1Xp87GRCVUY6brvtVFOQxXhuQBvdDavGAhYE/SoQU4
 aODRR5tA4fCodP5CmZwV5wVWUPAdwOnCEl4JO/tabikuoNdmqZuA9ZvRfwVpIdUiM9d6rjVN3W6
 zJ1Vh+JHQN+e2XMh6QlpF6VEzjkFQU9ScaxRZNwHwWxKVpvyRGm5FjElwU5KyZW36dsrouD14vi
 9r+CGliKkla/SuricDMtH/b2G4ruOTXty2Snwyp4=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA2OSBTYWx0ZWRfX3LoeJON/e6Ou
 MXJuYH1Ev60kkawLIjsYXNN0+nEsRLL0wrcWbS+NiKxeA4mB+og4f9C98PYiCxBIFQyMXBNt9cM
 YPXNAZt494Ic0T8cGqLC4nSNbfzRxH5L9P0LE1tAnReWmasUcZ8O
X-Proofpoint-ORIG-GUID: qANE87lKH10ErW4xkugqe-mtdh-XpHBC
X-Proofpoint-GUID: qANE87lKH10ErW4xkugqe-mtdh-XpHBC
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 08/06/2026 15:42, Jörg Rödel wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Introduce a data structure to keep VM-wide per-plane state. Initialize
> the structure with a back-pointer to struct kvm and the plane level
> the structure represents.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Co-developed-by: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>   include/linux/kvm_host.h |  7 +++++++
>   include/uapi/linux/kvm.h |  6 ++++++
>   virt/kvm/kvm_main.c      | 41 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 54 insertions(+)
> 

(...)
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c

(...)

> @@ -1304,6 +1344,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>   	xa_destroy(&kvm->mem_attr_array);
>   #endif
>   	kvm_arch_free_vm(kvm);
> +	kvm_destroy_planes(kvm);

This needs to be called before kvm_arch_free_vm() which frees kvm.

>   	preempt_notifier_dec();
>   	kvm_disable_virtualization();
>   	mmdrop(mm);

Regards,
Liam


