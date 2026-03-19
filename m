Return-Path: <linuxppc-dev+bounces-18413-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A648B1088E6C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 03:37:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbrwy1060z2ypk;
	Thu, 19 Mar 2026 14:37:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773891442;
	cv=pass; b=Sggy7BVw54saMK4Q+K3JGW25f0s6FfK08vGcytflATFLfZ79vuXzl5PJzPavMJVvVYjthnCSe1PYY3kwZN+d9/qvisUe/tMqXQlOKJQraaSOeASo6d+d+U77gPInATHvO8Ciny8KKMaiFswdDZZXyPVC2Rd4OCcfk+GC0Ob8DNPQV9hL4wm3RCwGVpNeahznJ+Ch/mGlPy7mIGc8dQGCflEzpwB+S1S/cQ4pnifxS/u2kqOlEjs+OfK7rp7UeZVtF7iRspu8u1+QbjjWzh6uRou3Bm3iv+VSeDSSflH2el97H/GHLwmTzg42Bgscx6NyzAdEuSIfqS5oL1eG8N2BpQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773891442; c=relaxed/relaxed;
	bh=fIRtjprekt3sjms8lcbaPz8KzLbwVpjx5svOpUIs6gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKpkUdgK+AvtmqybhEv2WV+Ov7OTz/+JhyjqcGIx6Qd2SFYCbqqMMkP7axi3oGEj5VdT/TH4dvtOJVUe8vLs+MWz+uXSU45HXhHMvI1i3d8lBVGZqeNKuLp/FoZ6FlPCafd/Ey4CRnH/4ofQiFvgDiBt983A+wwSKIyIGh5QBmBfJ+GmiS8nqMeOy7Jo22g1NdsoppITodWtAkaZ+kxDcnTO3UWIUAuL/3cMsV2XI757TyF+u/erYJ7dELF2PWf/95MYaKma4VqhBmO0EW2j3f7+qNrpzom6lzlSQSVg/obMtfzg5gPo1s8BUg7yCPfE+ifrDSxLO5OzGDWk+aPmhw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IEAkzkWu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IEAkzkWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbrwx2hnsz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 14:37:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPMyMQnUM9op5M17EhGfN2NHlFBsxfcS9xC1UGZO37jOgnOE6THktzgwdAgdlPIcEe/ISlu3fuWZ65WXH8a2QW+9HkHWwcgono18PAwzEnLwEQ3S4BZYGs0ZsHqwUMnb2FkWSx4QwqC/+8YizhhjS6i9Y3wa42LqeFKW0IpUM36Igx6RV2lKXtMviwnUPoGrKtlvPuJRDdx3IoZDZpB7jVmvPWLC6D7j8waj82x7mbvs5jN9YT6j7FBvvLWtOlFipYeGiL/+I9FcBA5N3SCLpmot6afLIHuNuwCBn9v3yQPUBSTbBqme68DAVw1DZ3OWuG/TzDMayHSwiqw/ZWrXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIRtjprekt3sjms8lcbaPz8KzLbwVpjx5svOpUIs6gM=;
 b=sFf1hpMzpSRVOLILLzjWCit8nV/w2oIQdaW0KPKFPWG+xdott3uHdCLEqUyPbVzh5vf6yAoxXIPY62EMeysDlv1dVPJeXfpDr8U/i98gE141IVsq5laDrSXemxuS/C44EXsqzUpNsSOe+1/A6vMmaTGMUOcRgO0Y8wDdkG5OyZYP8m39xiuP1a1De4PCCxajMYXupP3szXifUnKcK6Fexz6Jp1HhpfY02UfqpbIwOpQbIRzdMcgqe+qzo3vIzcMh0Mmc5ZrVavoJ0mzjA/AUM/+n8zj6kwenoslaLBhmGhQ0gAY9QL/acMVEoqOG40U9KVUYe6Ee/9YwPbA0ftGXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIRtjprekt3sjms8lcbaPz8KzLbwVpjx5svOpUIs6gM=;
 b=IEAkzkWumN7ADwpsJKIbXEAkSyzxFYs0aLdhKpTJk+BU3/VCrieQlAskDcfwksoZoZuC0JK5kJkoVixcf/2YQBqbfuVH3Y1V8kL1oa50b599JwKlsk8ApbE3pjzkBZLGkxwT1wggM/iX9gDeGOsYqO1jdilnBgvarJa6K9ReZBdJYPA2pUiILqJ5IHVtJObDjSSSnAouf99+df2FBWiX/OmoVroLY8ncxJ6GdD1kVmZqQx7pgO8s/Zm+RJEBrWxv26LfYg84VWnDKO6UqXvQWSIimMamBs4E2KWOAdK15EgF1OTB9YPSmXQ306zPP5J31fti8KvwiueDlUS6bPcY5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:36:53 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 03:36:53 +0000
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
Subject: [PATCH 1/2] Revert "powerpc/xive: Fix the size of the cpumask used in xive_find_target_in_mask()"
Date: Wed, 18 Mar 2026 23:36:45 -0400
Message-ID: <20260319033647.881246-2-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319033647.881246-1-ynorov@nvidia.com>
References: <20260319033647.881246-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0962.namprd03.prod.outlook.com
 (2603:10b6:408:109::7) To PH0PR12MB8800.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 01c8c2c6-398c-49aa-076f-08de8568c344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	4n/bnNeI6RNRLryim342thOAJHRedHNKnKMqegUwzlOWjx3S6g7tEG3xgCkADhg2lnESaBY+SQI4puG8J23yqm+PObAE3uvYs7oQQW7wg00nrX1juOs3I8I07ARTVnAx6U8jVTAo1P4tUfW1h1K3Wix8UPEscmQ5ykdDv9gNk2hu7p9slmW3DDQz5Yo5cWgBzKexfm2ES8yD1PtSIDBm5esJBepKkKXpjdkK1/JCEBjOZFZRWLSh7zx9jHMHoX14emOn5Ce6qNPtr1OrlLH8aUIvR73Yet+lSCpjialsM65YkbMNZ2smuIEYLdtU0z8Wf6Mq+uOrF0gmXzXc9OYa7OvXGjOkIYlJA8xDCnbPWKzHCjC4rsKD+qlCRrKbsiibCgzZKFDMUubo0a0eCqcvZusDaJ8V0asMUG5L3Tf4lt0Iv/KeYoN4djcir+R4yC2vh8TWwHjXDWLVmogNbI+T0+QqSgTBdF83veJCav6BUqDSHTJ34BTlIk9btL/6jt47tQwyWLnxTdQ8MTA3NCcEB3lY9FpzF7RCCENNlxvVqpjAkYG2s/g2MHqB9HygRpPx9QV4ivgSZo8zm4HmoBBKUys/587KecXqfUgoJqvcAWEphI9ZIWL8mXG9kKivFO8EHnb3qiy678037kXHTwxesPt3fOUsjcl9W4RUBjwuvRbQts1acQTXsyQjKSaawCECTseyy18Lh8PvqC2WKt/Kg0deBb7kw+RBQSlNyRVu0ouSf1nnr2Lj+DIAagK4WtM0U9Dg/sD0HFOjc3A+gidhfKUXF5MZhoxTnfS6zLRnWSY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Bcqe+ddoAZomTX1jG5J8BzuSHXYGpYyWLRunB2Ml6HRJMupuXPnXCIWuNoS?=
 =?us-ascii?Q?iAOGrvzLeP7OVmvrFr6/Oy19KPrguk8gDcJSQ3qMFpiu8FBAiBgJizREa6hn?=
 =?us-ascii?Q?v2USjP3ACkW3CKxgwcm0AS5FjQ08JhVY5oflsdBTzTa6YBowsTJSUBRKq4Yr?=
 =?us-ascii?Q?sMo8gsM3EaMXiRlMtRBd2i+svz4BAjXXzOlO/EoRpyum6F93nWQ9zAkD5VlK?=
 =?us-ascii?Q?CnX0yKLVsH4YUNaqcecjCX9MfZvAMO3ySbzV/0b8mtSJ7Ga5dRB7puwiykdF?=
 =?us-ascii?Q?DPUUTOjuxBi/ZHKhQ422Pxipv0Et1tRoNEelaQDhFA1aU8eHf1uTnAJuW7ic?=
 =?us-ascii?Q?Cc1QYTIgodphrvbxhCv2QAwb+/iz8cWk/cwCvjqcQA6C0sPfLoWx2BSpkiCb?=
 =?us-ascii?Q?/xozyhBXbB233r/nXgAc7q9WJtG6EjGTu7d4PnuKs5oTzDnIH+/5sRpgkN2M?=
 =?us-ascii?Q?FAcu0vR3HqTXLz7uuQzpoqN5STePq8zBrtpVMA2CJatp1d+mLUdQpT2cbAEx?=
 =?us-ascii?Q?F345cAmYn/IunoigeNmhUcqdYtMYivZqB6qIDqH2iy1u6uhfAPcisD61bL3W?=
 =?us-ascii?Q?vVSlOAmodX9k/k8fIiB7+eezSOzblRdHMVn5lwr/kR0l3NlgSBCGpHpK5V56?=
 =?us-ascii?Q?PdswKAkMw79CcraO4CsoaFwmzfSJC3evI4KHR2h6y+k3RbRxAVviA803wBC3?=
 =?us-ascii?Q?278dAq6MnifCmTIwVeMuPibFTmW7Q1f2RXFCyzeOTaAuvfb0l/bH0Xv4FI85?=
 =?us-ascii?Q?ChuEtq5xF3qFspo6cJduGKBbl7FnH2dyRL/Soyw5DxRztFh8/3P+J+fxOwCv?=
 =?us-ascii?Q?TMRsfeK+EruQgA2f9Ii/6Ydy8gMQoZA3gPULQkPC8u1EhgmtwW/eQ1G8n84M?=
 =?us-ascii?Q?q1CdjwRam6+3Md3dZ9/UUNDu28HlVzfvFhW1kZ8Ga/6Gtz0kF+DqnZVUQ57l?=
 =?us-ascii?Q?YEzs6L+fwRYklzOvCwpLHsX9O20a+wJwnwyRxjXpGAtkso7qHgZ79f+cb6uj?=
 =?us-ascii?Q?kU36jNYj45sbOnFEPpv35RPJTAXU1F5W5qEKNy72a7VVkemZlKh38SEctU0V?=
 =?us-ascii?Q?sbqCtCHSQT24mWNLr7jsk3AgnZCsFY+La/DcJ/3A3lA46YE0p3Rhkr1uvZMA?=
 =?us-ascii?Q?of8uVbHHsPWW0awPpLbrDxvwgl2Ka66xksZKLC66N8tfoegescTYzl2BAvjH?=
 =?us-ascii?Q?nr5ZpByR1M14Qi40xAqEUsgokm3Yu0Ldu03U/j7xhWsNOXvfsAWqmGobVSNK?=
 =?us-ascii?Q?NGMNfPg6YiOu5+ZsDzUTefpQGpSjtakZhYViItbTVvr0UIMlypotjsPmKK0c?=
 =?us-ascii?Q?um9m/CopfKLJ7Bhd2cHJdi73AiNI5YoSiY2+nnlZvTndwbI7whOCuGaXgc7v?=
 =?us-ascii?Q?IS6mHo1lveRc7IBnPBOJXamuSzOEH2vIIaIFE1iatSWpbmH5gyKIG1/qTYLn?=
 =?us-ascii?Q?KawJyOnqOfFChTlfzUE8jdx7WHlmxaeaabeLMd1o/JfOzXl1DyiZdeObgz87?=
 =?us-ascii?Q?r9/8q+vApeLL6SsUqyJtx08+zZ/auxDc3ECR4A6KeJSipg53ss2ZCFdzcPNC?=
 =?us-ascii?Q?7txCCd/WcK14cVwzDiLY7o6RnthgI6mVN1V+szHrE0rRxtmmj9WLFffCjwLH?=
 =?us-ascii?Q?bgb6b7pCzACi4CGTzSKN9N0vDFl4FiAR03ux5sdsvUC0j5o/eM0ShjLLhTJt?=
 =?us-ascii?Q?3dz8WyWdogMPTuOKtRHQnbDGwGLiyiyo4lxtOxseSvZaS2VfzAvK5s87t+F8?=
 =?us-ascii?Q?Ua50hVih4dV8/4VsNv+tHnVV1Bi6wuKRL5CVhXdhy6qxrqWDRsJr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c8c2c6-398c-49aa-076f-08de8568c344
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 03:36:53.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrC1X6S6NFaaBD++c96ZhDdQboM2ZJGG+GoFLwbCszFeOd1JBPxVHoskUClov075ByHtPCF2rrCjtsAB9QaXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199

