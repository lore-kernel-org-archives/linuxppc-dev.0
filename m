Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAD_ENC_HEADER,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2BC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:28:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABBF20881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 05:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m+odNnNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABBF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YRn62zkZzF38T
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 16:28:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="m+odNnNe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.40; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="m+odNnNe"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YRS30TFLzF38x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 16:13:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSSkBp30IhWmVxPw41xqF1Ctqa7KCfxtLKLxoxlyI4k=;
 b=m+odNnNew3zw8pdZagxOK0Lg7GQE+vmBPPbejhf/yMhCJRaaRAw/fqD9YFl8F+MgsQvgBR0+5jXCQEUPreHjDrL7j45fwAxaGfNZtMPEivdJXCdWUy1TSvat/e0bVpDIVH3eCP9mNq948FQg7wkauVjXbVQd6aeQ0nMlZcW4MUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 AM6PR04MB4790.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 05:13:42 +0000
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
Subject: [PATCH v5 5/6] arm64: dts: add QorIQ LX2160A SoC support
Date: Sun, 14 Oct 2018 22:38:02 +0530
Message-Id: <1539536883-1928-6-git-send-email-vabhav.sharma@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0ec89665-b5e9-468c-9a48-08d6325cfd62
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4790; 
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 3:7EwqZEMKuQi0iSpCaKisvo3/N0ckZWUQPM7aE2wh7knLDyORCNhlTYgTCgxMKK5ntJlrd0I5AdXQhTaVVldieKyge2wdtXNXO1DMy68HetePtXD0uCKm2lm0k211gQPhyRqwUaVUhwD9zxnXQj58/y3jk91Vdwkj7OiyYPa9FULX9H6JsfJY8rDFG3G6sh31U3G59dbJ5g+eTvIxqtE/ECN9wC6fftO65M5wbjvCy+fHklvHbxI7E8rCxhB30DrM;
 25:yYtaQjY5Dw0jpKJZRo0NYlSyr6Ely9p8Ii9rAjN7/74KxBiz/pycIGWZNcwaA3MXvr7HXzGLHfOxlK2bnDyZr1Knd8oGTUcrGV3Tn0o9goRVysy7fdkKm1vQt+9gtn9tZAoqOh30p9Kp7qk92QXdrDHT+qSpKTkt6JKqcOOi3Ft9KEW1EL1ebFPD1Iy2cn5ojljUg+k1kVG/kw3D5x66mIGM2HxM/jHdcBUMN2U1ltIAB05lF9sO3Y0Aii9Ba/fMT57IQ44tOYaN1LIqL+hBsezKXsmwVTXSi1Eaba4nZ9mK3Q9M0PmnozhL53qpXqN0ijC3Dfo90bs49cCwvQWnww==;
 31:xyMA85rdOq1WwsBNrwCm4psDthJcPy0Nl5rV0sreAzj++w+IbWoG4BTB4GcUiglNtHyx2SRgG1e7nh2lVVHBI/f1XcK5/Gv8Q+JDieZkuD4qh4a2eegqeDy3urLIYD6p9RRW7NhmsRznARLdjm+U+mjelsDX15ByNITS332vvOPN/Ss9kMKRFETDgh/OicvKR8x4hmPM8sRQmLs5dwfDibJhgvM07gqHH+NN1tRMMxA=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4790:
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 20:XL03Km/yGvTaxW41WuCgNvgGYTZoiw3o6c8ESdkyWHRfPnJUgk2YRnWlaQQ8WnCE1s2Ix9wG3CXQTW0xr+HRw63k4jn8hxHfEyvrEwG3R9LO3V4scaZA5CGAp3rnoRSckiYHVaDLNnqpKDitmRjqWjGXh7TPtD66ZDhMLI0fr2Jr82zm4yA5JMQsTuKPccw6NVUX3OifZ1ftoCCUmn24bEbzjlBePZBnwN7/ngdFKn/7VNe/WsBmebZI8aKJH/wB6PW/RJu+HUvAGDS9y6gNptN+kBDtpxChK0Om0HAC1OyfW5I+661d8xIQ56eRm1AaiorJQ22Vt6M90waxY5cOcRL81E+atDLsFojJMb/IKTW7FcgKkrcCVjbXcFINo3DELND0khh0z2M9SmCjdmuRncpMXcpEwaWdHfJizMslc7UMkZXUoxQA4g7uepQnSyPwDr4ZvNcqxshQnDO0l+9KxMl4q/YNbJgM1oGMKoXNtQSn4W4Zra1L7u+7OCtIFjGy;
 4:4X+8XM2lTJMGAlTjDl48dKgRuYpVKd6aneEZ27Xz6VeW3wpQX17m+1/DXm7NarwCf819ShIfBbp9j9oarMFMM+Gw0mXOpz16MAVTu6638oEvVee5ZHuAsR/trOnh1PBITugbKFyRn6X/Osnus4l6ShK9RQiSp6H8z9++qI76rqfFwGlfM2TDxHsh4LHOg4FKeud/IMCp1lsUIXjsiUx4siwZMdvcjobjTlhY/7bq+vDZGclIMdUmilIQPKVU85/UeNuLccjDEW/8svfmZCEJSamOTWvhCxr3RrhhPaGnLZeG08Q8CQ9wAUftc883W6ni
