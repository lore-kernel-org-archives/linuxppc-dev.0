Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F311C64EBD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:59:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45652098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 13:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RubzoLwD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45652098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qvcy0rS9zF3MW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 23:58:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RubzoLwD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.70; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="RubzoLwD"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00070.outbound.protection.outlook.com [40.107.0.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QtWc3YtHzF35n
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 23:09:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6WVxVoObikgPBErnEfip6fb486AZvQIMhpMrmwjOyY=;
 b=RubzoLwDc+s1CMCByEHWUfdAOCTgnmHkRbpF1BND9o7/9ayXlRp/QbiQyWIGxedAwTo7Of9a4t47ycebiuw+KfR4+aEWqgN0sW3LiGSyxN+zD8tnpO5JeYDgOT6YUtf5y7Zw9CKTFvj222AeSAxXneVfhA5Vn+PEhsh30+YFznM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4792.eurprd04.prod.outlook.com (2603:10a6:20b:3::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.24; Thu, 4 Oct 2018 13:09:09 +0000
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
Subject: [PATCH v4 2/6] soc/fsl/guts: Add compatible string for LX2160A
Date: Thu,  4 Oct 2018 06:33:47 +0530
Message-Id: <1538615031-7507-3-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM6PR04MB4792.eurprd04.prod.outlook.com
 (2603:10a6:20b:3::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5486911-70ac-4d54-3fbf-08d629fa9517
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4792; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 3:n8CkG44QFrVd9gJnnQ6m+iW7l8si++5bpDUEL7j9og/jiJXPsdPAyaTWDcWlzi+ax/d7tXLIyxqabtGgxtrbC+z9FnWlUYBDs4QbyqUGEStii0EB+IrpFMXg7LxfgAGRUj2L1yFvPkfOa+NUjrlXW1iOPJVPFzM5RTnVJVN/OPFsn3vlFJViwXVX8qZBW57DJgd7SxsxGcfN8uUSOU1ekEUMrmga32j37KMVJ+ztv1rKzLkXqcgWqQhfzzwGeHsT;
 25:6rYsFOVR2kxySkhwgXYO4JKGrR+JHS9BN5vAF6B+QvwqJtrhbDwwb6lct0SoIGJs7seX+qqXpzia4xux7cb1xBMi+yzzjtY/FufrSYOnmiCWUMeu5aQgCh0e/2+zc3WRhBZPLJrk9X9QBmh5IUXfvsOkHmc14YIJuv2w6JKsgXjZNmoBeLH3asp0Wpjx0W4HvrqdaW25Ai+XlOX2sayhyQy4OeAz115Qf8Vis9seprwYdqyNabv4oA06YRbAJjOzSsDA1SXi/zC2un+GgDxVcABNa9/FG0xsAIy+S89O0OiU2NwARNDMdNXQjSYw9DC0ntSf9XGJJH6lKTKwG2P5Jg==;
 31:N1BsPPeOZoUqWpAKslhFd5vrwVeCnHK+PBZwdEIHUEzihOVMKylq7ekrhFX5+Brh6AClnpaoZM9+SuQxLS6aM52As8YMMEpNbxHJORBhmYlg6jgChvHZfkTR2CSY92EImWS/NtgMcmZDlHorSsAPc2s1I680hz8VqIZBggf8+znlJ+WIRx+WCYSrgnJUQxhQ0tVF2qpQT/rEyU1sSduERQysdbIYosPfdcKIzbsWieM=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4792:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 20:+jq2qk9RflCCHkfHw92Mf40R3YTG+vd0JaE/H+UCrpONKeBkzVyEl98rj47llsk3HfmVBqgp/b44JyHQ/LAkrh2Ex7VTiu7gt1B4vxPVuv/4lkPoj1LkjgAQ3hZxPJIDlmry7fY80ix4CSQkwOERmHj5EES1+5j3N5qxwVsqBZMS15HhRbZmWkeaqi2lXxR3n+nVoWThWfN9zX6wVgE0N+GtZx0Di6D0FapBEuyidTGozGGmLR1TmYFi4xXF6C6hahrdR1wK3VcgzE4bg+AbVbjf7zYlzOa45VkLcY5yPEfeuPeB00lWKdLOLRvQ/xIb0xTKY7C3EmjkNmWBTbF+9L5HB3Rys79VFOFDAAQYEEx72wOHZtSTZ2BFMKIx9HhoB9JKaYE3u8klb3CJnHXMeirjadpu93tSahEnkgmey1cyjQZ/OwH5vcEsAUeuSN/fyFyEkvwnvz/K8+ZcpmszDd82OQn00nkavCJUaYI2ksjJggLyZMjK6/dgEpvmhMGI;
 4:y0xdwJTVCzSUmSotOSvNZvcW9Aq0CDORcsY2KHkTOSj8J1NAhxp613/mt40OgJNr+fdDfCy+Yyl2ZRdSbDOf/Bhd6RE9g5OQB/l9veweU9RhOVBF4dtPkPJq0SKa5b+CbV7+xZlmTcgPoscSIQpiwX7Y3S68hsI1JG3S6153c8TrJKmsBrhjkUyRS1IFl99t733gOvZfsigxWMHFQkXN4FohPhEdL1/jMcAR1r1EnYZ4L5p1Z5byhtRhbQM9IT3nnMsXRA6KMT3TAMwD14kRZR60yfD0WsKEbgmCxlrkYTytfk2qOrm6O3+Hauz78ZKB
X-Microsoft-Antispam-PRVS: <AM6PR04MB4792271AE6264FFEB84A652FF3EA0@AM6PR04MB4792.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);
 SRVR:AM6PR04MB4792; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4792; 
X-Forefront-PRVS: 0815F8251E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(366004)(199004)(189003)(97736004)(48376002)(106356001)(8936002)(305945005)(3846002)(7416002)(6116002)(7736002)(6486002)(81166006)(6512007)(478600001)(2906002)(53936002)(50466002)(68736007)(5009440100003)(105586002)(55236004)(6506007)(2616005)(956004)(446003)(11346002)(36756003)(575784001)(386003)(16526019)(316002)(476003)(5660300001)(86362001)(66066001)(186003)(44832011)(25786009)(486006)(16586007)(6666003)(26005)(8676002)(76176011)(50226002)(51416003)(52116002)(81156014)(47776003)(4326008)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4792;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4792;
 23:liMKZCW/5VDG4uLK+hvMdUx9MWQs98T2PXAKH8buS?=
 =?us-ascii?Q?WbZ2tkoyJr5IoRTV1EhFZ0SQLxNJY3dIyMP1kKys0EXE4d0RUua8xOFPCSit?=
 =?us-ascii?Q?c+5x67ps280TX7eVCDpJhOeXi2ZhjmqfgxiLRpEssGR21rcH+hTsFYlV6eFN?=
 =?us-ascii?Q?GBFaNxC03R5WRr/gFXab21iZLmuZlxW6J3mv+578FXijjTRcstbcwRL6Vz0/?=
 =?us-ascii?Q?H5O3o0kCxzGuKfQevYk2h0r+WJUMG/jiZMmOcWNF8clT7DhoF7lvPAyXZpIh?=
 =?us-ascii?Q?RWPl7X9wh7ByAThCh3egTBAXgAMMCBTsmoiWutYtFnAJyoNtLG/AcqYJtvDI?=
 =?us-ascii?Q?Tfngs8tSQOn/vlYk7Gdl6Zws1lldduLg8gHdlufaj2kz4G3pkcX4wFaLoHi1?=
 =?us-ascii?Q?poEMuTJc7A0KI66pdhoR1QoU/f5oi5L09FLrf3j3clNwSGj6AjbTT5zRMC5n?=
 =?us-ascii?Q?cMFYMQQFO2/toIJkYqtr/BQmvxqBvgrca5wEm3/ZGNDMkXe4xAOkkttbVD+W?=
 =?us-ascii?Q?WJ/4B/dB4+qmf1Wu3XlrBxGTPYGinGem2+yBsM+XbwgnHsW4TTsoR6sz20Mx?=
 =?us-ascii?Q?ZOCBKNv2xJdNdhsxsE5u8ob4ngQILjIhtxUUkeZ0j1V4r/f9Pf2TLhR/Ftrw?=
 =?us-ascii?Q?FmjpV8LjOzxgJ/9PJqjRh16ZtRu/ViVaTXXwTUzQEIqmXWcZsE/ou5XXyXno?=
 =?us-ascii?Q?k8fCpkdCoAewGoZp3GC/4RkwQmIDZ5nQ91ajxJx2AAEYTTEIFj9ZUHYBVGko?=
 =?us-ascii?Q?gEtDKiCaplHcG3ol+Fl1QQiOiMrLEElr8WQ8L5yjZZAdkYxs9vYQX7Mvbt33?=
 =?us-ascii?Q?FieHn6/BMTAOnxohTDr2lJsbf1l7fmIO39lfdUFpBlHbN36rH5ROhhDoU9l/?=
 =?us-ascii?Q?eH50XxDuvEHnYmPFYCyQuIrLBv6NVnmlhl6bRgl5htg0oJHznJ4OlWEwq6vK?=
 =?us-ascii?Q?4yA76P7N0jSvnkDHDS/5Z81wXRNZLAAejugL07JCaXIdfVxXDZNM9z8lX0ex?=
 =?us-ascii?Q?K9CuCwzT3UIJqQavshVbAUK8ItlYEKJAja2HxYEJ7I4ZOWO89AN8tyhBG4p7?=
 =?us-ascii?Q?zRET/sBnqn+bq+SuXRztEweaNAuJJdT7NiTN+WITNhyMpnFaIKE+jKPucvl5?=
 =?us-ascii?Q?lobdjP30dqc7c6BHHjVsAnxM9X3m29aPcdVsGr5btFG+GciJyfY46SemIkyJ?=
 =?us-ascii?Q?KOVnXx9CNSy2isQ6Tu2YDPU/3JY1t2TZ9nCYP+J8nQw0AbZqgKu3c/ku6Zop?=
 =?us-ascii?Q?vQx5soQlHmQTH8cqEcll8eDZUUSetDpBTwyigCBwLgy0NcAZHZfInaEO1os/?=
 =?us-ascii?Q?NM5pZZlypqRttEh4dG+QmZT9rXeKu1hOBwDPS4jbvmd?=
X-Microsoft-Antispam-Message-Info: o+woqkXENWUHJtWMXYy13pCtarva+IgTnHmdk0oR5uMqVvHjHjip/xke9AYoMFnRtyYi5AASIIIHrDEW7+QUPfouCJ5va+u6qKmk/NSS9FKsC136OlQFYAeRqKM3HgzTKR25/JzQ2a7MdRA7ilwvE4DwvcTmxexcrlkurs/AhZVrhHU1ucN5mej1NmQGP+aw+vSzNYMI0Xl82Js4kiCgtGf1enHtgTzwbrS15iG0S/3t159f0e08LiyfP53+Bs/X9aYE3lG6J94OOl9nOQuKDqC6lYb0N47OLNb2JF+AKgVVrMTz2kvf6YvOuTkKEjZsk4+eGpryoNUGEzgdcPrHj9Yj4hxhGeJVjQBxiSclBHw=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4792;
 6:8HhU8BG9n1QHGOyFgI17TCvkErFulZtZwp0GdYb7yczYBkVIkxdYfWWf5WK5PjW8/a9nLajC11JEa1E6Gl8SfCdzKyXo9CiQ24BATx0LWwmvY/oWkcHqGxWm9t0PEr0k7eztLNiquQBdg73JO65PS+Vw1fdVr5L6gdpKfdzqQE7M+ruh4CVpmfl08spyFwedlRhvnibXg0vj/u7c2Hrh/pvcSmJ4yXAeLdbvF74SPd7lhnzpmlcBndCnrSgflrVWYkptFtxXpqQwj0P8oT5AAkb+IttsClqXzYOZjhKguxfb2QdKeXyOG6wx7rZ8DY9MyLcOakd/OkMkHRsOkhX/LlFjDi81/iYawsxHf7/Y6OyNSLS4U2SeT1i86OGpCiUd4Y3Xo32VYBNYV89sy2gdqbMAB5/fPcwaOqnmlh7nbv8gfjAn2PcefIKgr7+i+WqPm/snpNMhMPs16/hXHHv6PQ==;
 5:mRMI+g2uZ3GuvUi7KOIEUt256/Z1wSQoCOT6YY2yZsoLtpVkrQJ7VTVmB6dmvbm3A2p4Ka7oUkpdkmrAqmNxjo3K02ztCokvz55cfGFaH6m3j/j3QeG4jVZTixwW1UfQAVXck58FamwDfZRUZ6lsnWWbOy649TDSWdn80pfXDws=;
 7:U0qC/RyKzRA67DU4O0JuIaECYuPnWJtFyCb54MyHMO81UI0++ADGv79iKP/Gc9EJrwj2AvsI758btqGREkHOOYVNZcfSWXJqPWe/3VmECSd+kkVquEbmwa4TZBuxTJ9K6S/fbw3JbkGme7hKdOwYCzh7mZum4b2D214bhItlRn7bddWtHHop2zWC/UuA5T24FBL4yI/6CgZ//E151RUbvyFsANzfMHcipOnVrPx5qLUWqhwMT+jAFrzxBcOsT0AE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 13:09:09.1580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5486911-70ac-4d54-3fbf-08d629fa9517
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

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/soc/fsl/guts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..5e1e633 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -222,6 +222,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
 	{ .compatible = "fsl,ls1088a-dcfg", },
 	{ .compatible = "fsl,ls1012a-dcfg", },
 	{ .compatible = "fsl,ls1046a-dcfg", },
+	{ .compatible = "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
-- 
2.7.4

