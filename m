Return-Path: <linuxppc-dev+bounces-18414-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1179C1088E6C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 03:37:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbrwz0P8Bz2yr9;
	Thu, 19 Mar 2026 14:37:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773891442;
	cv=pass; b=l+GkgCKlGYWmeSO+aHgWy7dVPmGQWY/HGu1TxoppI+aR99wNVpj8cmIQHE8uHffxDfgJusqN9cgrygKtkcPsry1j5y84e0z2t0Osi9WascnHOG5qtquB3Ds5Dlweu0FwWqtpb1nztnTyHFhwH1Ly44OqscrvKMQibdZXhRXbpGefo8vHkWkXq0CXkciYQJemRi5FSAls8Eg7iDoev53xPjSEk2qms//+fnCxBw29G4wDeZ6TBW6x/VPNXWD6Vl3f6LQ8NPiXxm1QbuYMyUzyjeEdJJx6s3M+bgMSPiHI1jLCRmPchyviEfSUfKnEI8Q1iat1/bW4AzE0Ga3DniMwCA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773891442; c=relaxed/relaxed;
	bh=3IER9p+mDI1F3D6BQZH4KGfcsMhix8+8DRdKC5N0HzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SV1YZglu/5dZbfha01MipHXzhbX5I17c+xEqLiqCr0c+jsoMFF3FyIABmsqPtUFNUV7Bnt2Dl3yDvTUrtVzrWx9CPfp/uZIdrlPuJ6YR2/MaXkrifqFPdlLVe9/FWeTd6B6tTtb3jiEvWyHNizW3DFQJ0Du35Nq8GP+D/c2MaD3aBoR2xswlcTMa365Ry43+NjenHxYrziPVKd7iV13bXxPO3jZP8VIoZ5bHxLzcmOq5ga13GpgbjAqMrXGE9b0s4hqMO1plemSEyqy4bdYbfUYheCyphsYx2N7MfnysEY6M2w/xBP0XOxIQjG97Mdlpib8bbTUOoa+T8bk0eHOQYQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Rzd51ag+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Rzd51ag+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbrwy2Qpqz2yqT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 14:37:22 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9cEGQ5zzv/AaGIdrjpGW5/yAx/cphHkdRi6hhhOND7X7en++157us/irxz6Cmw2+8jqoA+QFfOIkNnB1qkhDwrGgpqNUlmlBq0Ynxt+3GFLBGmeQvoZ42D6tNEAE0IIVeOBhB5SvZ99cv8Dq8waT+Wubahu2Zol+JbsuUE+oSZldvXt76fcI0TP07kWxVd5o9A2bTQBMSpPIO/Ps66tXjLPAhGnLfLuah+GGos8x76O57koFXCyTkTKi0+iZtvIIdY7KOdTP6uxS5pb5ZycgYuEd9DKluvARKZj+mjrYFQcjSPP/Y1SpOUz2cUckBguUYBg/RPreXUJF5UY8SAYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IER9p+mDI1F3D6BQZH4KGfcsMhix8+8DRdKC5N0HzU=;
 b=VQ/JQ1WMtIF/wjb9YUaWnnC1timE4OKrrr5LfUshEpJMYu9r8IfzQLf5hHmZ98soZtC52X0bNCB010yE/DtZbY+T/S0u9+F8KNjIeDrGafDe4ftARNRnkcEGmzq1sUrQcLn5oKoaFi0Xl8bfpARXB1F8TcoraR1RFFylRIcIVJKqrXz75zAH+eud+n5/SxqphkDHfymuoJQExUDXh29Lx9o+INhcDJf0zH2B9nRKbQShVC0X48vUJr0D5HQkzuO/t9nAh9+lYPE2cNS4w6hiN9W7cYmhlcT/KqLJUsJAOoa1Kk6ciZqYyyB5U6bSXFOtf1+9oQ5wyeT1LBpDel+3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IER9p+mDI1F3D6BQZH4KGfcsMhix8+8DRdKC5N0HzU=;
 b=Rzd51ag+zJwGJhb7tiNYkVUk+65HOVhAxRXlrtS9GT6F2jHH6eLlOfeg5M39id1WeFFiZGlE8qoqObWIezELhU8q4SNwxSsEo6WupQERuB/khQ5rX4AZY3znhqnU8CwQ7xbNcUWe7pmE2JZLKd15fFyISW8pR4UfYPaChToTgrRFK1Fnh4k8j+rUCZQ/Vg8gdIT1MvIPntvHvU2EIc4/otyrRMbTn7Eiaa19uINy6HANq5KRA2eUgoX2tkPT9ExWxiLS90QeCiiP0foqDnTEaKAu7uBe6es/xCnduzkNPV31987JJxXDzlVmtHyTFjwCTHpqXtmhJRdnv4dmCl57SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:36:55 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:36:55 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Yury Norov <ynorov@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/2] powerpc/xive: rework xive_find_target_in_mask()