X-Microsoft-Antispam-PRVS: <AM6PR04MB4790F01EE742544566BBFC11F3FD0@AM6PR04MB4790.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);
 SRVR:AM6PR04MB4790; BCL:0; PCL:0; RULEID:; SRVR:AM6PR04MB4790; 
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(53936002)(478600001)(6512007)(2906002)(52116002)(51416003)(3846002)(6116002)(1006002)(4744004)(575784001)(86362001)(14444005)(6666004)(5660300001)(316002)(50226002)(8936002)(8676002)(97736004)(68736007)(81156014)(81166006)(486006)(956004)(44832011)(2616005)(476003)(7736002)(47776003)(305945005)(66066001)(25786009)(186003)(16526019)(50466002)(48376002)(26005)(106356001)(36756003)(105586002)(446003)(11346002)(4326008)(76176011)(386003)(6506007)(54906003)(55236004)(7416002)(6486002)(16586007)(110426005)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4790;
 H:uefi-OptiPlex-790.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM6PR04MB4790;
 23:+ITOHa1ZsAHQuPhU/iL5JijqklNbnnThCQjmHh/o6?=
 =?us-ascii?Q?feSFb4uoum9KLEpkqBACVmnKXyYp3K3/W6ZYnxaYP9hZ8UGJeWe6lQ416Jvk?=
 =?us-ascii?Q?Dq60YkzJC2ahR4ypsks3T4zvxUpo3Bge2zTK2pOQA+/m0zi0LGZs5G7r9hf9?=
 =?us-ascii?Q?xUoS3q762/ex/8hUy0vTIBi0LBp4StrnMNifmWIt6TFFptz7HpQ1qqclysEQ?=
 =?us-ascii?Q?bkDjewjuneMlz5hWHOHJG+FMa28PoRmw9fhcX3WFkY5UtayYm0V743SnYrWb?=
 =?us-ascii?Q?g26hbe2rtZG6cvpyQKVjAUSxVkik8lXQu8p7mrqJrvFAuxsN0NNIETzYwW9D?=
 =?us-ascii?Q?G3l9T1J7V63o3gcteTJPd4Lt3ed70Ah95UQT3oscZ338/+ElTjnNbnhyBGaP?=
 =?us-ascii?Q?nH6wDPjwcpD5gli8CVSjjSND1FD2AXjMeWuKykBMpt+1XoTbuYkw9q+NkTJA?=
 =?us-ascii?Q?XxQ29sXq1QnDyGDd3GF2blwCyuTDdW8mPSc4jEJLHcafpB7E0+qPHZthGIUm?=
 =?us-ascii?Q?cm7NibZImtmZ5dABvx6IDM2jG5TewxMaMSTXwkCfDF+jrQkBTZ6bVCsO8SVb?=
 =?us-ascii?Q?d4d9u5VpGZUeQWXZ/eIePnOBaayLo4MGDrXP0IHA/bVcV9eoFgFh95llqI7e?=
 =?us-ascii?Q?IBwL2T9tX1v2oUPKr89V9dRRYhg9jf7ouYCyPZBT8AGfgUG3mcGK2+XGPrpQ?=
 =?us-ascii?Q?w4l3K+z7N6fC15dX73Wrq+YsOxOL+AbHBx4IO6q+fR+k6JYbXQ5jTiSjqm0f?=
 =?us-ascii?Q?a5EaEBc+DWULcTh++9nBwQyAv0yQ3HB4atpOKjz3WvIssD07fTTNlvO+mVMn?=
 =?us-ascii?Q?7ceewmEK+Eodc3ic+n5UAZX0V4ZnuxWymJQY8wHnLo+JSfJrQxeLb+MkKlnG?=
 =?us-ascii?Q?Ng1ZRxDCH+RrojhKMLbQDPSR/aPSarCDIieJhZ3QHmgFNeSUMuQMH2Z1ErhQ?=
 =?us-ascii?Q?qoXpVD6j1NC1ocTaYdBeA0a3CBHvxfjN1yaFrw09BPc+114O7eio1lLfuLnk?=
 =?us-ascii?Q?7zuC7aBwnMlvwonW1LfsAhnCCh2YSxHtgRqYIVMzxKskr2l7+1IQX3N3P0B1?=
 =?us-ascii?Q?IXUbgjMGftSuOv7KCBUVLv/w/PbG97MMbBn/hrd8r0Jt5wjbMxUej8hzmIR3?=
 =?us-ascii?Q?f6z7prdSD1KeReXwP/EOChZomsXwkmoQC2ZdhJkKMEs3LhjGl8WCuRNa470g?=
 =?us-ascii?Q?eOz93D9O7J50IJWB6uAfEu/oyZ4QlGd2nBLOtU/lIegpK0s7m+uQlZN+MWeQ?=
 =?us-ascii?Q?/8r1fZ17Elia3nR2hF4pfYd11nOt0dwLYe16UWGuHV+vlT2/S26APEY069Ac?=
 =?us-ascii?Q?tEhrRCdEbBaZdUcGlWUjxufn9i+pfUCDS+IJ4Y4kZQTYjg8FAzKeR1gAAZnx?=
 =?us-ascii?Q?lkv9/Mjq3XWlf/nbtCKwSfcRW8=3D?=
