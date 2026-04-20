Return-Path: <linuxppc-dev+bounces-19845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041C9F557EC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 08:52:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzfPM6XcJz2yqT;
	Mon, 20 Apr 2026 18:52:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776675127;
	cv=pass; b=eez52In1tMRU15Duiw1/ulNeUQ21JeYf8K07U0sUzjBhytrMiNpFmGKkFMgNwHvB1aun4AQYYzfzYbJminIe7AzIHUuyHYVe2eHRWs0zB3ososTo6dvFWKHPcTr05PPlTl4daugv+BQlhgHgHawhG/jjrDQVZVlDs75/szEwmclJpdrsLxQ9v2m9BvA2TgOpOodQAKQIiiDX3q7ZpYtRxGP2wNBJ40vBwePkf3BlxBu/fT3Nv/7mQ1R/eoJQ/STP7Qul41rlo64shVnkGyhXa/Zt6LYLEZ7GEcAzqBApWRXweidOLw8EzCASVLGKu9UaTh9RM9IYVgqEt7Fr87uEgg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776675127; c=relaxed/relaxed;
	bh=T6emW6ddv4wDTyYDqA4vz94bIXT8T4uoqcpcgifKUQs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LgyGl86xXvUCObnAJCZZNNXk5DXlZArJqCpyQ3a7U7WI4IdQaLktkdXbv6nV5e3PbbhmIl9LUTthN9AOInCrHkj5A9cGoMDWXjc8UKEJJg+JZrYL98Ide70Bbal/Z2Met17445jVZuxG65fCv5DKUF1aU0xMr+k9Sd26KOyEIztRoc7xb+eNH/L8hZQXPjdsYu1pZBJbNVv1D2hJgg/U6R/Hdq/4uUdGN1kLLXDC2g01B8ipEjDdy6NFbJdYGQFlqtSIV5hn8EExfgA8VyW3RRY9l5IS7Bq4KFYHz3mjHGK1a5EVOmuaWQ0Su0aTVd0O86im5eivIEyMojJf9MaL5w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V519Cloj; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V519Cloj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzfPK3C7Yz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 18:52:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSpSawofHsz6fgyFaLUXOva0DnefCTotZUaNNnKfmH7ovV6cqkgQyHvL/2rU2D0Sl/YBinzR9Zn5GV6PlFNzNkviAFtbj6cj1OpXehgN/PNjkbWLmRoRj5/jvloC6rKQXuqJHBF/gKKamxrXt44/dJwH6qqQQTEs7it7T31pK004fW80XrFE5SUlfKRrN/HO6FYvJ0mmXHJcyR7F4fj9AfJtulpY0f4iaMNC2oGNCwjfkMTjVEcxaYJbdg0/BSieBV03H+AXGrhzd25OFn3owjjhFQCi7UP+6hBVRCDo13JpXgKozOnc8NZp8tHPhVpoBtOlIHVVD2/Sn4HbCIn04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6emW6ddv4wDTyYDqA4vz94bIXT8T4uoqcpcgifKUQs=;
 b=Kd0b1Yz/S6shcHHCYcv5YAYeHIaNSaGX75ekP/sI3Ph6eSnOV+m5vGJgQ0tDlybnEYO9MUGnBe26GIlhwZEAZmC08RWk4WCr8/swTKlEeYh7WMfOJfhrMfM0bJBqTqnqKf7pzZiKsPscif5QvosebK15b3z3IV0cz/078/tJijduKjbXQ9t/hsmBEYZ6C1hp4UrjkFPw8lr3prKzaz+mudCRsz+vSgCopMXm0EsOl5FuhY9VhupiBOiEd13UK1KePFJKXPvZHo+b0E1pnhX1a/Y+c2eQWM5f33C8GMo6qMIXrVjJnUuRu/7ymhLH0uKgLRhk9GoKCqG7z+gCjGYa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6emW6ddv4wDTyYDqA4vz94bIXT8T4uoqcpcgifKUQs=;
 b=V519ClojMSnKDECMAxx4gh57OPNCYluMNw6RLBfNW/GHmr1rIFswPPrqNHVrIgce9V/ocWEj+Mdqmgyp0ZufVdKfl5WAQNOq1okJe6Pk3yz5YzRN3fwuFFxMo2lhTnuhdL061BnC6DIa6eR/5mmTU7x7vR72f2DSO19+6UEONukMANMU/5TJOVvGVN40Kw4DwMBsLVjDAgSGtCikOnI83p7N6mEN9LRlsNoaiOcQWB25ZsnrzIN1UE8gMB+ABnhHoIL78i9Q8q0poJppNM3zJy4R5yNZftYLwcJNlP8sZOVe6wx/1UPySlkZPwrVIRCU3ayh5Nwmbg8BrXuqQSpDwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:51:40 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:51:40 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_micfil: Add DC output remover control
