Return-Path: <linuxppc-dev+bounces-24699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AE0C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 01:18:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Ctk1yggz2xl6;
	Thu, 23 Jul 2026 11:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784769518;
	cv=pass; b=C7GdNwkCulSGeSgqQTcu0X2kaLuzAvPJA9KbrwrojNOk7SPv3sZjEOvccPKfaHY4I9/VFXofB3Kup5VjbIrdmvK3SxuUez9GwPi4+YA3k1Ypp3aRvbkSpHFuZox0cTd5dy7tDDMIaQutpVpSX4y8xF3tQahu5EZNq9xOXNTLRJycLHCW2SxoytkgjPh1OSEiB7HU2fD3zhjae7MyJ2SHQQTE0KxOntAXncsK225cOqq8oUDiFcPfVTnJUmg4vzH7BbZVWt/knT4BD4XIrxfVsjmwgrKDYGMatiVlm8KFgpcUM28FdATtE9lmS6q2l6ybC6jdgp1l9MvRvDnMHrDsYw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784769518; c=relaxed/relaxed;
	bh=klKU2GZtPXRyCh6iQm3N3OfLMwTD8mTqyzJhp1lf/8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TOkDtBVHP3KodRLCcYinc6GH2WWuKYtehHzdU5JLCzxbGycpXED9Fh1oWqLQUZJNcvZ0sTnxtspSEF4acW8SMuwT8vlNg9vLy57Meu1FmFj5nC1sWeHrMU8bK6M0Oe+HjteVhjUlLNMxDO6E096YfrAC0o4caJGJ+hBvDoabAWpT+cF+9ei5a8yRDVSZ/pTqf8mH7uzDR1jBDIuzSYJr30f2y4ftN17Qt6NRbOPZo0eHTKXgmhvVjEoDI5Fo832YpkO4byhXkzfmhoDWkntBMVaCYJObmgbHEm/7CUhJw6Kj0T1aY1+AVSG9vGIvKB4zgS4MNHRTtLdB+YRJHVrXXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KbYWCBH/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=KbYWCBH/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Cth1n3Wz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 11:18:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL7J8zuZsL9n3I9LR+CtDuj6dh/r/1BeVHLefv7eE1juyvjW36uWcWRu2HdqX/z6jwUN4xXj/tTNMg3MjqBzf+pL9k9QlO4pXaNwox2l+kBcxjyZWyjcI/sculti7PNrYJPtQftY3q99OACdE3nEJcWfEbxjxjTFktyrD4ghbaxCvCkyIoSUC67YZUJUyvxWqV6Lq39JxeClK6yU+kjbBwmURPM+u9tUer75zs+DYHikKc2Cw9Iui8CHeF2KhcO2Sq9XW96GdBFb4ZC4YhPNQtTZD3DJtBbiHqBdK2EbDSR0sQjXFX8zjNeVSBl21kXyr9wWpN6ae/0LJKoBpr49RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klKU2GZtPXRyCh6iQm3N3OfLMwTD8mTqyzJhp1lf/8E=;
 b=y2huGvwn2402c8kseIreWg/+DEQQAH8HC+3HJw1piW0d1K9tNy2VQL3msgLiFSsnO8A+AL7zuB/u9FWGzeG6aOx2x75Ardgy4xO01fJjpoJOBLySax9h7XHmhsw378PSpVHeJJXB6MiC482o2dZl+RuhrWG7o0ksb11wsK23KiHc7+hKwu2KfLmm8z+Ohky76ESXfDx/fWLaYhDvbZqP7ugZ8aVWVyXD/Or5JQ8vP/exhgXn+B0f1/LhFgoLGPNq6rxx6C1BVA8WaKXeQqNM5mjAkXQLmOsvW5x/0hNRv3R8yVuaKqwoCE3KWtIut+ImvUmvEcQmt7F9SKlkRMCOmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klKU2GZtPXRyCh6iQm3N3OfLMwTD8mTqyzJhp1lf/8E=;
 b=KbYWCBH/F5rsnJWtm29PBtHedIlCkKlr2PA8MW3DYOUgr5xk96RDKMM5CuFgIkO41UuZWe65kXkG5q3dpTeL5iCfGe1dhtW/lIjVV9vHMnTHil+ix7a1jBWJSxC22AsrfsfFTX2nM6z0SIDqN3MjXXqR0i2EgCtbqEZxwv/EcXNKHkcExTdv8PQCqf3j9LxvPtCOnXzOxnj0RbMXxpNxv2E2Dj3PHZFhQ2UBchGBtA7CQcdtO6TBok662UGsSJtvvjwvXMNXsDEp9Ttfa7nRUr8KyWUybmhmS66zwvVyAy40xgz/kBpfTl0vinpozm1WYm6bDzFHdmZZgvx83QHOrA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DB9PR04MB9991.eurprd04.prod.outlook.com
 (2603:10a6:10:4c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Thu, 23 Jul
 2026 01:18:06 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 01:18:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Joe Damato <joe@dama.to>, "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "chleroy@kernel.org"
	<chleroy@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH RESEND v4 net-next 10/14] net: enetc: refactor SI VLAN
 promiscuous mode configuration