X-Microsoft-Antispam-Message-Info: UYM/zuVDU4q08UY7WOnvTN68UBQ/2ZiZo8eVm8KPDgPDUblzNFP01NjdxCa/VjXz3W4RzN0Mrrg3UVeCRtNXVAloNuc2R7A9LeTNSebPKCvVMXsgLzg/KN3y0cPHlKm3GCc4HLeEoE0Rblxg7FetsEuZXuTXW5LTE9i8rAjWI3I+O7Kelo3VT8Y5nf3vsN5edu5C5K6no/KadMrcUowf4erF3O+u3J/8aRvvcLfZvCqwSyRcuIqYrHfPy7l2ZD8TumK4C9jtPQGGIMxZhHMcXG8C9EPQzNAi8SiEI1XJjkS+DNl4iRr0vmIQENjbPMzyo6B2QNUq0wavZXx0CnqIhQmF0worAneMcrFSLvt53Jc=
X-Microsoft-Exchange-Diagnostics: 1; AM6PR04MB4790;
 6:kDmVy+NmEecG6jEhT5LAJbkA0HZp/b0uLtqW9Bub0nmpkdBPmHCRdqt9qYtUhRNacPYIIp0ey4hyArgDOWavSYbndekhcvi1nWnCpZ7eBFvMrFW3Dlrpl/HgBEojTgLYZ9HUkZnnzarv0LmI179dO2XVZWjSWAPpUmK9b3MR+rKiUpjUg/LcJWjkHgds6LhGe4DfGRE+QP5VdAz3MnbRr2+SK9Bs0IdZTbHpReFmQGF0A2vOD0PaHllz/mvJG4d5vldc81XiBn3uaM5V2cqs8EdYHX+mSwYDMlB71nqMB8nX0bkfD2YpvXYZfnm+w6yvmX1w+BRGB3UIbjc/1P74PYHYQ+k72xugq5lDnxFFDF6ngQcvoQUzoC78MfwNmfq1715i2ejXUJ91IUfDVk+5+vM+eVNWrQNGlNQWlc//11SZdM5U12aYoM0Zi6TjXua5CIkONrTx0VuBc/zZt/rd8g==;
 5:t9xdhbHnV+mMlL83OM7nyioczbYhp6Lgj4O9uVWVQcO6hE3z5VjIBRWqPruiiRVhla3M+F31kmAX8r1BcIqF+C9QuYCp6wGZ3M4tCFJ7JH0pQ0di9hr4Ryb5HGH8cESOwsHsCYNCdsLgpFKR4obVRNG9HzktjJ8D5yDFtO1wvaQ=;
 7:jMZ4K+28u6744ZIQY+Gs9QWGik0MoGPVWldeOMhftNiU++079gCRvTt8hUZ6SiPuPzkYn3WelctaDyuc4mbCXPwaXCp6+4OkSY6JlI+E0I77buQM1ouiTGyKvrAG5WK815gvcWxyCVLvugZw/pg1J6dOD67QybaTEg5ucRtMB+vSdJY0+/cUXimQBDWkZHYNogVzLvkf8itNpZu45tYJ/EE2ozwuVkXEelvWcCVHZzNzbQQUOjIDKc4JqTIF/c7x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:13:42.0463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec89665-b5e9-468c-9a48-08d6325cfd62
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
 Horia Geanta <horia.geanta@nxp.com>, udit.kumar@nxp.com,
 Priyanka Jain <priyanka.jain@nxp.com>, pankaj.bansal@nxp.com,
 Zhang Ying-22455 <ying.zhang22455@nxp.com>, linux@armlinux.org.uk,
 adrian.hunter@intel.com, Ramneek Mehresh <ramneek.mehresh@nxp.com>,
 V.Sethi@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>,
 Nipun Gupta <nipun.gupta@nxp.com>, Sriram Dash <sriram.dash@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LX2160A SoC is based on Layerscape Chassis Generation 3.2 Architecture.

