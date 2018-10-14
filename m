Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62082C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:23:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D5020881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g33sdKaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D5020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRgD5vMKzDr0X
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:23:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="g33sdKaA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.72; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="g33sdKaA"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30072.outbound.protection.outlook.com [40.107.3.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRRk4s7gzF38m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfK2n7Ae+5RlBZd+X6EbwHtQP9Su7vGFVutmyvIpMjY=;
 b=g33sdKaAtJigwSpHO9Z1fY/Ya+rVDxVFGiMv6Tc3GXyU3yRX4mHczqfCnUnCXt7CrD4nb07pIXybCc6M56yy0njUBe9f2aRgocF/RkDk24jlDAZO+aYe5a+Ci+YMOcqIheP3lOMMwkrVebyweXVnJoIJGY2JFyyZTqjxrz16U7A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:29 +0000
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
Subject: [PATCH v5 3/6] clk: qoriq: increase array size of cmux_to_group
Date: Sun, 14 Oct 2018 22:38:00 +0530
Message-Id: <1539536883-1928-4-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::22) To AM6PR04MB4790.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2affe336-210e-4ba9-56f1-08d6325cf54e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:9cyYuginx0oTZ3yn4lZ4F6yGjLv3Hd5DuC4VzPfjqP4WMKN0KQ9iTMSW1uMXlzcMCGdI5NvbRjE1VtbXMnomyXGXnYrFg1ZnxgSE166WFKYQ3BIeLRK1UfigjrXiA0jadp/t4PPlWtCxSRfymo5bwuM2tuGomdjFj8FlO8ze0PgE2x5An2XTT9PYVGwo5WgqapYysTQPcjf21EZD90EgPJYEP5npbMx4K2cRvbY/tUQiPiQKmo75zIkpyV22gY5N;
 25:v3Icbmto3edQ12zG5CA/UnJydOKoqHA/pumY4EEIsHsqgBwQg86WIoM4AgIGJjtTPHLTbqLNhlFAT8s+dscH6GPIrZc6pZ8U0bms941TYcKNq8qUZ7XZ1TyX+sCu85MPj0i4I/BjgENzPnPla8NiQcjpQdTyKfslno4XUVO26l4Mxj47/EZ8TBdMgn3MPiZiAxpmd2qK5WGwYBF8RxI0ClTVfOaRi2dubWm9JeCQaAz14Z6KyrIkzJ/v1k24VXuKUTTLVvxeve3+z0l6yTx2PK5IaMsXVDbZzoWpbFK9nyIu0qg0KBjdBTphdRIB4OEjKEWPPkp7k9VHtpL/yByDKg==;
 31:HKNembB8WptZzi/zr3MnSW1Mmi8wqtpsma6cCHmPEqXxkbxsovTcuf0q4I6GK2FXpVHvJ0wD4C3grikU+VZSCQjnUgjflQVcj3Hq+yEeh7Qv89vfO9P1tUae5IIdjkNqCX5g2LcPiWA8qxhrwNb5S9x7d72TT7ZQNjLG0iVISX2wHDHQ5Zl5KEehe5L9FKGj8LGxEXVcNVd8b+2Qetmd+MMr/FqOTUdHOrYf/YxkZHQ=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:nw2gjDMclqliOza9rz8USwAOGIqrwAClt6MgwK6NbGclwvm9pVW3XPHdgqUWuN65euEPwXmvavzxrRieQGxTF7GxrgAUKKyr334qKZ6QN/8dnDjhRPrwn5wtnjpJAT7H2j5XZAYDfGkw9hmAawXjOXX1Jv/P7JVs0rAXyuFk2sADUNmkbSb3UnE4h6eUNKLsl7lppA32tT8BXqgJvyrMrWhxcVtsKjl5c0h/G+MEjJw/FYUIF20z9Uyys+Rrv0ARrwYv3W1GNIMBMMqN/tJFXXEA0wamlIjmGy9smpA08l0Je/3ugyrlLqf7OqdwHP/ELcHQjUBqqjB1bwjPhW7Pp91SpKCA7X6q7set0k1Xp+4r14hAy/bUGjIkC4MyNxf8gWvsJsOGyefYGBNYiD5rX4/1VhwCKOrS7iZ3cSHjxgPAyDQxBzqMzZRFld8ZRTutOcjdv94ag235gDZijPZH2CXXpSnZ0pqriFQqLKRbaZO6Jk3UJa0wkDnzbz9BBpq4;
 4:+IAFAoE4h9TRkhnTGEsXK0pcWBSNdCpfKpgsDwwyo0I+kIa5VFUvr6cn6uZ/nzRx5sjeqb9PCz9yRPboJvM+GFF7e0hzfGc4xUzUlHoutL216HsXqqmHU/0T+NHj0JQXTdSJ82imJdWNDXmizGWd1yK7zktASYbtIQLGQAoYEME4FDgc0jC3RBBASh6aO3+ZOytfCm7R9fgS1/fwnwZPC0X0yc7fFEnTAR0ASdC9fe9kkD0wJkrIjw5Aq7sCt+/KZyriwybiv1tVLa5yjHesEioua44mwq4+TV8vBijxPM27sW754fVjvKqogzYX/nAc
