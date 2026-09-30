Return-Path: <linuxppc-dev+bounces-28620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53892CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 21:59:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hw8844x5Kz308f;
	Thu, 01 Oct 2026 07:59:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain="microsoft.com:checkpointcloudsec.com:microsoft.com"
ARC-Seal: i=4; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790787344;
	cv=pass; b=ZUK2ODSe7L15BzekXWNx4j+FOjeRu+qkDM9w6lFmtwwnCH0zs4ONHPKCnfdPFe+GzQ8Euot3easWpfdVmlFt5LvZSWMgiVzfZbSf5DTFtwnQMf1n6Ij8bLVmb0DWYGIMEdXIkdrIXA1+fGdLziS8ILajLi+7RREI9DZanqUmYixd/z0OQuCXbr9c+X0ubF7DH+K5jP4OpjrBG9Czed9p4GGJ0R8vyekR5rFMkpfmBTWR3Ab0Yrc3bQ9Cvv0ymcUF4Nbxh2gcb533uYxmZul8HB67WYy8rE8FW/EO5ehldbnXhLC/BlWKtn+PPIO6fed+KdJS7FWohsnhDaWSICNblg==
ARC-Message-Signature: i=4; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790787344; c=relaxed/relaxed;
	bh=5LPn8Gj8Zi+y2NRKm6oiIdlZQWeAy7rt6uDXNYpaF5U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mwtTwkERDRyf5rp1qi63p6uFGr5HzHIn3Jkxt2kHGGTdLYo9+y9lL5wrSRBibFZbniyVIqF5yjaW3byo77PmiaPtI6UJk/aCytKU8VK+3oL0Gx3RykjPGiGWO+5iECVYFTNe8htNqRBJ9FQmbhoKBJKkNeYLPE9obvLm1wnqi4FQ6wxTVnXEWdVlLU50v56ECasTqya1tHCQB9AJmsHbwzbIouBufZDVLLyuJwBBGT/EkUtvH58nfv7t2IdTk3FhV0ELBJ32oj2rCrkbX7qoo6SjUpYLwjFjJ0qQuhXdYiF1N2tXIj3CjDIDEzqQ87OL7sI3lB0UtCXY74MPhz2LNw==
ARC-Authentication-Results: i=4; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com; dkim=pass (2048-bit key; unprotected) header.d=solid-run.com header.i=@solid-run.com header.a=rsa-sha256 header.s=selector1 header.b=cEWaTWqR; dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.a=rsa-sha256 header.s=selector1 header.b=cEWaTWqR; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=josua@solid-run.com; receiver=lists.ozlabs.org) smtp.mailfrom=solid-run.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=solid-run.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=solid-run.com header.i=@solid-run.com header.a=rsa-sha256 header.s=selector1 header.b=cEWaTWqR;
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.a=rsa-sha256 header.s=selector1 header.b=cEWaTWqR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=solid-run.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=josua@solid-run.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hw1Q76brPz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 02:55:43 +1000 (AEST)
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pEQ3byEKm1weQsl9wWgFJ//9nzjbf3UKiC+ZPdSS93fbxjXodFdvqr6vuJQ31dU0OA0HDN4Msw1RO5V9J1U204oM/4QAIwTvGKhx9glDb52rtaauC+vtXbny8ir3emqibmIGDIQ2d6QV44Wca8MLJX8/I3HgB1q7O6LsTJLHonl6dkTFpxitVxhCwpEM9hBb28q2yYg30Eu33iiphMPKWNMT4niFap1mNR75g16GQV5dN5MT94+SDiWk7oDnvEsFoa6EXR0HCcqRLRAWOel8ANpTYYhq9nki3tdoF+IKHsflV8cTY2mJcSnBaICt+12wIvCvFGK5hqWtZrZKSvsnuw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LPn8Gj8Zi+y2NRKm6oiIdlZQWeAy7rt6uDXNYpaF5U=;
 b=T/44UJaW3vcCr7V+SJXWsP95oV2L1J/PzRUIEXcobpSn383VFrYmxYxqNIqizceEw1XmkFXDu0y8KeVRnkCiBZtLGjL5QPimuQYoqHGWZAIMZqetfmtDtGTK0PXMOHKbWCsPZaqYuD00CB7pTd1N0zFj/bfEp/qS1LdcEhSxsv5NPR96K8HKzVMU7rymKCQN1Cc/VIPWQgL5G6QuH7gjUSQV6Fxf1eaEp3cf/oJML1352p4X3XCtaGUiZP+u+tGV4FH48HAP6ce6Q8Cy5mHBQq4s1qSIONrfp38Hm2x3EnAuMb/CX9G2LW0UvvfQ6GvDlZNGZvZ0bE0xAI8AdALppg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=davemloft.net smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,2,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LPn8Gj8Zi+y2NRKm6oiIdlZQWeAy7rt6uDXNYpaF5U=;
 b=cEWaTWqRVspLEM77RusCM2MXQ4Ah1KD4A7WwFpNdvIpgxgL3WTDdK4SLqoIoo0nKxbDe63Bd1fWrmR7Yp58eIAni28jhV/eq6Nvc9wx593gkBGDovyp0DN5HSx6o0nVqgb9M8psgAeO6dkIlAkZ4Siak+pKidCo0aqWBFM00yi5UocVRmmGB0Awp6dmcD+CwQVAly5ZQIaACdbA5uJQbw0oGfY6ORHioP19F4qIikFWcPV+vbSxQ0UgLwHmGm6LXXsiAK9J8iAyFPjEIqtGTlJFeWr/Y/lBF3N4WE8xXGZnC1gTtzbCvPhdahQJLGCfZzxEayIxEhM+Tr1cExp8nfA==
