Return-Path: <linuxppc-dev+bounces-17380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600E1FD5323
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 09:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMkK01bNxz3bkq;
	Fri, 27 Feb 2026 20:57:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772180207;
	cv=pass; b=izUpPNg8NMgaqk/m8JT3vSvpqXY9rHqoeiFl/Y+sTV6ijUK1Ri4PuXeOWTpUXVUQcgDjm8v86dg3UsgDei+N2mGdCousTJCrr8biGyG0CQy6AYPWM/beKyKVi1Hz+KAKDwmYU0c3HPtdwgwe+joGzK04fqvXJsAtjoLGC3b6EeVIjkaxcScNBD2xycn7+QKBkg1NhdMbxyqnptLQVSYABR/Pj9v7NcDK/JGJjwHGxBDI6UqiJxoPb4lxznrXXHchwjXMATiaktBUwb1hemFtOjmnCk4xzUjecfMwu27bSzV6aLd3yiEJJmE5I7f0GB3GSqir8lP3dvKl5rH2nE9rvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772180207; c=relaxed/relaxed;
	bh=Y0GvZ94LsbIvdzkg30/vvx2NxMJIzNexPBR7Q8OOKm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AEBoDKddBuFB6nvjgwh3AgLb2/Tjgmnr7qnD1cJqzqHWG5QsQb0dTLskOS8Ea+/Lml5L6oIf2oz2RcqejnT6MjVWgN0pl6+rNl+3BsgMkvfWOtyQ+QFdqzTEk2CVAwoDnwpG4eEpEeWIHcRJGn9wdcgpFh+WZkKi2dc2VYDiPjNFy2WtbWttXfuAC11l+U4irWzojSNDz//s6i4bpYIwS3dymPpZLZCRJuDfgJCG9lpL3NNCU3FEpaGJioEuZ64332RMxjfw6krhLDSxVzcj3S/gvVCnLRGcP9poNxLRa5fUkR9YK7uGFylG/mSvQZPiW22v4cmDk52bTlbcrsSgKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HLS2oM6Y; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=mbloch@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HLS2oM6Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=mbloch@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMh4Y6mxyz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 19:16:45 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJieOIZIPJzbCchHrjR2DRw8upBqQK1a/IfUANcvO6hYXndwWrItGzCzLk4gLxyvKRFxbLd6Ny4fJc6/EqCQ95ZLYUPMv9ydRKc5gm7WLYipuThBVBZWwm6FVNrxZpStgWlctXuv279LlSxoHtPX3jG+eRRdWFVpYgENkETKjv8At6eS7FiUfU0sCOXz1ScGMNrxdq1vATQbI4PO7ojYu2p5PDbX2zQ3/EN9lY72hdhqVf2RwPuErND+u0tCPnwa0ED6pmEAsn6AHYfpCoIp3Ld8ZhhlV/AqPhJqLshayJt5f7+9zVNzVXfu9+s/IVYtqWjguSUXQex55pBRspfnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0GvZ94LsbIvdzkg30/vvx2NxMJIzNexPBR7Q8OOKm8=;
 b=VJmHP08aod0UKvLBD23YD8s1b3j1ijbrfg9MiMfH/E2BILQhR29gtcBDpB3IdAEH7fdNXwapykoptDWnE8zs3cx/+0BAXl1HXCZsWXF5FRkPjfzcBmNR1PDjF+tKCBxEstfiDOAW1RGbf26A1U0QOokVeqRCmgMn5jcKpf1KlGpq/nlG+lkXS3h9IneIE14qHNfni+PjFaR7axh8yNGtPtpB3Ha5yg6baPyGAbEHEoamEty/ciQ8k6ZAKn3OpdzZwmdmoihGosUmtjbOxsmWXg7IPXJacqJbKuM4HQOliKUEQQ4fCjHGM7YRzXXZAxBpXP+99ihoHiwS3/ps+dVYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0GvZ94LsbIvdzkg30/vvx2NxMJIzNexPBR7Q8OOKm8=;
 b=HLS2oM6YHj78oxFBtIRCBAT0ielEsM5gp2mfwaBUwwpzmPIQ5cJ9/1KLQ0+RDm8cz1+l1+2UEV6kqkEfgibec+HYAIVMfQQlYzHDtty7Sm13KUEJJTF7SPke3y/SBzCJEhzVPatkfuCSLIwO6nPk0ArBoaKQ18rFozmaWFtEvg02zlBtG+rBIybHbr9wY4fZPMyueknNw8zv2CVVhBDnLM/BaHJdwNP94PxBVNZcgKrO8WBKsLoMd6fYDGvSmC/L/gBU2arBoFclxI+/JCxauKsYTBE03B+a+VNWileRQRtqFJsWug/1eGZoM17UXtKVspcfj46RCBmiWQpogzS+2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 08:16:07 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 08:16:06 +0000
