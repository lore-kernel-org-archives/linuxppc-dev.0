Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE99C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:52:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA782084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GTXBHlPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA782084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QvTR1rXzzF3LZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:52:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GTXBHlPp";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.70; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="GTXBHlPp"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00070.outbound.protection.outlook.com [40.107.0.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtWW6z4YzDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBUYz0ZAKkYCX+vb0d2FcxP8RwdATIPUWCf29kJ00mk=;
 b=GTXBHlPpLD3uepooUf0el2fz3d9vf8AC+4opxEl4Ks1YJKw3SzZSerdJXq02/fyMIWpBagErIOzoIsccso2P+2QItvnqH5T2+aAG4LahFrDuWKDAgzWshERpoXV1ldGCY9+zaOZIWptK5D/QxMv4+xsfpCDugEG4NBMqzqdLRqM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:08:58 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org,
 arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
 leoyang.li@nxp.com, shawnguo@kernel.org
Subject: [PATCH v4 0/6] arm64: dts: NXP: add basic dts file for LX2160A SoC
Date: Thu,  4 Oct 2018 06:33:45 +0530
Message-Id: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM6PR04MB4792.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21a3ea9b-bbad-4d86-b0b2-08d629fa8ec6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:8XCplk60EZHXf3taaIklrEix0W+8tiRC4A68EWf3y+m6hnfDRWGGU7M/mZ9XloK3FZVFFP2EJYid7Th4ZepU3s82NpHzPtogHkbxyl4+RfI7n9QC8IZBwUgtsMpsD8h4OMcn6XY2gXscSIi4KHm/q3eZQEQlu/nkOWLMjBE3jkdmBqJjTuCZmrkMcsbcaFuDT+2bMh0gkmMt7YpNLpOCvcNR4SjQR8z9/XxredCP6EcWewD1psaFd4ZfzblcADiy;
 25:u6GWxDlKUjXLxVxT6oBk+006i7SIkdGIhwHYDFKDKghbEMRheCDspxGLnUct5NFlcBoLNWcLjHMKu9Iiq+S3uEt72NeZrzScI8J5GrCxhm7OAaHDyR8sZ/646nkcWaZzKpO+n96yG0u+ON0emeE08T2Cd4+LCtGn8pXQ41qi+3HD8OPPLSloc4QWj0TQ9N0oexJU6cAN6mSdJlEnoJXkq9MGW7pFBCFERNGT+PeibC08PGLaqNHCytnDxKX06jU2iuZi5eXmG+E1PrM+Glg4PvojGKXFmO+Q89TQIbWN6rs857zFGVkt2KVP4Bt2NpbC91HIe3DaAVADwhWkMKwP1w==;
 31:ySQzxMULgFW0aYCoqVsspkrTBfpCWyuPaMItL5QCN7bcX3CI+1rzECHnlVbXJlBv4+i7d7+2iqArNTzRE6I/XrhLRtmTmw6SH1tS14x3D+sHW1cWYVqCJtXAZVKdW0AXHk9UNQ53bDghVgvpKOqU/we2IigMYXXYyN6DQ7Y2B9S01j+m+Kbs2JZPnXRa9iNp2aoKZmfewUS4xRsjDBUMukL5sYulyb2n5pdbbpVUq/Q=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:kBSugg13aJXbYAGVlBPO1r6b1q7NCpKpAztO6uk23xMw3gRq1RvLOKGPwQEegGjKIZT8dqxICH6CrEqWWWRqm2vioIygZpWd0lXrq46aFGERcjBtNTPLlz1S0JDLMb8JorQKqnJR83CPRUAHBmMkJ237uLelo6Rj5nmYg0G0vb9xhHk5mWYhWt26VOXQS9PNPrdkKQ+UkQHUknNWlTwHkXbbkHyYXxDxG/zC7AEYGbcfsNJyqCoYSZE7i3UBvl0saoAGp0GkHLGOVdmNXFJWRtgj2+3xnjC8uC2nDzFimhzFpRstD71sSrFzhYmIZbLzytofr/Y6EC8H0s60F+ywJ/BxFWN9bNoHXBJfv1oIuvBNBCgoHDj0fSuuao40yQashlTDgpIqMSVxgp9GHcQD5ZTLYMukUF/NLKrnjHvP0qAR31qkZVbwNN5CRMeVSVuad0w3EFGyJxy71ROaJm9bONqSqbaADQhvGdCgN2Kv7Uj2QKld/Vkkzvzn28dapymD;
 4:VZdlRnpAD8luoSIq2KoQ8nCA7QU142FH31sJUa2G8Vp/9bTF+4RC6Vhn/bqt7RGZqgqbw42lGhhFtT8Stf6Pc4J5bTl0q5AIBGz8wHPNhIhfHwvt90lN1Is77FcBqdo04htc6161VMY2BqBB1M4jzIvSbW2Z7Uq1++G2moxxGVbb6D77XFFXgOoKtSIlO7fOWtoFWtoTY2lu9x0FFhKizD0oxdVUANQzxOyzmqmLSeNvcSNzWk60mcY8r4xeN8/UGMc3CHNAXlrkhPDEdMnsmA==
