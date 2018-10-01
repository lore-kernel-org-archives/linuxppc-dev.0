Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F3BC004D2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E391420666
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 00:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gKQ9eGnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E391420666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nk6K6cbhzF379
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 10:43:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=microsoft.com header.i=@microsoft.com header.b="gKQ9eGnn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=microsoft.com
 (client-ip=40.107.68.117; helo=nam04-bn3-obe.outbound.protection.outlook.com;
 envelope-from=alexander.levin@microsoft.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=microsoft.com header.i=@microsoft.com
 header.b="gKQ9eGnn"; dkim-atps=neutral
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680117.outbound.protection.outlook.com [40.107.68.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Nk1b5DT9zF368
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 10:39:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=204mzPZMljKk5ODWVO2PCmqA2kuAGfKT2brLk1FmatE=;
 b=gKQ9eGnn5cUROl5WTDkgNpQw2tpicjeOqZOFhh4wk473es6EGk9FQz/BSMkriBo/gyj6E21dD5tVKpPjEDD3uQHOi2ZbohVRuGSD1gghrfOs4pGuKhoH3PMsrmgP9sEUYelfoZLWcoMw2wVmfpSIxoi/94P50Ub4LCGjuzFilZY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0824.namprd21.prod.outlook.com (10.173.192.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:39:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:01 +0000
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH AUTOSEL 4.18 47/65] sched/topology: Set correct NUMA topology
 type
Thread-Topic: [PATCH AUTOSEL 4.18 47/65] sched/topology: Set correct NUMA
 topology type
Thread-Index: AQHUWR8UySYKXmodaECkVPHVM4hIsg==
Date: Mon, 1 Oct 2018 00:38:31 +0000
Message-ID: <20181001003754.146961-47-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR21MB0824;
 6:mVGie5u/BLuVKgfRkzI00tYoIeW2THuWwqs7tPqEeFwCjQomBVlOOav4AevFX69GDDpAIk/aydm2UvmxSfQxQ6wEItY55zKt8uIXu82srmMwa+nzPqo7fZzHoufO95uakM1DUIKVek/2ki/9SNYbLtgax6Hw9yvolOD/tkK2kUor17zPJ0t7cK30s/EH5viS8u6PFPXKjwDt2mUtvx1XPce1U4j5AZi1sn5FCHb7LykHZjfSwwLQTwbVJtROWO9bHOb/yeLBUzMZTesp1AE1z9Zur2zsNsuWnfj0wtCBW1aawyr1tKzCEYAi3PDLXRlE8pCiVKy2Pz6pkaB5AENXMlrhIrvwDJT0U8BPCdUD+RR7Karm1RirRDqJ8EmVzZHxy+KeOZ6s5QsG2JQI6YSgLwNjkEqsgBF6H3LwyHQ8WmGJhBYOT7hTFqcD1GWdV6XI8uzEzBw8Mc9i0j+X9sx/Ug==;
 5:EpsBYeVdKT0017ZRZmx1z+PdgzOoGxCNvirhArIBfeOl8y+HVmz/sNN/FiPu/GWLe74TCzKHGrTgpFv+vxmpwUeYaCPXry1YzO8otOU44wwSZpCcWfUafEx+aK62iSqX9BC8yg5lStZwyxuEBYoqEVXOijjQihajqPRxrsevc6Q=;
 7:sLaFdHkPy5xaTqJxNhBbzOD0k+FMWtnf8AoUTamA51YLwAyMeuXPoS7ZhMOWMS1S+UGoRobCn5pYL0C5ik5lUqEWWYzY7tiJdL5/0vAPXg1jZrXFFaI4+FHd7tljL84XGXgaUQ/QAOO0/9A7d0ilYeIIweoV1GhW6Q/+zHqdzSrMpmQZNwXZVb30V7mfNsjqSDzPpsT8AvEnXREXz0H4Y6nNG4jzdVkB2bHVyU95fntLbfbC8vjnsTLzk0Ekd/B+
x-ms-office365-filtering-correlation-id: 8aeee115-b1d3-48dc-99c6-08d627364819
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);
 SRVR:CY4PR21MB0824; 
x-ms-traffictypediagnostic: CY4PR21MB0824:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082439826885AB59F537F8B1FBEF0@CY4PR21MB0824.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(42068640409301)(104084551191319)(190383065149520)(767451399110)(65623756079841)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(4982022)(52105095)(2018427008)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);
 SRVR:CY4PR21MB0824; BCL:0; PCL:0; RULEID:; SRVR:CY4PR21MB0824; 
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(366004)(39860400002)(346002)(396003)(376002)(136003)(189003)(199004)(256004)(99286004)(86612001)(22452003)(2906002)(25786009)(7416002)(966005)(2900100001)(8936002)(14454004)(5250100002)(36756003)(10290500003)(76176011)(2501003)(478600001)(316002)(68736007)(8676002)(72206003)(305945005)(81156014)(6506007)(110136005)(54906003)(7736002)(10090500001)(81166006)(107886003)(66066001)(486006)(86362001)(575784001)(6486002)(105586002)(11346002)(476003)(446003)(2616005)(53936002)(4326008)(1076002)(6306002)(6512007)(217873002)(6116002)(3846002)(6436002)(97736004)(34290500001)(102836004)(6666003)(5660300001)(26005)(71200400001)(71190400001)(186003)(106356001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0824;
 H:CY4PR21MB0776.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vQ3g4PbbqeZYz+6WO8OqB8vYXaIp24GGM5j2yF4qo9UYEpJ85PXFWcXO/PuK48h3QSVRoPJXDxb+eluACAUKmrD0gIcgFteFW9MDoeVIa7CWDjry2sRcHzmRih/bTSKDDd/bM0z10dZX93uwl/Up3HDnqPAXyfQverTa23EgV34Cimexni2HS38v3NCInHt9aCKySg/RS03/pFA2kRcWbwivmcPwbNvOFQlhOcTe5QoK37wt39HiYvwylvLzwdHdbJgJiKhvmNT1aGnsJOpdY6ZrmdQnyD3g3trHGLUo6shQ4u7WhRSmJ5BL4oaXOoIr1kYQsKcaNIrUeR2inHCvysD1NZ6nODRyUHqD6cx6q1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aeee115-b1d3-48dc-99c6-08d627364819
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:31.7745 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0824
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Rik van Riel <riel@surriel.com>, Peter Zijlstra <peterz@infradead.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Andre Wild <wild@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

[ Upstream commit e5e96fafd9028b1478b165db78c52d981c14f471 ]

With the following commit:

  051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain"=
)

the scheduler introduced a new NUMA level. However this leads to the NUMA t=
opology
on 2 node systems to not be marked as NUMA_DIRECT anymore.

After this commit, it gets reported as NUMA_BACKPLANE, because
sched_domains_numa_level is now 2 on 2 node systems.

Fix this by allowing setting systems that have up to 2 NUMA levels as
NUMA_DIRECT.

While here remove code that assumes that level can be 0.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andre Wild <wild@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Link: http://lkml.kernel.org/r/1533920419-17410-1-git-send-email-srikar@lin=
ux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..505a41c42b96 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1295,7 +1295,7 @@ static void init_numa_topology_type(void)
=20
 	n =3D sched_max_numa_distance;
=20
-	if (sched_domains_numa_levels <=3D 1) {
+	if (sched_domains_numa_levels <=3D 2) {
 		sched_numa_topology_type =3D NUMA_DIRECT;
 		return;
 	}
@@ -1380,9 +1380,6 @@ void sched_init_numa(void)
 			break;
 	}
=20
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *
--=20
2.17.1