Message-ID: <6391499b-d665-466a-a4df-b3d0b4921e28@nvidia.com>
Date: Fri, 27 Feb 2026 10:16:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
To: Vivian Wang <wangruikang@iscas.ac.cn>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Brett Creeley <brett.creeley@amd.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
 <20260129-pci-msi-addr-mask-v4-1-70da998f2750@iscas.ac.cn>
 <fb23d54a-fca0-43a2-ae1d-03ae52112192@nvidia.com>
 <c9329ae2-721d-4127-9380-b1ea454bd8f2@iscas.ac.cn>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <c9329ae2-721d-4127-9380-b1ea454bd8f2@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::14) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: a84e08db-4c3f-433d-bc96-08de75d874bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	fpzdURIRXwUCpTnVZ/zeklUKfb7AJtI4zWuDuv19kcgTkpu1hhONXNDuM01R8wGq9OizN+ncACddFCicyNuWJUJlN5hrNaOuBl7xmAyQqVsEK2lUlw9ysoTr8rbTEf7W+3hM37Z9rImZal7bRMYymCoLzYtAnRczjgoFyaoZqIwcmqnT77kdI2DwAJKe2ORTz63yF8OEOm5mO8pB5jA4Zrz/YgokFlI7yEKuYHFmvYYfxtZLQ1HJaQKBTN3BW4tvD9f0RCMB0u1MyKByh+BAlnhP/E/HWhW1Dcd1cuntPnCOkDvPfKa9lgBzGZ3lgdWI/z8XyT/8IlfTr9pRBngwPIWgouNiaO2DtcnrsuiIF+ZzkLSJ/hPzyTCgX24oIXKi6NqzbmowR03R/CGYNSOCk+8puM/WWVLYMU1Eq1JCC5d+LYUqkke2Ht0lF+0pEaDjQROZfVNSUKkn7HSjYomJXKC1zi5MuxRRcUgtmG1xX800n6tmlzjXZ/4dXoK5ZAYZfy3/cc7Tw5v6ZvDzdGSUj2s1GM7f2OAhee8L1TYmdblsd7KBAqyQwY+aQOxmrFEFU4XjwVi0B1uvnsHED3s+439yt+9kG64ocL7pMrI+ZqUMmNZ/u2bzShplUOpdIo2laY3UXJVfBxKVAuiWQsEsEHtXRZL4yCqrpFrW03c0eVvgEO03iSogm21icoOhCpL/Rs+FBbzUZpegKSenYSWnZs8j/eB5aN4HjLMvZeySqidrFdpb1kucRz4QBFy5SWWj+O3EqwgWA6xhl8d0NZxtNrO7Wq2gqWC2PTaRs+r+mWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VMc2t5ZVltamlPT2hWZHV1TW40QVVXT05UMTBBTkU3M1BIbDlYNXRveVQz?=
 =?utf-8?B?eENOTkFCM2kxYk5DMUZabXE4VzFSZWZpNTRqT1RqdjlPdEYyMUc0UDIwSzFW?=
 =?utf-8?B?T1NDVnZIWEJIY3h0N2t6RTh4YStTU0piS3N5cUZ1OWF5V25MdGRkMDJJSGVw?=
 =?utf-8?B?STFXemJ4YTNxZUhNSlVPQmMwTStrNlNIa0U3UG5lTGUxd3RtWlpwR2ZiZmd1?=
 =?utf-8?B?T2NPY0ZRNlpBYkx2WFpsOFYrOHJudzlnNHNBK3dQbXVoU1RZVkMyUTNvNHFE?=
 =?utf-8?B?Z09obEt6SE9MVERSM25EYXFteVMrVldKdXQxeUkzaXNZUlRaYWlNOE9sY0VQ?=
 =?utf-8?B?RlluZTRrRFJBQTRJdHZ6dlNjNlEyOEZOZTRHYXYyT2QzNnRkb0lUai91dFc4?=
 =?utf-8?B?ZXVRdTFxdUlPU0NkLzRUc3VtMXVKNkFhUGNkODJWMWV2V0d4ay9yK1h4ZThz?=
 =?utf-8?B?anJRSS9hVkZ4eVBlVjhwYXM0RVR3czlFYkMrTEVSRm9PYjNiVjFWdC9Jbmlk?=
 =?utf-8?B?YkNEOExuYXlLWnRyTjNJTXo0alhIRnh2L0dIbEJMdG5UTVgwS2IyN3Rrb1By?=
 =?utf-8?B?V0lGWFhTTUFUeVFhUEp2bC9ZbUNLam9Ta1NLNmM5TGFqc2tILzZBVnJQa0hn?=
 =?utf-8?B?bUxUNVFhamRvbmlmTWQyYXlSZjh2YWVKWGwrM1VUYkUvL2tFT3ZScHR2bUVC?=
 =?utf-8?B?REJ0VDFLdHI4RmUyNjhVbkJ4VnNMSkJJUmFOUG9tVStFZ0tUUEtuTTdPRSs4?=
 =?utf-8?B?VjV0R3VRRmRVZE5MZjJ5YlhaVzBsQkY2R0JvMEZUeGt6TGNIdWZWLzA0YlY0?=
 =?utf-8?B?MTQ4K2g5ZnVaYUlUMUVRY1FQQ0d6eFRWa0h3T1ZPRXVWaC8vV1hsd2xBZ2Fv?=
 =?utf-8?B?cnFxeDN3anN6N1RUdmxmT0lBclB2TW5WVjVtVjZSVXFUamdaYTlhM2g0cUU5?=
 =?utf-8?B?ZGx2ZGhLZ0JFNkdob043cWlzREEvUE4zdTU0RlJFdDFGUEFreW0wQmZUcGxr?=
 =?utf-8?B?U21oSlNmckozcVJFYzBnbFZ3WGZ6NE1DdUZYWjM3ZkdYWnVIU25IWWVjWUZn?=
 =?utf-8?B?S1FHdldJdlN2Q21USjdZTklPOENZRXYyMDQzanM4OHBKS0ZsM3AwNEtMaXFI?=
 =?utf-8?B?bHdHbXlQU3ZZdnBSNUZlNFhkdUl4bCtkalVnSzlpdXV4Q0dxcWo3cGtQcVNE?=
 =?utf-8?B?cXdzZTBCQiswbjY1ZlhtbS9CZWRZUXFkeTgvYlNoNU9RNTlUYTlBSXN4NE5F?=
 =?utf-8?B?YjhMZ0lEOHlvVnFOc2hGeXhlZzFDNEJiUCtoczUrOU56V0NlajZHVUd2Wk9T?=
 =?utf-8?B?ZFl4VG1kWHF6TWhvZTRidHhEZVN2a1ZhTVUxUzBqK2pESDluRUtoSFM2WUJC?=
 =?utf-8?B?SHlvS0pwQnp5VFgvVUZGcmxJUGVBU05XMWxhTE1hczFSelhiK2tJREp6MHBV?=
 =?utf-8?B?UERXNkcybmsyeWRMQWpTNVpvVFBETm1TRjQ0NDRaUGJYL2NVUGxIL3k4M1B2?=
 =?utf-8?B?ZEdUL0x3RzhjclcyenFSdkYydFdNSzJzOVgzWDVZZUR6UWFIVGIrNWhuSlFh?=
 =?utf-8?B?cXJhN3ZCNkRKM3Fyc211cGpkT2xmcksxT0hmTlFrOGt2Um9GS1JTZU1ud3Er?=
 =?utf-8?B?Ym1WMDM4ak5ERlhYUGZ6c1FBNzE2MzlhcEhaUnJVQUdKZXRDRG9QTlR6eE9k?=
 =?utf-8?B?Y0t0b2VCOEpiSnZCb05GYS9FWlcxK3pOVE9iaUZXWDA0N05DVnEwWEhGSGFw?=
 =?utf-8?B?R1RneCtqeGx1UFpETDVjWDBPb0ozbEJGVVhWZjFNZ0lzQi9WZDhNdG5Qdlh2?=
 =?utf-8?B?RXB4MkZjdTlqTVlUb2NhUEp1QlVLSU9qNllzbGFMUlVkckFQQ0xvck0ydDkr?=
 =?utf-8?B?clBKNnFxd3N4RWl1MGNTV3JGS094Vkw1UWN1Uyt1WHMxcHpGeGhPR3VPYjRh?=
 =?utf-8?B?NkQxbDF4ZmhPdklaMkowR2w3NThUaCtOUFRxdnpmVXI0TXF0UTdkM0dHQStm?=
 =?utf-8?B?Uis5MTRWVzdFVXRacURTdmRNYmZiK21xVVBGQTZCL0JVYlExc095a25tUDNo?=
 =?utf-8?B?ajR6dVIzcHg0cXBOdm02VEd2NkJFRTdDMG5EbThyLzVQZmd2b0dCZU9SRXo1?=
 =?utf-8?B?WWxWZzJ4QUFKRGkwVUpUL0NNVURFZDlYZXlhSGFoYW94d0E4bC90Z0RHYzlC?=
 =?utf-8?B?ZGVONkExUEpUaktxdlFlZTAxRFFQRnA1bEtBSm43UjQxV2RjK3owWnArU1dx?=
 =?utf-8?B?cDBqWWFMdGxMV3J1TTJOb25nbXZjQWdsSGtCQ3QydzhsUGpaZXJhVjBiV3BO?=
 =?utf-8?B?OWlZaTlhbmVNUzBUajc2TXVDZWhjaXltcm9FdklhakZ5ZTB2by9MQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84e08db-4c3f-433d-bc96-08de75d874bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:16:06.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2zFIVGaP3j9FcAxUGOJ0tvWB6UjfapvrQRLAaNHUaEsCEDY/tsupjIUrFodbGi42+R7TjJvMcWj7T5Ka7arwLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671