X-Microsoft-Antispam-PRVS: <AM6PR04MB47923C0177D7587FA7F63EEDF3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:AM6PR04MB4792; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4792; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(97736004)(106356001)(8936002)(305945005)(3846002)(7416002)(6116002)(7736002)(6486002)(81166006)(6512007)(478600001)(2906002)(53936002)(50466002)(68736007)(5009440100003)(105586002)(55236004)(6506007)(2616005)(956004)(36756003)(386003)(16526019)(316002)(476003)(5660300001)(86362001)(66066001)(186003)(44832011)(25786009)(486006)(6666003)(26005)(2870700001)(8676002)(50226002)(23676004)(52116002)(81156014)(47776003)(4326008)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4792;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NzkyOzIzOlB4d2hIVmhQSTRydXlaNkRjaFNwbk1Xa0pB?=
 =?utf-8?B?ZEkwU0ViUGRrS1lvNW1pU2NqNEp4Z2NHbVd3dmtmRDh3Sm1LdUpYdlg3SzJC?=
 =?utf-8?B?VDBEdWVRRm5NT2ZibEJMTUVsdnZiMlkxQmd5U1V1K1lqWTlQTXh3V3VMekxZ?=
 =?utf-8?B?UE5kd25BaTZiWHppekRKWkZXMk9od0xxQzB3WUU1T3lHbWcvZktFVzJxUnJM?=
 =?utf-8?B?bzR3NzlFUWw3UjdKeXl6NDVNdDB0Nm5PdWk3dCtHL2x2MTk4S3lLb3RtZHd5?=
 =?utf-8?B?Y3hDbmsrcHNacWNUc1h5dWxJUWZVcXNmRDlpaUZkcHZkVjNRbHQ2ZzNBWkJv?=
 =?utf-8?B?Rm1QQ00vVTZvbzMzcy9STWhoWXp6RnArd0JMU2w0bC9NUXVrWVBzL24xWHRL?=
 =?utf-8?B?amJRZndQT0k0MXhBVDF5L2FPTVJjSjZlYUtuaHNWVVN2Q3VwR0pJNHNNRHBQ?=
 =?utf-8?B?VjNiWWhuZG55ZHhHM3NRWHBZLzhWazhvU1VWZkRLdzFaZ0RNbS8zWkdzUThz?=
 =?utf-8?B?UGNKbjhCU0RsQnBJUU9Pak5ONnBOaFdGUStEMEJ3U0NrVGRUY2g4SnBtTGwv?=
 =?utf-8?B?VmYrUGZNU0ZydWFZbWdxbDRzeFpLVGxvK0x0MXhZV1kyTmN3b04zN1M2TzBS?=
 =?utf-8?B?SkZoWWlQSHhBa3hic1RaUFpUV0R3WnJUa1lLNGRIem1mcGdhSXkrNFdWckli?=
 =?utf-8?B?NUNFQUdNMUQwci9TODZTM3Z5dUFSWmd4YTlNc0tVNFoveVc0U081T1pJKzFP?=
 =?utf-8?B?dU16cUdvYVJPSFcvYnMvVEwwRmsvd2dkS3VBRk5GZ3dNa2FQQTc4RHdlWVU2?=
 =?utf-8?B?ZkhPaUJsdGZzNTI5ZS9GWDZKdEUrV2hvaWRnUUhaTGhjT3JZTnJSZHdjMGpZ?=
 =?utf-8?B?YWR0TE52Njg5WDVuTHkzNzVtSUgzRFYrSDI1UjhBRUZoYmRYa2JOOGM0NmJ4?=
 =?utf-8?B?Rll5Qk5mOUQvWnpEdDNlanIxOXNoQlc4OGlTVjRGcnAyQWc0Nk1zSlZzVHkx?=
 =?utf-8?B?dWdTTGF0YnVoSG5Pd2VCR3E5MExDaG4wWXpEcktxSGdSZUF1NkFRSklzNWln?=
 =?utf-8?B?U0hsd3BGaUN1LzhXSkJDd2RjYU0wM29RTXFNaWREYnhkc3dkak04Ly9OU21J?=
 =?utf-8?B?VzJBQXdCSTJMZ1pITElaNFJyc3pPRXY0OTJremczQVpnOGprdVRZZUMyVTRy?=
 =?utf-8?B?ajJ5Y241Q3doTUpLa3JQZDh6cmtUdEt5NWNSQi9yNVArVVFjRkU4MjlveUEv?=
 =?utf-8?B?ZlhaSXRvM0Z5dWVqQzFGOCtTVUNjOEJaOWtwOHlzWlVXdFNNN3NKaHVMR1FD?=
 =?utf-8?B?N084Qk95dWtvaCtGenZzSVVsRDkyL1ExbHdDblgwK0hKS1Y1TlAxZlh3aDJi?=
 =?utf-8?B?RVRsTEduMXJOVlh2NkhKWWxWUmlHYjI1ZW9uaWtzUzNia21qcGh6VTI5dkFB?=
 =?utf-8?B?NVRKK3FneWVGU2hGZkw3MGRxanZ1Zk9mVUxXdVh4bzlYcWVPa2VqamdEbmtO?=
 =?utf-8?B?UnlUMGlrQ0pLcVE5Z3NOWUdQV015ZDFMWXZ0YlI3V1JCRDR4LzJueGFwTnFC?=
 =?utf-8?B?WUd1YmpyKzE4MTBIaWtKcEIvWGExSm9yQnJKUmN1ejZLdmt6V0ZLTTFOYlQ3?=
 =?utf-8?B?VDNVMGFNeDZqTzlldlVTT0VsN1BBT05xWUFhWGNSbXZYelNseUdTM1lBPT0=?=
