Return-Path: <linuxppc-dev+bounces-19666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F92FEBFD0A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 07:51:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvKNY0pSDz2ykf;
	Mon, 13 Apr 2026 17:51:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776066685;
	cv=pass; b=iI+/xtEHafGOGsHzGkkdRLyau7reHGPzjbl8wvF9oYe9tKpAhBhbD1ECljvzG+czDWTqLWwRXzLRlLi/A+bXnYN9C2m3bkF0Vmya08NZRV9Y0EM1gz//bNpkywnWB4VN7oMJOCPIIqje1poyO2GKu2n8ug/r94+uEHwhU+4AK5hvLdqQ+pQyrESMvrFNO3B7Rs/ssKHUTC/uWJG8mvRbRhVU1HW6KukMKAgqaZa/i4pUziXuMZLvRQ/d2k37FXCeN9U+jKPL9cXBLsUBtP2HlsAO9TFwbAx7EImUHNR8Sql/jFXFRFRPLmNE1ieerr9PjGtKrxi4rH1DP68DWVU2rA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776066685; c=relaxed/relaxed;
	bh=do0AuH3dtvno41xfy3ln5li3TMODmlQ8+vENfvP3kfA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mP/mIl/sOyHYyr/QqR20NAt0fbZ8F4BMwkp4RYfhnlFaEsYpX05qYIO5acJridjnIXGYs/kpEOmdc3ocQsQak2S1JfbJDUvvkGEHzDsL+q2qq8A0mJhqkMKi5Z7hMN817ODnupXywZ7H5IVy9RqevUrXX8HcwAivEFXkvuDYN3zArD8viumuoCL+GW2Gouyb25TfGPOaffslR0D3AuMeMDace4MqQgmKcxrLguJDcdYOKd7oDFZD26PsSVQz0koseYSPYxus9BeRLRnb18RhBwxZcb6GSAuFOtjFNKd+QM8Oo/dYBhNcy3FzS1itd9whdh5g5XSUJ+OdCgc2ABq/Jg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=h6YBNbFm; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=h6YBNbFm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvKNW0fBjz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 17:51:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyHfM0yAD0CWk8uiSSjnGpBWQ8om/NvC2PG35hX0Z0jujr391exTeZKA/zowByXKlmX5h2DuaFOLMQ3WBvB40qc/kxmbCmU8jdnQXtdvB8z0q11p+NbxI1xCCbC/qcQFIDBs5fmaUB00Ydkm98ILDnFZRYbATF+x9stTQKqUnbb6/o+DXXxQZnA1vWLReT8B7iFsOy2YSGUDOqYlEPK+BRb08euXXInfm5zij4B8ISpfZmdAb07yS2UXvGXjWfRQQVSd0NT1aceOrxKvqYNdbyD0rgai75ECwPBLXQsnAwY5PXDYb+YSL8UyGNMT518yx/99nc6HEAYKOFGU571jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do0AuH3dtvno41xfy3ln5li3TMODmlQ8+vENfvP3kfA=;
 b=wJBXp0D4CLFWmik2j9mMBUOSSJqy0EzGnO6ut3KbgjevdpaIKpw2L4ogLpveqM/N4tyjPtjslYDTuMfHuJKc241MKGcQu+nHFtuR5JykKfTMYszj5k3AkAWQ/Ey/FZOjiuZSyhKIzSiM+GWCTM1sg/HLRk0p3UiKkx1JRHuVzBtqIU8wR6BbybFdbNP2KDPURxTf6DQggxhHm3kt94QCc6mRfa0vUjmM9ojj/mdW10SOW0zoNtlufN0NfGtWpo+ehzB7QfP3XHLQoAo2sGoc7ylOIxMtpcwbNt2cPUYigFK649S+r0T5iNTd15+vO3CvIXac3CWb+2cTB1oTXN8ihg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do0AuH3dtvno41xfy3ln5li3TMODmlQ8+vENfvP3kfA=;
 b=h6YBNbFmFbQukAwOS98NvZLeKU24Km5wm1Q0eZPOelqkxTS6y84RDOSxR66IhM1c9fz7LSrhZMP2jZyEYa6E+6mq3S9MkCOlZjKJ5QsrTul3Hh4nPRv6zOmu4ASt2MhPlQ1sKGY+zEXlWmHgUJTuw/s1goHl2vvH+0NbplGBW048UCyczylWq6NmdwNp5/6y/SmplwIw+751OV4B5l9sB1pkA+ZfD4UkB5x4kzNp1tX7VdVQNQtVshWzHjP1UtjZBUSzJJGqUofb4ajmonGIl01iw8usSMCzgQ2v3CLK3fgqXrf5hfAyF1pm5is99q25mcL/gBMWEB9N+5xDRbNlUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by DBAPR04MB7463.eurprd04.prod.outlook.com (2603:10a6:10:1ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 13 Apr
 2026 07:50:57 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 07:50:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net 0/2] net: enetc: fix command BD ring issues
