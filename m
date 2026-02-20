Return-Path: <linuxppc-dev+bounces-16993-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823B1C56206
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 15:41:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHZH35z9Bz30Lv;
	Sat, 21 Feb 2026 02:41:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771602095;
	cv=pass; b=A5f7niF3LA8gDkzPpjfNM2IU4acWyDMWy1wsKRidyGdXjGkIoY6uaxsSuDgHlCC2cjmCT5GkaChUjhdVOQOr7Xa5XGqbP6XamDM08HjEbHAmNxXH6+JfQ2sHSC4/0019AhTpST9+Sn5haZjXZGjHrZEOeADNNlYgI6Ga40HJZXWxksQurkLemqAke2eb7JCRTa2+wfzVcM+cTkJen2g0HIOS3nCzAB4lDapg5s5u2xkL5XF8pSvTIYQiOi+6Eb79HCDMkMQVtGdmPQuvsWKPkISvf3BaxgOk5pDGr4rExh/e+XwCEJXbd3DBExLqpXzS7NWbJ8PHN0hQILFMCB6d1w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771602095; c=relaxed/relaxed;
	bh=XgHoiXo9RRAPQvWaNjjo696Gb/HT+XpeG3h6Dv8Oq3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g0i3ev5W7+zZN+AaGgLj6kDvUVJjDkv35dwB9b+Z+fhmki86rpUN5gQglq/gWmGltp9CcVAs+YRL6Bb6u2qpYwXvH3qYJdf7NyIs6sZQ8zp4VGWL4H5YjNmaWFOBTydLqHVHmw71Z/nNva1p4RYJDQLf0W9GGLHpCQiLXcDe7g/7G/nFaBFP6n0DG0E/4F7yD+4MJKIF8tDKKRN7lS+jS8wYYKnKFLCPLJ51cZg+HKuuDLzCIhbVCpDyEWahK5M3F5e64z+h/3FAcuR97dba0erm/ZOmmlaDqJ7lyJmSzjDyCPfr+QyQ/JgYzvPHb+xZlxYy+U6XulhzFXQhuG19eQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LitFbx3L; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=LitFbx3L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHZH21jtyz30GV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2026 02:41:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmabv7uJBAg+RDOPPYy6kNkTzY/zYhzpR7sdDd1GfqxFwYfRfPfs+zUj+zst/IAECLyJyPhNYjC8gQKmsqRIye+J26I95cWo9lzHoGpR2mv9sqfLENLa25baJmCyc47F/yHMhxLbzwBhCgeGUl/RDPoUCiVnpGU0qXpkSSgLL9bbAy1GIZNDFAS/ioo3ouWp15pOS4Yhz8petQDOoeVg14mTuRL6FhgNRYyArJpxPDEtH3K/mFoysQFPpWb71ovxzgqUpEuS/91G1gdxKHkaOnUOmyBZOBZa+UpqaehwiLdmKeTL1kdxMI/W0YXBKROgAFUjMvkxL/0N77/ECpI/Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgHoiXo9RRAPQvWaNjjo696Gb/HT+XpeG3h6Dv8Oq3I=;
 b=kieM64MBom9oItT2pa+sAJgad1qqMiBxr6TZusNIgUMpoo+kHW8LMwQjx0ddHUmVTLmUDtsmyanBUIvhT58cQW4aSGjr7ssI3GlEGVki3IBzg38ELr/iB3CX4K9q3ZhacmYF8ZLIU7SdW5sFVTASWI5ddYDspytBWs7PhftfMqG0bbR3H2KJGwwlwoW0PdGVS0jet27yKbWCZwVpFVVcyt99KMPqutJd7Qakw8/N6RP5EuQwanQy5uEVReiaFGViYh/52+rhFRA4wCymser+DtXEo7iPBtL+6R/MCa4t+CWFw6iAJvHAYFkZ96G+UHBzab60XAxC1illqQysx0Ca7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgHoiXo9RRAPQvWaNjjo696Gb/HT+XpeG3h6Dv8Oq3I=;
 b=LitFbx3LtLagovgJj+TjqhAVuwLqhqPf6d49G4Q1gn63FGC1whUNfS/wu8cx8PewJI2Qm1MIvpTyC3eAc49y1+zGb1X+ohmQbmP2rYiXuZccvSICZsneo0NfQ/QYcEdhHfGyrgf3pZ+mJpz2wB5R/W1ep+N/TzFhCcw9OIYWwSSJMpij1veBKOn0hTi/Y2/SGRqqCjs1zdDRj6oQF89dP4eqVytlDc7i6VlUZJ6iNrfp9WNfaqwIybIf2iphrhCz5D+NdU0wq86HrVyD7fgehhERGH2sRLgV/gb6n9zl1LnHy1ZE1EtlKv+0gVTF+O5WwDX9GRDrn3xxyAON2vXCsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 15:41:07 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 15:41:07 +0000
