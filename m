Return-Path: <linuxppc-dev+bounces-27790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A02FC982CC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2026 02:29:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnVg04wt3z2y8G;
	Sun, 20 Sep 2026 12:29:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789871356;
	cv=pass; b=BD97Qz8Xfi4k21sSW6jURcH9xUhtQ6bppEmMhgQxn4Qcfy9rgbtJ0dyzpi2YvMI8cxM73aD4fRODp5/hRSzVx5LR6YO39o8DkkUwr1Ep/hFV2wvDG4Xj5Mfk5yeEJIbpoRpPLBnx4u23ctSjvPCr8Gp7spKr+QHOgUY3hVZIihfCKq9eJGX5rgDGQclAVSBIvo2dAqOmhOKjor079SUnWdAZDbpCO48Gkm3gukIYTGwUsKyrCooYkhY32eNzgOtGn9/AbuqpMAuLIEBE7f84hGwL+DtEst0gW/GqD1veTcmsxyEm1Do4tuwvOaHk2jv8zLDxi/WvkR7nCaxF2L7hrw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789871356; c=relaxed/relaxed;
	bh=cnisPdoVhZsxKLwg0yqAtYkm/XdJZgGFGUYT8RLQDUA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OxjZiccL3/TnWoQoZVJ1CgT5FohSSXlauEgArY9hgGx8+5oO+s2ROUCjqGi884tDPk8q+68Gtg3d41jxcA+S4UMEnog/cUM0pj5nUWoqh3TxE6GSDvd6trOxnKvmCUGe5COY7XAc2p/wgCHjEBFf8pB8bGRXSjOaWVecW3yBhDbbRNUGYq1jgXRbccLmMzSPUcHfoWtnd6EzdsjlaOTEQtmc4D0QS0Z1LMWHEpXu0UPJqEmQMbOMaXy5A89X/1JCtU5ictlBxB4s381ZR7+ZpUwnpcBwLaDW7DjAqJA9FPDe3nM4SXpc7VDhFPRuwsL8xqu2ghPZsdCUgKS2uV9OPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WTLp91QF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=WTLp91QF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hnVfz1MBjz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 12:29:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnv7ZyfpF1tYv9hDICJmeAdY01lfLGx+QIb/NSRNFvOsqqPgVbKeKKnRix8G6CquMtUE6GzAL9nxAjNJSkDcqwhja35XHt5D71n6z08sU6tYE6G/C0oTJ3LKYyW1qiY0rGb6Yy4uTS9UebTPx5eIjDGt70vvPyihqil3u+iZpSXKsbwACk4g5Pgy+YbZfE4kkzONf/4bZ3IwRrtFqr53PN94/VQe3+YtyNwEi6GEw3NaWQsm+zEnlj1fvdzqV4CSS0hhAUyV3XID/0YnsvKVem5uf69IB2N+L/6r63JPix1x2HYJMUBVbsa3FciUfrDlBkokG12QisyQPJ9ZsTtibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnisPdoVhZsxKLwg0yqAtYkm/XdJZgGFGUYT8RLQDUA=;
 b=l5QggW+ACvDnYZ0oIQYCkBc0rQLxsaamtoD/OJaPx7pwh95c2DbY1LsJIMKVGa4EgQfNQKMaDx0GR50dRo2/F9nm4bI0tlRro+SIz2voYmFzCa8KsaXkxpAstRIaeZK8qGZrJExtv2OkMEpSmLkzJtJuWpJ6XZaEBWh/SQd23toZcoaPG34WTFuZNGwN7KQP/Q843w+Jf5TxhNLobg6+gkwT+xcx7v6R6x2SBhTYzC1gJgla7if3UWm9kY5pU5HG0tkS5Sc/21DggCbXjZ94hA/OMZMeR2hAFW0s4H2Pb/PgmTcXz0z1XUNFlBP9xYrJffTXd/RZSpQznTzaapJkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnisPdoVhZsxKLwg0yqAtYkm/XdJZgGFGUYT8RLQDUA=;
 b=WTLp91QFRVn9B9Jfzi6QA53hv8cj6ghp/JHIuTmco6MnmzucZ+vgWf5fm/6Q5Jjl2e0I+qsPx66hD3hBeyAUXlORpddEQU35Li1m857T2tDhJNXjMaws2x3XKNPtTK6cw4R4B23VgIWgG8KHmiMDkcDnoK8kGz4DJfOnnh8wTsCc4/cVKdAzlSpA/E4iAWo4QuDgYMoq63U0VZSUdPwhQqwmMY4bU6kMNiwIplcK57la1NK6nIupy+VsSXwG44EvBTdTOkfCRUMEpXNf7SLrJeTcmMQ0xOt0hYKbCE0+RcQtUqUEkkYWU2YE+G5rCN0p11SHe+fRlnamByDvGwtuYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:28:48 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:28:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org