This reverts commit a9dadc1c512807f955f0799e85830b420da47932.

The commit message states: 

    When called from xive_irq_startup(), the size of the cpumask can be
    larger than nr_cpu_ids. This can result in a WARN_ON.
    [...]
    This happens because we're being called with our affinity mask set to
    irq_default_affinity. That in turn was populated using
    cpumask_setall(), which sets NR_CPUs worth of bits, not nr_cpu_ids
    worth. Finally cpumask_weight() will return > nr_cpu_ids when passed a
    mask which has > nr_cpu_ids bits set.

In modern kernel, cpumask_weight() can't return > nr_cpu_ids.

In inline case, cpumask_setall() explicitly clears all bits above
nr_cpu_ids, see commit 63355b9884b3 ("cpumask: be more careful with
'cpumask_setall()'"). So, despite that cpumask_weight() is passed
with small_cpumask_bits, which is NR_CPUS in this case, it can't
count over the nr_cpu_ids.

In outline case, cpumask_setall() may set bits beyond the limit up to
the next byte alignment, but in this case small_cpumask_bits is wired
to nr_cpu_ids, thus making overcounting impossible.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---

I've added some explicit tests for cpumask_weight() to make sure:
https://lore.kernel.org/all/20260319004349.849281-1-ynorov@nvidia.com/

 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index e1a4f8a97393..e91ec9036ad8 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -551,7 +551,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
 	int cpu, first, num, i;
 
 	/* Pick up a starting point CPU in the mask based on  fuzz */
-	num = min_t(int, cpumask_weight(mask), nr_cpu_ids);
+	num = cpumask_weight(mask);
 	first = fuzz % num;
 
 	/* Locate it */
-- 
2.43.0


