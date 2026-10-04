Return-Path: <linuxppc-dev+bounces-28875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7724FCA5FCE
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 09:10:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyGvM5Kryz30Sx;
	Sun, 04 Oct 2026 20:10:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=148.163.158.5
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791105023;
	cv=fail; b=F6nyqDZxym1aZPqURDp1Vn1nFw8MUYEA6km1x1sS1+HEV3cbjooRx4WfDj0JrzdxPjUQmp2T299Bwa54VZENgHhFA6Yt+jD1J8ZSqtq8l6ki/0X6tT5sEJkiv9jOzaEzOZJq8JWtt+/O5I2I1bYjy3UvOPMsbgQupjRUhoxcCdBghVdGkLbwBsWdj6zvSrnBifNgeZW4MAWZX/Cy1tf+x7Qcdk3GgHSKi1L/Sn87vjoNwSmDztHTnodIWslBqSHrcw1osXrPWfj9URjuERbdWruTVcuinGQklL432umo3h8Ot4KNB5xNUASvEiw+gMYvJ7nkABs/BYj3FWItOkIx+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791105023; c=relaxed/relaxed;
	bh=mAdbs8WOvb0MHGDzgdufNtu+YtmlhLN/tMcQJ1vwS/k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KjGbV9tyR7ZfYE/S6DUa0FNpvcB8x9fwM5RPr+I+1+IsGtlZyE8c0CknSJCrMwzwN/TCq63VeiDdF/FhTO7nEAUkDxyhEnXV9rneFp6AqBTqrVlrurGBqKDmQiRE7RDIpq84GxyMAssUXH3P9KZj+Uu5XXWBpDBgjU0+fgW8MgegyS6bk6S3j3uHZp8snZRowtQIZWiG1TojRPLh/Ahvam3QQbu9wxKstHgXpZqY5nfutwO3McSsnhtszNrNfDdo1G/cpfSKIc2ntjS5vYLEfHvDKmT2UIBEhXj8YorwRPyVkQk+CFiX4IS0vHhA+P8XxOsPrjNWD33UK66X6WPJgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CQjL4lrB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbabu@us.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=us.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CQjL4lrB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=us.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=hbabu@us.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyGvL2GWdz30RN
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 20:10:21 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6947bh5e1134500;
	Sun, 4 Oct 2026 09:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mAdbs8WOvb0MHGDzgdufNtu+YtmlhL
	N/tMcQJ1vwS/k=; b=CQjL4lrB9zEjOuQBObgHzismV4MpKZ8GnD6hQa0uxpR5M9
	h1YCOsWo+5NjsjTIAWdpTRZtUncA1PlNbjTuGULetfh4yKTxyPxsJ879/YbPlizS
	qvX6qAzPECELR4ffFXl6X236MXh0wThq3+dnjFSllrMWSclD4ruBepIajnuMhDCr
	4VsPxX8KZerkOjRuwxGbrmbR2rPP15n8MQkhxhalscGtMbpSvSv93MuyaDJ4wJwh
	dTGHWcNy8rVK3U77aMYscIRx5VwYamQ0ic5s3lUO5bKHHOJurCqrOKwuKjyTG2nv
	Mle6K8eKR1ey5dESgan72kD5GVKej0Ax+sDgFs5w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jd0eu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 04 Oct 2026 09:09:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne5fsA0G89AyxmaFSb1GGyzAQGhEy4R8xLdn+8eYhW+N2vi9BUCFVa00Ng3iDL1vbN9bHj70JGaAbbZOC9UE2pxX65/m2Ffc0/RIa5TB181DvHWW5B+bY7WyYO1hL/N9JCV0c3MBxjoWkncYf6O6PCBOsJf2t7meMvvN3UyGH4VsU9GT9p1OhrAtqXH6hgSayfUimjobKOIdSFi1KqBsZ+OIbzFrdvm2scPPGhx3Ior+yPy7Jj6uzg140uYLCaQkfNxNXBo1B1TYVG1t8v/0y8KrINWUzMcXk9aF/5PXPz47wOjoIkqPBp5WqljlHg4/B9p8AC980XZ0bkXdXxX9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAdbs8WOvb0MHGDzgdufNtu+YtmlhLN/tMcQJ1vwS/k=;
 b=Jc6p6Bf6KWIoIUGs9DNtaL1JDPgGC0uj4/IKLSIZXLXNpSRcNyvtSr0v72XV4EdOnZvf7x54OQHPBGUxx2OF+veUoc1vdSn5ZuH9DAGb/67Moz5v5omHZ+sunh9D4pgm9jq56BZ8oKWC1NsEvoKfWvvq6oWkoUhnAk8eM8CdJXBRkLvCIeKebApL24+Ld38aNemaNzYOdNKlFp0MEImJIBdXwUNR+ePwOQkmR3SqcOWMFfuZ+sQmhMgP1bp0/CGx67jhZ4H+j7kxxxK92L9V/Ud93gVPnn8MGsRy7pBsSUJf4m4gyazT30GzNBvwx/fBOn8Y9xMNiazpoMhzfbkP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from DS5PR15MB7005.namprd15.prod.outlook.com (2603:10b6:8:342::17)
 by CY8PR15MB5927.namprd15.prod.outlook.com (2603:10b6:930:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Sun, 4 Oct
 2026 09:09:53 +0000
Received: from DS5PR15MB7005.namprd15.prod.outlook.com
 ([fe80::bf1:2147:ac41:863e]) by DS5PR15MB7005.namprd15.prod.outlook.com
 ([fe80::bf1:2147:ac41:863e%6]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 09:09:53 +0000
From: Haren Myneni <hbabu@us.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>,
        "maddy@linux.ibm.com" <maddy@linux.ibm.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "ritesh.list@gmail.com"
	<ritesh.list@gmail.com>
CC: "npiggin@gmail.com" <npiggin@gmail.com>,
        "chleroy@kernel.org"
	<chleroy@kernel.org>,
        "shivangu@linux.ibm.com" <shivangu@linux.ibm.com>,
        "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
        "mahesh@linux.ibm.com"
	<mahesh@linux.ibm.com>,
        "adityag@linux.ibm.com" <adityag@linux.ibm.com>,
        "venkat88@linux.ibm.com" <venkat88@linux.ibm.com>
Thread-Topic: [EXTERNAL] [PATCH v3 2/4] powerpc: move to 64-bit RTAS
Thread-Index: AQHdM6BZge3yXNw9lEmZFsyzgs4/Q7btV6jL
Date: Sun, 4 Oct 2026 09:09:53 +0000
Message-ID:
 <DS5PR15MB70054353A2CCE5A34BEBF9EB87972@DS5PR15MB7005.namprd15.prod.outlook.com>
References: <20260824081202.264913-1-sourabhjain@linux.ibm.com>
 <20260824081202.264913-3-sourabhjain@linux.ibm.com>
In-Reply-To: <20260824081202.264913-3-sourabhjain@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=us.ibm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PR15MB7005:EE_|CY8PR15MB5927:EE_
x-ms-office365-filtering-correlation-id: 5678b7a7-daff-4f1d-5ccc-08df21f740c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|5023799004|56012099006|4143699003|6133799003|8096899003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 7tpHqn4Db/2848eGqYkKmlTtHAUenHvHqlVw7grNdRD/9ILEly7AjlUH/zNiwSbZl1qYKJyiAT92dSNmKeP8G2gHFJ7e36t21lra7bLgCzBlbt+U0tA/2yfdzwfeTD2ZNDgHfHyjyDLFVWL1nfo5hA02q+G0iYob8t7Mdp5NZbeaK+J/11BbGqjW6OY53i92QJttmGufUrqTukO2YsOf/AqoGq48yCguiGUcEAG1eLYLbbT3ELlelDRtwXcq3kwns2YD1521wGPv8fgDrk9XVGxoYTx55Nj+QN9gH6EFMDgeQSo9fL/wJwxQ1536nsQN2pQ3+fqXfRn/7ddzMruS91WyegJFNGaVqQm9AfHYV7IQqFe+2RNsOuyzGJ+gFYaulfAoY/9f/Z+Lc+aLXokb/lv6GWv7oAn6TnO6kw/Y9ygJhvMeTjx/8dvbdsLqAH7ocXTu9TPmztzbZqAVHZki2u4jkSam42V9GcuAG8/q+iIyLX3JzRVqx+4oSQtL3hryAWiEOifVkLrY9oqUXEt2RCgrrrTDgpOZQgyhIaHtbD2PPPYLgA3JW0vochkluhvDWSYLGOkibJSaWYAdrR263FEcvqJcSzp2ZYdOWWvWJ1qhGM/NgeTw4p6caC1oNckFzsgLEw2USu4k9J8M2K41PKvcwf+8oeGruM/tvxk1ihrOHHoifnQTEmc6cFn+BSz4TpqbFWyVz/mvfToPralLoD+JTQP4vxHdiI2qvKgP5bY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PR15MB7005.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(6133799003)(8096899003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7bcH6LkeZsdQHINTPO03/x7isTJRpX8D4fNzIlYOneFN4+lbGfTG/JZ4Q3Yg?=
 =?us-ascii?Q?vYbIdgVgskNG4pkQ7xF0BovQXqBEv9U1ApWIoBgRRtK+vZwmHGZns8he2mTM?=
 =?us-ascii?Q?ZwhPqA/GokYQwHaIfm5Z1Nkidb21lG/8F1VBsLvaCF+UVfdxhe2ymhx5b2Jh?=
 =?us-ascii?Q?eqgOnFWKiKFwSmVrRWIyxhFR0IlU1I8qQt8czDh73p9rdCAiUFob2q37N/Z9?=
 =?us-ascii?Q?LTkBIQdj+sLlm95yrsIbTtvObgOPmJ0faUtdd+erBydg5LeLX7NV7qqx2RSw?=
 =?us-ascii?Q?amhHyJsOZQXS3oIV6X85KTdWSiTB0ONG7ftLbM1aiElD07MwUKUQsnnU14f8?=
 =?us-ascii?Q?n3woUdDxyxsaM+RdZLcnGg6gd5iQBLDXL5F2OMNFTLkzshlZRYtGYXli6ozR?=
 =?us-ascii?Q?dH8z03iA1S4neYddVaSU9Vpg5oooGffEzzLLnE3fjV74y9rgq1FtuLbo03oQ?=
 =?us-ascii?Q?9uofatuDH4j/GNLqL/Xl6fiIvG429zaXlQd97efv22qrzLm5SR9gASz9JTXX?=
 =?us-ascii?Q?aQHxNIxjqofiQkTW0u6s4imBYcLHmsJCn2HCa82VrcsVLeS4+9WTrzhOCzMl?=
 =?us-ascii?Q?T89iQKlfG2CLNB1ojLy3n9lG0+jKz1vknR3stj6s05Xdt4a+1ScYNJjDB85e?=
 =?us-ascii?Q?wA+MHX70ZGrrm06JNEDuamLxE4Zy2XEeY0SRWlxg4hnaolQIlqFcTujFromJ?=
 =?us-ascii?Q?ZMJCPEpO+ckNyUCZI+C4ari1I2/xsWPadI15K1M112x9L0BnarIwT9k+JPGn?=
 =?us-ascii?Q?zEGxdXGIkOfd9AN+Xcz7lcKX0G8jTRTWU+uOvfzVDovvHOpcY8JVJ5sxbMvG?=
 =?us-ascii?Q?OVnixxUcjSXX/hy8YfbKME1WjPm6VTD8HXBBCEaQtEk94ySj1TsslOzcvvTg?=
 =?us-ascii?Q?m6ZDmv4YEHl+YX352BduwGklyR+DP/GbjsK/2B+5ambbvdEq21OcwecVFn5b?=
 =?us-ascii?Q?tgw61xrD+6A7o/fdjzQXJ9QWrXQXnJ79D4lLh7wcFKcBMg4f4K7qd+FR0E8W?=
 =?us-ascii?Q?pYB1Kv0Ss82VVhAzSBLsCl0ThRAkLcwwAFt6yLO3LjLNbCYO9zosvt2pJAX2?=
 =?us-ascii?Q?bNojYp5jzucwrwvL6wUqA0uOpomFgc3A9j4TRaUl6jbp/bnG5RsR44KhSIKo?=
 =?us-ascii?Q?mycox9EBjNAEkDGnKgwXQ5UqSSfTxdiC4h4XfIwAF7uEbfioRBNOHBL5mziG?=
 =?us-ascii?Q?chxGzzFU/17tppl3U1N5AbF3UF4x21vW4OIaWefN+JuOh2YGp0BphQFpghK6?=
 =?us-ascii?Q?wZX6qrfHkTRNX76+Kd5EDJ6rbBM3WYdEddvcgVhCdsZZSuli4LELsaOhexLf?=
 =?us-ascii?Q?5ZWjUqpyQCrWe9f8XJT89GGJRCoSLs7rt8MGUbB66FiHxsko+3FdJcN5oCIv?=
 =?us-ascii?Q?IXqNlISZc1kTypfAGXOhINFlMpoL2LDoIoFHEdYVhjkqnMGkU236/zou0Moa?=
 =?us-ascii?Q?hL6dvSOdY5K4BrdUQXuF3KfX8kCpeNZF0WedJaUbHce+ZlnuwHj2JkkSvLfc?=
 =?us-ascii?Q?CVMoFvQX/bMI6rgAuJjE52dvu8Cr+zPWZuT+cMvebIh3f+WTB5Sgh+d7hE9z?=
 =?us-ascii?Q?5UqRZ/EricQxYybSzb06XW8hqh7yc9L+XK+EgpIwlrIg7SSjz6WlYTp0MSaw?=
 =?us-ascii?Q?VXh8HNsKfhMALU1Y/0Pwa32VuU4NJoKoBrwtqW04rO9Kts64zOalhkOI4hCk?=
 =?us-ascii?Q?PZI9yr+ApjL52+ZeX0eIJ+LulQVNFwFI9a1jCWtcnGCAqEvU?=
Content-Type: multipart/alternative;
	boundary="_000_DS5PR15MB70054353A2CCE5A34BEBF9EB87972DS5PR15MB7005namp_"
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
X-Exchange-RoutingPolicyChecked:
	XgYPQTDGkzueFyP9MZBVldzF0Pb75xsS/cA6d+7GCz1Kde/OzfPmEKomx6QdUvHflvdtJR3hAHpGt1M7XaL+7kyI8QYonBRYQwQxeWghhrbL6dAK/5dXOHpo27+d8WNb7yQTg+RjG2WTRRoULpobp4FIAt7D3k9yWsyV4KyJo3l60fHVtpnbge1grfe/J3nOJfmm9n76V3iM2HUWIlviYGgcAh84/TXBrk2sI+1R0fqoF38mh0bdXE4g5/pQmxIppgit/GlxRkTbtTnISGcMV0czs4Q/7luOCDczboGY3hykcx7bvv3vy35Wijq+8TH0PlHnPs6ofU7Qt2hOusgPNw==
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PR15MB7005.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5678b7a7-daff-4f1d-5ccc-08df21f740c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2026 09:09:53.6612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNdgAsUUD8HEW13k1R1ZDgwOYip4vQCP8wPpqI9xJZwlSBBMDz0FuTqfRPOhZ28BrSdRadswqwiPqngHIYi0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5927
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: myHgFxHcVH0nswK_KkNWMxuo2OWMwcUW
X-Proofpoint-GUID: gaMS6mvmpcb56v7AGdLIcwGkxcwxXFw3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA0MDAzNiBTYWx0ZWRfX8FwyD4JlEG7B
 5efNqvVVWa7AE3/1P4xZHYDufFzqo1UEcz8LlArEEYribUXf0LAikZYVz+7B3SP5YKDd0bV409X
 bmRc/ZTyfYyUprLMApW91jkEbZpLaIo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA0MDAzNiBTYWx0ZWRfX4Kf/jfvRGKP3
 W6MIM5/tOqhnN4ddgnj8ZIv/vmkulsHf0RFIQs5YLB6WBOngCWCxIOzCGMdgFK5QSSaS7jcn6zD
 DDLx6da6qeJ9P4YAN6DEii4RnMZFKrQCS5HS3n4F8uVDnF6ePV8eAzItUeQu+eBPoNRZPG4/eaw
 QZcfprXKmTd+YA10N4RbZpysSGAVRFkELRCpc5hwYfH88rg6ONGhllc3T+48fmNxDOSzieD+TpZ
 EouYV16GqsIKlZTGOt2HStvhEigEWKIqsGDsYuuZwcT5vA41K3cxetywX2kUrZsvd2c58H8POQm
 UiIvhi2zXdKhAG5PkAM47nJXWecCcEK7norPZk2ywPbLpTIiSablkTngW+M9Dx8blXjGSTYAcnp
 lw45KeXUArMkTqmA2wLwlbTWT532zuFrItNOP+y8aGt/UUgauqJY42kdxzXU1JYjlTvBO9KCJCS
 MCnI3vo6E6yqtho4cLA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac217e5 cx=c_pps
 a=dfvQMip10+6xT43tUf6YKQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=DnqUbCA7qRao4eOhWTEA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=CUibJDt6J9-GKNTH2-AA:9 a=tTEGEY58mYewZ95P:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10 a=IC2XNlieTeVoXbcui8wp:22
Subject: Re:  [PATCH v3 2/4] powerpc: move to 64-bit RTAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-04_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610040036

--_000_DS5PR15MB70054353A2CCE5A34BEBF9EB87972DS5PR15MB7005namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

If "ibm,rtas-64-capable" property is available in /proc/device-tree/rtas, t=
here is no need to add new "linux,rtas-64" property.
________________________________
From: Sourabh Jain <sourabhjain@linux.ibm.com>
Sent: Monday, August 24, 2026 1:12 AM
To: linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>; maddy@li=
nux.ibm.com <maddy@linux.ibm.com>; mpe@ellerman.id.au <mpe@ellerman.id.au>;=
 ritesh.list@gmail.com <ritesh.list@gmail.com>
Cc: npiggin@gmail.com <npiggin@gmail.com>; chleroy@kernel.org <chleroy@kern=
el.org>; shivangu@linux.ibm.com <shivangu@linux.ibm.com>; hbathini@linux.ib=
m.com <hbathini@linux.ibm.com>; mahesh@linux.ibm.com <mahesh@linux.ibm.com>=
; adityag@linux.ibm.com <adityag@linux.ibm.com>; venkat88@linux.ibm.com <ve=
nkat88@linux.ibm.com>; Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [EXTERNAL] [PATCH v3 2/4] powerpc: move to 64-bit RTAS

Kdump kernels loaded at high addresses (above 4G) could not boot
because the kernel used 32-bit RTAS.

Until now, the kernel always used 32-bit RTAS, even for 64-bit kernels.
Before making an RTAS call, it clears the SF bit in MSR and uses LR as
the return address from RTAS. For kdump kernels loaded above 4G, RTAS
returns to a 32-bit truncated LR address, typically causing an exception
and kernel panic.

Fix this by switching to 64-bit RTAS support on systems where firmware
advertises "ibm,rtas-64-capable". The kernel instantiates 64-bit RTAS,
passes RTAS arguments using a 64-bit argument structure, and sets the
SF bit in MSR before entering RTAS. This ensures RTAS can correctly
return to addresses above 4G and allows high-address kdump kernels to
boot successfully.

If 64-bit RTAS is not supported or initialization fails, the kernel
continues to use 32-bit RTAS. In that case, high-address kdump kernels
will not be allowed (handled in upcoming patches), and RTAS calls will
continue to run with the SF bit cleared.

Changes made to support 64-bit RTAS:
- Detect firmware support using "ibm,rtas-64-capable"
- Initialize 64-bit RTAS in prom_init and add a new FDT property
  "linux,rtas-64"
- Read "linux,rtas-64" during boot and track RTAS mode using rtas_64
- Add 64-bit RTAS argument handling and return value conversion
- Prepare MSR appropriately for 32-bit or 64-bit RTAS calls

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/rtas-types.h |  8 +++++
 arch/powerpc/include/asm/rtas.h       |  2 ++
 arch/powerpc/kernel/prom_init.c       | 20 +++++++++--
 arch/powerpc/kernel/rtas.c            | 48 +++++++++++++++++++++++++--
 arch/powerpc/kernel/rtas_entry.S      | 17 +++++++++-
 5 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/a=
sm/rtas-types.h
index 5d40d187b965..8a54647a87f4 100644
--- a/arch/powerpc/include/asm/rtas-types.h
+++ b/arch/powerpc/include/asm/rtas-types.h
@@ -14,6 +14,14 @@ struct rtas_args {
         rtas_arg_t *rets;     /* Pointer to return values in args[]. */
 } __aligned(8);

+struct rtas_args_64 {
+       __be64 token;
+       __be64 nargs;
+       __be64 nret;
+       __be64 args[16];
+       __be64 *rets;     /* Pointer to return values in args[]. */
+} __aligned(8);
+
 struct rtas_t {
         unsigned long entry;            /* physical address pointer */
         unsigned long base;             /* physical address pointer */
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rta=
s.h
index d046bbd5017d..aaa4c3bc1d61 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -10,6 +10,8 @@
 #include <linux/time.h>
 #include <linux/cpumask.h>

+extern int rtas_64;
+
 /*
  * Definitions for talking to the RTAS on CHRP machines.
  *
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c
index 53503937de0e..be7c5ea0b75d 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1841,6 +1841,7 @@ static void __init prom_instantiate_rtas(void)
         u32 base, entry =3D 0;
         __be32 val;
         u32 size =3D 0;
+       u32 rtas_64 =3D 0;

         prom_debug("prom_instantiate_rtas: start...\n");

@@ -1865,15 +1866,24 @@ static void __init prom_instantiate_rtas(void)
                 return;
         }

+       /* Check for rtas 64-bit support */
+       if (prom_getprop(rtas_node, "ibm,rtas-64-capable",
+                        &val, sizeof(val)) !=3D PROM_ERROR) {
+               rtas_64 =3D 1;
+               prom_debug("Node ibm,rtas-64-capable: %x\n", val);
+       }
+
         prom_printf("instantiating rtas at 0x%x...", base);

+       const char *method =3D rtas_64 ? "instantiate-rtas-64" : "instantia=
te-rtas";
+
         if (call_prom_ret("call-method", 3, 2, &entry,
-                         ADDR("instantiate-rtas"),
-                         rtas_inst, base) !=3D 0
-           || entry =3D=3D 0) {
+                         ADDR(method), rtas_inst, base) !=3D 0 ||
+                         entry =3D=3D 0) {
                 prom_printf(" failed\n");
                 return;
         }
+
         prom_printf(" done\n");

         reserve_mem(base, size);
@@ -1884,6 +1894,9 @@ static void __init prom_instantiate_rtas(void)
         val =3D cpu_to_be32(entry);
         prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
                      &val, sizeof(val));
+       val =3D cpu_to_be32(rtas_64);
+       prom_setprop(rtas_node, "/rtas", "linux,rtas-64",
+                    &val, sizeof(val));

         /* Check if it supports "query-cpu-stopped-state" */
         if (prom_getprop(rtas_node, "query-cpu-stopped-state",
@@ -1893,6 +1906,7 @@ static void __init prom_instantiate_rtas(void)
         prom_debug("rtas base     =3D 0x%x\n", base);
         prom_debug("rtas entry    =3D 0x%x\n", entry);
         prom_debug("rtas size     =3D 0x%x\n", size);
+       prom_debug("rtas 64-bit   =3D 0x%x\n", rtas_64);

         prom_debug("prom_instantiate_rtas: end...\n");
 }
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 8d81c1e7a8db..873e54238d2f 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -45,6 +45,8 @@
 #include <asm/trace.h>
 #include <asm/udbg.h>

+int rtas_64;
+
 struct rtas_filter {
         /* Indexes into the args buffer, -1 if not used */
         const int buf_idx1;
@@ -569,6 +571,7 @@ static struct rtas_function rtas_function_table[] __ro_=
after_init =3D {
  */
 static DEFINE_RAW_SPINLOCK(rtas_lock);
 static struct rtas_args rtas_args;
+static struct rtas_args_64 rtas_args_64;

 /**
  * rtas_function_token() - RTAS function token lookup.
@@ -690,13 +693,48 @@ static const struct rtas_function *rtas_token_to_func=
tion(s32 token)
         return NULL;
 }

+static void populate_rtas_args_64(struct rtas_args *args)
+{
+       int i;
+
+       rtas_args_64.token =3D cpu_to_be64((s64)(s32)be32_to_cpu(args->toke=
n));
+       rtas_args_64.nargs =3D cpu_to_be64((s64)(s32)be32_to_cpu(args->narg=
s));
+       rtas_args_64.nret  =3D cpu_to_be64((s64)(s32)be32_to_cpu(args->nret=
));
+       rtas_args_64.rets  =3D &rtas_args_64.args[be32_to_cpu(args->nargs)]=
;
+
+       for (i =3D 0; i < be32_to_cpu(args->nargs); ++i)
+               rtas_args_64.args[i] =3D cpu_to_be64((s64)(s32)be32_to_cpu(=
args->args[i]));
+
+       for (i =3D 0; i < be32_to_cpu(args->nret); ++i)
+               rtas_args_64.rets[i] =3D 0;
+}
+
+static void rtas_args_copy_64_32(struct rtas_args *args)
+{
+       int i;
+
+       for (i =3D 0; i < (s32)be64_to_cpu(rtas_args_64.nret); ++i)
+               args->rets[i] =3D cpu_to_be32((s32)be64_to_cpu(rtas_args_64=
.rets[i]));
+}
+
 /* This is here deliberately so it's only used in this file */
 void enter_rtas(unsigned long);

+static void _do_enter_rtas_64(struct rtas_args *args)
+{
+       populate_rtas_args_64(args);
+       enter_rtas(__pa(&rtas_args_64));
+       rtas_args_copy_64_32(args);
+}
+
 static void __do_enter_rtas(struct rtas_args *args)
 {
-       enter_rtas(__pa(args));
-       srr_regs_clobbered(); /* rtas uses SRRs, invalidate */
+       if (rtas_64)
+               _do_enter_rtas_64(args);
+       else
+               enter_rtas(__pa(args));
+
+       srr_regs_clobbered();
 }

 static void __do_enter_rtas_trace(struct rtas_args *args)
@@ -2078,7 +2116,7 @@ void __init rtas_initialize(void)
 int __init early_init_dt_scan_rtas(unsigned long node,
                 const char *uname, int depth, void *data)
 {
-       const u32 *basep, *entryp, *sizep;
+       const u32 *basep, *entryp, *sizep, *val;

         if (depth !=3D 1 || strcmp(uname, "rtas") !=3D 0)
                 return 0;
@@ -2086,6 +2124,10 @@ int __init early_init_dt_scan_rtas(unsigned long nod=
e,
         basep  =3D of_get_flat_dt_prop(node, "linux,rtas-base", NULL);
         entryp =3D of_get_flat_dt_prop(node, "linux,rtas-entry", NULL);
         sizep  =3D of_get_flat_dt_prop(node, "rtas-size", NULL);
+       val    =3D of_get_flat_dt_prop(node, "linux,rtas-64", NULL);
+
+       if (val && *val)
+               rtas_64 =3D 1;

 #ifdef CONFIG_PPC64
         /* need this feature to decide the crashkernel offset */
diff --git a/arch/powerpc/kernel/rtas_entry.S b/arch/powerpc/kernel/rtas_en=
try.S
index 6ce95ddadbcd..df776f0103c9 100644
--- a/arch/powerpc/kernel/rtas_entry.S
+++ b/arch/powerpc/kernel/rtas_entry.S
@@ -54,6 +54,10 @@ _ASM_NOKPROBE_SYMBOL(enter_rtas)
 /*
  * 32-bit rtas on 64-bit machines has the additional problem that RTAS may
  * not preserve the upper parts of registers it uses.
+ *
+ * Note: In 64-bit RTAS, the SF bit is set so that RTAS can return
+ * correctly if the return address is above 4 GB. Everything else
+ * works the same as in 32-bit RTAS.
  */
 _GLOBAL(enter_rtas)
         mflr    r0
@@ -113,7 +117,18 @@ __enter_rtas:
          * from the saved MSR value and insert into the value RTAS will us=
e.
          */
         extrdi  r0, r6, 1, 63 - MSR_HV_LG
-       LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI)
+
+       LOAD_REG_ADDR(r7, rtas_64)      /* Load the address rtas_64 into r7=
 */
+       ld      r8, 0(r7)               /* Load the value of rtas_64 from m=
emory into r8 */
+       cmpdi   r8, 0                   /* Compare r8 with 0 (check if rtas=
_64 is zero) */
+       beq     no_sf_bit               /* Branch to no_sf_bit if rtas_64 i=
s zero */
+       LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI | MSR_SF)        /* r6 =3D M=
E|RI|SF */
+       b       continue
+
+no_sf_bit:
+       LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_RI)         /* r6 =3D ME|RI (NO=
 SF bit in MSR) */
+
+continue:
         insrdi  r6, r0, 1, 63 - MSR_HV_LG

         li      r0,0
--
2.55.0



--_000_DS5PR15MB70054353A2CCE5A34BEBF9EB87972DS5PR15MB7005namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
If &quot;ibm,rtas-64-capable&quot; property is available in /proc/device-tr=
ee/rtas, there is no need to add new &quot;linux,rtas-64&quot; property.&nb=
sp;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sourabh Jain &lt;sour=
abhjain@linux.ibm.com&gt;<br>
<b>Sent:</b> Monday, August 24, 2026 1:12 AM<br>
<b>To:</b> linuxppc-dev@lists.ozlabs.org &lt;linuxppc-dev@lists.ozlabs.org&=
gt;; maddy@linux.ibm.com &lt;maddy@linux.ibm.com&gt;; mpe@ellerman.id.au &l=
t;mpe@ellerman.id.au&gt;; ritesh.list@gmail.com &lt;ritesh.list@gmail.com&g=
t;<br>
<b>Cc:</b> npiggin@gmail.com &lt;npiggin@gmail.com&gt;; chleroy@kernel.org =
&lt;chleroy@kernel.org&gt;; shivangu@linux.ibm.com &lt;shivangu@linux.ibm.c=
om&gt;; hbathini@linux.ibm.com &lt;hbathini@linux.ibm.com&gt;; mahesh@linux=
.ibm.com &lt;mahesh@linux.ibm.com&gt;; adityag@linux.ibm.com &lt;adityag@li=
nux.ibm.com&gt;;
 venkat88@linux.ibm.com &lt;venkat88@linux.ibm.com&gt;; Sourabh Jain &lt;so=
urabhjain@linux.ibm.com&gt;<br>
<b>Subject:</b> [EXTERNAL] [PATCH v3 2/4] powerpc: move to 64-bit RTAS</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Kdump kernels loaded at high addresses (above 4G) =
could not boot<br>
because the kernel used 32-bit RTAS.<br>
<br>
Until now, the kernel always used 32-bit RTAS, even for 64-bit kernels.<br>
Before making an RTAS call, it clears the SF bit in MSR and uses LR as<br>
the return address from RTAS. For kdump kernels loaded above 4G, RTAS<br>
returns to a 32-bit truncated LR address, typically causing an exception<br=
>
and kernel panic.<br>
<br>
Fix this by switching to 64-bit RTAS support on systems where firmware<br>
advertises &quot;ibm,rtas-64-capable&quot;. The kernel instantiates 64-bit =
RTAS,<br>
passes RTAS arguments using a 64-bit argument structure, and sets the<br>
SF bit in MSR before entering RTAS. This ensures RTAS can correctly<br>
return to addresses above 4G and allows high-address kdump kernels to<br>
boot successfully.<br>
<br>
If 64-bit RTAS is not supported or initialization fails, the kernel<br>
continues to use 32-bit RTAS. In that case, high-address kdump kernels<br>
will not be allowed (handled in upcoming patches), and RTAS calls will<br>
continue to run with the SF bit cleared.<br>
<br>
Changes made to support 64-bit RTAS:<br>
- Detect firmware support using &quot;ibm,rtas-64-capable&quot;<br>
- Initialize 64-bit RTAS in prom_init and add a new FDT property<br>
&nbsp; &quot;linux,rtas-64&quot;<br>
- Read &quot;linux,rtas-64&quot; during boot and track RTAS mode using rtas=
_64<br>
- Add 64-bit RTAS argument handling and return value conversion<br>
- Prepare MSR appropriately for 32-bit or 64-bit RTAS calls<br>
<br>
Signed-off-by: Sourabh Jain &lt;sourabhjain@linux.ibm.com&gt;<br>
---<br>
&nbsp;arch/powerpc/include/asm/rtas-types.h |&nbsp; 8 +++++<br>
&nbsp;arch/powerpc/include/asm/rtas.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 2 ++<br>
&nbsp;arch/powerpc/kernel/prom_init.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 20 +++++++++--<br>
&nbsp;arch/powerpc/kernel/rtas.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; | 48 +++++++++++++++++++++++++--<br>
&nbsp;arch/powerpc/kernel/rtas_entry.S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 17 +=
++++++++-<br>
&nbsp;5 files changed, 88 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/a=
sm/rtas-types.h<br>
index 5d40d187b965..8a54647a87f4 100644<br>
--- a/arch/powerpc/include/asm/rtas-types.h<br>
+++ b/arch/powerpc/include/asm/rtas-types.h<br>
@@ -14,6 +14,14 @@ struct rtas_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas_arg_t *rets;&nbsp;&nb=
sp;&nbsp;&nbsp; /* Pointer to return values in args[]. */<br>
&nbsp;} __aligned(8);<br>
&nbsp;<br>
+struct rtas_args_64 {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __be64 token;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __be64 nargs;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __be64 nret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __be64 args[16];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __be64 *rets;&nbsp;&nbsp;&nbsp;&nbsp;=
 /* Pointer to return values in args[]. */<br>
+} __aligned(8);<br>
+<br>
&nbsp;struct rtas_t {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long entry;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* physical ad=
dress pointer */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long base;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* physic=
al address pointer */<br>
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rta=
s.h<br>
index d046bbd5017d..aaa4c3bc1d61 100644<br>
--- a/arch/powerpc/include/asm/rtas.h<br>
+++ b/arch/powerpc/include/asm/rtas.h<br>
@@ -10,6 +10,8 @@<br>
&nbsp;#include &lt;linux/time.h&gt;<br>
&nbsp;#include &lt;linux/cpumask.h&gt;<br>
&nbsp;<br>
+extern int rtas_64;<br>
+<br>
&nbsp;/*<br>
&nbsp; * Definitions for talking to the RTAS on CHRP machines.<br>
&nbsp; *<br>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c<br>
index 53503937de0e..be7c5ea0b75d 100644<br>
--- a/arch/powerpc/kernel/prom_init.c<br>
+++ b/arch/powerpc/kernel/prom_init.c<br>
@@ -1841,6 +1841,7 @@ static void __init prom_instantiate_rtas(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 base, entry =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __be32 val;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rtas_64 =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_debug(&quot;prom_inst=
antiate_rtas: start...\n&quot;);<br>
&nbsp;<br>
@@ -1865,15 +1866,24 @@ static void __init prom_instantiate_rtas(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check for rtas 64-bit support */<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prom_getprop(rtas_node, &quot;ibm=
,rtas-64-capable&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;val, =
sizeof(val)) !=3D PROM_ERROR) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rtas_64 =3D 1;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; prom_debug(&quot;Node ibm,rtas-64-capable: %x\n&quot;, val);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_printf(&quot;instanti=
ating rtas at 0x%x...&quot;, base);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *method =3D rtas_64 ? &quo=
t;instantiate-rtas-64&quot; : &quot;instantiate-rtas&quot;;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (call_prom_ret(&quot;ca=
ll-method&quot;, 3, 2, &amp;entry,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADDR=
(&quot;instantiate-rtas&quot;),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas=
_inst, base) !=3D 0<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || entry =3D=
=3D 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ADDR=
(method), rtas_inst, base) !=3D 0 ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entr=
y =3D=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; prom_printf(&quot; failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_printf(&quot; done\n&=
quot;);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reserve_mem(base, size);<b=
r>
@@ -1884,6 +1894,9 @@ static void __init prom_instantiate_rtas(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D cpu_to_be32(entry)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_setprop(rtas_node, &q=
uot;/rtas&quot;, &quot;linux,rtas-entry&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;val, sizeof(val));=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D cpu_to_be32(rtas_64);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_setprop(rtas_node, &quot;/rtas&q=
uot;, &quot;linux,rtas-64&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;val, sizeof(val));<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check if it supports &q=
uot;query-cpu-stopped-state&quot; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prom_getprop(rtas_node=
, &quot;query-cpu-stopped-state&quot;,<br>
@@ -1893,6 +1906,7 @@ static void __init prom_instantiate_rtas(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_debug(&quot;rtas base=
&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x%x\n&quot;, base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_debug(&quot;rtas entr=
y&nbsp;&nbsp;&nbsp; =3D 0x%x\n&quot;, entry);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_debug(&quot;rtas size=
&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x%x\n&quot;, size);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_debug(&quot;rtas 64-bit&nbsp;&nb=
sp; =3D 0x%x\n&quot;, rtas_64);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prom_debug(&quot;prom_inst=
antiate_rtas: end...\n&quot;);<br>
&nbsp;}<br>
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c<br>
index 8d81c1e7a8db..873e54238d2f 100644<br>
--- a/arch/powerpc/kernel/rtas.c<br>
+++ b/arch/powerpc/kernel/rtas.c<br>
@@ -45,6 +45,8 @@<br>
&nbsp;#include &lt;asm/trace.h&gt;<br>
&nbsp;#include &lt;asm/udbg.h&gt;<br>
&nbsp;<br>
+int rtas_64;<br>
+<br>
&nbsp;struct rtas_filter {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Indexes into the args b=
uffer, -1 if not used */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const int buf_idx1;<br>
@@ -569,6 +571,7 @@ static struct rtas_function rtas_function_table[] __ro_=
after_init =3D {<br>
&nbsp; */<br>
&nbsp;static DEFINE_RAW_SPINLOCK(rtas_lock);<br>
&nbsp;static struct rtas_args rtas_args;<br>
+static struct rtas_args_64 rtas_args_64;<br>
&nbsp;<br>
&nbsp;/**<br>
&nbsp; * rtas_function_token() - RTAS function token lookup.<br>
@@ -690,13 +693,48 @@ static const struct rtas_function *rtas_token_to_func=
tion(s32 token)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;<br>
+static void populate_rtas_args_64(struct rtas_args *args)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas_args_64.token =3D cpu_to_be64((s=
64)(s32)be32_to_cpu(args-&gt;token));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas_args_64.nargs =3D cpu_to_be64((s=
64)(s32)be32_to_cpu(args-&gt;nargs));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas_args_64.nret&nbsp; =3D cpu_to_be=
64((s64)(s32)be32_to_cpu(args-&gt;nret));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas_args_64.rets&nbsp; =3D &amp;rtas=
_args_64.args[be32_to_cpu(args-&gt;nargs)];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; be32_to_cpu(args=
-&gt;nargs); ++i)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rtas_args_64.args[i] =3D cpu_to_be64((s64)(s32)be32_to_cpu(args-=
&gt;args[i]));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; be32_to_cpu(args=
-&gt;nret); ++i)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rtas_args_64.rets[i] =3D 0;<br>
+}<br>
+<br>
+static void rtas_args_copy_64_32(struct rtas_args *args)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; (s32)be64_to_cpu=
(rtas_args_64.nret); ++i)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; args-&gt;rets[i] =3D cpu_to_be32((s32)be64_to_cpu(rtas_args_64.r=
ets[i]));<br>
+}<br>
+<br>
&nbsp;/* This is here deliberately so it's only used in this file */<br>
&nbsp;void enter_rtas(unsigned long);<br>
&nbsp;<br>
+static void _do_enter_rtas_64(struct rtas_args *args)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; populate_rtas_args_64(args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enter_rtas(__pa(&amp;rtas_args_64));<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtas_args_copy_64_32(args);<br>
+}<br>
+<br>
&nbsp;static void __do_enter_rtas(struct rtas_args *args)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enter_rtas(__pa(args));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srr_regs_clobbered(); /* rtas uses SR=
Rs, invalidate */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rtas_64)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; _do_enter_rtas_64(args);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enter_rtas(__pa(args));<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; srr_regs_clobbered();<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void __do_enter_rtas_trace(struct rtas_args *args)<br>
@@ -2078,7 +2116,7 @@ void __init rtas_initialize(void)<br>
&nbsp;int __init early_init_dt_scan_rtas(unsigned long node,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const char *uname, int depth, void *data)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 *basep, *entryp, *sizep;<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const u32 *basep, *entryp, *sizep, *v=
al;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (depth !=3D 1 || strcmp=
(uname, &quot;rtas&quot;) !=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2086,6 +2124,10 @@ int __init early_init_dt_scan_rtas(unsigned long nod=
e,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; basep&nbsp; =3D of_get_fla=
t_dt_prop(node, &quot;linux,rtas-base&quot;, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entryp =3D of_get_flat_dt_=
prop(node, &quot;linux,rtas-entry&quot;, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizep&nbsp; =3D of_get_fla=
t_dt_prop(node, &quot;rtas-size&quot;, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val&nbsp;&nbsp;&nbsp; =3D of_get_flat=
_dt_prop(node, &quot;linux,rtas-64&quot;, NULL);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (val &amp;&amp; *val)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; rtas_64 =3D 1;<br>
&nbsp;<br>
&nbsp;#ifdef CONFIG_PPC64<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* need this feature to de=
cide the crashkernel offset */<br>
diff --git a/arch/powerpc/kernel/rtas_entry.S b/arch/powerpc/kernel/rtas_en=
try.S<br>
index 6ce95ddadbcd..df776f0103c9 100644<br>
--- a/arch/powerpc/kernel/rtas_entry.S<br>
+++ b/arch/powerpc/kernel/rtas_entry.S<br>
@@ -54,6 +54,10 @@ _ASM_NOKPROBE_SYMBOL(enter_rtas)<br>
&nbsp;/*<br>
&nbsp; * 32-bit rtas on 64-bit machines has the additional problem that RTA=
S may<br>
&nbsp; * not preserve the upper parts of registers it uses.<br>
+ *<br>
+ * Note: In 64-bit RTAS, the SF bit is set so that RTAS can return<br>
+ * correctly if the return address is above 4 GB. Everything else<br>
+ * works the same as in 32-bit RTAS.<br>
&nbsp; */<br>
&nbsp;_GLOBAL(enter_rtas)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mflr&nbsp;&nbsp;&nbsp; r0<=
br>
@@ -113,7 +117,18 @@ __enter_rtas:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from the saved MSR=
 value and insert into the value RTAS will use.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extrdi&nbsp; r0, r6, 1, 63=
 - MSR_HV_LG<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_R=
I)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOAD_REG_ADDR(r7, rtas_64)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Load the address rtas_64 into r7 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ld&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r8, =
0(r7)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Load the value of rtas_64 from memory into r8 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmpdi&nbsp;&nbsp; r8, 0&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Compare r8 with 0 (check if rtas_64 is zero) */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; beq&nbsp;&nbsp;&nbsp;&nbsp; no_sf_bit=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; /* Branch to no_sf_bit if rtas_64 is zero */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_R=
I | MSR_SF)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* r6 =3D ME|RI|SF */=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; b&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 continue<br>
+<br>
+no_sf_bit:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOAD_REG_IMMEDIATE(r6, MSR_ME | MSR_R=
I)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* r6 =3D ME|RI (NO SF b=
it in MSR) */<br>
+<br>
+continue:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; insrdi&nbsp; r6, r0, 1, 63=
 - MSR_HV_LG<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; r0,0<br>
-- <br>
2.55.0<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DS5PR15MB70054353A2CCE5A34BEBF9EB87972DS5PR15MB7005namp_--