X-Microsoft-Antispam-Message-Info: iAe0xQTDd3ueEO1jVTMfrR6HX7eI007pP6JKIlpuoEWILOTLZo1CwjvsNsGb7Sx9+ojsGzhkeI7lk7wNJy/RNPZLZ6VAP/gxNlAXvgWfe9xp12KkjqpUu28pqU7sjzZGEGJ3jGPNIiaRgwGyJahnGXgfcTOcaymsDINO0pz0teFFTU/0nud4YALhZFvkbRX+uTOudSDvhfrqUQMI4YPRb62Su3GIXuEr5TpFZ5VcAYZVpLRgePjlfTkmXxzYY1hGB/VfNwz0Wqq9UXN/ZdkpUaLKxN9YV09L5PeDkTQD3E68VOdxS/EdMk8jXLISYHRrWWS4NFr9yiotMf+MKYoKlFCAqR/ZSmVsfn70sc3C4NE=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:+EFQfvggGvnm/NGx2C/iUii/3QWFrP9Kp2isWeHjkPS8ioRgGvNJ/OnHuz7FxeDdY9GaSJVogGyVBM0V5Oc+T5lxeKIRjNjOpnkVkxc7WhEtdI3X14RABXSg4pRXfoTqPGbqsc6O2q0fC/kzIttf08k90jMECp12VBjTT7ZkS1i73b80g1KBjS676QAmZU6cVU88S/ycB9SR853gyWMBHCUaR6y1lXbfuzJpj+ki/i7hoW2zwsuHkP2LtrcATYfQ4uarlA/gOLFE63NdjfUZfkIUSUfwJK1VUTpIhaCA/iZUmcvJEsJQ0en3yQK3JarXOBECjwfZo6IfSlGt1EkEtdRMinnoBJsOTaYHrU70ZDqQQb9dCHA0m5sWVYVVl1t+MHIyANyZsj7/Ieo70vs+n6z9j3clgrcnKEYWNojkuT7ftgoeBc7fP6dDd8gqet+yc9KlaDZh048QJdA5LLeiDQ==;
 5:/bGYbduBpeXniy8FhNKTSWdjkXf9ZoUtorZeXEm+QeewJb/aY9gVSilIBgPBsxlvjxeScdY+HKVyb2/o8kycYhf8/0p7qIgRW6d32InNYaQRn0KU09c5518/o9871L61YpAY6iD82fYMOx38jucMVimES4z0O21EPbQJFlwCOfc=;
 7:QRmZvjkBAADW640Xj7ScNHjMbswWxTeEHinNaHjslJBdPnhKWX2UV86+NxbHUhoSXPUvI4On/Ynx57V7ggoLZL+CvsxVzz+knya8gcGC6zXAPGgrSRCl5n7XUFoc/F2Yv0IzGj5195mqubTiAosPCPsd0mgjpwFQjfb8cRUqwj5YPWxVx5bHhGZsekEOA39lB03DtJhite7aAts/5mfXpZZmvLRWP0P9o/m1MhkrUcAHNHGyiLPJTeVVUDL1ekn4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:08:58.6575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a3ea9b-bbad-4d86-b0b2-08d629fa8ec6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4792
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: pankaj.bansal@nxp.com, udit.kumar@nxp.com, linux@armlinux.org.uk,
 Vabhav Sharma <vabhav.sharma@nxp.com>, V.Sethi@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Changes for v4:
