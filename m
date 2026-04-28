Return-Path: <linuxppc-dev+bounces-20203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14306FF8867
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 02:57:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4Q7v1tKZz2yqt;
	Tue, 28 Apr 2026 12:56:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777345019;
	cv=fail; b=idtbUlBY6yji9fGEuyQ4dPaEPwgk89zcGxemUsLTj27TJsxToM+eufbbV1MtxrCCUclX5ZkxMU/uj46pvC4BnESF2ybn3fUIlPdzBece4Fll7kUrW2jCol3gNElQaflmltIWS4mZma9Jv794hl2FwGnOf9pvdDBtCWn7OTZvhBSuqRw0RwCEbXnMxVGGM7ykjtdUqi6eIzl+LhXtXO20DTlyZdBvIsEobmYimPvVa8lSu6ugDxzCiKpJAGqUWKttcOhMzmTdxQNecfp9qLxXK6xt8ht27si5g2Tw15zEbq0/iW5AkUgHGbAN7Q+FUekgMdD8v1PZxhQBFruR0AIcDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777345019; c=relaxed/relaxed;
	bh=fMiyHL+7JnRcquvQoWewQpcd3jLKB/I3OdiVz2FGXBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eQCcZxzRViKkXBgYVB/T0JYNCRHQ7NVdl09bA6lzdjjDTukS05Gq3HycWh+Q4QQPCle2cjQ4LC/Ou3cvvZqy8yqzq/kXOb4KTdZg7p1QJjWRmaJJ7wzWssYAuTRVYYSVJncElLxXlHEgxo7iDzCAaPyu1aGRB5v1EvWMtXPAJbv3JmDsuJ21pGoehIgtZQ6BTHNdW18zkNGiY2zOlfaDbbKj0pKuOOazK32g3ypC6Ct5BU6q73FOJ6cgHT75NR7NKmAR6ZrQeNhcX/M5uF/az3jszgeMT2ePCKzdru45pz0zPLpMc47R3MUit2oPcoSFrAE/XCnfcYP5xM9NaNwiZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=fail (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qdTc9/jH reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qdTc9/jH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4Q7s6dvSz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 12:56:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiMWG7Y6mQVZHyjTsB4sQIYHOdSsKy6QMitVxsqgrNDyycpkgzyFQnDdyWHJ/VmYdsoVTvh3G72+sMp8EASgP6LhwO/EZ1ffPjqJUPgNDelLsJ23fJRKHmjwLkNkz4JOEhmpY9IkthUR0qQPcKnW8eFJ9wcnPiOZz7SmN2aLO4aiwmoWGkk2iFE/l0PXmsr/E4avHUu/UHlJD4NgRybYQ7EGblC5N9RcAJl3Iq8WzvsfQA1j/fxhAWRxcQtoJl3gB8gfc4M5k6XYdgRgddXy654dS+eUGPKUJ9dLxsggYKmJgJI+Q83erukDlG+6kjkqZ9NIkIL9btm9640M3INgUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rymy+Di3gKjbpOt7vggNR07FAoNtjhNhbcGePn7XsrE=;
 b=pFSpylB5YlNint6CmlalyD2+KhMpJE0eP30sA6WFDuq2QQEQPuug1iUQ8YRXuiJnVrptTCOaokmf/UdGgi4kYrGLLD0Ld1ww/OrE/WEPoCgs2itcjl3Ay+fr/KeaThzYWPv2T3Q3YMrILqgR5UZaDf9CRiQ/7Jhhlh2O2Cxtr+H53mRloa7YWeSaSdVcZ5RIF9bi/5RAyZJcO98yEOU7aJU8PaiHINGDTph6mdr9tUAXUSZ5knN+crY08u6IV6zGzAfl1K5RR/srhMWHvwnJKY+kWPQQVRmD6vk0pCJpW0SYNp5cezY3+xCmye4pZ4QwVuCGYhnK8C5MdqRnqWCfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rymy+Di3gKjbpOt7vggNR07FAoNtjhNhbcGePn7XsrE=;
 b=qdTc9/jHS9De/3jBoLQjHdC55X7JR+Sf3SMvLHN1MiHjDxDlAqdBR/GeXOcS5hW8CHhEJnDfGH8j9ZXpjUILYQELVrYWgGty9dL07evc8zyQl++o65JZd8C9au5+8CSRwR3uqeqZHmNCRqu2ObRGiCp+kMRx6hXSFVMCv73ygDM7B1bs6yDzXUb0Mf60EYIsebMyWF3pCTagXFyya8Vvrtl9CEioSgEiYn55xC9aTx9SK95NDVQTy1cjorBM4HJOVnXGKl5+XU0piztUgpNNe/HIL4yDkG5y0WvdlEqyeM31462nwv4026u0uKx7mSZQfrKft4YclcboYCvgaxfVqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 02:56:27 +0000
Received: from CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de]) by CY8PR12MB8300.namprd12.prod.outlook.com
 ([fe80::ce75:8187:3ac3:c5de%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 02:56:25 +0000
Date: Mon, 27 Apr 2026 22:56:22 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>, Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suki K Poulose <suzuki.poulose@arm.com>, Tom Rix <trix@redhat.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Xu Yilun <yilun.xu@intel.com>, Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5/5] fpga: m10bmc-sec: switch show_canceled_csk() to
 using sysfs_emit()
Message-ID: <afAh1hq_mkRN3q2t@yury>
References: <20260303200842.124996-1-ynorov@nvidia.com>
 <20260303200842.124996-6-ynorov@nvidia.com>
 <acJWNRb1t96yu/H6@yilunxu-OptiPlex-7050>
 <acLaDFuCzt0d33Q_@yury>
 <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acON/EU/GFvxRO1e@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BN0PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:408:143::30) To CY8PR12MB8300.namprd12.prod.outlook.com
 (2603:10b6:930:7d::16)
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
X-MS-TrafficTypeDiagnostic: CY8PR12MB8300:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 56dd3ab1-3cab-4aa6-e0e3-08dea4d1bc60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yugtfAalFpypmSFlLPgPsXbJgBpUDtMyBUJwPOeNFsEahwUL6MlzaxNMHPBB9t5oc5IN87TyzfSl0MilRkyIqqvGHWyfeEjg8z0MBl7ZK6+72l9URv1zC+lfhlO+OBVnvAqhg4qiCEZC7hov617YK6O+K3kBHRzqql1m2bbkI2DgvNTRuXBcqF+Np6B2q8m/KG0JE7WRd5wmhO64hcPIEnNAD0H1rPn6cV32cb3yejd8ltdyyNsfBLVRRmxmYkDr7nOY29KygSIcOwpFW/rU0J3qZPaCJE0GoTGdq8lGTUcuPUrNhcMzdy/quEflt1Xz3ZKJh6D+gQWEUS1bfOUtC719iMlEmk7tdKpiMcuklKRMjkMNWD7MPnuq+/9V1zHJnTkGc+gwk3ukyAkrPB8YKzwcOIfYt4AhqVYJ+RGxOgt/sN9enSbheKS8mFMeNL+MVO0VW45b10yhpg0P2ESWgK8+XgwEyft0/AqWCeAdrfmWm0EhNmFDlxzlFZGSYjk+w0+9p0ATCuQmM18xbakK4/AJS1dt3cBwLdWeThiTOy9VSNur7gIsoZSa9TVfiuzc4fKYFJCoUNjjaU4mVzpWsnTEqbzn9gxx+4URKT4i4AqwoAy7Ywdnm2IR7FbMn7vwPqwEAIeyot/f228ccdT/qRmdRoxw94iQXZZj/9F4vXNSp5mTLhQOgMTglkdORGeOKUfxTHX0T8Rva+WkZy6bcYAMFwFOw9HpKo/Anh5y7NA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8300.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?a9sVNbeC+t2hNjsRzjrTXaHHZePkDI9+wedrs9XTeWgq+cPR5gaUpUQ4JG?=
 =?iso-8859-1?Q?KmbkGQgwP/BokO+N2cGukcyC87GQUBqhgllfx/aGsaoCRzFKbIfWq+dEso?=
 =?iso-8859-1?Q?YDqbl1VXfXgIRebCIfhGUZqMl9P9wdKQoSbOO7O7388PfeAG4vPSjvFB1s?=
 =?iso-8859-1?Q?4YOouF6p2keGQBoyq60GaGzS4fnCctTca+Nvnc3nfNS8JofIV0Qe8CXnvS?=
 =?iso-8859-1?Q?7jc5S2sD+VKLsMqaMQgNa4WmK4ogGBmYsCTd7B7NcO6T+iTXO67T1Lkm5y?=
 =?iso-8859-1?Q?gFY3Phe+RvqEuhd9/e7NJtPGrTB14jUVdaq2ot5KVcXAJKOS4cSk+wlyuM?=
 =?iso-8859-1?Q?ZvY0bngTRaubezb62USNMNSXM/eP3N/TMbINnaXf4frQxPFv0x88KDzqoH?=
 =?iso-8859-1?Q?fOT6a0Mrn/C71NMRZ/7YJemd0GFwI17fZvuwhP0dYxm1LgllcILo7qETI+?=
 =?iso-8859-1?Q?wUNr+Pcmx3rp3NGGw0ujIYcTQ5WP5T2f5Q8a7dmFlKWN3Bl0qPL08PHO6H?=
 =?iso-8859-1?Q?bRchHd+HRRqR4+i1f1NdoHDwEpuQNqPuhTieHbPcqUGfu5OiwyUckJk2/+?=
 =?iso-8859-1?Q?TTHjsHglYSZYxrY8zpuw3AavhIK+NnEyYJLw7yxHqY08LLYV/B+alMKJpU?=
 =?iso-8859-1?Q?4AiYEqy19Z6omnCMi/fw4MdIaK9sPI352yhL35lOYHD7yfOa3URGJpLp+R?=
 =?iso-8859-1?Q?tJWFWNrXcS4OX8hDGJ6XOdcNhW29YH1KSy1GvrfNvU4gzsXinc/I3naEfS?=
 =?iso-8859-1?Q?i4Zihqh6tghgxOPXvPdVxaHSFVFVkU53XuHYRcMNjNU740vHax0odFg3Cn?=
 =?iso-8859-1?Q?zNBXzICuwbg5zqw+YsCLPrlasb8rihNPgA5ogA0dCMa1vaRjS9EUMaRSc5?=
 =?iso-8859-1?Q?vR0xVaonhySr51LnJBlBGURg/oX99Wz3MMAWI+heBqXvNAVeP6MS84dYwl?=
 =?iso-8859-1?Q?PkdLDAPEX2tKhos1ea9Zi4e5se5wf+GClEtxKjJisIcV5w23yBK+yEAspE?=
 =?iso-8859-1?Q?ZhR1RYPPAHJmz8wwcuSVFpk9/mWsNvlL/1e6UQr+p43YGbw2y1oKwA7SwV?=
 =?iso-8859-1?Q?z8PqaAP0FaMemjdCIROwALzgSUMWhVsoA7z0yGzDUYiiBe4P2WIf9dVNVC?=
 =?iso-8859-1?Q?nDSX8tQ4AQT3Bz2k7/FmNE2Thevgi8lEDW1HoebFHtwumrbJt//1DIsmTr?=
 =?iso-8859-1?Q?pSbYIzxxBoqFDLfmAyVfMLyt4CUXS+2j1lGkBnF7R0wszLVmvYIihwHt1n?=
 =?iso-8859-1?Q?p3OcTGxTqlt9TBnaKQ5fYtudINLf1bkjtQQkTChU5vkAUJqfV8RuwXVYqA?=
 =?iso-8859-1?Q?+Uvusqv2GbJFyGeC3PHAxW8lvw/me+f5Ya7Wyv7AS9djlVlJwQWNR7gBFa?=
 =?iso-8859-1?Q?vRKT7RWdB32vN0MiFZGgcTqbZL+d2bQMqJ6HAwHXd4yocHUPNJjOHHhiq+?=
 =?iso-8859-1?Q?VU4JgjOg7InydqWiDEzsw2bVnAAyZU/1pqcBnIMNFMWjKPnO+YO5GOnwWB?=
 =?iso-8859-1?Q?E8gks0DMIFDd69uz7zlUzk9ZzRGUlfUusR00oZdj+FewUq5kMRCrhjrbPk?=
 =?iso-8859-1?Q?rjyRLtv23GlwbK++XlKvheBz1Es7oCzjUSzZEY9VO8Iu7wryZcHo6eDd3o?=
 =?iso-8859-1?Q?UR7p4gM3YhYn4UzIIJPOmhgYJdcLcIJ/9bznNv6PXkr1mzS/lZYMCHVjtG?=
 =?iso-8859-1?Q?LLZjoBEEMAb58xOKZwnGkbDIuU0BSbyF4V/DOYoY7shLZond1qsfF47XT0?=
 =?iso-8859-1?Q?7BcIeaKIprQrtN/ZAcGgDVs/exUAprxy/DQJGprhq9+pZIvlRWm4qGhjA1?=
 =?iso-8859-1?Q?C+0hj/hiU6149HI6CfoYMALDYTGB9lbPL1SRBGb3BwCTkKLDDw/p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dd3ab1-3cab-4aa6-e0e3-08dea4d1bc60
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8300.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 02:56:25.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hw0EAIMJX4BAZZWEG3tnfhHtaBaFG+zYg5X/OypBYsKqX8wtWmw74mltiDKA7dU/vgBYae2fZlk2EnhhdLplzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