Subject: [PATCH] KVM: PPC: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:26:17 +0800
Message-ID: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 07395eaf-aa91-4370-7458-08df16bee700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	edjO5PQeb86jsraB2e+othd0sm0G3L2KrClQx9nR1Mzk1mzorxGXU/FVHMa++FfE2sgpEfjEGK1jrwwcYMYpxVJN+EQBUJRC+kJPlxMNuSdbQT34cBvtXmQQb4Rv6PCf3Fxsin4MlQ4YBsFkaE/Iga4CzONTu9vONpOQfvujoRl601qrpW+WivhPu0a96AEyef2MFqunGqf7lgkacUZCzMxP0d8FrCPBryPyFP6AEL1Uz3oB2LWtTlP4w/Pr3/RJr3hafqXZi4mMO+2likJYz72LaBy1+nxDbKS9ExVc+7x0/wA0nTS1DePK03HgbkXHvLWxVfIjqSd3h6QCFbwjFj15yqe7EjMpPJiPld8XVX02xQUfN1fKnV8rLov3InrjmRXk/+Pa5K68xMRL51Bed0l+3OUsgFZmBKqUJ7J4woYUC3pSQg8oCtSbc0iIHTjKKl81UQdGhr8uepvR0x/J/NQV3qJqxRDSqna3KU5fP8O2cV5eY7RVnFDhZA8PLvZ04nhi5r0AfkBeQW1W1A4WIiT+sULCmuSQmYczyBFWjF3jxCwCh1GRijt1bAZtKxzZFhfkSAu4Eo2d/58zQf64wDBWTVP8/gED2T3/AfFfDRbNaZf6JhA4Ba6GPW+yyzGfJEPW0Hl23OosmIE8HJUxWE7npkEEeP8KGn8ypA3Lsbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oMSJN+y6N2aoFoy4p66wjBIIU0tPrju7QV8XHIloQRaS9lfaXySSZGNLEBhw?=
 =?us-ascii?Q?cra/HE1Pdur52XWZ2kCaYHcrWXTUstMtsSMW345UY1LkZzEpJWxK2aHs1s7k?=
 =?us-ascii?Q?sfgzgN+KRqrK7cEX0b8xLyJfMSd06MoBhIxLZxniE34CKQKmpbgrfnNbVda+?=
 =?us-ascii?Q?p9AFjTg+1ORFd+dI5XMMs4UGtrk57KLzTiDVEDC7lnguZ6O+q9Fn19hXcd6u?=
 =?us-ascii?Q?aWxuq1yhC/aTgdogseOL7MF2ZRaaC/jOAk0IqVGB+FasQ/wbw0YC/IAvl7xN?=
 =?us-ascii?Q?JogjEYq/hhAxNU0MSc3CUBpf5y7wzP9SY+AkIQpfr9hzqORcx2zJXUF4dZzX?=
 =?us-ascii?Q?M4JBdX5qt9KFr6/9q6r5ewGLyJT9OZkM2b1ZXQAETBSYkUln3DTMNqBHX5eJ?=
 =?us-ascii?Q?PYyBQ6JTOGXXCLQagIl0u8wD6ju9Xt7T1BHor4onSdlpnboeDOMGEv3PD312?=
 =?us-ascii?Q?IMuXH4iMTFuj4OrcHNlb3bHZupKEgN3Sot1G9FO2RqvfmdpkwlYmoTfxKnA6?=
 =?us-ascii?Q?hLVS+MYvvapo3zZUwNunVDcHO6sst8lDedN2RS7K72/16tlpDOWqvX+JMPUe?=
 =?us-ascii?Q?MjE5WlJF9RAjl8Iz7aBYANoVE4L7TPuB+pXdxhvpcObQhUMlZl6TpeU+/a4n?=
 =?us-ascii?Q?Qst77ye5S4pL36K5gebi2FDYewtQZSteo35d7vYpfDAhE0JTBwrCLaeb+0Q3?=
 =?us-ascii?Q?Qc4i5Yj6BDokg74Swm6tysd6MT4E2L1EmBDLGuIVtopj0EsnM4wJFF57U5rZ?=
 =?us-ascii?Q?RQIjtW9zP/j47vQMxBZeGCs6BHxT/8OA7VpcLGEtlWOT4WNwlS/o8bVBVNXs?=
 =?us-ascii?Q?fYuXTW/x+aHTA52gfeE/Qw7soV7ErTabXPenfBV16FqMO5aR/v/ww/CbUg35?=
 =?us-ascii?Q?00TvQdTeU07+3CtYN9fCFJ8894mCERjNN3KkVnMr9J+DXa1PXQgWuHxfh1sB?=
 =?us-ascii?Q?8Isc9L5r2U74R7sPuKxARDkiEtHeQFffFwRXRHX7gi+4JJKPJeI9lTr6GqPr?=
 =?us-ascii?Q?yn6jRXz9GJPzlxd2MyGc693LT0iERlTdXjlGV0FQR1TL2rsJ34HUtigSZ2uJ?=
 =?us-ascii?Q?aVAXbRMipSz2eySAWYwIgTmjr7emp5gk0De1nD9GYiVkFxggsx88naD2ETGR?=
 =?us-ascii?Q?U+C2HfX/p1wAs1Q9CX4k1mW5W9v3qIcPxHQrhCOK8K7MpLZ4UusBP5t/jB42?=
 =?us-ascii?Q?fPzFqcj3+Q5WR9QOzz5z5eJ6vziAIzyiEP9Ag7ad5vBYevHpHiP9K1K6llRD?=
 =?us-ascii?Q?zXxSmmlpEPFLtJqud7EeWMAtoIkH3WbZKtU28yC9bXX9+w7z3y/ufVUgVeOu?=
 =?us-ascii?Q?UJgWJscOQ4jTV9FSoTMYprIQmTz6PZHfB9iHdcCnGTxPzSs13k8N98CgjuJh?=
 =?us-ascii?Q?vTbRulGP5eLD5oqluonbHWGqYsjtmlyu2YaNM2qJ2kMZYWkHf7BU35j7WhEw?=
 =?us-ascii?Q?mq6zpL/d6E7jipn0zt6HbWEjV+gSbGOJwG3xMxysf1FXNbkkpMP+Fs01atAB?=
 =?us-ascii?Q?9U7/CWfFY6/T5eSbZThsKmtJg9R3O+y9RykqPjPd1KUPATqQxAoB2c54oTLf?=
 =?us-ascii?Q?gRGpP1oBDZC5YdtU2bFeuKNz6o2ZGkkITBbaGu7bMr5VSNKyhVUbqf7R/jNs?=
 =?us-ascii?Q?Bx+7+chtVb4Wvh943eQmz7ILMyCsQZ5GLxdzcswvOxYpo4uY1G/HJbBXB46C?=
 =?us-ascii?Q?agoPLPzMvE+1R7E2xyunT4AE9iozCjCiCtZTTlsU//t9TlXE710SCoXZuqby?=
 =?us-ascii?Q?wdTREA+ct/SI2i+m77ZqMNKC08sA4nuLXVUQdYfOTX1+j4pAozcw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07395eaf-aa91-4370-7458-08df16bee700
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:28:48.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFlME0p0M+w/g/DL8oJGlopUnbFzaBw7NZ4AXap2vGlpb904UjXRdEAUO1cTQMdqyYpbLmgEQUk+iCAXpEZzpiUIUu/jrUBwtjmpfBIzqLwNHLrNiYFf5SlEyWuaisLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/powerpc/kvm/powerpc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 9194cf492d1c..a567b63a5f1f 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -2210,10 +2210,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			break;
 		if (!kvmppc_book3s_hcall_implemented(kvm, hcall))
 			break;
-		if (cap->args[1])
-			set_bit(hcall / 4, kvm->arch.enabled_hcalls);
-		else
-			clear_bit(hcall / 4, kvm->arch.enabled_hcalls);
+		assign_bit(hcall / 4, kvm->arch.enabled_hcalls, cap->args[1]);
 		r = 0;
 		break;
 	}
-- 
2.51.0


