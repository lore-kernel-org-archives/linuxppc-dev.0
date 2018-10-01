Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51353C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 18:23:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988882082A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YD9mey0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988882082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P9dP2X9XzF3BG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 04:23:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="YD9mey0l";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.7.44; helo=eur04-he1-obe.outbound.protection.outlook.com;
 envelope-from=ioana.ciornei@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="YD9mey0l"; 
 dkim-atps=neutral
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P5vn14YqzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 01:35:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPYlgqgE0D3x82exSYZbB52QfKnQpd377k+FbV/r6Z0=;
 b=YD9mey0lM5mBNi6fDS2KlnwQvAogSYVJkvd7PXAu0it9esG9ofZOwLoFZ4qy1QYxArKlCg3Vdr4DPrurwKt8wjrq/R6fA/1jWIA2Viq6A3gUZYxHoZ91v7C0wmyyJPZYh7ogj7Ca5O226YMi4VFcsJilnM32phv6ywSnAvzaHzU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
Received: from fsr-ub1464-137.ea.freescale.net (86.34.165.90) by
 DB6PR0401MB2357.eurprd04.prod.outlook.com (2603:10a6:4:4a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 15:35:17 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org, idryomov@gmail.com, sage@redhat.com,
 elder@kernel.org, jth@kernel.org, benh@kernel.crashing.org
Subject: [PATCH] driver core: device: add BUS_ATTR_WO macro
Date: Mon,  1 Oct 2018 18:32:52 +0300
Message-Id: <1538407972-9340-1-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [86.34.165.90]
X-ClientProxiedBy: VI1P18901CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::31) To DB6PR0401MB2357.eurprd04.prod.outlook.com
 (2603:10a6:4:4a::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e086f1-e8dc-4c24-c747-08d627b37d92
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:DB6PR0401MB2357; 
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0401MB2357;
 3:iGO3BdKKWnYaozEtkXLbrihEOvoeohyBmmsqzgqvIXCj+nW1Kxaf0jg9kly0eIYw8YIBuc2ObjED1XkyMZxd+E74oCD9RsTyt7EnH9s0/al7JIKmWxzI3SvDwIlFxy5HDMSQVGd9a611JHihfBAz02ysgidw9hqTRdZRQzGKZJe+TgK6I4MohjgSQrm+Q5SGa5ySR9qxW018B4gowcE1CmVu+kPyAL9r1DF2RctP4QShh/S42HP6W+VNyXaub/DG;
 25:iuqeGSvgdZG6kzUPlbDibJCPBSOiwrrsZe+YuVe7KxO/HHkbXw4xnje0uv2SWLCNLxN9tlP/1uKC5QXXyQ+vUKe+oh27GhJO2WLSRy7wvTdHYMnwGRHETEVsZveRtF5akJiyQEPMAlt4ay0NbpO/ZLQQ9Ux1A/DVfELJ7PGWybwJT/wzecAUMpjRt4xupcwuL+PNPqW10p+lTFTJHWTjbpZXYV/NhNl2oMHFnLt8fRXoKaerSIcIbUvQSWTkVL/PZ2TAAA0GcF/WNmgyJxZ7ItGbESAsUKn7EeRFrlvimLYx7GhYltAU+j/olWQRYMdyCLkAOhpR1+gaVpBxg4XFYA==;
 31:acnC9xCfXfogs7MVPQya6iY7rxWdHoTrqocGQplotD5Xk6hDExShprR322NYQtEFoDgHfAVyIMA/bjt1MB3dSx+ioP+6QCCpVM672+VYdSs5YRJeLWY1DUe2BNcW+WvOHU1zj+PH5LqNtISkcJsYqRCJTiPByhRLl61jBseWmSs07GKhlVVbJDrCBMEtw4wLP2rrA9e0cYQzE19XJnqndhfTyCERGyl5KbpGsxYLfLA=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2357:
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0401MB2357;
 20:wEJqfZoGCsXmXjzqV4ibt/EobMRqZHBZ+hmbpiujYhC2pRjQ/RIPlcm2pJaHIQJ9gIOdnZuSyU+7W9q5BY8JZI9V+BB8/XSjetVYyk+xdN9O/RyBhHPXfXZbNyKE5Q99FD2ms2SYWk3xTXb4V0YWTq7DSHrEYyjQNxw6Dmns2CMXO7scSW5iRd1jVagnEG4IzhSWA+19a4XqU1q04IPIEKKqLQnYeHVPSfIAWgfprP13I0Qk7vnoaToeyAYGtK3BGzjxm+Kpb8iLmqJysruE0bjbSAIBrbuyhR16xSUnzh+HoaK8kyTMMYDb6yQnYfGW3MsM1Ms7syQw6WzQBE29UIzHfh7q5zFnuHpt0jKbgbEb9yhl/ZyjXjpZ6ZoODaebl6vcirs4rLywqSNjKw3XSaS88CQCt/JTekUdinoH/Rnlyw9nYVDd/G2TfopyL4QEdR+HyoDqCFyPD0jKn0zYOQuBvOIOjKP3G/AYN9hAuJD9kqgEdKiX8ANqtPwNBzS3;
 4:fEPSkFhMgGLlLWoQ/QBiHG0wz1MGvsmIW3oPylmqoK3sUxiOFABMzkwJlFG9hQJ0at4zl2UWqxwO2bjGUeWpkNX1IE+LjIbwWlmPH0xTnS3V9UiLip/3Myw4RD79wUbRZU6vyt1R6qCzRtejal78Z3wEyvTYps6dS23jLBkWecU9doqfPL5GwGYeI3SGD/wafTzvIWpzyRZG0kRY+yQttUrDYqPeSzC7UvIZkvD11zcHBYx3crl43Z9144BoPlEvS8giVskYqMQhkAuSmozp6SAFc+iZPFRXlcyZd6XpPcRkBz1jQhy6/IQ/2lbmqHxP
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2357FC17C2D585BBD9ACDAD0E0EF0@DB6PR0401MB2357.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);
 SRVR:DB6PR0401MB2357; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0401MB2357; 
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(7416002)(6666003)(386003)(47776003)(36756003)(106356001)(97736004)(105586002)(50226002)(316002)(26005)(2616005)(14444005)(86362001)(16586007)(2906002)(478600001)(6506007)(1857600001)(66066001)(186003)(16526019)(486006)(51416003)(8936002)(25786009)(6116002)(3846002)(39060400002)(4326008)(52116002)(476003)(956004)(44832011)(8676002)(81166006)(81156014)(50466002)(68736007)(48376002)(305945005)(7736002)(5660300001)(34290500001)(6512007)(6486002)(53936002)(33830200001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0401MB2357;
 H:fsr-ub1464-137.ea.freescale.net; FPR:; SPF:None; LANG:en; PTR:InfoNoRecords;
 MX:1; A:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB6PR0401MB2357;
 23:RveyP2dXzzLTErr56RZrKSrBDxR+ZEFmcaQJO0T?=
 =?us-ascii?Q?QKm78DbylkiF23Q4kqh2vuqrMuObQw7pW/YEaJMjhonRzWi+4Ctar54o16Ex?=
 =?us-ascii?Q?9bl2U17TLREZ/4C9FEwL/rC0AhYuu1vrFoByGOLvgYzZiPRMtGhQZVfHK3jy?=
 =?us-ascii?Q?I9zQUohENsxBr9hdmE224xArUWNLk1+C/VAIhd0o9GU8Y5H4PK/nD5DiixWC?=
 =?us-ascii?Q?07+D7Kfjv2ZFFfkk8X6vdaG/jLllqHGRKZ+vA6+paWp5AgzJUmIY7NnM6VLX?=
 =?us-ascii?Q?XGlr5P+KuJ5zzzcANPoYTcB5wjg2aLFTp1ejJfcuGkInewoZhY6VnkLQvkbJ?=
 =?us-ascii?Q?/YjsJImWEzIO1YrqvEzFx1NM2xNmu4Y1V53VyNfK2fI9ZBaD97ezS9/5PKW3?=
 =?us-ascii?Q?s4KWs6hxOrWR/P3SRAQsFBqNLwL/4bDgs863WEl/irkzB3I5BnMbgpRnHUzh?=
 =?us-ascii?Q?mfsA+WpoxJ27qDlSS8TiEkPZtqTv8tR5bWjdlqOAbWg5Cj29+dMmBn1rnmfY?=
 =?us-ascii?Q?3WMkwlUXL/lSLQKJM91XGFlrJXXPn8u4CfHcmAwJcIb9PHh5Hk0CncJUVoqC?=
 =?us-ascii?Q?iueQfEiZ6MmRyKPPMkeeMUrxtc1CPpDdiLTHnlbSvTFTxF9XpoQZTmlhYl+I?=
 =?us-ascii?Q?zs9fV0teLltGCDjMhx4rN8T4iNBH6ozoCXMGzbDbLQ6VZUiEa9EQaEM1gHBd?=
 =?us-ascii?Q?Jt9BQi62+7Ji3w2uUMGuZf9MJiJJ5hJPITu2V1rzzLdHoWDOsl1MD8iE4Wbv?=
 =?us-ascii?Q?fEQndWZ2QEAXSvKIvdKL4ZpishsBN3+hgx73fwEYgIfj9BYnXVVwniG2sjr5?=
 =?us-ascii?Q?ElGt287H1Lb9UqSMnVkeYSd9+jCh1OwhezPRb6kft6eoFd3ytQO8YRBUXS2l?=
 =?us-ascii?Q?CFPGDfxFPMljtOdGk7xtnjm8LKlKVq+4hp+kX/NtNijmBdzDObH1vsdH4qCb?=
 =?us-ascii?Q?R0YPDteAduaszgARst859j4G0nFEiXehtmse/ohLZgXw1MmdEBXrYHMBT5Y6?=
 =?us-ascii?Q?S4td0wMP4SJDYV+EQ8mgNXPhOPhFZUhg4uFUP7S/ktvX7K7TRxJg15penJjY?=
 =?us-ascii?Q?a3L4CeN73iGDV9qpWDWveiDvQENQwZX+Q1i/9xi3vgdamyMJJJD+LmMNpAeQ?=
 =?us-ascii?Q?pJ8TAuyjnWlNeIbNt8N4eLTWnxE0P2/CQJyV8zjZX3tIjW3bc3MJd4a7zn6s?=
 =?us-ascii?Q?LPpjPQ/LrtxTIrh2rAV8lWE1CbcKxxCT1+aVenpeYJEIbdepMH7wxzf5Bcrp?=
 =?us-ascii?Q?YqN8NsV4Hv477clnBwSM=3D?=
X-Microsoft-Antispam-Message-Info: 8fiuOYtLbPJTMG+AeNUdVm3wGxVDH0DIGALP/gRLF4UWi4xLnmhSekae3e4DaVL5tODbY/BuzHqsPmrFoj3rjJZIOX0d64CVcnsjhkre8PyeLIwU3xX3yj9qB3cGzT9PDkUUGvXO8qko117f5Ks6GRtt/rRd7FMBohqCXYwZScipR9PFol4JdnAmZwKngnrQZdSL+WQVG4qyenUWK925ewLpgq6UAfCUXSyLjwDFT2IF5aG9NcdaBg3B/sY12VfnO885Dvjb+3kwF9rCP8RKppxzsOuSeW0pFPYBGHd9vPga7vftt+MiCpp7xJk5PMU/4wGyMj+i14YAQfd1K2ftzodp4CEkSn7v7wJGdd7GyYA=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0401MB2357;
 6:Hm0gjikMdNi+R/QJRXmohN/9m4RqYd4ebz83Z0bxV1S/JPqzX2oppQGJDJsN0Mhl0BY06QKhbhvp6Z8zvFBJSa5LKaYUJfIlQeh6I6TAP5rHJpZFMXPuQ7WxbOCWdiH/yONt6dPXcn9LMskTkXOMEcbW6He5a6EEW0zm9SB3mk4luMm7qeIJOtaxm/7i8vwosSSiuXxd2qcdeE8YUyVlE4hWPJMXmK+Ht0hiX0KOv52fbd3tb25yFE58cf/bpj2KJ4r+XlTfJ/+JtbG7M4HUXO33S//dmX0t1weKkoyCmFKhEEPj8CI3Owc7KVxoptRxjF1onJSWuH381S26PanWJ5PrpAsphlNqML0HX1o9PqMVxxH0XWaEyy8t4ua28JNCYOnw6rlb3GT8Qy/x+ykzxb3Q+u+cEWUM/iaoAbGeb1Ci1vVDUN9hQVtZ75D4x7tLXfZHKIuvp1arKcT7MXRAbw==;
 5:d2GVp5J+rtaWljgDvJ+XN6xYfEvMCFetbJObzBtytbwbXrG3yixKke0hVubSwCoeRarcYK61IBvhcIjKDVM5zct+yFpNF+uqXXhoClhtFQ5iSGqRIDCQp2RQOqBl3aGIiaH0qIvSXJXfrLBswufvDz1chNRQGZ/kdPlgdUhJQ70=;
 7:O+21IhUok5F3Q56wV6ibZnJKedMMFfNVnc1yCtT+Iqx9MFhjgEfGrmoYxIXaKzJlIaJUlZJRIeD0PQRmiWTZFO/faDarh4u3JSI/tc6rdSvT+TCa/phUG67ZxgwygDTT9sYzMJdVBtLNyyj1Nfvppy3tJkECeAIKPEXA+w2EpTyKCZgwed3oAh3uH9ebeLPy2n92HUtU+UpQ1+/uIK7HTIWcC+qXaoYOGrQJvYdFttFkyQqrMyoBm/bqves3FRvl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 15:35:17.1716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e086f1-e8dc-4c24-c747-08d627b37d92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2357
X-Mailman-Approved-At: Tue, 02 Oct 2018 04:21:05 +1000
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
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
 ceph-devel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add BUS_ATTR_WO macro to make it easier to add attributes without
auditing the mode settings. Also, use the newly added macro where
appropriate.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 12 ++++----
 drivers/block/rbd.c                      | 48 ++++++++++++++++----------------
 drivers/scsi/fcoe/fcoe_sysfs.c           |  4 +--
 drivers/scsi/fcoe/fcoe_transport.c       | 10 +++----
 include/linux/device.h                   |  2 ++
 include/scsi/libfcoe.h                   |  8 +++---
 6 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index c7c1140..c75006c 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -261,8 +261,8 @@ static char *ibmebus_chomp(const char *in, size_t count)
 	return out;
 }
 