Date: Wed, 18 Mar 2026 23:36:46 -0400
Message-ID: <20260319033647.881246-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319033647.881246-1-ynorov@nvidia.com>
References: <20260319033647.881246-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:408:e8::23) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: fb84cb08-3a08-4a82-46d3-08de8568c483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	QVpQ+BUtkrfUTVpfAuQwMTBY2uv/1oB5lzgB5wBE1p3uHSzhNeaW2bFiW2DRmDmnRP7kj8sH9cL9mPUiqHs3oYIsk9XFjpMdd4ZlNctKmXlV30/FfOPc0I3At0x96JDnhUgyQrLCTyclSQUwQoCJjQEMufy0I3fWZj+0tQDRsrPhlzbzVOhohhtESURAQRfsBzGkHDRaI+lODIWum6HPbHfubsk8dsPhrU8Yd8Ua5zCA+JlNZMxlEkPkKFsw/AxPK3fLPzPb3IiTxC2UIldz0kWd6ttaYQ3TwaAgxZIY7mSB2UU0HDS5MfdE4y5SpCnr6D46h7xoryYzI3VZdqAfVeKA83GunH62ZuE3Sut8onwERhZLc7fKxdDQO4v7XrvaFqXWpec9EpdPYu842LyvGHL33Nv5aOYkf5HUPenoPj+L2Bay7EBFT4lyMV6XjGEo3cTtr87XC+t92cEkI649UW4IOtPod9e7GqpUebTtEtjuyJom+qO8F1TzXyO+/YlUz1TYg9CjCU+/5tC+mUaUHp8R7AMO5ByL5g0CcDH/oGN3+ud8cwJCgi/gA0pjk3o7q18J8XWLx+98ewIFo92txRzEEsyTY50T0RdCceMUxBbu8GWR692h+0Y8QjNsTuj09YBab8+N7wFzSPhRc8tOtQ6TXRlXl2w1RqOBhpX8NcoMDC1B0o9TAyXimVRLvJCLkYmqABD9GJGXrPrYZ5mCjZSovBM2lPLiSdvY/oZxpW5RIimEPXU997mqTo+dFXnLCSwYBVSODkvmNYjgtK1l+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jQFkHFMor5Q5HKNv8Ubp9NPnphVmN3yc7qjw4LqfA3SOT6doZmb+Kh7igb+7?=
 =?us-ascii?Q?ae0dxTmFppSFOPAY5HPwZlsKaVk1vK1V5gyY+OzMY1iKQjD1Iu0lP9DTOLy9?=
 =?us-ascii?Q?N0QWCVGBD4052Dp8tuNLntWK7z9uq+hD5WowmHwZEHVKG0xWTmj2yIfTXqtD?=
 =?us-ascii?Q?6IelF96Nr2mIgMF3QTQ83Yxq8VXqaZ2pSIp5C5dNfpgMKLQKplWG3cvmoBk+?=
 =?us-ascii?Q?HysMo9aWjVHqB/nVevZvteRGoqux6GVUU4S90Xnz+DMoH9d8Zj2TGydjdKhF?=
 =?us-ascii?Q?QTRkp90lWUhKu7ie90b/kQMt7FNk84wkAP6+kaexXTaduCWYaPmmL8B5T0KE?=
 =?us-ascii?Q?HfDljUodhpJKEvEjzkWN3pviIg+o4mhlSPJV5t2VKDWsJg3cfcADNs3VyUYt?=
 =?us-ascii?Q?4Ia3smUju9mINomWwXk2As6OTYcE1Uww032tYpLr1A/eq2uH1BMRmQcinySo?=
 =?us-ascii?Q?wRm5fq1x/htNQcr0YvSA4+bChkYy+8kJR7Hi+5YdEr00mfM5d4SUiA4yxeIX?=
 =?us-ascii?Q?jS0idaZX+SC3dct1X6faeCFKuw3FDxSegDS52QD4YYFBTP4nzRA7GzxSuNsi?=
 =?us-ascii?Q?hr31aKXw9GTwrA8NcV+utmlTSxKUqHDDj3QGgu6p6cXej+7/2Jd3gOnQJuHT?=
 =?us-ascii?Q?yUXVxfSEMlMP60pgxb3jp13isCGZ6SArY+4u++gUAW53Vu34NzPJQUxgTIb0?=
 =?us-ascii?Q?M8CflzJNGrdaU+Filw0/vKnET0kNri1eYdJJFAOfixX1ynxbKkuf6Qg3Sn2G?=
 =?us-ascii?Q?P5kTfKVSSjB60fr21N7DTAfLD7W6PMAbMvZS3XCsBdxJLJ7tI5jz4ijPh664?=
 =?us-ascii?Q?xzq/9hYt+zmGvqQS0YHRgNDiHwOIDGMGaDZikbz1Qj6A8jMHZOWwb1r2pONF?=
 =?us-ascii?Q?MJdo0xw0osCvjHGUGnxR825lOOHT+ylNOxGqoQOKyDxsFWVVwiIn91pCW+dK?=
 =?us-ascii?Q?jbA6lBIzuPunmYHdOmPXe+uEJ9hvRMNNWwdhHDyBgequtgaHaQrMi8RCgg9+?=
 =?us-ascii?Q?DZNn7n367kkkAY64GEBG/DwqKpMJmytjCljmVeieAnSRxkV7sz+xFc/kPZ7O?=
 =?us-ascii?Q?0wZIq/Z8FesMhHa+0Rpe7nsYKWY/9LbBeCG3S9jTuLjynMP+cv5pFq15sPum?=
 =?us-ascii?Q?Q+5sKZ6l+N8FdofTjNpJ3EJetbz5KXJUZS1POOJo1GdgR3PHFDHOkr9+JzqX?=
 =?us-ascii?Q?roY57cgaCOa5lfcnQtSKLDUupUYNHsn7n5Ujk+xPXDsgCsyt08m8BtebAZZb?=
 =?us-ascii?Q?qQzEFxtBu0ZdYiSXX00rZK9YAfvG5SSUyI+WPZdUdF0aBqf3BwBWrwTCyOVc?=
 =?us-ascii?Q?X+MvO5RR1q/muR61AcZkEE1MzU/yRStmUaA7NdrKuMpsFDkWAnF6XLgCg2oO?=
 =?us-ascii?Q?iVGO98Q8gzTqWyhTIZAK8Uy0uesVyI7iDlIeh8QaGhaO+TO1EuAVpNSfGCst?=
 =?us-ascii?Q?p5Lwya4q6zBYfDGFho46aL+qqyIx6CrT+OJjiB8GmUt0E6/aR4h/B5FxgR5T?=
 =?us-ascii?Q?4pxDKJXypAiV7la+REhWn4U3TyhV9c5/9LnaxAPLw7YsfrWJccftJukjVdEC?=
 =?us-ascii?Q?mpu5xVSrsUVetkO21dYvANn1ml+ETY6GwZHdNqh7+UYimH/OtG08PbutOxoe?=
 =?us-ascii?Q?jphpkxYNYv7QAzbzi8yR7J0hIpaYM62PkeZhu5fsWtW/njTsRkUJ9J6rWIwX?=
 =?us-ascii?Q?rnLwprTPOxPeVRXTmYj0vsJEufWCkNhdUgAO2NUimLEahOzSy9wYo/ZAytlS?=
 =?us-ascii?Q?kqtc2kTSAg+DFC92Y1WyCMak2Ilw85tTIckXBp5l09/Jc/r3Hx9R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb84cb08-3a08-4a82-46d3-08de8568c483
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:36:55.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xoj4+WljdA1feVA6XfljvhixYAM36yarYFTyIcW4mHmVMB5JztQZUtWyUJF8Th1QPzKPbp2x+fcIm4Fze6Fx+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

