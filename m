Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F2BC32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 08:51:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A78820825
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 08:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GxfWDcOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A78820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rH834yrRzF3N9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 19:51:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GxfWDcOS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=xilinx.com
 (client-ip=40.107.73.56; helo=nam05-dm3-obe.outbound.protection.outlook.com;
 envelope-from=michals@xilinx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com
 header.b="GxfWDcOS"; dkim-atps=neutral
Received: from NAM05-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr730056.outbound.protection.outlook.com [40.107.73.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rH5L0xbXzF3Mt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 19:49:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NzdHd6R9qakoALMu31y5x0DtMRzivzrrRFERpanuNo=;
 b=GxfWDcOSAnwhWk5E7NOLC4ze74MUXxY9+p2FeCp0eROSYbVItuIdr9WRMUE5LaGh7GxQUlIyKYpF4hK5ZzYKXHvabJVY4SmTUcbAPFH3v76zizFHoJ1UZ0Bhc666lf+E7AytSwqLQDzLJYOIrYhNq/30D54bq3wUcgQyQOiM4aI=
Received: from MWHPR02CA0055.namprd02.prod.outlook.com (2603:10b6:301:60::44)
 by DM6PR02MB4332.namprd02.prod.outlook.com (2603:10b6:5:2a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.22; Thu, 8 Nov
 2018 08:48:57 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR02CA0055.outlook.office365.com
 (2603:10b6:301:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.22 via Frontend
 Transport; Thu, 8 Nov 2018 08:48:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.11
 via Frontend Transport; Thu, 8 Nov 2018 08:48:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gKfzi-0002J5-Hm; Thu, 08 Nov 2018 00:48:54 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gKfzd-00041b-Cx; Thu, 08 Nov 2018 00:48:49 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA88mmu2016178; 
 Thu, 8 Nov 2018 00:48:48 -0800
Received: from [172.30.17.111] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1gKfzb-000417-EO; Thu, 08 Nov 2018 00:48:47 -0800
Subject: Re: [PATCH 12/36] dt-bindings: arm: Convert cpu binding to json-schema
To: Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-13-robh@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <035ae23f-3c92-ffd9-0753-abbd604c5c02@xilinx.com>
Date: Thu, 8 Nov 2018 09:48:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005165848.3474-13-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(438002)(50944005)(189003)(199004)(110136005)(8676002)(106002)(478600001)(76176011)(186003)(81156014)(81166006)(64126003)(54906003)(316002)(2486003)(26005)(77096007)(58126008)(23676004)(6246003)(230700001)(356004)(63266004)(6666004)(106466001)(336012)(39060400002)(4744004)(6306002)(65806001)(53946003)(50466002)(5660300001)(7416002)(229853002)(65956001)(2906002)(4326008)(53376002)(966005)(31686004)(47776003)(36756003)(305945005)(11346002)(2616005)(9786002)(14444005)(44832011)(486006)(126002)(426003)(446003)(2201001)(31696002)(8936002)(476003)(65826007)(107986001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB4332; H:xsj-pvapsmtpgw01; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-83.xilinx.com; MX:1; A:1; 
X-Microsoft-Exchange-Diagnostics: 1; CY1NAM02FT003;
 1:UYPygGWkusrEetl7PLRnrfUptpU0EfwN9DfR1QpJCA9G5F+0xKTEjCltA8noKVi9xazjslGEp5a8oedb6LKzWcyuwA//VItIFKkJEPigUGvZ++EHp582VuyG4cIZY8A5
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c34306-aca2-43d0-07e5-08d645570523
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);
 SRVR:DM6PR02MB4332; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 3:TIcxk/kVwv6/D7VE82/ylRimCYknSpRodFFhNSRXjZ+/9iids7d1C5mCJLCl3owpMrtHlcfIO57cAQtQTmmWbofJvjN5Kcz4OyEQzTqM8EXaJKMLxbFczjzUX5XFnJp+mjhPnunM009vB33ijbGfgwmCC3bC6y7+nVE1Q68/J9BUCstWltWdCN31mryrFgF8sBtCBIm7eqHh3saHN8dxaDLXMMa6ESTzgxrs9uedHhc7xbK2bxEPbH4dpDe9YJtmHOvq+WeT9WSILKq0hblIL3syIARRbxdTYqaiszYpmaD9qqB//d53sEaoSgkkf4y3yasv4wt0VhSLp1vHiMeqT60NlOKUpEjgKNG34eiM/Qo=;
 25:qG5LvwgisXFUiTfAz+CPyfd37TILntKtVfd7w+MN1FIlGU+a9J9QtHKQ7IeNbj5On7o84W2XaZ3chO3G3zHHLB/pAEJO0ztZwhkWdDSSM4Z8MT7y1oMxgScJJi9DJXmGKiTrWZyFhgcQjB39EXHUYyN0gutpxWYsPiLlT39KG//lmILUqlnMDncPY4uv7awAbP9iDlMQi2c7MkeUps5UqOWGVgRGy71vOwSIehlazxVsblU2nRg1hiqnitnAEgbi/SFLKhXffs7EV2BDuHdu41s8NabrpHwOVf8yAn6EQ/JqWx7zOdrJkFIooD2lvEvb7LDOTGcPZ8JgaeIkFfEo+g==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4332:
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 31:blK8yAtAmUik/nG1fGOS+qY8yWZNALAw8crqDJ64xad03DkEEdb5RItPX0auKpxfUTozCMh0e0bST0iLKFFPvTYfDyfNzfTx55wowdUlaWxC5I1yg2WsRpI5iqqc0PFsknIXcoxMbXtlcTzLvAmzXLIVfvqeBbkbk3ETe4zHXQvijlkzDxed+NzeY+rqRym0DwY2q2u5LPHpR7yeeQc27my7HP2xZw29U2eEIpTHoKQ=;
 20:1i6yNhBkhRQafzL3RZhbjw2ysF4VwED0keB9o4v6crj3hFSZJk99WJ+TzFfg39tZ3DDhl/K8DV8HLGCFPb1qZDRu3PmKlDFztvtt70McSi0ttLkAMOOAHUiuRl/Wn1khqjAa3Ekd5259TzWju8rVAZsyMGKhM6YVIDe/Uaoh2VubzyDKLIVvblQu6tuyjJCKE75NL7/KF4d7+wqKXUoSMMYiWwmF+mgB0Q/nuy8Y40cH24Cfw/vSKbvBzjmK3Op2XyC/7FIMpDMcuVDU41fa9l2Vim8xnrui3CCDx+DAUeOT2MfYaVnc+c6H77FuzCaRX+ajsjvbKEUqaOH8zwt0EaxruMlYzQGvGAHEe2qHmFoudj81JtWzrUVx2gCuhWZ4dCKj/ZHWWhX/T+WA/lnwHncC2w94P1hN/b2dty1myivIlVgqFspj6Crusl91dioOzrjAhDXL9Or90UXInfM2ZIm0Aqhrw6UWOMWeRgd04BJEvxL9uhlzwChhySIbr+xj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43327743A6DCDE324590A406C6C50@DM6PR02MB4332.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(85827821059158)(9452136761055)(258649278758335); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3231382)(944501410)(4982022)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:DM6PR02MB4332; BCL:0; PCL:0; RULEID:; SRVR:DM6PR02MB4332; 
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 4:jNC4iRyvfqUbty7sNjSMDjBZL0wSwIN9TnkVW9GK6Bx8JmhohaiAtwD+6dclpVlJpL3ho1VIWCBRi0tfnT0cJgqanbO+9y+VEUhLMQnu+h1vlHaHpGg1X/tj4KO6LmQH10j6qnTRsipurDVIiICe2SghaywgzYPw+arvjm0Bqq92cIsJYw2pUkBLp9GM7lBmdlJVXb9Y0NJDNCedXNmfq9G4lEgzdvy8REuZR2f2VaNIaHaEIkMv2IaUSfpaAcJrTEm1JkyTZQw2gSKdAS3szMWnUPrBSuvqJYInQhXDpEc+Ceor3AN6ZBKhN54hP+asjeZuSE0WVfGa932bISAmWix6b8JCQ0+qhcRhEEa1MYkC742hYx9ocJ9Cj19sr+MI/W+QUsfkTu2LnmNxdjyGSch0pzX8IGfBwgaXBMWrv3g=
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0MzMyOzIzOllQT0xjc080U29zUkJadWVPemhJcWJBdjN2?=
 =?utf-8?B?bnhLUGg2dlNWS01sYzVLSWNvVkdNRmJCSXF5d0Y2aGYxbk0zNnZPaWJuNlJn?=
 =?utf-8?B?YVQwWElpM3NGMWpveldJcWtiN1VKQTIzeCtvZXdjZFVZbFVBNFEzN1QrOURo?=
 =?utf-8?B?aWw2djFFSHQ2TkdZS1dIODNLSzExSEMzclk0WUdzR2hxOFNLRUxBclk1U3pX?=
 =?utf-8?B?enFHWURaWlU2TTRZSmh3YnAvVkhWL3FzQzdOaFNoUHV2MHU1WkszYWllTUg3?=
 =?utf-8?B?RG9SWEhGLzJXMDNidUx1TFMydEVKc2paSENzMERvcHZESFVaamFRRWc3ZzZ1?=
 =?utf-8?B?d2pNYWRMR3BQQVZhY3Eyd1RNL2Vwdm00N3AyY1BtczBHSkN3eUVvZ2F1WnNU?=
 =?utf-8?B?MFpLQ3BJL21VYmlFWVVFaUZmQ0ZuZktQc2x0NFE2UFZ3b0ZhYi9CL2RSRStx?=
 =?utf-8?B?TE9WRUptaldLYmVSV1VSbTZrN3BEZFZhY3lRUi81clJYSUFSR0kxdys0S3ZW?=
 =?utf-8?B?TXBLNWhFVDBLZFNXY0RmV0RGeEtKMCtqQUVEVFM0N1grb0hSNnNwUDVHNHVL?=
 =?utf-8?B?cnRNSkd3eStCWUpVSmxSbkNLaTZRbjllTnppMEdyK3FXTDQrd1RheXZMZWVP?=
 =?utf-8?B?eFBORE9pblA3T0RudEpPQVYxWFVQbForOC8vcWlwTDFEUDBtYWsrZzY2ZGZF?=
 =?utf-8?B?U3dqQTlTQ0tZOGRQbmFua09iZERaSDZjMVNodUVSQ3d2dDRzbHhYeG52TUpT?=
 =?utf-8?B?RVpDTzlEWWVUTW1jeDg0TDMzZnJqQ0U3SGxLSC9DUldwdWY5U0NIeWU5NlFy?=
 =?utf-8?B?WDM5TkFuQlA4YVcwMFIvSkhCdG5SbDVvQk9SYnBGUitmNnN6YTVvRk5FWWw4?=
 =?utf-8?B?ck5VOGNVOWdFNGVPOWQ4KzQ0ZWdpUkhMbUxiQ1loVVZ5ckZDY3lZRU00QVI2?=
 =?utf-8?B?eEo3NmZzUk9Ka3NuczhxTDk2MVdMVzRrRDE5L2Fzem14RGZLU28zVnZHdm5G?=
 =?utf-8?B?bnZvN0dJT01lbks5VklEY1M2RlJVdWduZ2pwQlJkZi91TTBWUUkrOXNrc3dU?=
 =?utf-8?B?MFpFajY0ZGo0a0RKWDZObVdXaXZpVzVzVmQyK3NRWEthbkcrUy9aTFp4S2Rh?=
 =?utf-8?B?ZHFkaHhCVjcrSzV4VzdpNit6MHVVYUJCYjdtMVgzY01mSDlPNXhEZ3R1bTRN?=
 =?utf-8?B?YXVEY2R1WXYrcE9HUnYvWkNabDhENHlHSC9laG03Vnd0TDNlVXpYWnFJangr?=
 =?utf-8?B?K3VZTTR5dUMvenUrbVdkZVd6cUUxTGJXVEpDZmlHbmhvL3dpd21LY24wcEsx?=
 =?utf-8?B?WkxwS0hqeGlrRXlGbnBQV256SEJnTWlaM1k2ZVU2bDkybTU5WmZSeFYxcndW?=
 =?utf-8?B?ZTRtR2huQnFaVUUyRmx6WHZUeTJpRGswcXUyUFIwdUVBZitGc2pnblgvaWNy?=
 =?utf-8?B?WlRjT2dFeWs0Um03Q053ZElaQ1FFRDVlK2p0MEdreTVqK1hQZlBheHV0a0tQ?=
 =?utf-8?B?MHQ4aC9FWXY4YUpWU3EwRlhMR2lFRnhiYnl2citMVU54VFdKN2FTQkk2ZWFF?=
 =?utf-8?B?blBTdm02ZWdlMnM2M1hvME1kMFJrb21HTWRnL0xsMnVCWWtLMi9DejdWZDRQ?=
 =?utf-8?B?ZVFkNW10d25tbTZHb0ZlQVJ0aTN0UHBmVzBSY2dkNjVFRWxUY0ZuUGUxWGk5?=
 =?utf-8?B?TzJtbU44K0cxQW11YzR1NEQyWmhCbk4zWUVuMUZVMHpZMi9SY2hqZTRzdG9C?=
 =?utf-8?B?QVBKMm1vNUZCbXZhU1NYSVpicnZKbnlQYUwvWGlvdTl1RUl5eVhOclVvME9L?=
 =?utf-8?B?NUdySEM3SzhoTVFqSnZJUkYwUlVvRHFoVTM0UHplSlJXelZ3MFBuLzlKM05Y?=
 =?utf-8?B?eVFPVHptUVZZeFZzc2p3NWNPRlZWK2VSMHFhclRsaWJCK285UnI0YUNxU3BD?=
 =?utf-8?Q?IYee6qBT/EueKp5ASFEYt3GCyoyhbY=3D?=
X-Microsoft-Antispam-Message-Info: CFKxzQhB4caF04nsrCsOxIZvns4XjZ/Re9CavQeuqBT9o5Gm4vNmgyJ9tB3vwQcMhMgH2wJSM+WXTy6Ht+DIeNP9cfqr6HWj3yWK8jbz/i8aoghRjglkiZ6Qa8r8hivDStFp+J0JMjFxCuszgAa8DdWWZMYBh9m5Rg1Kg4QximL0s+Lxxng7SOxpMZH7MtliGqGR4eFc13tY5AdrnvaA4XbGIHFGHozoMKvfRCGRwuHNik7j0xUXMH2pTD9d80xyDNDvcipH3vhDtgvo37dZTN70fztUTTdO+ccLlrXBJaTNXBnbJMQYIJ3kLLH9aG6/bMvRoFoOSPL9t7kKv+F4g9G8zEz63SbI6u0CQYaRnCY=
X-Microsoft-Exchange-Diagnostics: 1; DM6PR02MB4332;
 6:sJ1awQn5o92guOW5fsy40asD7Lwsf9QwISBRHfR35iId/R1sY5jlurOrJUGM16YS4fueE09t3jtpVoFSK5piCBYgb0b+OPKU0g4k+g1784QY1rxo8K9GnTlBgBWZYadLNLo7vl5t5oWshKul+s4uvpkwO91waAYdW7w6Hx8iVJ6ZIq6kD6vRTrPs8kbmqt5a3pZcFkJLxZmdb8/iwRigPIAUuuMPOQT1/dwDnqLvr5+o7BVyhsS/VANC+fntvZaOajyrbFHztV2DyRr6+bNXTN4pZ6OXiLPoKxNoMh42Q39Tplp1PcBJBzVEqCtdQg6kZB1pIlS/NOdUD6lxlAq9Sf991DtlaNFJk7Kb1FuQ2GAed7F1wMt1CEFNRGK5g645Wdha0xlxmcb6Zjy4t8CoAQBu0y4s9tpHvlojUSF7SZB6PWChuaxnpju5/adT3bU9ap3Qncr2SD24fF0ykywOYg==;
 5:v5JAn7zAKEyTVF53N3TJgY/2z/zJKQ9XaoNDPO0s0uGbunx+WULrR5jq86oY5QJWpJsJySv6zjfAYPS4OZtQqZtLVyHdFwf/h2DlEPIEyiY6kzyGt8YJPhiZUCt6KRmUeaEjAcHc8u1ziwr1ZLzfKPBCml5KW8Au3X4lLkbuA94=;
 7:+xfkhS5S9LFANj2xhyA3NY1dNc3PaKL+utNpp5lLWj4Y9laAC3X49/oU61odpW/vNYCN/DO1MTdWCCnZgoBW2pVvMfNj0cn72yLghtdl3RcbHXPt3zw000xPRvexgV1QDiSTuDOb9/FwHjzfsS/KHw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 08:48:55.7812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c34306-aca2-43d0-07e5-08d645570523
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4332
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
Cc: Mark Rutland <mark.rutland@arm.com>, Tom Rini <trini@konsulko.com>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Olof Johansson <olof@lixom.net>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

On 05. 10. 18 18:58, Rob Herring wrote:
> Convert ARM CPU binding to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/cpus.txt          | 490 -----------------
>  .../devicetree/bindings/arm/cpus.yaml         | 503 ++++++++++++++++++
>  2 files changed, 503 insertions(+), 490 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/cpus.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/cpus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> deleted file mode 100644
> index b0198a1cf403..000000000000
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ /dev/null
> @@ -1,490 +0,0 @@
> -=================
> -ARM CPUs bindings
> -=================
> -
> -The device tree allows to describe the layout of CPUs in a system through
> -the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> -defining properties for every cpu.
> -
> -Bindings for CPU nodes follow the Devicetree Specification, available from:
> -
> -https://www.devicetree.org/specifications/
> -
> -with updates for 32-bit and 64-bit ARM systems provided in this document.
> -
> -================================
> -Convention used in this document
> -================================
> -
> -This document follows the conventions described in the Devicetree
> -Specification, with the addition:
> -
> -- square brackets define bitfields, eg reg[7:0] value of the bitfield in
> -  the reg property contained in bits 7 down to 0
> -
> -=====================================
> -cpus and cpu node bindings definition
> -=====================================
> -
> -The ARM architecture, in accordance with the Devicetree Specification,
> -requires the cpus and cpu nodes to be present and contain the properties
> -described below.
> -
> -- cpus node
> -
> -	Description: Container of cpu nodes
> -
> -	The node name must be "cpus".
> -
> -	A cpus node must define the following properties:
> -
> -	- #address-cells
> -		Usage: required
> -		Value type: <u32>
> -
> -		Definition depends on ARM architecture version and
> -		configuration:
> -
> -			# On uniprocessor ARM architectures previous to v7
> -			  value must be 1, to enable a simple enumeration
> -			  scheme for processors that do not have a HW CPU
> -			  identification register.
> -			# On 32-bit ARM 11 MPcore, ARM v7 or later systems
> -			  value must be 1, that corresponds to CPUID/MPIDR
> -			  registers sizes.
> -			# On ARM v8 64-bit systems value should be set to 2,
> -			  that corresponds to the MPIDR_EL1 register size.
> -			  If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
> -			  in the system, #address-cells can be set to 1, since
> -			  MPIDR_EL1[63:32] bits are not used for CPUs
> -			  identification.
> -	- #size-cells
> -		Usage: required
> -		Value type: <u32>
> -		Definition: must be set to 0
> -
> -- cpu node
> -
> -	Description: Describes a CPU in an ARM based system
> -
> -	PROPERTIES
> -
> -	- device_type
> -		Usage: required
> -		Value type: <string>
> -		Definition: must be "cpu"
> -	- reg
> -		Usage and definition depend on ARM architecture version and
> -		configuration:
> -
> -			# On uniprocessor ARM architectures previous to v7
> -			  this property is required and must be set to 0.
> -
> -			# On ARM 11 MPcore based systems this property is
> -			  required and matches the CPUID[11:0] register bits.
> -
> -			  Bits [11:0] in the reg cell must be set to
> -			  bits [11:0] in CPU ID register.
> -
> -			  All other bits in the reg cell must be set to 0.
> -
> -			# On 32-bit ARM v7 or later systems this property is
> -			  required and matches the CPU MPIDR[23:0] register
> -			  bits.
> -
> -			  Bits [23:0] in the reg cell must be set to
> -			  bits [23:0] in MPIDR.
> -
> -			  All other bits in the reg cell must be set to 0.
> -
> -			# On ARM v8 64-bit systems this property is required
> -			  and matches the MPIDR_EL1 register affinity bits.
> -
> -			  * If cpus node's #address-cells property is set to 2
> -
> -			    The first reg cell bits [7:0] must be set to
> -			    bits [39:32] of MPIDR_EL1.
> -
> -			    The second reg cell bits [23:0] must be set to
> -			    bits [23:0] of MPIDR_EL1.
> -
> -			  * If cpus node's #address-cells property is set to 1
> -
> -			    The reg cell bits [23:0] must be set to bits [23:0]
> -			    of MPIDR_EL1.
> -
> -			  All other bits in the reg cells must be set to 0.
> -
> -	- compatible:
> -		Usage: required
> -		Value type: <string>
> -		Definition: should be one of:
> -			    "arm,arm710t"
> -			    "arm,arm720t"
> -			    "arm,arm740t"
> -			    "arm,arm7ej-s"
> -			    "arm,arm7tdmi"
> -			    "arm,arm7tdmi-s"
> -			    "arm,arm9es"
> -			    "arm,arm9ej-s"
> -			    "arm,arm920t"
> -			    "arm,arm922t"
> -			    "arm,arm925"
> -			    "arm,arm926e-s"
> -			    "arm,arm926ej-s"
> -			    "arm,arm940t"
> -			    "arm,arm946e-s"
> -			    "arm,arm966e-s"
> -			    "arm,arm968e-s"
> -			    "arm,arm9tdmi"
> -			    "arm,arm1020e"
> -			    "arm,arm1020t"
> -			    "arm,arm1022e"
> -			    "arm,arm1026ej-s"
> -			    "arm,arm1136j-s"
> -			    "arm,arm1136jf-s"
> -			    "arm,arm1156t2-s"
> -			    "arm,arm1156t2f-s"
> -			    "arm,arm1176jzf"
> -			    "arm,arm1176jz-s"
> -			    "arm,arm1176jzf-s"
> -			    "arm,arm11mpcore"
> -			    "arm,cortex-a5"
> -			    "arm,cortex-a7"
> -			    "arm,cortex-a8"
> -			    "arm,cortex-a9"
> -			    "arm,cortex-a12"
> -			    "arm,cortex-a15"
> -			    "arm,cortex-a17"
> -			    "arm,cortex-a53"
> -			    "arm,cortex-a57"
> -			    "arm,cortex-a72"
> -			    "arm,cortex-a73"
> -			    "arm,cortex-m0"
> -			    "arm,cortex-m0+"
> -			    "arm,cortex-m1"
> -			    "arm,cortex-m3"
> -			    "arm,cortex-m4"
> -			    "arm,cortex-r4"
> -			    "arm,cortex-r5"
> -			    "arm,cortex-r7"
> -			    "brcm,brahma-b15"
> -			    "brcm,brahma-b53"
> -			    "brcm,vulcan"
> -			    "cavium,thunder"
> -			    "cavium,thunder2"
> -			    "faraday,fa526"
> -			    "intel,sa110"
> -			    "intel,sa1100"
> -			    "marvell,feroceon"
> -			    "marvell,mohawk"
> -			    "marvell,pj4a"
> -			    "marvell,pj4b"
> -			    "marvell,sheeva-v5"
> -			    "nvidia,tegra132-denver"
> -			    "nvidia,tegra186-denver"
> -			    "nvidia,tegra194-carmel"
> -			    "qcom,krait"
> -			    "qcom,kryo"
> -			    "qcom,kryo385"
> -			    "qcom,scorpion"
> -	- enable-method
> -		Value type: <stringlist>
> -		Usage and definition depend on ARM architecture version.
> -			# On ARM v8 64-bit this property is required and must
> -			  be one of:
> -			     "psci"
> -			     "spin-table"
> -			# On ARM 32-bit systems this property is optional and
> -			  can be one of:
> -			    "actions,s500-smp"
> -			    "allwinner,sun6i-a31"
> -			    "allwinner,sun8i-a23"
> -			    "allwinner,sun9i-a80-smp"
> -			    "amlogic,meson8-smp"
> -			    "amlogic,meson8b-smp"
> -			    "arm,realview-smp"
> -			    "brcm,bcm11351-cpu-method"
> -			    "brcm,bcm23550"
> -			    "brcm,bcm2836-smp"
> -			    "brcm,bcm-nsp-smp"
> -			    "brcm,brahma-b15"
> -			    "marvell,armada-375-smp"
> -			    "marvell,armada-380-smp"
> -			    "marvell,armada-390-smp"
> -			    "marvell,armada-xp-smp"
> -			    "marvell,98dx3236-smp"
> -			    "mediatek,mt6589-smp"
> -			    "mediatek,mt81xx-tz-smp"
> -			    "qcom,gcc-msm8660"
> -			    "qcom,kpss-acc-v1"
> -			    "qcom,kpss-acc-v2"
> -			    "renesas,apmu"
> -			    "renesas,r9a06g032-smp"
> -			    "rockchip,rk3036-smp"
> -			    "rockchip,rk3066-smp"
> -			    "ste,dbx500-smp"
> -
> -	- cpu-release-addr
> -		Usage: required for systems that have an "enable-method"
> -		       property value of "spin-table".
> -		Value type: <prop-encoded-array>
> -		Definition:
> -			# On ARM v8 64-bit systems must be a two cell
> -			  property identifying a 64-bit zero-initialised
> -			  memory location.
> -
> -	- qcom,saw
> -		Usage: required for systems that have an "enable-method"
> -		       property value of "qcom,kpss-acc-v1" or
> -		       "qcom,kpss-acc-v2"
> -		Value type: <phandle>
> -		Definition: Specifies the SAW[1] node associated with this CPU.
> -
> -	- qcom,acc
> -		Usage: required for systems that have an "enable-method"
> -		       property value of "qcom,kpss-acc-v1" or
> -		       "qcom,kpss-acc-v2"
> -		Value type: <phandle>
> -		Definition: Specifies the ACC[2] node associated with this CPU.
> -
> -	- cpu-idle-states
> -		Usage: Optional
> -		Value type: <prop-encoded-array>
> -		Definition:
> -			# List of phandles to idle state nodes supported
> -			  by this cpu [3].
> -
> -	- capacity-dmips-mhz
> -		Usage: Optional
> -		Value type: <u32>
> -		Definition:
> -			# u32 value representing CPU capacity [4] in
> -			  DMIPS/MHz, relative to highest capacity-dmips-mhz
> -			  in the system.
> -
> -	- rockchip,pmu
> -		Usage: optional for systems that have an "enable-method"
> -		       property value of "rockchip,rk3066-smp"
> -		       While optional, it is the preferred way to get access to
> -		       the cpu-core power-domains.
> -		Value type: <phandle>
> -		Definition: Specifies the syscon node controlling the cpu core
> -			    power domains.
> -
> -	- dynamic-power-coefficient
> -		Usage: optional
> -		Value type: <prop-encoded-array>
> -		Definition: A u32 value that represents the running time dynamic
> -			    power coefficient in units of uW/MHz/V^2. The
> -			    coefficient can either be calculated from power
> -			    measurements or derived by analysis.
> -
> -			    The dynamic power consumption of the CPU  is
> -			    proportional to the square of the Voltage (V) and
> -			    the clock frequency (f). The coefficient is used to
> -			    calculate the dynamic power as below -
> -
> -			    Pdyn = dynamic-power-coefficient * V^2 * f
> -
> -			    where voltage is in V, frequency is in MHz.
> -
> -Example 1 (dual-cluster big.LITTLE system 32-bit):
> -
> -	cpus {
> -		#size-cells = <0>;
> -		#address-cells = <1>;
> -
> -		cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a15";
> -			reg = <0x0>;
> -		};
> -
> -		cpu@1 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a15";
> -			reg = <0x1>;
> -		};
> -
> -		cpu@100 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a7";
> -			reg = <0x100>;
> -		};
> -
> -		cpu@101 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a7";
> -			reg = <0x101>;
> -		};
> -	};
> -
> -Example 2 (Cortex-A8 uniprocessor 32-bit system):
> -
> -	cpus {
> -		#size-cells = <0>;
> -		#address-cells = <1>;
> -
> -		cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,cortex-a8";
> -			reg = <0x0>;
> -		};
> -	};
> -
> -Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
> -
> -	cpus {
> -		#size-cells = <0>;
> -		#address-cells = <1>;
> -
> -		cpu@0 {
> -			device_type = "cpu";
> -			compatible = "arm,arm926ej-s";
> -			reg = <0x0>;
> -		};
> -	};
> -
> -Example 4 (ARM Cortex-A57 64-bit system):
> -
> -cpus {
> -	#size-cells = <0>;
> -	#address-cells = <2>;
> -
> -	cpu@0 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x0>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@1 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x1>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x100>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@101 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x101>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@10000 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x10000>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@10001 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x10001>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@10100 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x10100>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@10101 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x0 0x10101>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100000000 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x0>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100000001 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x1>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100000100 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x100>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100000101 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x101>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100010000 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x10000>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100010001 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x10001>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100010100 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x10100>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -
> -	cpu@100010101 {
> -		device_type = "cpu";
> -		compatible = "arm,cortex-a57";
> -		reg = <0x1 0x10101>;
> -		enable-method = "spin-table";
> -		cpu-release-addr = <0 0x20000000>;
> -	};
> -};
> -
> ---
> -[1] arm/msm/qcom,saw2.txt
> -[2] arm/msm/qcom,kpss-acc.txt
> -[3] ARM Linux kernel documentation - idle states bindings
> -    Documentation/devicetree/bindings/arm/idle-states.txt
> -[4] ARM Linux kernel documentation - cpu capacity bindings
> -    Documentation/devicetree/bindings/arm/cpu-capacity.txt
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> new file mode 100644
> index 000000000000..bb75914324a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -0,0 +1,503 @@
> +# SPDX-License-Identifier: None
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/arm/cpus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM CPUs bindings
> +
> +maintainers:
> +  - Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +
> +description: |+
> +  The device tree allows to describe the layout of CPUs in a system through
> +  the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +  defining properties for every cpu.
> +
> +  Bindings for CPU nodes follow the Devicetree Specification, available from:
> +
> +  https://www.devicetree.org/specifications/
> +
> +  with updates for 32-bit and 64-bit ARM systems provided in this document.
> +
> +  ================================
> +  Convention used in this document
> +  ================================
> +
> +  This document follows the conventions described in the Devicetree
> +  Specification, with the addition:
> +
> +  - square brackets define bitfields, eg reg[7:0] value of the bitfield in
> +    the reg property contained in bits 7 down to 0
> +
> +  =====================================
> +  cpus and cpu node bindings definition
> +  =====================================
> +
> +  The ARM architecture, in accordance with the Devicetree Specification,
> +  requires the cpus and cpu nodes to be present and contain the properties
> +  described below.
> +
> +properties:
> +  $nodename:
> +    const: cpus
> +    description: Container of cpu nodes
> +
> +  '#address-cells':
> +    enum: [1, 2]
> +    description: |
> +      Definition depends on ARM architecture version and configuration:
> +
> +      On uniprocessor ARM architectures previous to v7
> +        value must be 1, to enable a simple enumeration
> +        scheme for processors that do not have a HW CPU
> +        identification register.
> +      On 32-bit ARM 11 MPcore, ARM v7 or later systems
> +        value must be 1, that corresponds to CPUID/MPIDR
> +        registers sizes.
> +      On ARM v8 64-bit systems value should be set to 2,
> +        that corresponds to the MPIDR_EL1 register size.
> +        If MPIDR_EL1[63:32] value is equal to 0 on all CPUs
> +        in the system, #address-cells can be set to 1, since
> +        MPIDR_EL1[63:32] bits are not used for CPUs
> +        identification.
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^cpu@[0-9a-f]+$':
> +    properties:
> +      device_type:
> +        const: cpu
> +
> +      reg:
> +        maxItems: 1
> +        description: |
> +          Usage and definition depend on ARM architecture version and
> +          configuration:
> +
> +          On uniprocessor ARM architectures previous to v7
> +          this property is required and must be set to 0.
> +
> +          On ARM 11 MPcore based systems this property is
> +            required and matches the CPUID[11:0] register bits.
> +
> +            Bits [11:0] in the reg cell must be set to
> +            bits [11:0] in CPU ID register.
> +
> +            All other bits in the reg cell must be set to 0.
> +
> +          On 32-bit ARM v7 or later systems this property is
> +            required and matches the CPU MPIDR[23:0] register
> +            bits.
> +
> +            Bits [23:0] in the reg cell must be set to
> +            bits [23:0] in MPIDR.
> +
> +            All other bits in the reg cell must be set to 0.
> +
> +          On ARM v8 64-bit systems this property is required
> +            and matches the MPIDR_EL1 register affinity bits.
> +
> +            * If cpus node's #address-cells property is set to 2
> +
> +              The first reg cell bits [7:0] must be set to
> +              bits [39:32] of MPIDR_EL1.
> +
> +              The second reg cell bits [23:0] must be set to
> +              bits [23:0] of MPIDR_EL1.
> +
> +            * If cpus node's #address-cells property is set to 1
> +
> +              The reg cell bits [23:0] must be set to bits [23:0]
> +              of MPIDR_EL1.
> +
> +          All other bits in the reg cells must be set to 0.
> +
> +      compatible:
> +        items:
> +          - enum:
> +              - arm,arm710t
> +              - arm,arm720t
> +              - arm,arm740t
> +              - arm,arm7ej-s
> +              - arm,arm7tdmi
> +              - arm,arm7tdmi-s
> +              - arm,arm9es
> +              - arm,arm9ej-s
> +              - arm,arm920t
> +              - arm,arm922t
> +              - arm,arm925
> +              - arm,arm926e-s
> +              - arm,arm926ej-s
> +              - arm,arm940t
> +              - arm,arm946e-s
> +              - arm,arm966e-s
> +              - arm,arm968e-s
> +              - arm,arm9tdmi
> +              - arm,arm1020e
> +              - arm,arm1020t
> +              - arm,arm1022e
> +              - arm,arm1026ej-s
> +              - arm,arm1136j-s
> +              - arm,arm1136jf-s
> +              - arm,arm1156t2-s
> +              - arm,arm1156t2f-s
> +              - arm,arm1176jzf
> +              - arm,arm1176jz-s
> +              - arm,arm1176jzf-s
> +              - arm,arm11mpcore
> +              - arm,cortex-a5
> +              - arm,cortex-a7
> +              - arm,cortex-a8
> +              - arm,cortex-a9
> +              - arm,cortex-a12
> +              - arm,cortex-a15
> +              - arm,cortex-a17
> +              - arm,cortex-a53
> +              - arm,cortex-a57
> +              - arm,cortex-a72
> +              - arm,cortex-a73
> +              - arm,cortex-m0
> +              - arm,cortex-m0+
> +              - arm,cortex-m1
> +              - arm,cortex-m3
> +              - arm,cortex-m4
> +              - arm,cortex-r4
> +              - arm,cortex-r5
> +              - arm,cortex-r7
> +              - brcm,brahma-b15
> +              - brcm,brahma-b53
> +              - brcm,vulcan
> +              - cavium,thunder
> +              - cavium,thunder2
> +              - faraday,fa526
> +              - intel,sa110
> +              - intel,sa1100
> +              - marvell,feroceon
> +              - marvell,mohawk
> +              - marvell,pj4a
> +              - marvell,pj4b
> +              - marvell,sheeva-v5
> +              - nvidia,tegra132-denver
> +              - nvidia,tegra186-denver
> +              - nvidia,tegra194-carmel
> +              - qcom,krait
> +              - qcom,kryo
> +              - qcom,kryo385
> +              - qcom,scorpion
> +
> +      enable-method:
> +        allOf:
> +          - $ref: '/schemas/types.yaml#/definitions/string'
> +          - oneOf:
> +            # On ARM v8 64-bit this property is required
> +            - enum:
> +                - psci
> +                - spin-table
> +            # On ARM 32-bit systems this property is optional
> +            - enum:
> +                - actions,s500-smp
> +                - allwinner,sun6i-a31
> +                - allwinner,sun8i-a23
> +                - allwinner,sun9i-a80-smp
> +                - allwinner,sun8i-a83t-smp
> +                - amlogic,meson8-smp
> +                - amlogic,meson8b-smp
> +                - arm,realview-smp
> +                - brcm,bcm11351-cpu-method
> +                - brcm,bcm23550
> +                - brcm,bcm2836-smp
> +                - brcm,bcm63138
> +                - brcm,bcm-nsp-smp
> +                - brcm,brahma-b15
> +                - marvell,armada-375-smp
> +                - marvell,armada-380-smp
> +                - marvell,armada-390-smp
> +                - marvell,armada-xp-smp
> +                - marvell,98dx3236-smp
> +                - mediatek,mt6589-smp
> +                - mediatek,mt81xx-tz-smp
> +                - qcom,gcc-msm8660
> +                - qcom,kpss-acc-v1
> +                - qcom,kpss-acc-v2
> +                - renesas,apmu
> +                - renesas,r9a06g032-smp
> +                - rockchip,rk3036-smp
> +                - rockchip,rk3066-smp
> +                - ste,dbx500-smp
> +
> +      cpu-release-addr:
> +        $ref: '/schemas/types.yaml#/definitions/uint64'
> +
> +        description:
> +          Required for systems that have an "enable-method"
> +            property value of "spin-table".
> +          On ARM v8 64-bit systems must be a two cell
> +            property identifying a 64-bit zero-initialised
> +            memory location.
> +
> +      qcom,saw:
> +        $ref: '/schemas/types.yaml#/definitions/phandle'
> +        description: |
> +          Usage: required for systems that have an "enable-method"
> +                 property value of "qcom,kpss-acc-v1" or
> +                 "qcom,kpss-acc-v2"
> +          Definition: Specifies the SAW[1] node associated with this CPU.
> +
> +      qcom,acc:
> +        $ref: '/schemas/types.yaml#/definitions/phandle'
> +        description: |
> +          Usage: required for systems that have an "enable-method"
> +                 property value of "qcom,kpss-acc-v1" or
> +                 "qcom,kpss-acc-v2"
> +          Definition: Specifies the ACC[2] node associated with this CPU.
> +
> +      cpu-idle-states:
> +        $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +        description: |
> +          Usage: Optional
> +          Value type: <prop-encoded-array>
> +          description: List of phandles to idle state nodes supported
> +            by this cpu [3].
> +
> +      capacity-dmips-mhz:
> +        $ref: '/schemas/types.yaml#/definitions/uint32'
> +        description:
> +          u32 value representing CPU capacity [4] in
> +          DMIPS/MHz, relative to highest capacity-dmips-mhz
> +          in the system.
> +
> +      rockchip,pmu:
> +        description: |
> +          Optional for systems that have an "enable-method"
> +          property value of "rockchip,rk3066-smp"
> +          While optional, it is the preferred way to get access to
> +          the cpu-core power-domains.
> +          Value type: <phandle>
> +          Definition: Specifies the syscon node controlling the cpu core
> +                power domains.
> +
> +      dynamic-power-coefficient:
> +        $ref: '/schemas/types.yaml#/definitions/uint32'
> +        description:
> +          A u32 value that represents the running time dynamic
> +          power coefficient in units of uW/MHz/V^2. The
> +          coefficient can either be calculated from power
> +          measurements or derived by analysis.
> +
> +          The dynamic power consumption of the CPU  is
> +          proportional to the square of the Voltage (V) and
> +          the clock frequency (f). The coefficient is used to
> +          calculate the dynamic power as below -
> +
> +          Pdyn = dynamic-power-coefficient * V^2 * f
> +
> +          where voltage is in V, frequency is in MHz.
> +
> +    required:
> +      - device_type
> +      - reg
> +      - compatible
> +
> +    dependencies:
> +      cpu-release-addr: [enable-method]
> +      rockchip,pmu: [enable-method]
> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +examples:
> +  - |
> +    cpus {
> +      #size-cells = <0>;
> +      #address-cells = <1>;
> +
> +      cpu@0 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a15";
> +        reg = <0x0>;
> +      };
> +
> +      cpu@1 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a15";
> +        reg = <0x1>;
> +      };
> +
> +      cpu@100 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a7";
> +        reg = <0x100>;
> +      };
> +
> +      cpu@101 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a7";
> +        reg = <0x101>;
> +      };
> +    };
> +
> +  - |
> +    // Example 2 (Cortex-A8 uniprocessor 32-bit system):
> +    cpus {
> +      #size-cells = <0>;
> +      #address-cells = <1>;
> +
> +      cpu@0 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a8";
> +        reg = <0x0>;
> +      };
> +    };
> +
> +  - |
> +    // Example 3 (ARM 926EJ-S uniprocessor 32-bit system):
> +    cpus {
> +      #size-cells = <0>;
> +      #address-cells = <1>;
> +
> +      cpu@0 {
> +        device_type = "cpu";
> +        compatible = "arm,arm926ej-s";
> +        reg = <0x0>;
> +      };
> +    };
> +
> +  - |
> +    //  Example 4 (ARM Cortex-A57 64-bit system):
> +    cpus {
> +      #size-cells = <0>;
> +      #address-cells = <2>;
> +
> +      cpu@0 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x0>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@1 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x1>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x100>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@101 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x101>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@10000 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x10000>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@10001 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x10001>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@10100 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x10100>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@10101 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x0 0x10101>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100000000 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x0>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100000001 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x1>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100000100 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x100>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100000101 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x101>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100010000 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x10000>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100010001 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x10001>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100010100 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x10100>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +
> +      cpu@100010101 {
> +        device_type = "cpu";
> +        compatible = "arm,cortex-a57";
> +        reg = <0x1 0x10101>;
> +        enable-method = "spin-table";
> +        cpu-release-addr = <0 0x20000000>;
> +      };
> +    };
> +...
> 

I have take a look at xilinx part of this and try to build it for arm64
platforms and I see errors coming from this cpu description.
/root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
cpu@0:compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
/root/linux/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dt.yaml:
cpu@0:compatible: Additional items are not allowed ('arm,armv8' was
unexpected)

Based on grep this is used in a lot of places
compatible = "arm,cortex-a53", "arm,armv8";

Should this be moved to just simple?
compatible = "arm,cortex-a53";

Thanks,
Michal


