Return-Path: <linuxppc-dev+bounces-20537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39312CD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 01:38:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9vzN3cjqz2xqJ;
	Thu, 07 May 2026 11:38:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778117920;
	cv=pass; b=kBLRXsY62Lg8nB+n8s/V7/l8DxIGSrZ5TdPh6gepXSzh7Iv4M8TKH5Quw/Evri6YIBnQMvxO6+5iQaRvAYz9lKlRZXSBJV2gv/M9hRw6X9y79eWmCG323hqdmQt/XXz8TWF7lvr6ypHYCWHF9wP4qyTWOb/z1Ogmg5vXygjMFtjG4dysETIWTi6reEjuaqJfgFSuDeNLWfhLpnH7dPoZYBPjhzO2vVYKnFLkQJfqKZwJtw/nUnNs9EtMWc87PaSqShYE51+D8EAmHwVW/8LiV/cwygljV3XG95zjmXejTfhmnEXzQy8zg0v68H8Ni2et2xH4bLdznSWcnHd3+sIJHA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778117920; c=relaxed/relaxed;
	bh=OzITesbsPMenK7G7D9k4XXQY94du/QN33zLUJqIj/YM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=csN22HRYFGPZOfpTqCKqVs34xw6REOhBBTOPRpd8oEtHX6wLAFy57/NK/mDfwwntYnq+ZqDaLiKpruHO6XRSHK6yYvdTu/kx3hVD4LbUDRno0iceg0ApzA0g76RDzpQijMKQoFv4rw3MN8uXz0xeq7NcuDpdnjxnLSaG0QBjAW06+KLyFp6BGsJjBwk3w4tcHd82OMhWzTAiCJZkF7e5naBQlwgIpAruXWAz0pLYFm8Z5yScpEXULil+w+2ff0tbj/XmwzQtYm3uuhR3B4g9MBlFS1hXGrMAHtoFsoutkvN+y7TlwcVlzMAGp8wiYwQaDH7f7Bld0hHxwz8iU0yxPQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mfRXofnL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mfRXofnL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9vzM0L1Nz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 11:38:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCOK84Rr2H89W7czpUdQ/aRUqnxCwVBxfeRjmsoRFXFedbB1UlhgxhMxZ+FNUKmzZhH3OP2EtDVf8W8QDjMrezdJwOYyOy4r67MUCQvSokAh8OWgQfrUWJ3ZM+LUZ+iqxF9t3uJITr46sbG070BUs4mtTXWOnzGI4SW1YVE/3iJjc3jg8SjvhKPS0iI/8DQ2rfOilL0no2WZjZ1DVR0E7wbDpC1g7tF2IP49c5/8aRhXKADtLezZ+oZ4KsGtEr/qiya2nd0y7BUOD8O1dPJxKVR7gi5FJbTArQSm1tzWh/wx0fvfdJoUpzyFqxXB3nrRGd5JssqfNEDi1RHQVnUnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzITesbsPMenK7G7D9k4XXQY94du/QN33zLUJqIj/YM=;
 b=bdL4gNeO59LS6fRvoNXdDOWLgZK8sJEmBOxKpV9A1gnkoxDzM1/dq4A2ng0t7mDdrY7u2ncAku7cDWGFWHuxcg8NWeK6gSJxHpYTEZNSl95qy8IkfIQWPnkgxLb69StMYSBgpmgw6yw/90GQdBikTz4ehAACD4HFR3bNfvApiQjav6nE0h90LHwc9nAwg/TmjpVMXGSis1qqDBPrygYdCBWOXuoR78cRaxIRF8MQv/VHBZGIQd9RAZoZeflc7yETmTYrvekr7eBNZLGDT5UJAKC24DgPSr5wLcgRp93BnWD811w85M/IyL0523rTbRjvprrIVRij1rxgPneW1DBsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzITesbsPMenK7G7D9k4XXQY94du/QN33zLUJqIj/YM=;
 b=mfRXofnL5TBjta7I/W36lhzsyMBvRt5VwWw9jg6QC5Q8PEBfrHjjcuU8dhBZi7XlsIxOSzEEEolfPu88mq8ALzkqNN2LYbfvFggOfwQQzwj9YlLfrIMzLsOgZx9KEN2zC17kMCoE/GULrMEkYhfw/F8akXiSIVnTbtL1ktORU6upxVr4Gzdzs6EmpdHIiCv+ylfsyUIzEfQzBEB2rQYWKIFEHejMaUf09unt/Mge0xXSAwP9n5BR0DvIEjTJKI14CgKNYe3nuNWDEvsjXATvmM3NsOk/gtVO3hVH2pv9Gow3riErNGuzCy3Lly34GsnVVjxRlVXlnIRQBfnS9ZDhvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 01:38:13 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 01:38:13 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	shumingf@realtek.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