On Wed, Mar 25, 2026 at 03:25:48PM +0800, Xu Yilun wrote:
> On Tue, Mar 24, 2026 at 02:38:04PM -0400, Yury Norov wrote:
> > On Tue, Mar 24, 2026 at 05:15:33PM +0800, Xu Yilun wrote:
> > > On Tue, Mar 03, 2026 at 03:08:41PM -0500, Yury Norov wrote:
> > > > Switch show_canceled_csk() to use the proper sysfs_emit("%*pbl").
> > > > 
> > > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > > > Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > Signed-off-by: Yury Norov <ynorov@nvidia.com>
> > > > ---
> > > >  drivers/fpga/intel-m10-bmc-sec-update.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > index 10f678b9ed36..ae364c6636eb 100644
> > > > --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <linux/firmware.h>
> > > >  #include <linux/mfd/intel-m10-bmc.h>
> > > >  #include <linux/mod_devicetable.h>
> > > > +#include <linux/mm.h>
> > > 
> > > Why add this header file?
> > 
> > When I was preparing the series, I had build issues without this. But
> > now I checked it against -rc5, and it's clean. Would you like me to
> > resend?
> 
> No need. Given that I'll pick this patch alone to fpga for-next with the
> fix.
> 
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Hi Xu,

This patch is still not applied. This is the last non-lib user of
the bitmap_print_to_pagebuf(), and it blocks me from removing the
function.

Are you still going to pick it yourself? I can move the patch with
bitmap-for-next if you prefer.

Thanks,
Yury