X-Microsoft-Antispam-PRVS: <AM6PR04MB4790D1B6F7F84B2CBF6A92C3F3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(478600001)(6512007)(2906002)(52116002)(51416003)(3846002)(6116002)(1006002)(86362001)(14444005)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(48376002)(26005)(106356001)(36756003)(105586002)(446003)(11346002)(4326008)(76176011)(386003)(6506007)(54906003)(55236004)(7416002)(6486002)(16586007)(110426005)(921003)(21314002)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4790;
 23:CPyVh8Hd9DLA/x/Ht7U7IPFYnmm8sxaLbscFTCeNa?=
 =?us-ascii?Q?Oi012B4TUkxiWWcYG7GpzeKOqAW1f8HmBL29U9iUqv0kgsSdD2/wGk5wTKRa?=
 =?us-ascii?Q?Hof0Y9TXsBLkNu84eofbSzcvTPzcAJnGXV+tauYt9lzwU3xuiEGUCPxy2fqc?=
 =?us-ascii?Q?NP4yFSZN6AG9nPmBqK5hZA3n2ASPArFdCMB/pbBDpiYqjvLGpboMm9kUWhsW?=
 =?us-ascii?Q?ri/22B00kxjBm5PRwwZFZYedsMMVGHFe5L6+97vRL/150YvAMn9P/xLImHW9?=
 =?us-ascii?Q?4jGeupujRZ/WbjKH/J0Om0UEVuc5TEbsXrA+N3v7klBnLcMDnFacouF553/I?=
 =?us-ascii?Q?8DH/TLMkGbd7ps24bQOfDp0k1T2qXRRUO4CvaeA60nvq5zD5DYH98u/6cgFJ?=
 =?us-ascii?Q?9sV4CyhUPCFn2shzUsMoWsRGLgQoqu3x6N/2jIWaWfd5kkt+H030BI5G8muj?=
 =?us-ascii?Q?fAtmyZ2gU5uE2teBBPyHFsM1YJS7pt82z/WtBPAFjU1m0S6XrcqV2zwzeb0y?=
 =?us-ascii?Q?q3zpJ0a5rztUAh7yKEhFJOSWbrj6jjoLffaNsGK04edOoTpCOj8Cmiu6FujI?=
 =?us-ascii?Q?xM1WF/nLiIur0ine/L1+K0kYNm+URIyPsOtlwVaWVXpf7mGD1nHmgrN6X8e5?=
 =?us-ascii?Q?RBmcy9ZmGE+hqtRV3CrL2fh4e/2WaoM6YukLIcJs3HBeIv6oV5KGqGhxICN5?=
 =?us-ascii?Q?cGo76ixXchKcK8Cw58eWRTD1L0UH+D4MxWoh5mrPrznxehpe8msqgHZfWQAQ?=
 =?us-ascii?Q?Pkq+K4HBCkD/x+++GkarppvXxUYkI7wYU99f8WrQlre/Hu8+990/jv+FcaPK?=
 =?us-ascii?Q?1lZUDVKMHMFtM1qAwjtb1hh3nEfmLfVxKKH6mClxCeij77ehqRjHwOfiIcKP?=
 =?us-ascii?Q?UJualIo8G2fTt4XruV5wskEBTO7yFmJyYEqeneGLrKF/oTfbbpvzymqG/xM4?=
 =?us-ascii?Q?nzCqXXupBZcMiMt8QzBbgn68CGmJwrY/o9arTZlQlw23V7wnOXOC7/x0DkVJ?=
 =?us-ascii?Q?BVtSgvYDYR2inw/1dk5T9+AJXFSLpg1g9He2c0SVgWRLhBDu3DsZYHK9kBSy?=
 =?us-ascii?Q?qSvEv8UsYPNstDqORRenhlp5p3nLIAKbgcZhDWA8dM8Cx6BtO/rrhOQEoTij?=
 =?us-ascii?Q?bmRuK5jzJTuQCC92ZuT/mM6RxcOKgHCSZTGq3SZLsM5CPkJH7Kq7eUmV3yxn?=
 =?us-ascii?Q?jz4HAPYRwX17B8Z7nLnz0j2eNdekIy5+h2GV6XUS9BKqsDZjy9c1TQkNP8kD?=
 =?us-ascii?Q?NnTvtscYkVk29zZ1jUpy+Xqc1nIn1JENA/rQOiZnxf1XtukZ9yH7VeLe0IY0?=
 =?us-ascii?Q?r29f2hhmL4DcGbFlBdKVHVUxoVLyn3uXvLJwjHQl5LVznn+WGTBQq9xkC/z+?=
 =?us-ascii?Q?pbV3w=3D=3D?=