Date: Thu,  7 May 2026 10:36:51 +0900
Message-ID: <20260507013654.2945915-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0087.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::14) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9c9aad-33e8-443f-676c-08deabd94d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|52116014|366016|921020|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	k43b2F4uJ8QdfHajmuzpBoxl0Xv2yDjqkUXSzvaNZd7RxkQ5oUAo8TaZRzm9wjCOEDcRmaqB+/ytG3WAbXQ8tUsLpMhRZ1xC/Sk9pMLzS2rlAUKDPeLHDye5Jzgayklo0nD6gJi3QeDb9tkPXcyQ0qWlcOISt5vLOTxGPFvwunv52xejmcEbkEKXDG+ElffpJxdvt5xVRY/iF7wDit8flkFFk2iKWYkQG38pl0KhLQy80408afEXvAMoHL0OlZic90cPvX6tPEBDyYEv4m5ImtY4/7CHSx0IytG2jHSVVO//EEk6pnmjvjT0cCkeQ6jbC/n3h8ShZFo2HbUIdbuYMekwLZmvuHNwe3OUDTekiGXn1H8ntYTeYd7aDULrfpzNb17XwujPa5aHnN49K6FzVjGre0nq9lUsqSA5NaEURAHlqgZGFq8MvlTaTK/2u9FhvbZCvyfPYN04LjisEhr/wkNUSaLocB02JfLQqk6s69hqAsZAI4WToM97O5KJMxGaDEUSoKPT1Bc/JVMF33E6cc3Zu57vsH4Kk1og/oS4rYRh9TBSFnKpZOWsugeR8N46lWwWVtTLeapYo04jReHTEuaSHpwupqjcl8/ZmmisxE1fhQoFAfl7/+uZ8zotXv4TolcKDIAaOF9xAUj6JExiZvrWU89k6lG/JiBExNZN/nwg7x8UWGJ5RfAGPlzkohf12I+r8x2HulVshQwwlWU/BWFHMyIK2p0PfSuTq4TPQGJKP4WFz4IGdmEUoOwUVTY84cLqP7EJC0zl0VK2ntTwEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(52116014)(366016)(921020)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QASS6FTMBTq89D9eYSSzAMIoexUNbXFNE0j/6StvDe7FJr9ERJhTKHkdYmzr?=
 =?us-ascii?Q?UJWzuK9uAZB1hx2913X3ygrvjal5aoMmmwfrGB0TtqU23yLUZDrq6sBNPL19?=
 =?us-ascii?Q?JNVBHeensh5DcYqFZQAxEk4bsBV2kpECaOOJCQ8Ga1vAkVI5qzcmIjnLh7WK?=
 =?us-ascii?Q?jL8DdkXky/9mHEoduZgm3Tmi+F3Fc590NJ/BPDtwMNzUeMPnx4zDwJL40U5A?=
 =?us-ascii?Q?EULSJ3P3gmaAb01tZL2QpjoXx8PcPuf29efq91baQ0yI78IB3y1MqE7kPc08?=
 =?us-ascii?Q?LMda8bJ0gwAxae9SONa57vsAdw32V0qBca1vOectLeAjwZGaE8OUA5VF7HJ2?=
 =?us-ascii?Q?DB10Gn8ABJoh61xr8RFFjO39zpActvWkae3ex7+zT4gP3TpMAEHo2Ir8+SMP?=
 =?us-ascii?Q?zOax8jmszZXryWweKGiSvNcSBwcn9rChBAlduEhkg+0dPdTR2r1lmwl+1iHR?=
 =?us-ascii?Q?78rLmwMggCWVnHnBR6DApthPBHtTgO6woUggxPLvDbhZeRZS8aejmPoPKF63?=
 =?us-ascii?Q?yA86u//G8oAnSNp++5BmbvDW6HxKk7HuhxY2PRNgFwLjXFJ4zaa6i80tYBq2?=
 =?us-ascii?Q?jOugW9eMAUrMdjF0FQ9+csOk4AGkfbrY5YPolr8dt9vr5BGzTIK1PqxWiT3N?=
 =?us-ascii?Q?A4PGlbqOX2vuPJZlUoon2Cro5fSaummKZSutaV0tGusnnqPjDNxi3H/jaZTO?=
 =?us-ascii?Q?X0Y9sJbltzmWPP06hAvLgMSLpb1v4zZyrXj1UNIemCzpq+FI17wsDIr1GTQy?=
 =?us-ascii?Q?K21DY5VZ/ZPqOxzt9vs/WAS4F2jZqdb5kEM35djgbas7VvNhoin0t+q/1CY3?=
 =?us-ascii?Q?1oEFiKZV9yB6i1WJiCtxH//SSm002xqZn7fhl3+Z8kfwq1EMhHMCldTlUr+n?=
 =?us-ascii?Q?Cb93/rk0NGiofZbDxpY2LNs9sM9ut1trTX5tt5HrCQ+qFKacrSNbbG3l4Jgk?=
 =?us-ascii?Q?5vGgyo5iNK1vP2wBnxdeEzkVRPWlq0pfim+RhAg0gm/pujH+vDJgChJ9w2Xr?=
 =?us-ascii?Q?ncTeQ71t70zU49bEtwl2XRsnVYXtwSCT04DU3UR9hMukAB5Sv9yBdB7TTOKD?=
 =?us-ascii?Q?6qmzCa7Yb/woryKS7MbEhZRc3hLQwbeythuyQUw7abLgPhS7WVmihtp+xU4k?=
 =?us-ascii?Q?L7HHPTFeZ0+myKXFuFkF5IoIW9HPY2YfJZrSR2YD14LthN4n+kz+K2sm1B5U?=
 =?us-ascii?Q?Qq+frRCHSbWbDQ2Vgqo3AgviI6DQbYX7BSWzSbS7+eu5TwUeS9IDmzKjMZBV?=
 =?us-ascii?Q?adWwpZm8n68wrJ3O5Em+uE2Gq8BI0w40auIWlXw+QGk+JI+PIRp+fGMZcMpB?=
 =?us-ascii?Q?SVvUFwUo0sw+FhT0a3ZMRQftnsV8ll+CEWn/fNGse1Qizp4cabIT03MUJuPk?=
 =?us-ascii?Q?rQDK9xL9Nqeync7suRRb09AjOQM98vIplO+V+E6cyUuSkSuTbC/ONuQjrpb5?=
 =?us-ascii?Q?e4A0i7yj9xznh3nWwKSK/rXXNtM2OKTmd1qzrIcd7ICVdbeR5CM9W7MjSb7/?=
 =?us-ascii?Q?Y9ku+pvClAzsDj7bkn5IuB6CzBwfpuh+VKMaDPtM+H8RjTf+/mY5Jn2SFfua?=
 =?us-ascii?Q?HrUMX59ZIMwAEw0eXloH2GzdpKSCnlP+k8kY7gW6eGbr/VRDP4GzR+svL9FJ?=
 =?us-ascii?Q?RA7feTp8Vjpl7CpSfKv1Gvh2SbAMXH9IcvV+qh433xusjMldjLksQYIq8m3B?=
 =?us-ascii?Q?p9lZ+0O5O0IMAs9ooOTp4+G10fJQx9ed26NvBrtzcL69zverFAlQF7oMNHHA?=
 =?us-ascii?Q?R7nj0jnjaQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9c9aad-33e8-443f-676c-08deabd94d7f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 01:38:13.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twWGZa2g5rozPeHw1RUjwVGnDkDWKX7y+4nWdXGcOdstUxOde/AehAr86IcBlV0ADEKsXHzQC2mNa3tm423k2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