Received: from MA4P292CA0002.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:2d::19)
 by AS8PR04MB8691.eurprd04.prod.outlook.com (2603:10a6:20b:42a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 16:55:18 +0000
Received: from MAD0EPF000008B9.eurprd04.prod.outlook.com
 (2603:10a6:250:2d:cafe::27) by MA4P292CA0002.outlook.office365.com
 (2603:10a6:250:2d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 16:55:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 52.17.62.50) smtp.mailfrom=solid-run.com; dkim=pass (signature was
 verified) header.d=solid-run.com;dmarc=pass action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 MAD0EPF000008B9.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Wed, 30 Sep 2026 16:55:17 +0000
Received: from emails-5762875-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-124.eu-west-1.compute.internal [10.20.6.124])
	by mta-outgoing-dlp-517-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id EA1CE80FCF;
	Wed, 30 Sep 2026 16:55:16 +0000 (UTC)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1790787316;
 b=LMz9Fnyk6as1kHcDqnIMDokqMWhKFx30uYJsYyRh6NTCTSiiupat7G88kNu0kDYg/5mNm
 8RFZrMuQkIvlr3cfi61Pfre2n/M9qy+pmqyzD+FpsaCS9vGz4Xc11LHQNdM8yok/M/8VTND
 Kbgpht3wif80Gu/n9jbKTfE8UGzjmk4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1790787316; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=5LPn8Gj8Zi+y2NRKm6oiIdlZQWeAy7rt6uDXNYpaF5U=;
 b=AFEOAiYvGed8lmBBv6zOtkUgOq5LEM502fYlKw00ZdDDMlVdA6jMlDcKwO5jPHKMfKz3B
 lH6+l5eBAg9OBHRhEwyd8AfN+yuWUT3oAT/YPC6TdolDofEXozbe3DLIUaRMwrNtNihah/Z
 rkYaWeu3xtgUQomH16EeNcPp703ecsU=
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com;
 arc=pass;
 dkim=pass header.d=solid-run.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LPn8Gj8Zi+y2NRKm6oiIdlZQWeAy7rt6uDXNYpaF5U=;
 b=cEWaTWqRVspLEM77RusCM2MXQ4Ah1KD4A7WwFpNdvIpgxgL3WTDdK4SLqoIoo0nKxbDe63Bd1fWrmR7Yp58eIAni28jhV/eq6Nvc9wx593gkBGDovyp0DN5HSx6o0nVqgb9M8psgAeO6dkIlAkZ4Siak+pKidCo0aqWBFM00yi5UocVRmmGB0Awp6dmcD+CwQVAly5ZQIaACdbA5uJQbw0oGfY6ORHioP19F4qIikFWcPV+vbSxQ0UgLwHmGm6LXXsiAK9J8iAyFPjEIqtGTlJFeWr/Y/lBF3N4WE8xXGZnC1gTtzbCvPhdahQJLGCfZzxEayIxEhM+Tr1cExp8nfA==
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=pass header.d=solid-run.com
Received: from MMZPR04MB400504.eurprd04.prod.outlook.com (2603:10a6:190:28::8)
 by DBBPR04MB7499.eurprd04.prod.outlook.com (2603:10a6:10:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 16:55:05 +0000
Received: from MMZPR04MB400504.eurprd04.prod.outlook.com
 ([fe80::2f52:2d22:c7b3:4292]) by MMZPR04MB400504.eurprd04.prod.outlook.com
 ([fe80::2f52:2d22:c7b3:4292%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 16:55:05 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 30 Sep 2026 18:55:00 +0200
Subject: [PATCH RFC net-next 3/3] soc: fsl: dpio: skip isolated CPUs when
 assigning portals
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-dpaa2-isolcpus-v1-3-66c13f4fd75b@solid-run.com>
References: <20260930-dpaa2-isolcpus-v1-0-66c13f4fd75b@solid-run.com>
In-Reply-To: <20260930-dpaa2-isolcpus-v1-0-66c13f4fd75b@solid-run.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, 
 Pankaj Gupta <pankaj.gupta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, linux-crypto@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::20) To MMZPR04MB400504.eurprd04.prod.outlook.com
 (2603:10a6:190:28::8)
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
X-MS-TrafficTypeDiagnostic:
	MMZPR04MB400504:EE_|DBBPR04MB7499:EE_|MAD0EPF000008B9:EE_|AS8PR04MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1a13d9-37fb-459f-0006-08df1f139b04
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|10070799003|1800799024|376014|7416014|52116014|22082099003|18002099003|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 WvUi/evIzIOJew+r4o4JvzenGWF3WKA25IHvNTa94S7cV9TKNvfEcWI2qfr9KqKfxtJPrzmJTvytGTykJyOqAqI5NZKtUtbwLTA8Rb8XpINvhGwrS97PTqhuoG6qQs1I2nHjYwdNxKORcSK5GwBC2c89+kB2rjYxOH36jGeYah4Dh2UYw/9NVksQp5VWuPxdEPMGIWcgL3JvX2qE1UnPpe932S8iPgl+B9YJh/cEdZ4b2BDL+3MCscPbTJv9CrV62Owp/ViBkR6Psj+kpk0uaY5erdcMfYs1cT33ikYby3ZO5ng9zzsLVrtW99lVQHdNkuSOMprwB+pta4qT90hXzreR7Rnuvk1Vdbt35+APLzekV4K8oyUcVQ9c4M2Nh5cMyrpuwt296Dhlkl3tLNrjueWV8olOmu6pz8m5B5j42MHoMLSSvLhmbDZnSCXgALtmzzSYL7bEfE5E9ScPFcZZlEt8oAqixe1XlkPsyvXEIouQv9uMhp1QvC/wvqLjn8vjyYhAn3YmF62Lc5odbyg7akfPszZNJvWbyf9lDdHdxGGBgrPkMHEuEYLeVU9yEpndPSo4lyr6THTrZxMtjiGcfa1klnuCcjYXPyROZlkpG282igrwsF2TM0MshTD9Hzm1wB5RuAGJ7CraxOpGw0/FsbCkHgk0fdTdNmtUu8dpfKd1U+Y3w5vSkIdTfUzk53h3hy2rZRSVTAyOOw7JtlIFBA==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MMZPR04MB400504.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(376014)(7416014)(52116014)(22082099003)(18002099003)(921020)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 iTptYOEwJjUNT5qIhnfX816OVFbOHbwkujlogQsPI8eGQnsmK3fDBo/inLSMvWyo2ypOQnZjtNkE9xC9P960vmOQqDVt1Dfs0+m99GzQ6UO0K2LtPCKb9FbNYGqb6dIOidVBswU5168kNa28J7K3BTvACs4506pMHvdW5+epTIJ/iGKGPTrZdHkxsuXh2+0ClbsXn2b00PYsfUrSSUyqu1KZ4n8TZiuuJsE3wdGcY8NFuGUHO5OIUZyIhRcha0tlR2gulwFhCdW9YdxBk1uHaQMnIJhT1HTvQ6Q1Teaw561BUlQjlQVeX/hsWgn1uoj1efmSaAr8ourwimW3Eq+NMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7499
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: aae9d9f2896440feac83b33e239a4a2a:solidrun,office365_emails,sent,inline:776544cf20a4f6cb347dc8a29c053d94
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXP5Ab3u46w8jQL5ySgSA3ZAZeLV7i9dSP22DotiY1xmRtT4q4TNc3hiw7eWjQk9wTtiPo+T8Gv7m/DQVUA49we870eC6gtoJ3KfxOpIsO0Gy6HF6ej5KxAfAlCDYhnRiG5iPQbr0t/TXibybJFbwAvhmH4cITShtl345A3gOlT0mwfQ835OGDD5NfmFEl30qlFXOx9RoZvpvGcZY01eZgrMCHudsKXQISScdJW+Zj5BHvG8rYLN3sk7AmACZP77k+aslFN5cs7L+r7f56HF3BEydFQ81+JW5iDjEEHHeY8RQAqvzCIDj9rwKCMeDqVpEZMfvrsxlaDzUpPOXv3HIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LPn8Gj8Zi+y2NRKm6oiIdlZQWeAy7rt6uDXNYpaF5U=;
 b=t+zRZBJktiYHtWUfS78x0qn7Ah9ODkBO+zpODzzXL9hTNlYACuacnsmdd9IH7wEN9sVVe9QBiWxDrGaJqvK3WeNn89NBlwp+/L4GlGnFSRv8Yv5o1AIkWfch5ubHZJNjCM4/cnGfVJP3NZ84scW7FPTFLNyipeSzkGcpRn9YgLSD2JVFwwy5fPiGz5gSi/4vndD0an1AUEW012iGw6Zrbl11tKKg72sg6TCBic1ggm13rkO0wIz9i6NDySDktGbMueGQksK8alJwd3GkxMOj90VN+Qy7A0hTGlHHPZMCTGUba6uQj8Wclyxtl2u3audzea9SiaUz6ujF73hPktWPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cdfd2247-a7df-4d32-0481-08df1f1393a9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|14060799003|35042699022|82310400026|36860700016|22082099003|18002099003|921020|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	pQ/0jBknsi2A7aU+XXUKHvE7J7MM4Uja9CnQDAFfUp9vY0KIeFYMxiITkWaErCmSKqni+5SumDsVqavNIo9oSI72aLrLwtNUFXa9hrgjosfcQv29RjhPxcrjgN0YQZhIrq4TBUITIjeCGX2bmq7gMv7HgVq1d4cWjWqug5yuzkdMH2FFlSVXO6mIJI+EFMC+gA1S1d9MgmFQ2m5L8ek32mHlJY5eaBae2HSAdlJyt5CiX4SnLt4xwNCzMh2H5rE+bxGRLNJLxy7oTdKqmSbwiOfTd/83EIDUjysE6fNg2beEqc2H5T9K3J6UwBPpVvWCEqbCf6a4YuP8r8MLMO1Vjw9FW0mxFSGp+crivF+qjkCuWtzffy7NxHBfZcZcf8Q+wyXv7dIyawpRGL68SUdfnkBiMkl7zJ19uZ4QmGYauM7piktZhMbxYk/J1vyJwcYPXfSErn+cYQkmGP1mYcsN2yyyLcJeTovKeMyIzyqHfJNDcGRWxmkGvCNCTxkOWpS4gOwuYTggwGZBt9wi05dTYv7hderjrozOdT37dbGSr88/b7s1M3GosiBj4yRzRftDkEGKpymu039NVYZeq/AZ+s2q1OolEfaJ5cTy4hSSv9pJo1aDbh8ETLGbOgo9UB+D8CY/ycR9cvP/nErM5gCpU7lhRWnDDu3nVpAwTu8VK7hfJGvRHHQR7cPxMMiTEYY1/eF00lFSTzU89HZK8G8OjCydblK6VCYVRVrdRgjvwPrKkTK1SNLD7z4Ua0+s5kxf
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(14060799003)(35042699022)(82310400026)(36860700016)(22082099003)(18002099003)(921020)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8OEz7wRNKNU/nOTOj6ZpP9dDuGP6o8hR9B+/z3Jb8mmPf6OnYWO7irFQgP3TEKYbraNCWnzbhu3pK4PSyLRQDs6dLP3mzOcNWh1IsBkF9/NKShsbgGMRft9JJrFggU0+eCzmrZ1efQQwD195CdL/tH1XL7mUm1hZlYoq78XnUU6qB/IJFQCDHnZNR4OuVqo+OdlWw00HC1WLizYPB2X2Ryen5+HnhNDCE1mAVsMuyZ/RAfSzXaaLQF9LbFX0v2gYOVMRZHDP5JGX8ixxgBsG4aM6OjrSDMlFDEUMlkjQu4Y5bEPVHw4vmcp1mGEhURkhL12jUMhyPfAS9NPyHf61wy5R4PlSLMYw21GfSqkUYrvr5wCOT6c1/K1GgDdrcq26WzONtxajc6anuM7lYm5zceuwtgCEWWeBGWSWRyF4GFz/ESyFnqFwYwJyHt0NNRXl
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:55:17.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1a13d9-37fb-459f-0006-08df1f139b04
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8691

During probe, each DPIO object is assigned to exactly one CPU, and its
interrupt affinity is set accordingly. CPUs are picked from all online
CPUs, regardless of CPU isolation.

The dpaa2-eth and caam qi2 drivers use one DPIO per CPU and follow its
affinity: notifications from each DPIO and the matching NAPI polling are
handled on the DPIO object's assigned CPU.

When isolcpus=managed_irq is used to reserve CPUs for latency-sensitive
applications, those CPUs are expected to be free of routine device
interrupts. However, DPIO interrupts currently continue to arrive on
isolated CPUs.

Restrict the CPUs available to DPIO objects to the online CPUs in the
HK_TYPE_MANAGED_IRQ housekeeping mask, so that isolated CPUs are skipped
and left to the applications pinned to them.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index d5198ffc44550..242db78affb95 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/sched/isolation.h>
 #include <linux/sys_soc.h>
 
 #include <linux/fsl/mc.h>
@@ -173,7 +174,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	/* get the cpu to use for the affinity hint */
 	possible_next_cpu = cpumask_first(cpus_unused_mask);
 	if (possible_next_cpu >= nr_cpu_ids) {
-		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
+		dev_err(dev, "No unused managed_irq cpu left for dpio\n");
 		err = -ERANGE;
 		goto err_allocate_irqs;
 	}
@@ -317,9 +318,11 @@ static struct fsl_mc_driver dpaa2_dpio_driver = {
 
 static int dpio_driver_init(void)
 {
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
+
 	if (!zalloc_cpumask_var(&cpus_unused_mask, GFP_KERNEL))
 		return -ENOMEM;
-	cpumask_copy(cpus_unused_mask, cpu_online_mask);
+	cpumask_and(cpus_unused_mask, cpu_online_mask, hk_mask);
 
 	return fsl_mc_driver_register(&dpaa2_dpio_driver);
 }

-- 
2.51.0