Date: Fri, 20 Feb 2026 17:41:03 +0200
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/6] fsl-mc: Move fsl_over to device MSI
Message-ID: <kukzdg7cym2cwytx3zgbu5ik2cw7c2zq7irwp6q6o4jzupjzla@qgkrv7emus6f>
References: <20260218135203.2267907-1-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218135203.2267907-1-maz@kernel.org>
X-ClientProxiedBy: AM8P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::34) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c1168e-9ca4-4670-031c-08de7096767a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BZJ6+AbDehUAOzROlkjcEV3ca4cx3+Wxc+TJp6Wu6KhqY6KHZQsss6ZJoYbe?=
 =?us-ascii?Q?9LRu5z416Dc+mJSvnpPXAwHdyLSJxoWNln1JpSSnXf5wf4e3ZVn2566mtRff?=
 =?us-ascii?Q?tUW1y9x1+EWvyavQxUAWbgiXVmPsm54i1V1tBTVvF3+JWTzOhEND2qBEMR3y?=
 =?us-ascii?Q?87h7GJr2FbSFNH+fXmvxveLRCU8fcLZrHEMCZusbQc2haQEbh1DRM3CWgbQy?=
 =?us-ascii?Q?ej20xe/cl+ndyMi4ISCTkPReTzQ0fKSE1LwIToIuQ8pZjU8cIaUh0OXnTIQz?=
 =?us-ascii?Q?Z2hotyb+XZNGwueHbgK+S4TZqXEEeiOk/c2gz7Xj0JM6MwPckls13TJ62RhL?=
 =?us-ascii?Q?GDXNY+WXYfehjYYEkJLOvXZ37XJ5QXuNgWnCv4tzeoUDEYmAQmhCvq2ZE4Jk?=
 =?us-ascii?Q?YBKLqBdsyKwviAUocOZu/UI6MIxv3bbkwyGhX5PST9tmKCHCAZA/xy8X58FC?=
 =?us-ascii?Q?05grRJonPtVBEDAj2VZAQAsvwWePyjwnd3liUWH5ejdKJOS2gE11QYcPMcJ1?=
 =?us-ascii?Q?8BXnCAlShgCzCUfznlntoIJWJgX5DVSMCTBHXQr5sSkplltxArI/ina2xbTY?=
 =?us-ascii?Q?bRR245K8rHmAqBVC1Tpbqiy5COWqttOp+YQEO2G5CRTk9tgyW9J9r7RQZtAv?=
 =?us-ascii?Q?0625x4j7SMzvvWRm/U/EbSBWXMLMnxqZzisUtM+TLezid/HrfLiZJyg21LqK?=
 =?us-ascii?Q?BnKcAdSRx1F3Bq1AJoaoD4I2kIU3RFiu2fhkDV5PJ2byjOopXm0XRghJaZQa?=
 =?us-ascii?Q?PsI8kKr/r5q/ILoGSWOXRVxPtvlcKlp8WlYRnKD70XuCyE5pHgzCUl/ITzMD?=
 =?us-ascii?Q?Src3A6ayakZMm2whQjP+K2jP1/0xBu44aA4t8P8DbQGZIA2YLsPVsfue8LhY?=
 =?us-ascii?Q?ggeZzfS491Wb7Q+8mPgGBgKzHa86GyiYBg138nxYU5mE0/MhEH8aMXpTon9o?=
 =?us-ascii?Q?GtFmcv8EVmhMQDCRZFqEO3HSQE8g3UMRqv3ZQMVUmdHNGF8r5RD9koPr4irm?=
 =?us-ascii?Q?0lFTNKhMJQHo+qHS1PupSVkSKubRIPt4XnI3hX2zvJjlZSubyIPunS0vn8RR?=
 =?us-ascii?Q?0i42aEA+I/N12pIurGnNEUwzAZo6G01a8qlYPAMWoq64zIEui9Il2eBxk4c5?=
 =?us-ascii?Q?/QFTveaduCSOZvwbtmzDhavRGB0XrD71RwHQNE+Aqz1Hhjw4aihzrHKlrHB/?=
 =?us-ascii?Q?D8ptLEvC3+Jl+2Fq7vvSbA0zNF7ivRFFB7AuvYVb4xbWdw4iL92JlUhQZAJg?=
 =?us-ascii?Q?G2FE7DzWJw61anSN1Kg3HEMDYTKnUE4TkqQm2DRzX54rXoFM+cVvtKFeBert?=
 =?us-ascii?Q?qPO9vgmVl3/jJ8Tx6TRkyHSwF+tjZO/AsRoisC9iGMWtVUtaAO57jx+qPxiR?=
 =?us-ascii?Q?C0u92NYPX9WeE1IBm2KfozmO+pQ4ikvXn1EXY75OPXNTixGHz8Mm3JYLcwHs?=
 =?us-ascii?Q?wWpnBIMgpdshYOJQvjmiuOUU2zDuVnBJF9cqrftVmf/AKJm5UK/kNytLp0M+?=
 =?us-ascii?Q?VhdHQiVIBFvDVQs4KHr2cKvjBNpFQDygan1UaT6HrK7poJoGj+XrjcTKzLQl?=
 =?us-ascii?Q?mkwMAxE2OQ1SiW08GiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Nm9pI3KcLBtuQIX46+oUwl9VkKGjKU7CbR/7AwUU/cIxYxI6luz/WlP3//q?=
 =?us-ascii?Q?NAkX0DnfaD5dU/pQUyCS0k3qOqQ29OYxEDPX7MgnoGb+xXGWCpcy5Hvq4mS+?=
 =?us-ascii?Q?lT8rhz4roM/MKlAA69VVKbE/91qkY4SSXFZMRs/LxWoZFXzpMUdWR+99vZIK?=
 =?us-ascii?Q?qAOl0lBc0QW/P2ULlXHJ4WhsEyR9jtC3FFuT2bJBsjZMLrYkdDrrDTSV3sGo?=
 =?us-ascii?Q?ONgEasxqSQoh55LzF8bD0/wp/EC4LxA9xoEd+xu68PaaiPDbDaOsmQONlJRV?=
 =?us-ascii?Q?2ad8YWxbUJIMdoY7MxHk27YxzWntDcS6ELwwDwE2/os1H1MlQfNGjfVrtG0/?=
 =?us-ascii?Q?fS5gZHtmSA1E8tvr0HxtObmpdpYVxIAfIWGfAxCie3gcfaBRHR4L/sqAinmQ?=
 =?us-ascii?Q?XXzPRgUU9gQLZKWW7kPRhqWVqD7iR5JAvU00oyDCGcVmEEGIWQrrW2V2+4r/?=
 =?us-ascii?Q?HinR9++DmSQSX5OGfaMx/e4y7m5YfscNFbai7SXXTK2LAxMmLVx/aM31B9kH?=
 =?us-ascii?Q?jM6EOMAMw0s2yTdsyFAp9VKEN3mFYcMeYVnSh0oe02dez7EcVY42RSynPt1Z?=
 =?us-ascii?Q?7L6Grf8xOBiFJWzpiB0a217yHiL50y/SOWCVDle2D33M76GNBSBIeutuQIc6?=
 =?us-ascii?Q?UBcyyHRKtcFseo5QBeYQH78Xt1QvUb3WMJYwu9uMeooTrCT8oGwIjUrYlXip?=
 =?us-ascii?Q?NyXBNhqHBpoHu9RExFbMC7mmSUpdwwd0Fhvr0UedUVvkotaly6UX26vew7xS?=
 =?us-ascii?Q?1g4/niZS7kgD2aRR2Xpzn5t4UVEHncPP0djThy4/BOjF46YmQyGlnqXuoEgk?=
 =?us-ascii?Q?vJ+wSNIhIwp4o8s2X50IfNQlp+2mZQCDfxG7dnYlNI4kS0qsnconxj/q0z9L?=
 =?us-ascii?Q?ImrZiIxTUzWvCYGLH0wM1lKgR9ucPf4ZU/C2Bb5DwFSS3Vqz2UMADarXltTD?=
 =?us-ascii?Q?OunZqDt4q6CVqbD5t7f7npYAwPmGPRdV3NuDPecBp9KW2/r1RiEPKsezs+f+?=
 =?us-ascii?Q?NZ0h6CRYFCnDHUgln1rmHBSTCJjOOnQXwtdkN8rxLa+48pPF+QJ8BQBxEEoe?=
 =?us-ascii?Q?nXinUzJQq8GRRI0jurgK7hndJO+/14LuY+MezSNZxvst+18PBhoJP8MfFXF8?=
 =?us-ascii?Q?cp1BPIEwJbarp606ozp8ypcdkrHV2jwddq0MRABoQTgVOKF4kTLSpVJ5zXIE?=
 =?us-ascii?Q?BG/CH/Qu/MHgNKFftUEPjpWqGRXgCWpu4zLq2w2U7KoPmZrFf8V4VWlhYarC?=
 =?us-ascii?Q?rRHRlEPM4SJMUyIrMgr4sScwZPyqFKblsygIUAEBwSwb0ObFBFF6BMsZMeRR?=
 =?us-ascii?Q?CvwskseQR67EWvUGqew7fzmZFAKEPqmk6GSfyTmpx40Ir+7+A/tnxh4sZUyF?=
 =?us-ascii?Q?nQyv2xHNvMBHE6tcAqUyNhgHcUqP2NvRv1f2ERvj+YIWVrzEg+ac51aksrr2?=
 =?us-ascii?Q?JG0xbk72QDbarys8a6RStXFv6Qx1ZcXK27Khyp5m02C4M8QpkHrt4y7zmW38?=
 =?us-ascii?Q?+FaXBHm33JllrrjQtzOJLqMybbP8GFqGDiKn6ms4FZl0Rw0e2xorVGy4vjyu?=
 =?us-ascii?Q?m4iIU32KEYPt/1wbRpt1mjEvgtbiSj/wV6pPSErBsDo9hbrK0F6nPDhlxXDg?=
 =?us-ascii?Q?EAz2zHBQXdXCrw1q8YIkoa50DEb8PpuUyQYY8HrLi9tq9PP3Mex7+SGul/yg?=
 =?us-ascii?Q?gr5Y+UksiaTAtNYF36Khe+i20f9vhUefs0TbBqGpys6Qqi3wSmPdnlD1nm4g?=
 =?us-ascii?Q?5x45R0QEjA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c1168e-9ca4-4670-031c-08de7096767a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:41:07.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IeBjJODlT9M/vbTHwrl/nwSEcaeX/F2rNNYkHzSIDR7+UqpiepC4eI+JRWzlGHOcWh+oU2Brhd/UnVb0nzqMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