Date: Mon, 13 Apr 2026 15:52:48 +0800
Message-Id: <20260413075250.281653-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0236.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::10) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|DBAPR04MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: df75c7d6-9c74-4d7a-9227-08de99316480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	m/941PBn9R+mWkB6kVGIsWEvh1oH3ARmMcLfMyCH6+BhkciPjs59uODT63YsgrH05cPbuEcuuvN4iHRsiACmh8Z782qjB8wQB0kbF+CfYGpgvFnGWUsixys5t7LEZ2jofX7RJGDxQWmjEDvr6h1ps/jJWSF/+cJQszcSdnUGA7mGn61JNpPA9AuTAiUCHN2uyEho8j/KfLC1768V0d1iiTqTv03Y2j70DHkvLjxSjcnMTzh/HnqX8fR2lzvgldgWDzdbneE2GANYWym+8cmG45q7l8XHUqYex79KiBZbdAHfITC0z910JMQjsES4EcfTLt6355FckqPTE/P3vEQdaT8/LCWcwUxga96sZmlllOZX4aWildOQ6HTpJICb976paXRM+JCfWigSF4obXWSRW9SeATdDc1enRO5UVxZpWy6hLLzEMjH5OgsHwvNiiTBc5djIx6ivQmv31ZXOliBTTYF36zvlQUrr5dO+RsqoTgR42MkXKSPlA/aTyuoJoS7pNA/RAFihkdbHHK15sTYjTYiVHK55Qar8lnaM+mwXFa66CR6EO5JjoC9CXDHcxSP/3CSanEzYC8vnUHyrJXy+kllq8PZSkJ0j4/jZ6ycAEibQjvIdbJ4ZEkJ4Bv5/2PW02sCf0e9lCUeXyqJTSYNLQmxxEx8oUCoRJqrAibMhkSm6vqsQMi0DhseqP9UvlKuxatp+j2lYCmM1esSHf3haaQ9ZtepQiyBZu3iwyw5zHON0LuL2NOeL/3LRIbia3TnMHcukVXkxqpbF2ZTCDkvUYBh3CSXorTyf5j/bV7k4TEY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8w3nTpunoS7HTeyFiLtgnUHWCXvNvHuxpklZC9sLuF7kpELd2AUwuPanirte?=
 =?us-ascii?Q?PwE1djZxXw5/WVaU8UZ2BRqUMYnKXydogOlgnCWXVqNUNLCpixA0wk7EEbos?=
 =?us-ascii?Q?hQa04VMfSC71Qy8pRDelq6CSms9MkhLSH93P3pdRHxvSENFaGDg8RFZvtV+f?=
 =?us-ascii?Q?+i8LSmHe5uFknhuUQWCVs2475ji18w0OqZhRjsJJ5vtmz4AkqB9fsAOHzcBY?=
 =?us-ascii?Q?bCXL/t3Xucej7Ofp+2rCsWBnuP86+EDHp3D+ZUFuymBfexdoE3oFIDYw7IHl?=
 =?us-ascii?Q?LOTiif/+LS6GWa4qoG+K2919pmHmWtUus1KYJVLq8ToMudTDrcKNzX9KFJvF?=
 =?us-ascii?Q?lgBQI217deNvWqsDY67fM6BrJ+KM6DA9aXlYC/oE3iNoSOf535lFgtebqQQg?=
 =?us-ascii?Q?oxj7V45yirKSLV+E0cxItN/mGNaOgFQCDMFqQznh8slK+r8CtMzCc+kWbY2H?=
 =?us-ascii?Q?13Xvmea1us6YY/akIkKZO+NCqwngrDe8AW4BTmDtBJllIYhjdj+UeCOT09Bb?=
 =?us-ascii?Q?cw9PDemaeXqV5u9SDUStXtb99OHKZf5/W3FXHcHKRGwM+orSjwAALoyJPu0E?=
 =?us-ascii?Q?yb9xLNKCdmpPcF7oFq5Ky1dGPMZMR2cKBdcvbK61K5gDdEpvfd5LUD/q07pV?=
 =?us-ascii?Q?42d/Kh7JXYA15y5q2yTuKZ95m1sOppHSOosMA4HdYqUt7NYtUcBB77XjVCWP?=
 =?us-ascii?Q?0YtOMPvkYowQpv08mF4CcFyRvOvo9E9D6QqEeGwzdvAT09FBvSvkOHQE6xBE?=
 =?us-ascii?Q?TR6BfI6G0wmArDait06e7H7DA0agfYriFQssaET6QEztMZ3T3McLk2ZVB3Em?=
 =?us-ascii?Q?7nH1kaFmVVNc1qM3/fK2WMYdk2xEO8CzByrh18tcIQZ4pv0TJjX1XPFyBb4z?=
 =?us-ascii?Q?J4H0MRK6Ozn825UQhck+ze/3MZyXMBOzZRccrXOBv8WEplsAG6pjgZ97QJ05?=
 =?us-ascii?Q?45wLC407l2i+VtuHRDljkqb2HknSZxr1VG9i+5kYXvzjZ5uXNpDGX8GwBDSa?=
 =?us-ascii?Q?UMElxclTOjLJiB25oAMfQqaHeuNO89lRJs8McHY4f0Xwl0gSOd2uKJ0vBvOH?=
 =?us-ascii?Q?meqCSQWfnyHgip1GX5VwpBvxrRePfBl9FzCvVGspQAHqWMxMOVnrE3gkVNht?=
 =?us-ascii?Q?Ovholib+lmqBx7vv3vsCEYZsHH4quHheWBfmHOVSfz28eNuMchXH7IBEEJnn?=
 =?us-ascii?Q?CCgDJlixzHWSB1ptZGQcgxYBtZzh8kRTI7Omb7Zrz3I60VrqGccevEg/k4Z7?=
 =?us-ascii?Q?gPX5j+Cz23voS+3b7TpPk03l5ng8rRTRFlhV/rIajlH9LJulVGK/1PEde08b?=
 =?us-ascii?Q?T9Wb7G3GACktQG0Tg4lMv74SpLpbNyWF0qt6XmhEHk1KRR8hz25PfURjARR8?=
 =?us-ascii?Q?dDVkyRK7eZpbTLmZfFZYKNYrIFWWlJ5kJWUDFhlpmU9MZq7YWPvJusX+ZpJ5?=
 =?us-ascii?Q?3P/56RCKIKQZA/KsUQI/q4NDKVjveND85gFIR1iRNcmjbsqSuEW6wdMUMcfc?=
 =?us-ascii?Q?3KVHYrkHu3jvjVxQvPts4necJG/PbqloeXFN9RLAKDzBAAmN4VKkphjhA/yu?=
 =?us-ascii?Q?y7tJe0iJ8AZDRWHDT/m+FzlttvnNFkVtn2midQzcxWRSpK0Y0W5XvBOZmS6E?=
 =?us-ascii?Q?ZEUjbAvYemj7kg1xP7w2eh2it3zfCW4F9p7CtkeBvx+VWG8W8DjRISk2bEFc?=
 =?us-ascii?Q?8Sjt7VtOAQF/MWOpLVfZsFLaIRapfxXlscpb9jqw+eR/+GOg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df75c7d6-9c74-4d7a-9227-08de99316480
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:50:55.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZdO0/TsskMJmCiB9UPb85cUPiwQyY1YgV2Euy9agGz1e+ocKgvCLz1OqhxYbZKG1iSACito1YAKXUPsAQmt6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7463

Currently, the implementation of command BD ring has two issues, one is
that the driver may obtain wrong consumer index of the ring, because the
driver does not mask out the SBE bit of the CIR value, so a wrong index
will be obtained when a SBE error ouccrs. The other one is that the DMA
buffer may be used after free. If netc_xmit_ntmp_cmd() times out and
returns an error, the pending command is not explicitly aborted, while
ntmp_free_data_mem() unconditionally frees the DMA buffer. If the buffer
has already been reallocated elsewhere, this may lead to silent memory
corruption. Because the hardware eventually processes the pending command
and perform a DMA write of the response to the physical address of the
freed buffer. So this patch set is to fix these two issues.

Wei Fang (2):
  net: enetc: correct the command BD ring consumer index
  net: enetc: fix NTMP DMA use-after-free issue

 drivers/net/ethernet/freescale/enetc/ntmp.c   | 161 ++++++++++--------
 .../ethernet/freescale/enetc/ntmp_private.h   |   9 +-
 include/linux/fsl/ntmp.h                      |   9 +-
 3 files changed, 96 insertions(+), 83 deletions(-)

-- 
2.34.1