Some audio systems require specific DAPM widgets to remain powered
during system suspend. Introduce a generic and reusable mechanism in
the ASoC core to mark selected DAPM widgets as ignore_suspend.

The unified mechanism consists of two parts:
1. Parse and store the name list of widgets to ignore suspend in
struct snd_soc_card

The list of widgets can be provided either by the machine driver or
parsed from Device Tree. Different machines have different routing and
power requirements. Each machine can specify its own widgets to ignore
suspend through DT property. It enables flexible policy without hard
code. A new helper, snd_soc_of_parse_ignore_suspend_widgets() is added
for this purpose.

2. Apply ignore_suspend flags during snd_soc_bind_card()

After all components have been probed and all DAPM widgets have been
registered, snd_soc_bind_card() performs a unified lookup of the
configured widget names across all DAPM contexts of the card and marks
the matching widgets with ignore_suspend = 1.

Switch to use core ignore-suspend-widgets support for imx-rpmsg driver.

Changes in v4:
- Rework first patch to improve widget lookup strategy:
  Add snd_soc_dapm_pin_has_prefix() helper function to detect if pin
  name contains a component prefix
  Preserve exact matching for names with prefix to support
  disambiguation
  Only apply prefix-stripped matching when pin has no known prefix

Changes in v3:
- Reword first patch subject to use snd_soc_dapm_widget_name_cmp()
- Use goto fail for error handling in imx_rpmsg_probe() to ensure proper
cleanup of of_node references

The v2 series is a rework of the previous "[PATCH] ASoC: imx-rpmsg:
Fix ignore-suspend-widgets only applied to codec DAPM".
Changes in v2:
- Rework to use a unified core mechanism instead of machine driver
specific code

Chancel Liu (3):
  ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts
  ASoC: soc-core: Add core support for ignoring suspend on selected DAPM
    widgets
  ASoC: fsl: imx-rpmsg: Switch to core ignore-suspend-widgets support

 include/sound/soc-dapm.h  |  2 +
 include/sound/soc.h       |  5 +++
 sound/soc/fsl/imx-rpmsg.c | 26 +++++--------
 sound/soc/soc-core.c      | 43 +++++++++++++++++++++
 sound/soc/soc-dapm.c      | 79 +++++++++++++++++++++++++++++++++------
 5 files changed, 126 insertions(+), 29 deletions(-)

--
2.50.1