On Wed, Feb 18, 2026 at 01:51:57PM +0000, Marc Zyngier wrote:
> Over the past few years, I have become increasingly annoyed by this
> sort of messages in my boot log:
> 
> [    0.067861] fsl-mc MSI: ITS@0x100100040000 domain created
> [    0.073352] fsl-mc MSI: ITS@0x100100060000 domain created
> [    0.078841] fsl-mc MSI: ITS@0x100100080000 domain created
> [    0.084328] fsl-mc MSI: ITS@0x1001000a0000 domain created
> [    0.089815] fsl-mc MSI: ITS@0x1001000c0000 domain created
> [    0.095303] fsl-mc MSI: ITS@0x1001000e0000 domain created
> [    0.100792] fsl-mc MSI: ITS@0x100100100000 domain created
> [    0.106281] fsl-mc MSI: ITS@0x100100120000 domain created
> 
> While this is useful on fsl-mc systems, this is completely irrelevant
> on 99.99999% of the arm64 machines, which know nothing about the
> Freescale stuff. Including all of my machine -- bar *one*.
> 
> Global MSI domains such as the above have been obsoleted for the past
> two years, but nobody at NXP seems to have got the message.

I do admit that I wasn't aware that this neeeded work. In the future,
please let me know of this kind of things and I will do the work.

> 
> The obvious solution is to delete some code! While my first port of
> call would be to just 'git rm -r drivers/bus/fsl-mc' (only kidding!),
> a less invasive solution is to drag that code into the present times.
> Which is what this series is doing by converting the whole thing to
> device MSI, reusing the platform MSI infrastructure instead of
> duplicating it.
> 
> This results in the expected cleanup, and kills the last user of the
> non-device-MSI stuff on arm64. You're welcome.

Thanks!

Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB, LS2088ARDB
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