Date: Mon, 20 Apr 2026 16:53:44 +0800
Message-Id: <20260420085344.2081805-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::8) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 46314302-c3b1-411f-a0e4-08de9eba09c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|19092799006|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MyoK0B028WYZxCc3hB2+zVHGK3rN5gLMrIaa7Q/lDXqSBdlPGxLm6wPWbXYF4/Kf1EUln1w30rqHlO6PbQIJ0vhPaTVyb0MJ+bX5pKKu/Qx+BWT3wgpBkwxQqOtu6XTQ0+IPHWgHnb5REj76wa3SL/pbuDAdRPmi3vZ9/5D19KcdruxX3GLehfXc4+JYuCK5bW2h8T7tsl2ioWI3CFTVYWP4L/gA+Vuotooa9YRMyjHqBFYPqYfIivLFTM1m9TD3h3g9bcV4Uz3gqkwwSEJ7qUcSemA9VPP4hd4wNh5L2Ml8pAusLpmVB4wEBQs2g206t7oj+zfbJE81QFuKANEzl6IIi6Fkg0t3y9zOYIz/ZtBmf+PYzotNwA8KvVMJTJb6Cf8UYJHe30QEUrsRNcHEefnNY4o0qB8iy7fKXblZ2v2poE/OZMaHnwKTJ8InBNgOMRTP/HSCu50bB929LlvN8QxBZZBenUz2EFRJBcdLtF0QyOjKWMhDk+rHED1QB6msKU8MjbkBdQOxUYXdpeWdn9gM9hgIUAguS12Zy0fP3PiMprt5iXhnfGl1DYC/sH1Dw1GwJH+hxX5JjHtc4SlQWn+OCEGeLbgFz+hx+D2RZlmaAtcupAIu31spYoE3szLZhiw7VCf9+t1af8JR/Hau99eCO2z3SmOzJ+M793bnS+JuqsfH9L3LMkSzMyucxXSEW3EXO8zGOhjgdMguRAdacDL5Om9+2hwI3PVeSDMyRF9QHzA/17DigiE5wAt4hu9woHiCpol+JWK4sofSnlYr6xOIUmr+UQQ8BnNtOkdycyxp3KR0FX/RkTd5XyXqrXoP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1OmqbM6jHPm+9a3Hw3XmminBQM43gy3Tis4px1Sb2l9MjucojHi7MtZDgah+?=
 =?us-ascii?Q?LkHAJGVnAn/sdvJzCW6BumcE5Jfcj4eyZk+dEY/wWbCVKKWvDosRER9fVTVG?=
 =?us-ascii?Q?6ScoqxlRki4V0hXjMYSfd7YHM1L+yLHyniSRPgT+fiy7PUOb9KqKsbxxhRLA?=
 =?us-ascii?Q?IQaBnnyWrqK3ypJaOe4H3c+HjpOIFX7/u1qCYoNvr6v0hVVzrU5oRlIVqQms?=
 =?us-ascii?Q?1TK6yA05rWWo+APCCemlTOriArXP+1Xd7blUKX35ZpHIsNQD9xp1LanOz0Lg?=
 =?us-ascii?Q?0HhGY4AOJCvyV/JIflnfRo3UrEa5BwsyZuBPzmyoQMr4S7OlYBonuff3gLFY?=
 =?us-ascii?Q?vL+7ttzVds3RRQ+bmYrJ3WFRDzEfHqKw5tikGgfLAFczTVNNF3wn0TOg4Dan?=
 =?us-ascii?Q?7opODWX8xe6yPlJ30UIB9alKk37scrccAEzYe2dP6NGnayd6/gYjZSzUf/rq?=
 =?us-ascii?Q?q9c0MwhbKSj67rCNq4B3jQlvN5iYGRilxFwvCSWWr07ewe7B5btE76YTOFME?=
 =?us-ascii?Q?yn1m/E1XbZ9R118/QnZikik1qz9EetaiCviPoqv9QMkQkrptIjj1Oc/8NHzF?=
 =?us-ascii?Q?laeMa9i/zqIH+nWUslS8R+XaqbocTazS8gx3SWlarmg22htViYbnDLoYdxPg?=
 =?us-ascii?Q?9QdSZEgToy5692bqyfhxQjOzvr7i3JbTopauoR+2ud6xkrEd/l7dgiHqEQ0r?=
 =?us-ascii?Q?9dMBB11F/knB/MC0zv6+v2CWDo1dSSenLOg3xNVOjsG5RAnHX+1sJRd80Era?=
 =?us-ascii?Q?IQc7h5DFWE5dFRCsCwxG7RYB58pG2R33CN/tb+lR5rvHkWG+XckfzP58u2AT?=
 =?us-ascii?Q?yaVSdmY6Onzv7ch6QB0GrgqPlRQs6iB/tUJrJ+czahaDh9yG8N6Fl3vnX9rk?=
 =?us-ascii?Q?eIp4lGQqumBbv9jujLqel9wJmZlR4Fl//kkPH2/553beHAn642lvB/Jnsb2u?=
 =?us-ascii?Q?oyW0SVySDx8I50itUVQzrwWytpmESaVneDk1h/wF4jnNks0B/iI8M1D/tY0J?=
 =?us-ascii?Q?2JMToHjwFNwfiWNZOJ9aoS2GkTnu0conuu1R3iK9/yXvhQiQo5aa6hSm4l2y?=
 =?us-ascii?Q?VFPoy73cUL0jjj7wHKq8pqMKadim5AKlVnNqgJ0eCDtdZMra6m7fSYQmDDKE?=
 =?us-ascii?Q?qpVltyUjv4SgUnvbCB3sh//R3u/wLIhRNzUaTmCqWIvyeZhQHENavAHIfhl9?=
 =?us-ascii?Q?Lun6eam2ZUgwq2ILpj1D+IUfRsgQZhRC7Wa2WUyNiAh/aUOUc3F7WR0Pqxj/?=
 =?us-ascii?Q?uwHY60QBuN0F60twi6l5hgq/iOg6RvwMVbLxueBWSzxvW47ElZzsV1SOo0i+?=
 =?us-ascii?Q?gzBzRxGoMVlodqrJzvCDIeYX3QNoaM+MV4hHN3iE7fp/UmsISKSzzKRtFHUA?=
 =?us-ascii?Q?rRqmmSkmv3+uwo4SHNVkmha5zfbd3BKFR3yy9u3kvhCPcAm8t4R0MX8eHvTk?=
 =?us-ascii?Q?DIuvNTdqx+9GHsBsaB6N9hyvWikFUjL8tL9GBS1FhR8kOqbOlb30oJcKwjqF?=
 =?us-ascii?Q?yvWVrKbY32TE1q+qp3RIcWnio/mgvUXzAKGbnqGzafmUofM5MFeBgrFSMFZg?=
 =?us-ascii?Q?MRfpsQ4wOwIEFJfGG86Etn808KLZ1N3UbjMFSd3hqJ9eSPhsP4K/1bb+T6SU?=
 =?us-ascii?Q?eFGhbaizJIV8unoW2XaUothvN53cmak6utNnlhYw6najglcpLj7UVzMA6kXb?=
 =?us-ascii?Q?aV/yQiLaWvhnsS7AcuLGkQPrrpNtR3WELZ2mEI/rmqdBMGojs+WplSBimLC8?=
 =?us-ascii?Q?e0P+QYs72w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46314302-c3b1-411f-a0e4-08de9eba09c0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:51:40.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWM2Wczm62bPe7dzfTnStcX/mWTxb2xAUx90MOa/YRad4UqvNqy0ehE0EryNwhUjxfLAkm5PTukBevR1lI+APQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