-static ssize_t ibmebus_store_probe(struct bus_type *bus,
-				   const char *buf, size_t count)
+static ssize_t probe_store(struct bus_type *bus,
+			   const char *buf, size_t count)
 {
 	struct device_node *dn = NULL;
 	struct device *dev;
@@ -298,10 +298,10 @@ static ssize_t ibmebus_store_probe(struct bus_type *bus,
 		return rc;
 	return count;
 }
-static BUS_ATTR(probe, 0200, NULL, ibmebus_store_probe);
+static BUS_ATTR_WO(probe);
 
-static ssize_t ibmebus_store_remove(struct bus_type *bus,
-				    const char *buf, size_t count)
+static ssize_t remove_store(struct bus_type *bus,
+			    const char *buf, size_t count)
 {
 	struct device *dev;
 	char *path;
@@ -325,7 +325,7 @@ static ssize_t ibmebus_store_remove(struct bus_type *bus,
 		return -ENODEV;
 	}
 }
-static BUS_ATTR(remove, 0200, NULL, ibmebus_store_remove);
+static BUS_ATTR_WO(remove);
 
 static struct attribute *ibmbus_bus_attrs[] = {
 	&bus_attr_probe.attr,
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 73ed5f3..703d875 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -428,14 +428,14 @@ enum rbd_dev_flags {
 module_param(single_major, bool, 0444);
 MODULE_PARM_DESC(single_major, "Use a single major number for all rbd devices (default: true)");
 
-static ssize_t rbd_add(struct bus_type *bus, const char *buf,
-		       size_t count);
-static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
-			  size_t count);
-static ssize_t rbd_add_single_major(struct bus_type *bus, const char *buf,
-				    size_t count);
-static ssize_t rbd_remove_single_major(struct bus_type *bus, const char *buf,
-				       size_t count);
+static ssize_t add_store(struct bus_type *bus, const char *buf,
+			 size_t count);
+static ssize_t remove_store(struct bus_type *bus, const char *buf,
+			    size_t count);
+static ssize_t add_single_major_store(struct bus_type *bus, const char *buf,
+				      size_t count);
+static ssize_t remove_single_major_store(struct bus_type *bus, const char *buf,
+					 size_t count);
 static int rbd_dev_image_probe(struct rbd_device *rbd_dev, int depth);
 
 static int rbd_dev_id_to_minor(int dev_id)
@@ -469,10 +469,10 @@ static ssize_t rbd_supported_features_show(struct bus_type *bus, char *buf)
 	return sprintf(buf, "0x%llx\n", RBD_FEATURES_SUPPORTED);
 }
 
-static BUS_ATTR(add, 0200, NULL, rbd_add);
-static BUS_ATTR(remove, 0200, NULL, rbd_remove);
-static BUS_ATTR(add_single_major, 0200, NULL, rbd_add_single_major);
-static BUS_ATTR(remove_single_major, 0200, NULL, rbd_remove_single_major);
+static BUS_ATTR_WO(add);
+static BUS_ATTR_WO(remove);
+static BUS_ATTR_WO(add_single_major);
+static BUS_ATTR_WO(remove_single_major);
 static BUS_ATTR(supported_features, 0444, rbd_supported_features_show, NULL);
 
 static struct attribute *rbd_bus_attrs[] = {
@@ -5930,9 +5930,9 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 	goto out;
 }
 
-static ssize_t rbd_add(struct bus_type *bus,
-		       const char *buf,
-		       size_t count)
+static ssize_t add_store(struct bus_type *bus,
+			 const char *buf,
+			 size_t count)
 {
 	if (single_major)
 		return -EINVAL;
@@ -5940,9 +5940,9 @@ static ssize_t rbd_add(struct bus_type *bus,
 	return do_rbd_add(bus, buf, count);
 }
 
-static ssize_t rbd_add_single_major(struct bus_type *bus,
-				    const char *buf,
-				    size_t count)
+static ssize_t add_single_major_store(struct bus_type *bus,
+				      const char *buf,
+				      size_t count)
 {
 	return do_rbd_add(bus, buf, count);
 }
@@ -6046,9 +6046,9 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
 	return count;
 }
 
-static ssize_t rbd_remove(struct bus_type *bus,
-			  const char *buf,
-			  size_t count)
+static ssize_t remove_store(struct bus_type *bus,
+			    const char *buf,
+			    size_t count)
 {
 	if (single_major)
 		return -EINVAL;
@@ -6056,9 +6056,9 @@ static ssize_t rbd_remove(struct bus_type *bus,
 	return do_rbd_remove(bus, buf, count);
 }
 
-static ssize_t rbd_remove_single_major(struct bus_type *bus,
-				       const char *buf,
-				       size_t count)
+static ssize_t remove_single_major_store(struct bus_type *bus,
+					 const char *buf,
+					 size_t count)
 {
 	return do_rbd_remove(bus, buf, count);
 }
diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 5c8310b..3c23b26 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -671,8 +671,8 @@ static void fcoe_fcf_device_release(struct device *dev)
 	.release = fcoe_fcf_device_release,
 };
 
-static BUS_ATTR(ctlr_create, S_IWUSR, NULL, fcoe_ctlr_create_store);
-static BUS_ATTR(ctlr_destroy, S_IWUSR, NULL, fcoe_ctlr_destroy_store);
+static BUS_ATTR_WO(ctlr_create);
+static BUS_ATTR_WO(ctlr_destroy);
 
 static struct attribute *fcoe_bus_attrs[] = {
 	&bus_attr_ctlr_create.attr,
diff --git a/drivers/scsi/fcoe/fcoe_transport.c b/drivers/scsi/fcoe/fcoe_transport.c
index f4909cd..7789141 100644
--- a/drivers/scsi/fcoe/fcoe_transport.c
+++ b/drivers/scsi/fcoe/fcoe_transport.c
@@ -754,8 +754,8 @@ static int libfcoe_device_notification(struct notifier_block *notifier,
 	return NOTIFY_OK;
 }
 
-ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
-			       const char *buf, size_t count)
+ssize_t ctlr_create_store(struct bus_type *bus,
+			  const char *buf, size_t count)
 {
 	struct net_device *netdev = NULL;
 	struct fcoe_transport *ft = NULL;
@@ -817,8 +817,8 @@ ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
 	return count;
 }
 
-ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
-				const char *buf, size_t count)
+ssize_t ctlr_destroy_store(struct bus_type *bus,
+			   const char *buf, size_t count)
 {
 	int rc = -ENODEV;
 	struct net_device *netdev = NULL;
@@ -855,7 +855,7 @@ ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
 	mutex_unlock(&ft_mutex);
 	return rc;
 }