On 27/02/2026 7:25, Vivian Wang wrote:
> On 2/27/26 02:25, Mark Bloch wrote:
> 
>> On 29/01/2026 3:56, Vivian Wang wrote:
>>> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
>>> implement less than 64 address bits. This breaks on platforms where such
>>> a device is assigned an MSI address higher than what's reachable.
>>>
>>> Currently, the no_64bit_msi bit is set for these devices, meaning that
>>> only 32-bit MSI addresses are allowed for them. However, on some
>>> platforms the MSI doorbell address is above the 32-bit limit but within
>>> the addressable range of the device.
>>>
>>> As a first step to enabling MSI on those combinations of devices and
>>> platforms, conservatively generalize the single-bit flag no_64bit_msi
>>> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
>>> with msi_mask.)
>>>
>>> The translation is essentially:
>>>
>>> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
>>> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
>>> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
>>>
>> Hey Vivian,
>>
>> We are seeing issues while reloading mlx5 on a PPC64 platform.
> 
> Mea culpa. There's a fix on the list [1] since last Friday. I'm not sure
> why it hasn't moved yet, but please take a look.
> 

Thanks! I've looked at the patch, it seems fine and should fix the issue we
are seeing.

Mark

> Vivian "dramforever" Wang
> 
> [1]: https://lore.kernel.org/all/20260220070239.1693303-1-nilay@linux.ibm.com/
> 