-Updated bindings for lx2160a clockgen and dcfg
-Modified commit message for lx2160a clockgen changes
-Updated interrupt property with macro definition
-Added required enable-method property to each core node with psci value
-Removed unused node syscon in device tree
-Removed blank lines in device tree fsl-lx2160a.dtsi
-Updated uart node compatible sbsa-uart first
-Added and defined vcc-supply property to temperature sensor node in
 device tree fsl-lx2160a-rdb.dts

Changes for v3:
-Split clockgen support patch into below two patches:
- a)Updated array size of cmux_to_group[] with NUM_CMUX+1 to include -1
 terminator and p4080 cmux_to_group[] array with -1 terminator
- b)Add clockgen support for lx2160a

Changes for v2:
- Modified cmux_to_group array to include -1 terminator
- Revert NUM_CMUX to original value 8 from 16
- Remove “As LX2160A is 16 core, so modified value for NUM_CMUX”
  in patch "[PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
  lx2160a" description
- Populated cache properties for L1 and L2 cache in lx2160a device-tree.
- Removed reboot node from lx2160a device-tree as PSCI is implemented.
- Removed incorrect comment for timer node interrupt property in
  lx2160a device-tree.
- Modified pmu node compatible property from "arm,armv8-pmuv3" to
  "arm,cortex-a72-pmu" in lx2160a device-tree
- Non-standard aliases removed in lx2160a rdb board device-tree
- Updated i2c child nodes to generic name in lx2160a rdb device-tree.

Changes for v1:
- Add compatible string for LX2160A clockgen support
- Add compatible string to initialize LX2160A guts driver
- Add compatible string for LX2160A support in dt-bindings
- Add dts file to enable support for LX2160A SoC and LX2160A RDB
  (Reference design board)

Vabhav Sharma (4):
  dt-bindings: arm64: add compatible for LX2160A
  soc/fsl/guts: Add compatible string for LX2160A
  arm64: dts: add QorIQ LX2160A SoC support
  arm64: dts: add LX2160ARDB board support

Yogesh Gaur (2):
  clk: qoriq: increase array size of cmux_to_group
  clk: qoriq: Add clockgen support for lx2160a

 Documentation/devicetree/bindings/arm/fsl.txt      |  14 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |   1 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  | 100 +++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 702 +++++++++++++++++++++
 drivers/clk/clk-qoriq.c                            |  16 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   1 +
 drivers/soc/fsl/guts.c                             |   1 +
 8 files changed, 833 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

-- 
2.7.4