Switch the function to using modern cpumask API and drop most of the
housekeeping code.

Notice, if first >= nr_cpu_ids, for_each_cpu_wrap() iterator behaves just
like for_each_cpu(), i.e. begins from 0. So even if WARN_ON() is triggered,
no special handling is needed.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 arch/powerpc/sysdev/xive/common.c | 31 ++++++-------------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e91ec9036ad8..4e05f678e171 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -548,40 +548,21 @@ static void xive_dec_target_count(int cpu)
 static int xive_find_target_in_mask(const struct cpumask *mask,
 				    unsigned int fuzz)
 {
-	int cpu, first, num, i;
+	int cpu, first;
 
 	/* Pick up a starting point CPU in the mask based on  fuzz */
-	num = cpumask_weight(mask);
-	first = fuzz % num;
-
-	/* Locate it */
-	cpu = cpumask_first(mask);
-	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
-		cpu = cpumask_next(cpu, mask);
-
-	/* Sanity check */
-	if (WARN_ON(cpu >= nr_cpu_ids))
-		cpu = cpumask_first(cpu_online_mask);
-
-	/* Remember first one to handle wrap-around */
-	first = cpu;
+	fuzz %= cpumask_weight(mask);
+	first = cpumask_nth(fuzz, mask);
+	WARN_ON(first >= nr_cpu_ids);
 
 	/*
 	 * Now go through the entire mask until we find a valid
 	 * target.
 	 */
-	do {
-		/*
-		 * We re-check online as the fallback case passes us
-		 * an untested affinity mask
-		 */
+	for_each_cpu_wrap(cpu, mask, first) {
 		if (cpu_online(cpu) && xive_try_pick_target(cpu))
 			return cpu;
-		cpu = cpumask_next(cpu, mask);
-		/* Wrap around */
-		if (cpu >= nr_cpu_ids)
-			cpu = cpumask_first(mask);
-	} while (cpu != first);
+	}
 
 	return -1;
 }
-- 
2.43.0