Add support for the DC output remover feature available on i.MX93 and
newer platforms. This allows users to configure the output DC removal
filter with cut-off frequencies of 20Hz, 13.3Hz, 40Hz, or bypass it
entirely.

The control is exposed as an ALSA mixer control and defaults to bypass
mode. It is only available on platforms with the use_verid flag set
(i.MX93+).

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 79 ++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_micfil.h |  1 +
 2 files changed, 80 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 2e887f1f1f36..60ac8eabab9d 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -74,6 +74,7 @@ struct fsl_micfil {
 	int irq[MICFIL_IRQ_LINES];
 	enum quality quality;
 	int dc_remover;
+	int dc_out_remover;
 	int vad_init_mode;
 	int vad_enabled;
 	int vad_detected;
@@ -347,6 +348,11 @@ static const char * const micfil_dc_remover_texts[] = {
 	"Cut-off @152Hz", "Bypass",
 };
 
+static const char * const micfil_dc_out_remover_texts[] = {
+	"Cut-off @20Hz", "Cut-off @13.3Hz",
+	"Cut-off @40Hz", "Bypass",
+};
+
 static const struct soc_enum hwvad_enable_enum =
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(micfil_hwvad_enable),
 			    micfil_hwvad_enable);
@@ -360,6 +366,9 @@ static const struct soc_enum hwvad_hpf_enum =
 static const struct soc_enum fsl_micfil_dc_remover_enum =
 	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(micfil_dc_remover_texts),
 			    micfil_dc_remover_texts);