-EXPORT_SYMBOL(fcoe_ctlr_destroy_store);
+EXPORT_SYMBOL(ctlr_destroy_store);
 
 /**
  * fcoe_transport_create() - Create a fcoe interface
diff --git a/include/linux/device.h b/include/linux/device.h
index 8f88254..767cf19 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -55,6 +55,8 @@ struct bus_attribute {
 	struct bus_attribute bus_attr_##_name = __ATTR_RW(_name)
 #define BUS_ATTR_RO(_name) \
 	struct bus_attribute bus_attr_##_name = __ATTR_RO(_name)
+#define BUS_ATTR_WO(_name) \
+	struct bus_attribute bus_attr_##_name = __ATTR_WO(_name)
 
 extern int __must_check bus_create_file(struct bus_type *,
 					struct bus_attribute *);
diff --git a/include/scsi/libfcoe.h b/include/scsi/libfcoe.h
index cb8a273..f58388c 100644
--- a/include/scsi/libfcoe.h
+++ b/include/scsi/libfcoe.h
@@ -405,10 +405,10 @@ struct fcoe_netdev_mapping {
 int fcoe_transport_detach(struct fcoe_transport *ft);
 
 /* sysfs store handler for ctrl_control interface */
-ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
-			       const char *buf, size_t count);
-ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
-				const char *buf, size_t count);
+ssize_t ctlr_create_store(struct bus_type *bus,
+			  const char *buf, size_t count);
+ssize_t ctlr_destroy_store(struct bus_type *bus,
+			   const char *buf, size_t count);
 
 #endif /* _LIBFCOE_H */
 
-- 
1.9.1