Thread-Topic: [PATCH RESEND v4 net-next 10/14] net: enetc: refactor SI VLAN
 promiscuous mode configuration
Thread-Index: AQHdF+1I8fWr44qhJkG8IHPkqQ1oArZ5iywAgADG9dA=
Date: Thu, 23 Jul 2026 01:18:05 +0000
Message-ID:
 <GV2PR04MB1173938AA2F6026E023B8476588C02@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-11-wei.fang@oss.nxp.com>
 <amDEtJmcET788Lls@devvm20253.cco0.facebook.com>
In-Reply-To: <amDEtJmcET788Lls@devvm20253.cco0.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DB9PR04MB9991:EE_
x-ms-office365-filtering-correlation-id: ead0d4a2-cbc5-4d74-f937-08dee8583f98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|23010399003|376014|22082099003|18002099003|38070700021|10067099003|5023799004|56012099006|4143699003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 wf1QCvX5Y8X4rqzJr0o451PMzNU6Bve5d6sPjQjHtF2utdy6qBBGDqAJO6cqRllsSUheEcBqOBqWmeiyE/cZTAy68cj5vIpg8Z5p7lTtwPVQ3rwKu2QldCMoagkhr3wkYbRdM22sHGflJ+2C9w7+fu8lUhfDcNnaCQR3KgJ9F6kRSjnhJj2JHMKttIzkmIF2gN9Hiyi1H4xHj5yruTJpz0NLtKXNa8BP1KMxAwI7Vry507jNXmeqtjqkCRVQjtAf22K1MaeU5m7uZhU6JNHtx5dQtuUJ4eGNoDJeGjjDClM7Y3oe9+h0p5H63QugiXGWU0CpmpYghzlfmKV4g8W5CTRl97yoxiAsWrszHSsLl2Kkabgayldz9e3bAFkbpfyoOyNY8zdu9F0ctVwqdv9ub/ImxvrEu7KEK+iiQjCqHf9Z4613Q6xXE+nEtzXapszz3uBoRKepGZLthvjmS6jJMBeS5VDHqtM+SnIa4ZTG1dgbpBe7GyQKldbcPCb/gNmx0iyxFGqOYwh6HR31zDN89Tz+LNXZmDv7CuQi1b4RQlPZkFWzEAuaHtp89XH2MkHoBZJkgdAtlkx7Ve5IpcqH4e4MfUpWsXBjxxipp6RQlHT5iNbotWKFdJf92a/JrELSIAr7Z4CmUwxVWP/ynRHzwlBc8ypyDfY374UpiSP9oOXyXyOYB6GK0BOiiKmZL6kYE3F7qfK1lfEDgrQeYTZZ/P8oMak/YQnborAYHyx/f1Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(10067099003)(5023799004)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cshZouDiUGd7q14uOvRy3hY2UAmv8/ACs685XIeIMNlFvDC0T5Ni1zEcz4lv?=
 =?us-ascii?Q?uX4nnDqV2/jx1lXW7QYGmUb7RsdscsfFkmTl2n/mMhqRvlFh14EkiRnKQgs3?=
 =?us-ascii?Q?D94HgDmS1t18e/j54QWWQREXGEhZJNovGPdY/EhfBeG2SozvgBAq3SsfuQq4?=
 =?us-ascii?Q?WoA8l5KXeW9UiQiXfVlV32sttxajdT/yoNvfgL6RqQHOJ641dpKKgRMwFNau?=
 =?us-ascii?Q?FQLUZiCY4J0ZO/uPiyCXRHagdWcF8aHhWwrVzl4j5fECshWH6yWUZsnX77yf?=
 =?us-ascii?Q?MdjT+l++qB/C5alOGF9V7KaAMW2pjsFbs6aSetU1IKaHvV/FktdwUXAIQQcS?=
 =?us-ascii?Q?AU6xfWjdMRcpUX2pK8/EZz5dhTQ06bjL6AT0VV8M6vvvFwTYrmZNRiTb+kv8?=
 =?us-ascii?Q?ZHPkikX1L35TJIJiRm6cUjPdE4mLKd1W8+acdGOEpLQDbk6AQcGuTBNcrnAn?=
 =?us-ascii?Q?jsnD0DMIQP+Q4PMq5OnS56cu39hTVWpodtJ7fc+P1QTU6gXOsLv9KbiEqtxt?=
 =?us-ascii?Q?tlqv3RMOLVeq8N16fntxf1HAP50kU6y3zQd80Uba1Qp9TSm8qlNDEtOvcZAW?=
 =?us-ascii?Q?t+s8GD5QeD4NfvyBw7nMqQ3sHXMPqcPOSlVSQGETetVpMId6hdIZ+GjoocDz?=
 =?us-ascii?Q?9rpJnwuKHPfhhWCgIscG0jP1qBz3JoXX2OIIboYjWjSEwg0UB1kasSZ/Xrxm?=
 =?us-ascii?Q?utm+fwq5xOMqKUtwXp1Kw1OVFpHhuV2RJarBXfektqsW1Foxrcf9oLH8InVo?=
 =?us-ascii?Q?luiu/kHGkDz82u35sXC/I8enIkR0D9GqmufhZwW+5bpsM1XTWQHWogb1vlh7?=
 =?us-ascii?Q?v9dsJj0YN6YKz1mdnQ//SDauYsO1BuvdodzkpzT/lO9KWIaEolehXrWiOIYk?=
 =?us-ascii?Q?6LJ2E/XKUYtKKkjdZQRl4747JNhWrMF98gZQ9yywVmDpgxecfebeLS5xoxNd?=
 =?us-ascii?Q?pUQPKwrLNLbqmppTkrZIsHzlUiwwDE0m9vpH0qm5wAziAyMFJXQGXOC+VBmS?=
 =?us-ascii?Q?zVUrymi/juyiTEr18jaMkBPANG+Qlqx9UQt60o8Syi5zslaWf/UcDMcWntM0?=
 =?us-ascii?Q?7wOqbDSkLk/lJb1DVucPidj+cyHHtxWjZBNLpv1ik/Aq417p+GG43rnPh/4K?=
 =?us-ascii?Q?09hMxCZcvZ6itNQlTAkTU6pzmC42+uciWdtVf68R+weViVMRqvmhSwWvlppi?=
 =?us-ascii?Q?8S1FKupdVpoWUMuBWv638Us97cLVX41fTAHfrHUeImlOEELk+8sVPuTtDdZX?=
 =?us-ascii?Q?ZFfARjjmtidiVfkls4b5Lqug+Qf0e7i4U596jos36JBldWlVFxkEzLIavTrJ?=
 =?us-ascii?Q?oFHKmNaYBr49eQdrqVYgZf9MXcR1wW/d7XpHLCGC3k5Toc8jtyue1kuideCO?=
 =?us-ascii?Q?+gqgpbXWAGJJ5qrr+dUzCjrBEC1nXX0RKat6+cMeVsViaYT8bR7VPjknTj2R?=
 =?us-ascii?Q?Hh/sMNwRytDzruVPCimJ5dhTyEVYsUZ/0a8SFH9fA+CHrnGHbjd/hqka15NS?=
 =?us-ascii?Q?v+MKVjH4lIXkwN3yrrLT6pHP6TI3f3kLRolMzFs24yVQs+3E7rkyTKAacNZ+?=
 =?us-ascii?Q?huz6UCEh2w+ZscKq8IismD7tqHLDYGv1zW5igNT8p5sTTtp2aYbzn0aJP5h8?=
 =?us-ascii?Q?/Ay8qb6PhH/ZhD8pxGtKfMM9BvOce0smFEa90yf2BNfWzNzbzvDwHMVDbu57?=
 =?us-ascii?Q?7P0pKbAwfTwKUI9QukfAi/iR8lwgoTZcWN2/EFtOyV/A0+Rx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead0d4a2-cbc5-4d74-f937-08dee8583f98
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 01:18:05.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTcVK1OUKWFAwFErFPmoFjGeljhCMDBMehQoGjuy3w7905O3aBBJPvE0F91VjWZZSyw7upp+zlESNNMjuqs90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9991

> > Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
> > enetc_disable_si_vlan_promisc() functions, and introduce a new unified
> > function enetc_set_si_vlan_promisc() to enable or disable VLAN
> > promiscuous mode for a specific SI. This simplifies the logic and makes
> > the interface more straightforward. The vlan_promisc_simap field in
> > struct enetc_pf is no longer needed to track the current state.
> >
> > As ENETC V4 only changes the address offset of PSIPVMR register compare=
d
> > to V1 without any functional difference, enetc_set_si_vlan_promisc() ca=
n
> > be moved to enetc_pf_common.c in the future with minor adjustments to b=
e
> > reused by the ENETC V4 driver
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
> >  .../net/ethernet/freescale/enetc/enetc_pf.c   | 36 ++++++++-----------
> >  .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
> >  3 files changed, 16 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > index 66bfda60da9c..16da732dc5de 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > @@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
> >  #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
> >
> >  #define ENETC_PSIPVMR		0x001c
> > -#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
> > -#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
> > -#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
> > +#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n =3D SI index */
>=20
> I suppose it would have been nice to only have a single space after #defi=
ne
> above.

I intentionally used two spaces for the macros that define the new register
bit fields to distinguish them from the macros that define the register off=
sets,
making the hierarchy clearer. :)

>=20
> The rest of the code looks right and I think the promisc logic is clearer=
, so:
>=20
> Reviewed-by: Joe Damato <joe@dama.to>