LX2160A features an advanced 16 64-bit ARM v8 CortexA72 processor cores
in 8 cluster, CCN508, GICv3,two 64-bit DDR4 memory controller, 8 I2C
controllers, 3 dspi, 2 esdhc,2 USB 3.0, mmu 500, 3 SATA, 4 PL011 SBSA
UARTs etc.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 765 +++++++++++++++++++++++++
 1 file changed, 765 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
new file mode 100644
index 0000000..56f846c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -0,0 +1,765 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree Include file for Layerscape-LX2160A family SoC.
+//
+// Copyright 2018 NXP
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/memreserve/ 0x80000000 0x00010000;
+
+/ {
+	compatible = "fsl,lx2160a";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		// 8 clusters having 2 Cortex-A72 cores each
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x0>;
+			clocks = <&clockgen 1 0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x1>;
+			clocks = <&clockgen 1 0>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster0_l2>;
+		};
+
+		cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x100>;
+			clocks = <&clockgen 1 1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x101>;
+			clocks = <&clockgen 1 1>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster1_l2>;
+		};
+
+		cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x200>;
+			clocks = <&clockgen 1 2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@201 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x201>;
+			clocks = <&clockgen 1 2>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster2_l2>;
+		};
+
+		cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x300>;
+			clocks = <&clockgen 1 3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@301 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x301>;
+			clocks = <&clockgen 1 3>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster3_l2>;
+		};
+
+		cpu@400 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x400>;
+			clocks = <&clockgen 1 4>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@401 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x401>;
+			clocks = <&clockgen 1 4>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster4_l2>;
+		};
+
+		cpu@500 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x500>;
+			clocks = <&clockgen 1 5>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@501 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x501>;
+			clocks = <&clockgen 1 5>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster5_l2>;
+		};
+
+		cpu@600 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x600>;
+			clocks = <&clockgen 1 6>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@601 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x601>;
+			clocks = <&clockgen 1 6>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster6_l2>;
+		};
+
+		cpu@700 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x700>;
+			clocks = <&clockgen 1 7>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cpu@701 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			enable-method = "psci";
+			reg = <0x701>;
+			clocks = <&clockgen 1 7>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			i-cache-size = <0xC000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <192>;
+			next-level-cache = <&cluster7_l2>;
+		};
+
+		cluster0_l2: l2-cache0 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster1_l2: l2-cache1 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster2_l2: l2-cache2 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster3_l2: l2-cache3 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster4_l2: l2-cache4 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster5_l2: l2-cache5 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster6_l2: l2-cache6 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+
+		cluster7_l2: l2-cache7 {
+			compatible = "cache";
+			cache-size = <0x100000>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-level = <2>;
+		};
+	};
+
+	gic: interrupt-controller@6000000 {
+		compatible = "arm,gic-v3";
+		reg = <0x0 0x06000000 0 0x10000>, // GIC Dist
+			<0x0 0x06200000 0 0x200000>, // GICR (RD_base +
+						     // SGI_base)
+			<0x0 0x0c0c0000 0 0x2000>, // GICC
+			<0x0 0x0c0d0000 0 0x1000>, // GICH
+			<0x0 0x0c0e0000 0 0x20000>; // GICV
+		#interrupt-cells = <3>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		its: gic-its@6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0x6020000 0 0x20000>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a72-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	memory@80000000 {
+		// DRAM space - 1, size : 2 GB DRAM
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+	};
+
+	ddr1: memory-controller@1080000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1080000 0x0 0x1000>;
+		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	ddr2: memory-controller@1090000 {
+		compatible = "fsl,qoriq-memory-controller";
+		reg = <0x0 0x1090000 0x0 0x1000>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		little-endian;
+	};
+
+	sysclk: sysclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "sysclk";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		crypto: crypto@8000000 {
+			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era = <10>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x8000000 0x100000>;
+			reg = <0x00 0x8000000 0x0 0x100000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+			status = "disabled";
+
+			sec_jr0: jr@10000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x10000 0x10000>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr@20000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x20000 0x10000>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr@30000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x30000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr@40000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg        = <0x40000 0x10000>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		clockgen: clock-controller@1300000 {
+			compatible = "fsl,lx2160a-clockgen";
+			reg = <0 0x1300000 0 0xa0000>;
+			#clock-cells = <2>;
+			clocks = <&sysclk>;
+		};
+
+		dcfg: syscon@1e00000 {
+			compatible = "fsl,lx2160a-dcfg", "syscon";
+			reg = <0x0 0x1e00000 0x0 0x10000>;
+			little-endian;
+		};
+
+		i2c0: i2c@2000000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			scl-gpio = <&gpio2 15 GPIO_ACTIVE_HIGH>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@2010000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2010000 0x0 0x10000>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@2020000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2020000 0x0 0x10000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@2030000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2030000 0x0 0x10000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@2040000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2040000 0x0 0x10000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			scl-gpio = <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@2050000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2050000 0x0 0x10000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@2060000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2060000 0x0 0x10000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@2070000 {
+			compatible = "fsl,vf610-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2070000 0x0 0x10000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "i2c";
+			clocks = <&clockgen 4 7>;
+			status = "disabled";
+		};
+
+		esdhc0: esdhc@2140000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x2140000 0x0 0x10000>;
+			interrupts = <0 28 0x4>; /* Level high type */
+			clocks = <&clockgen 4 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		esdhc1: esdhc@2150000 {
+			compatible = "fsl,esdhc";
+			reg = <0x0 0x2150000 0x0 0x10000>;
+			interrupts = <0 63 0x4>; /* Level high type */
+			clocks = <&clockgen 4 1>;
+			voltage-ranges = <1800 1800 3300 3300>;
+			sdhci,auto-cmd12;
+			broken-cd;
+			little-endian;
+			bus-width = <4>;
+			status = "disabled";
+		};
+
+		uart0: serial@21c0000 {
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21c0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart1: serial@21d0000 {
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21d0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart2: serial@21e0000 {
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21e0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		uart3: serial@21f0000 {
+			compatible = "arm,sbsa-uart","arm,pl011";
+			reg = <0x0 0x21f0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			current-speed = <115200>;
+			status = "disabled";
+		};
+
+		gpio0: gpio@2300000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2300000 0x0 0x10000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@2310000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2310000 0x0 0x10000>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@2320000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2320000 0x0 0x10000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio3: gpio@2330000 {
+			compatible = "fsl,qoriq-gpio";
+			reg = <0x0 0x2330000 0x0 0x10000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			little-endian;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		watchdog@23a0000 {
+			compatible = "arm,sbsa-gwdt";
+			reg = <0x0 0x23a0000 0 0x1000>,
+			      <0x0 0x2390000 0 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			timeout-sec = <30>;
+		};
+
+		usb0: usb@3100000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
+		usb1: usb@3110000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0x3110000 0x0 0x10000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "host";
+			snps,quirk-frame-length-adjustment = <0x20>;
+			snps,dis_rxdet_inp3_quirk;
+			status = "disabled";
+		};
+
+		smmu: iommu@5000000 {
+			compatible = "arm,mmu-500";
+			reg = <0 0x5000000 0 0x800000>;
+			#iommu-cells = <1>;
+			#global-interrupts = <14>;
+				     // global secure fault
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined secure
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+				     // global non-secure fault
+				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     // combined non-secure
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     // performance counter interrupts 0-9
+				     <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
+				     // per context interrupt, 64 interrupts
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+		};
+	};
+};
-- 
2.7.4

