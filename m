Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D1C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:00:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E97820875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFMNeTKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E97820875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHdc1H3zzF3K1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:00:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WFMNeTKI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.66; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="WFMNeTKI"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RFTW66JnzF3BN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 13:23:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUim4c+5vEG2lxNl6E0QOrHS9P++4YI70Xuzl8/ib7A=;
 b=WFMNeTKIH+a/Zhf9p3ioTVxCDTUQk6/QRFZyIaxORWVBdJloqj0nWoiuRXMH4bpd0VuEZT8TlHJJCIDEweqhmW71kOsEGSjLu3FVlcAXvKU5N9zYP2W6AV3OxK8ROWNbVYRBQL4YERMlK77QXwLZinV5RFvP1VmIEEiy/MV37vk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
Received: from uefi-workstation-2.ap.freescale.net (14.143.30.134) by
 HE1PR0402MB3324.eurprd04.prod.outlook.com (2603:10a6:7:81::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Fri, 5 Oct 2018 03:23:23 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH 1/2] dt-bindings: soc: fsl: Document Qixis FPGA usage
Date: Fri,  5 Oct 2018 14:25:04 +0530
Message-Id: <20181005085505.29024-2-pankaj.bansal@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005085505.29024-1-pankaj.bansal@nxp.com>
References: <20181005085505.29024-1-pankaj.bansal@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::21) To HE1PR0402MB3324.eurprd04.prod.outlook.com
 (2603:10a6:7:81::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db0e8539-533c-4fa0-6b24-08d62a71e937
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB3324; 
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 3:e7jGirJcRPM9taGGwDBblixFbqvBl0M/MMI1XTuGwFMRctyJKI/D4RpWiikaRFVeL0pr6uuLkd/qxW0T/hl8NOUBe6X0BCaAjvOxz9+LowJA/sRKhbNv4MGl4UxyI4KWgrif/6kG3+sdGCbKhE6Q24BaNLqYIw/TQziD6szOomNnLZqlLfuOwyk38D5XmNEx4d0Xk+/t7Dy8sR9fSJ//wgpgwo1vfTMPSvxhPPyV+bFyzVks05BxxXhgGhHEJZ4L;
 25:3zhYFowfbY6eBvkSpGkZg0GCz4QNTahIxxKv++I0alX0P2624CpZqM1X+pN0l72CF38g0bkwS+mH8U0Jj3Bs8mdMGG4rCK/i7f2pcYkYqVqYH9YkxVdrNUuozJ2bXwdqEdH/KNMfcJNThfErGSVQQe33tS6Fj6q3NNXW6Ii54lpfPWKID4h/N1jcUvKVnMsTvHqnoloJkVT0c5eLwRYd0UBprA5tVkw7dlgsyVRiCD1/XhcXOtJk5s8iLly5L3yLz4JL8VPSiEDY/SpRLEO0aOwJl03ygQYNi/9n4E2LiS4GLnKLoZ2JbnPnuFIilOHhbeJVgzst6IAsTj/iAM5dPA==;
 31:2/DAvE01vV0TayZTtqgyPQn6LQ6x8fPVizrItZvCLXXBZL4dorfm1zeoVmu0UFx0cbwUZR1oxW6sFfN/W+1KGj3/OoGx5FEaelGlF1I5NEYJFwaGBrLh/ei4bC4UKbnZA97owJwE0zwkjRL0BDKD6C31e9qHiE9bNeoJmyuV/FGCwT+pr1ZQylMkCrLKOVfK2lgQM0erF38ij/1intQCcR2lPqz3qsJESnM3vh5du8c=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3324:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 20:3jv+zLuzmT9fnjSfl34A8cAYrX9dLwLc+rnEn9NIeT7gAHf52Gs55u+ziBwBBq0mvhJRxTfAnsAeSskECupFOjAqImg+fqaQodI5uXzrX/l4aeCKI5AYCYdAU0l/M0JeWk+gl9EQIW/rNZ0lsOwiQUWtS2ozuYSq4l34e1kcYs964UTXnIlM3c7VUeE+hgoSPsBvhl9kbx+BHKDYlcR4Dy01rURhhs7JY+Syk3PthMn6yD9L1R+ZMaO3SvGZs0mndLHIspeDF3l/2ExYct8tNo92JV4kGmjMfaW0hYiRIYaMY3iV/m7ptAt3a+Vbqrj+4XF1ZKqipDRfJEKjIIbUTOJx7WafyPuzEtpq2Co4vTfpTPeS0qLT/WsOIsuxfSBs/vL4Z6OG+GkGceW836aQXOrz16XYEyvoOVcSsl7lyRv45esLuSOLsTBLJdjdx6FGIIm+5xPC9tP9zXg5F3ycb9CbjzauZjwx6QwjjyqwzMrKp6zpxh5rJE8j0EMZRD3S;
 4:btdO1wvw/LgwjzErCKlpDc94vohf8fB99pMNNH/gspRDjip7il04HWUqb4HEn2enJudGXSRwbQDEB2UhCIynTye8KBh4LMTkwLULCn70HBe0+u056Bh3TUwKWu4BdNT7NY2d4o3bwv5AGpqdUoc/NOXXNziFOywtnazILeul0V7pLMZdlqINRiSF3ZVbA1+adnWPBziBvUTGpH0poUHMLW6u9ZiAyGNgmuaU4vBqo6LIupVwIsJ8SQ7WKI5xf2FD8U7X6PiYgHGZ9X8G59mxumUHj8WcGr9K57tLpCKz9GE/DKlWIW9rQD8dBdLGwxThBiIjKCw1pcFTeDGGzMCN9g==
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3324DB6E721F2A82A518B804F1EB0@HE1PR0402MB3324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(72170088055959);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);
 SRVR:HE1PR0402MB3324; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB3324; 