+static const struct soc_enum fsl_micfil_dc_out_remover_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(micfil_dc_out_remover_texts),
+			    micfil_dc_out_remover_texts);
 
 static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
 				       struct snd_ctl_elem_value *ucontrol)
@@ -405,6 +414,50 @@ static int micfil_get_dc_remover_state(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int micfil_put_dc_out_remover_state(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
+	unsigned int *item = ucontrol->value.enumerated.item;
+	int val = snd_soc_enum_item_to_val(e, item[0]);
+	int i = 0, ret = 0;
+	u32 reg_val = 0;
+
+	if (val < 0 || val > 3)
+		return -EINVAL;
+
+	ret = pm_runtime_resume_and_get(comp->dev);
+	if (ret)
+		return ret;
+
+	micfil->dc_out_remover = val;
+
+	/* Calculate total value for all channels */
+	for (i = 0; i < MICFIL_OUTPUT_CHANNELS; i++)
+		reg_val |= val << MICFIL_DC_CHX_SHIFT(i);
+
+	/* Update DC Remover mode for all channels */
+	ret = snd_soc_component_update_bits(comp, REG_MICFIL_DC_OUT_CTRL,
+					    MICFIL_DC_CTRL_CONFIG, reg_val);
+
+	pm_runtime_put_autosuspend(comp->dev);
+
+	return ret;
+}
+
+static int micfil_get_dc_out_remover_state(struct snd_kcontrol *kcontrol,
+					   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(comp);
+
+	ucontrol->value.enumerated.item[0] = micfil->dc_out_remover;
+
+	return 0;
+}
+
 static int hwvad_put_enable(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
@@ -525,6 +578,11 @@ static const struct snd_kcontrol_new fsl_micfil_volume_sx_controls[] = {
 			  MICFIL_OUTGAIN_CHX_SHIFT(7), 0x8, 0xF, gain_tlv),
 };
 
+static const struct snd_kcontrol_new fsl_micfil_dc_out_controls[] = {
+	SOC_ENUM_EXT("MICFIL DC Out Remover Control", fsl_micfil_dc_out_remover_enum,
+		     micfil_get_dc_out_remover_state, micfil_put_dc_out_remover_state),
+};
+
 static const struct snd_kcontrol_new fsl_micfil_snd_controls[] = {
 	SOC_ENUM_EXT("MICFIL Quality Select",
 		     fsl_micfil_quality_enum,
@@ -1047,6 +1105,19 @@ static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
 	}
 	micfil->dc_remover = MICFIL_DC_BYPASS;
 
+	if (micfil->soc->use_verid) {
+		val = 0;
+		for (i = 0; i < MICFIL_OUTPUT_CHANNELS; i++)
+			val |= MICFIL_DC_BYPASS << MICFIL_DC_CHX_SHIFT(i);
+		ret = regmap_update_bits(micfil->regmap, REG_MICFIL_DC_OUT_CTRL,
+					 MICFIL_DC_CTRL_CONFIG, val);
+		if (ret) {
+			dev_err(dev, "failed to set DC OUT Remover mode bits\n");
+			return ret;
+		}
+		micfil->dc_out_remover = MICFIL_DC_BYPASS;
+	}
+
 	snd_soc_dai_init_dma_data(cpu_dai, NULL,
 				  &micfil->dma_params_rx);
 
@@ -1071,6 +1142,10 @@ static int fsl_micfil_component_probe(struct snd_soc_component *component)
 		snd_soc_add_component_controls(component, fsl_micfil_range_controls,
 					       ARRAY_SIZE(fsl_micfil_range_controls));
 
+	if (micfil->soc->use_verid)
+		snd_soc_add_component_controls(component, fsl_micfil_dc_out_controls,
+					       ARRAY_SIZE(fsl_micfil_dc_out_controls));
+
 	return 0;
 }
 
@@ -1117,6 +1192,7 @@ static const struct reg_default fsl_micfil_reg_defaults[] = {
 	{REG_MICFIL_DATACH6,		0x00000000},
 	{REG_MICFIL_DATACH7,		0x00000000},
 	{REG_MICFIL_DC_CTRL,		0x00000000},
+	{REG_MICFIL_DC_OUT_CTRL,	0x00000000},
 	{REG_MICFIL_OUT_CTRL,		0x00000000},
 	{REG_MICFIL_OUT_STAT,		0x00000000},
 	{REG_MICFIL_VAD0_CTRL1,		0x00000000},
@@ -1143,6 +1219,7 @@ static const struct reg_default fsl_micfil_reg_defaults_v2[] = {
 	{REG_MICFIL_DATACH6 - 0x4,	0x00000000},
 	{REG_MICFIL_DATACH7 - 0x4,	0x00000000},
 	{REG_MICFIL_DC_CTRL,		0x00000000},
+	{REG_MICFIL_DC_OUT_CTRL,	0x00000000},
 	{REG_MICFIL_OUT_CTRL,		0x00000000},
 	{REG_MICFIL_OUT_STAT,		0x00000000},
 	{REG_MICFIL_VAD0_CTRL1,		0x00000000},
@@ -1179,6 +1256,7 @@ static bool fsl_micfil_readable_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_VAD0_NDATA:
 	case REG_MICFIL_VAD0_ZCD:
 		return true;
+	case REG_MICFIL_DC_OUT_CTRL:
 	case REG_MICFIL_FSYNC_CTRL:
 	case REG_MICFIL_VERID:
 	case REG_MICFIL_PARAM:
@@ -1210,6 +1288,7 @@ static bool fsl_micfil_writeable_reg(struct device *dev, unsigned int reg)
 	case REG_MICFIL_VAD0_NCONFIG:
 	case REG_MICFIL_VAD0_ZCD:
 		return true;
+	case REG_MICFIL_DC_OUT_CTRL:
 	case REG_MICFIL_FSYNC_CTRL:
 		if (micfil->soc->use_verid)
 			return true;
diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index fdfe4e7125bc..e271c6073f42 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -22,6 +22,7 @@
 #define REG_MICFIL_DATACH6		0x3C
 #define REG_MICFIL_DATACH7		0x40
 #define REG_MICFIL_DC_CTRL		0x64
+#define REG_MICFIL_DC_OUT_CTRL		0x68
 #define REG_MICFIL_OUT_CTRL		0x74
 #define REG_MICFIL_OUT_STAT		0x7C
 #define REG_MICFIL_FSYNC_CTRL		0x80
-- 
2.34.1