X-Microsoft-Antispam-Message-Info: WeZt7BS94LpwDfM2PZ7HazGEkQ6ofHq+25vSaGPdoHjV5jMgPym2cYgMN0WFDuE4Yq9M7hRiKlxjQedKa2kbOH71qvcgBN8AIMCaZpDP5K7ixLIBKdYFot5eqvVgKsJ0j0fjqhyRQtzSXgkxSXRk6c1/wNSvdvY5mFnFGxaah4dgtLRYL3pVzKCkrxYCl2prYZTUVfpYimXD1AIXNG8gp6oup3TmMo0UKXVRbxcIhmApOWzHe/SscLGMtyhkcxGC2hlWsFuQTnVxlj/ARSN2MzP40URXGLsgxuVbdFjMCuQ8vM7T9XKE82sMhsspZXHt+BuTkdp71CQcodtcr6Pq65ZRdMsXH7ERbQWl1JFzgNw=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:g9yrKQqkU8j/X0+CUUmcHrtCdBZUW4vGlr/P8SI5xyxwHGHW60ZcGZV4kLLOHtmp2FFmW4OdYSOjGJcQFFK/VmTnV4YOeopVXdeaG2fN9WotYI9nGKmjloaJ08PzXRAY1pWAweo1vSocwrRK4FUbOZswr/D696mvU5DyGkAJeToNR1dCeF69a/iB0JBuv+T2QEfDEVSwwTFFgxoU4zPKFaV8IkLp4S808NIhdFKzPrAch54SxVIlF8QAvtXQ8c9UajkwYpUyIfJXJi+ZsDZfY2GQRRXQ242WMrIZbJQZle7gecEoH6yN+iS6/QXicsn1ffFHNu1whiqIaL59KIxHRLeFPP67uw9WvI+1ToO0MoXFYBmdtSEeSS3A4SQGNNVKdCGztgJHoL1fhjNzvxP3Quqmj7FPK4c02mroZXjYQMsxB496LmRz4EijHslHktS7Sh10NYmvwVgjRZgLeUnn5w==;
 5:9uN4hUCdQk8S0PB5ZzBhngGjLi3M6akb9CmbJc7TGQacNdxUKMHuEzWu/dD/VxT2lByufA1S6Sq2PlD4p0Ui6r+EPGTVDsVG0Viu1sBJfP8m9/5ERbijzXJfKg9ey01JcrW6C9mu25rxnRr4/W5U96sDgK6aG1Ms0TTsWYQgmek=;
 7:FbnQ9cVGxh7ayFTKKqBsW1ZB+9tRtf4TdSVjsuW5SzIt1yhDkmXSomcjYwCTnh2yOdeJx0I3d3+B5kJbrOKP1teHV3ayC1CY/VAedkqNgODSM/KnnolxgY6uR5napDi7yGwHH/VCkkL9EFVqjcMVDOAEI0wv45h7EL63soSl0HefCdiyehK7ryWk36XGCQfrG6ys8FWTk/C8jiO/m5ICkZnfZyo2yqogun26cF6a5DdPIIil6Kkc3IQ0EaN74b71
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:29.8256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2affe336-210e-4ba9-56f1-08d6325cf54e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4790
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
Cc: ulf.hansson@linaro.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 udit.kumar@nxp.com, pankaj.bansal@nxp.com, linux@armlinux.org.uk,
 adrian.hunter@intel.com, V.Sethi@nxp.com,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Increase size of cmux_to_group array, to accomdate entry of
-1 termination.

Added -1, terminated, entry for 4080_cmux_grpX.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/clk/clk-qoriq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e152bfb 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* array should be -1 terminated */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -601,7 +601,7 @@ static const struct clockgen_chipinfo chipinfo[] = {
 			&p4080_cmux_grp1, &p4080_cmux_grp2
 		},
 		.cmux_to_group = {
-			0, 0, 0, 0, 1, 1, 1, 1
+			0, 0, 0, 0, 1, 1, 1, 1, -1
 		},
 		.pll_mask = 0x1f,
 	},
-- 
2.7.4