X-Forefront-PRVS: 0816F1D86E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(186003)(23676004)(81156014)(81166006)(478600001)(1076002)(6486002)(52116002)(50226002)(8936002)(386003)(55236004)(97736004)(5009440100003)(6506007)(6862004)(316002)(8676002)(5660300001)(16526019)(26005)(446003)(66066001)(44832011)(105586002)(11346002)(76176011)(106356001)(476003)(6512007)(6116002)(3846002)(6636002)(7736002)(4326008)(486006)(37006003)(53936002)(68736007)(54906003)(956004)(25786009)(2870700001)(50466002)(36756003)(305945005)(86362001)(6666003)(47776003)(2906002)(110426005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB3324;
 H:uefi-workstation-2.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA0MDJNQjMzMjQ7MjM6a2xEaEllVlV4eEhYOGZraHBUeGh3cW03?=
 =?utf-8?B?Y083TjZXMDhqOTN5TnZpMDBJaG1hcmlvZjM0Skg3SUg1NktFNThRUWgwbld2?=
 =?utf-8?B?WFdoRlU4YmNjbmlrS3VVdStZMFJmcFJVMmxCMVRZdk1RbWNXcEVsSEx6Y2Ft?=
 =?utf-8?B?OW1McXhsZDJUbklqZk5wbU1uUzlVNE44bkVxQnFRejVLZ1F5SjVTcDUxNmFI?=
 =?utf-8?B?WmV0L1pjdE1PdU9zVW1nWTRrMWRQSkZRVE4ydEhra2d2NGVPSVl4NUJEdlkr?=
 =?utf-8?B?N0huYVh6OEdBMC9DUk10bFhMNXVPdG1oOUp5eC9FM1Y0SFBmQy91MTVqdEc2?=
 =?utf-8?B?eFpzd2dKYk5wU3ZNaDZmemkvWnpGNG1JZGJGa3ltUGhZQ1MrVUdMRmdwS1kx?=
 =?utf-8?B?QVVzMUxyVUJaeEVhd3RpMjhHbERuOUdadkh3azc2K2pOckE5SzNUUU0zS0Fy?=
 =?utf-8?B?STVKbjRZRUlkSGJOT1NWQldpWk51VW1MTUw0KzlDSGpCeXliakdYekFFYTFR?=
 =?utf-8?B?elNadzV3TjFnUFFoZ0pFUHVIbC9SVnlqUVExTWd0ZkMxQi9LVEltN0RpVHJk?=
 =?utf-8?B?RW1KWVByMUY2Y3FsdFJHVGU5Rkc5TVU2b0VOWWhMMzBFMHdSdFVVRkxTMVlF?=
 =?utf-8?B?anIzdHhMM0J4YjFtNTlLaUVPYXBjMXkwVDFIVzZ2cFRPc1JrODZ2NXBCT1p2?=
 =?utf-8?B?ZFE1L2Y3UXN5VHRzbHdiTFdPNGJ1cXlzaUdWOXhIc1R3M0piQitIWnM2S08w?=
 =?utf-8?B?U0xlTVo2bXFiU2ZKNGZEeGtlS3VmcWk0NWxYaVF6VFVZdzNMWUJTaG9OdHpq?=
 =?utf-8?B?dVAwYUFNR1RCbkhBUlFaRUt6ZVl5cVE2dTlMcFJYN2JOcEFZaXdnZ3BCTFE5?=
 =?utf-8?B?Ti94VGRtVzR5UlZUbDVaekkwQ2dHRnlKWHZjTFN6dnpiaXRrUEdSQ00rcUQ4?=
 =?utf-8?B?NGhzSi85MEJMbERyS3laZDZFenp4WllPVzdNaFRMNzR5aGl3TTFaZjJRaW1t?=
 =?utf-8?B?SXFIckJXZDNuemlCaWlLb2pyZFlNbWJmT0Fhem5kbVBNZWlmSmFFVFlmQjdv?=
 =?utf-8?B?cHhId2xCRHFuN2lUV0NoeVZqNjdDZmZ0YmQ2cEUxV2hZUm16M1dhbnU1Y0tG?=
 =?utf-8?B?VHFIczRFTlk0VFczRWIzZi85WU5xSmhmN3B1OTY5TjF1Ly9ZOXdZdS9scnVM?=
 =?utf-8?B?VndsYnVYNFpZK05OQlQrR0E3SWZtTDZsSzV0K3dmUkFCMTU0UTVnTUM2TkE4?=
 =?utf-8?B?S3JUOXhYRzVkcEo0T3pEbGZlallHNy82eEtrU01yQmRseDR5R2llR01qcXF1?=
 =?utf-8?B?dWdMVTNiTko4cDlUZGJQWTgya3hpRDRFOGlLbnNSMDdtQWQ1V3dJWVROQWx1?=
 =?utf-8?B?ZktCY3J6NzNpMkRTREFNd2REQy9iTWo3ZlFKVWZCdUNCdzMyRytMUHlLQ1Fv?=
 =?utf-8?B?SG5wZk1tbFcyQTJMbXdYUUl3MW1qUmt2b09SaGlyVEQzT1hmV2Fqa211OHhY?=
 =?utf-8?B?dnFVR0hxUDRiRmFCN1JXZGNYN2F3K1J2UHhIL3JJQWcwZHNVUUlqNncvRDQy?=
 =?utf-8?B?eDdLaUVvajFOZzl0UDJUWEdZRDJSeTZZQXltcE5ZRHNKcXBwekwzOS9kRmhU?=
 =?utf-8?B?Y2NocjFNWkE0OHUwcGE5UDNIRld1MHpxRldObGJCMW1tUU5MQmw5bVg2ZEJz?=
 =?utf-8?B?dUpaWEZ2RmI2bmFCUUQ5NTRiN3MyVXp2NE0xS0pZMmNGN2tiSnhINlo1VEIx?=
 =?utf-8?B?c0J6TURPaTYxVG5idUNXR0s4ZDRLVW9ESVJMRStjWFdrdU9XOFRlTDVrZ1ZP?=
 =?utf-8?Q?lK+WXT02VawuuNG?=
X-Microsoft-Antispam-Message-Info: M24YjccFjW4OzSHcYXzA8Di3aJL4wBJufRLratMSjxFxb5RBW/YKuERGP6hcSfhmDwc22PZ3oW33j8dBKpjlPw/ExT5+HcAiPz8WDUHFOozhQ9C715siEQ4x7tlkdE91VSMgg9Bz46Wp2J5bTWUlWCA7D1hMzvM6eZ1YBmRFZydUUfjui9zoSPIMCmqlla3Wf90hOKrrKzdFj817wjzLzKm7k/K+ntA2g7lbY3FObBW5cIAb5IMUPuuSmzjWFzPTPq3oV4SWTd45xubFSB4U0+m1OvhywyFWEZI4wxsk+xMhUNycPIdr8LmopQ01EHkqF+qU3rOoOqHhhQAdVAaxfEneyJCN4ffSRkflJOB6K28=
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 6:G9eUt3hmFy0i+VWEVszfOfmCLmgTimCTiN+D9Brg2ovE7CruV/flC4AOF37kEQaRon75qjutTIKfrBXJ9rw8ddMLsY09QqbGya7LR0mSw31s+ai0e9fo57h/nv4oApApm8QhKYcxYcH5wFHIz4VY9QMRGRd0IBwexTV4rq6RYsiVChA37sA6b59AxQf4WNepxjx/rmjJEG5LUvgcriORicauy0buXFaKrYi02TXJFM7oFpb3hQXdFnwkdTCCEWdUaNY/0vGqWb81QL6rdOMo1bcgSQYCAiP8YGKlvKYc+Weks59w7nU0MONS3y+b8Kxm1jTCJ6J0Vt1ADQ2sY63LWhERy11Tl/EqwDDaGY09vB9Z3U16g5fGM+2M8AM9eDpPVnmZLWOTmkA9uagp5Xg2IcYCysE60WdTjjRAVTdzSQcJBji58sGp4oWHA7PYj3tLxUA6Ml3NBEn1oznmzM2g7Q==;
 5:AhPXygOgdQuoOfLN+XnqaPXuBm+ffs95x8P6O9QXiermj3Yhn27cIeVX0l0bU1+QdpIgLzQJag5dPDXmheaAueuQQF3lWEXCeHhVG0iZOgzlT8QpN8j4ivMJ+WJLejjsD54YUq2ZGOkSpo4AmsIeZ6EtwE/pPoaeKp+kS4ATej0=;
 7:gQLTbMynyXgrXG+xK7RRAEKzXomZPMhk7n4vVTjzIEwja2U/HNJuNc88DQDvz/TmbfHnw2GSk9GwrOo/37IgW8j20rVn211AM8yOXPdzhYghHkUt3AyNXixIhb9X4ccJxqazxYDHfDM3HTUcH0p/PLto3EcOLd6u0Yib1M2h6QzTVD2ehpRqPLdG3O+kh9tXXcFloK0QygOBGVyehfMTQd9m+TGD/4AVC6ziTGYcGbHPhW3AKtG9oXQrDMzNh4lL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2018 03:23:23.9085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0e8539-533c-4fa0-6b24-08d62a71e937
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3324
X-Mailman-Approved-At: Fri, 05 Oct 2018 14:38:19 +1000
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
Cc: Alexandru Marginean <alexandru.marginean@nxp.com>,
 Pankaj Bansal <pankaj.bansal@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

an FPGA-based system controller, called “Qixis”, which
manages several critical system features, including:
• Reset sequencing
• Power supply configuration
• Board configuration
• hardware configuration

The qixis registers are accessible over one or more system-specific
interfaces, typically I2C, JTAG or an embedded processor.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 .../bindings/soc/fsl/qixis_ctrl.txt          | 33 ++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
new file mode 100644
index 000000000000..bc2950cab71d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
@@ -0,0 +1,33 @@
+* QIXIS FPGA block
+
+an FPGA-based system controller, called “Qixis”, which
+manages several critical system features, including:
+• Configuration switch monitoring
+• Power on/off sequencing
+• Reset sequencing
+• Power supply configuration
+• Board configuration
+• hardware configuration
+• Background power data collection (DCM)
+• Fault monitoring
+• RCW bypass SRAM (replace flash RCW with internal RCW) (NOR only)
+• Dedicated functional validation blocks (POSt/IRS, triggered event, and so on)
+• I2C master for remote board control even with no DUT available
+
+The qixis registers are accessible over one or more system-specific interfaces,
+typically I2C, JTAG or an embedded processor.
+
+Required properties:
+
+ - compatible : string, must contain "fsl,fpga-qixis-i2c"
+ - reg : i2c address of the qixis device.
+
+Examples:
+	/* The FPGA node */
+        fpga@66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
+		reg = <0x66>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	}
+
-- 
2.17.1

