Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F40ECDE47
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 13:47:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DF020825
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 13:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qYu+5VwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DF020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rPVH2dklzF38H
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 00:37:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qYu+5VwM";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=xilinx.com
 (client-ip=2a01:111:f400:fe4a::62d;
 helo=nam03-by2-obe.outbound.protection.outlook.com;
 envelope-from=michals@xilinx.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com
 header.b="qYu+5VwM"; dkim-atps=neutral
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rPRF5r7fzF3Lm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 00:35:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Gd6anbUXQUpiSZ3gZFzVdDMjnZbxtP8H0ttX9gHrjk=;
 b=qYu+5VwMo4TrkkqFNT7fv4fQ9ikpwCsbQaJJbv+KHFf035fMlEhjN17aj25hksYq7qOv+DD7EQWxVAgnuFCQkGcyPb8R9Cw6cYy19OTdteNftxOtHB1NRz+n4uf3hHdh4kR4OnLO0cUYAEc2A/HL/UAGQntLCc9fPRfbH/qtDro=
Received: from DM6PR02CA0020.namprd02.prod.outlook.com (2603:10b6:5:1c::33) by
 BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:57::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 8 Nov 2018 13:34:58 +0000
Received: from BL2NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by DM6PR02CA0020.outlook.office365.com
 (2603:10b6:5:1c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.23 via Frontend
 Transport; Thu, 8 Nov 2018 13:34:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT021.mail.protection.outlook.com (10.152.77.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.11
 via Frontend Transport; Thu, 8 Nov 2018 13:34:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34720
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gKkSX-0006nt-BG; Thu, 08 Nov 2018 05:34:57 -0800
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <michal.simek@xilinx.com>)
 id 1gKkSS-0001c6-75; Thu, 08 Nov 2018 05:34:52 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA8DYnsF032163; 
 Thu, 8 Nov 2018 05:34:49 -0800
Received: from [172.30.17.111] by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <michals@xilinx.com>)
 id 1gKkSO-0001bw-Nu; Thu, 08 Nov 2018 05:34:49 -0800
Subject: Re: [PATCH 35/36] dt-bindings: arm: Convert Xilinx board/soc bindings
 to json-schema
To: Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linuxppc-dev@lists.ozlabs.org>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-36-robh@kernel.org>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <0120c2a6-b7a6-cbf8-0604-855b0e01f050@xilinx.com>
Date: Thu, 8 Nov 2018 14:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181005165848.3474-36-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(50466002)(6666004)(356004)(36386004)(426003)(2616005)(76176011)(446003)(126002)(11346002)(476003)(44832011)(2486003)(23676004)(186003)(31696002)(26005)(336012)(4326008)(486006)(2201001)(966005)(478600001)(77096007)(106466001)(65956001)(230700001)(6246003)(6306002)(53376002)(229853002)(47776003)(54906003)(5660300001)(8936002)(64126003)(65826007)(81166006)(8676002)(39060400002)(14444005)(81156014)(110136005)(2906002)(58126008)(316002)(63266004)(305945005)(31686004)(36756003)(9786002)(7416002)(65806001)(106002)(107986001)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4454; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; MX:1; A:1;
X-Microsoft-Exchange-Diagnostics: 1; BL2NAM02FT021;
 1:2/Z25olz58GxLHzumU6xgs/D4qSN/NknQHH0oZeoMiF/fEPvrNKchZZBdvuTACWW/1oqCMn6q92h8clD5moV7h4ur1c805WAeN8w30p8PoMd2vuo+5gueiFrlrWMGqB3
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e898898-eb15-4dd4-0b06-08d6457efa0f
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);
 SRVR:BYAPR02MB4454; 
X-Microsoft-Exchange-Diagnostics: 1; BYAPR02MB4454;
 3:R1obif4LKfS49nxdMs0srJnlKR5dkpYZUc3xdBL2IMkm1PjjxnX1fW/bEysvF78ZL2PZoR3i40zK5FnIWCGAVCUwcKBOs89mVu655mQeI4pEExYmdoT9LypC7a0JSx6SMWOrBHvGH5YT2IafSohZ80MdIUWehSsEIhNux2X+rM8x39An7BywYwmGa9rmkWa/GoMvicodfXGIzE5jzZCGHPWEYsnMXbfV56M2muQjGTq5TRIox81GTYiurUWW+CwWnAvLC9wm30WyMLkoD6sJIIYZgmZoW6lvejOy08imHXpGiuG1DApe5cmigPIfTa+A+Nv0e5xyseRiUlQItvnAV6Trj9wqBnnk/1uTFrjrYG4=;
 25:YvvaM1kO2yLWr+OuxKpFtswLRZ3Y3FThkKJ2nPfVMRAeshSluq6O+Ql8+dO4sYZJIqfjLoR60qciX0Blhcq99mdjszA7TEBwySNaiZWqoo7mVvljh0D8gHhS5QnNUI6DdfRyEnz7yynfIQxezwTaEQGKVqB3GVAKedEbQdUX9a9AFYvKrGoIo4a09SUBUNcsGB7MvgDB44GOvhP6ombT+8HkZY0YwJFdi9iW2MEPrN4vKnnUmpRoBPkQ+/1Dgam32e3BWLi6g6CCfIyRKj8A9yzd8rpkq6jUj2jVCONBBfMtdfE45AK3yEYVx5R93ZurwCKOk4FvjO0XYVDtZfJsrw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1; BYAPR02MB4454;
 31:x9zFtbKWAqtGQUe6nuED3p3Tjv4kryZgZf5/4rxk2odLnjBuTc4mGR4O4RIdzJjYjzPJ8ohHUb5D3/DwG87ecP+oEn3E/0dMLvbgbTp8rH6Mi1XQHXQ1g5syM/eORFXOeFo12dWPEbLx2supgKLuJk7G+T3QV86VgIaMRIb7sK5DyVQ88OiL7E3tfAjepyJwnlxPIaLaZaAQtNWwjxpyNN0DLllGnKqRSB86bGq1rjA=;
 20:IapvtHvcQEoZMxcJkyW0WXQj+dt92u30cdgzOq4Tuopamin3rz9O2t4u+Qt7MI1uiF6dQHx7QJSN/rg35w5VO0iWaR4u6k9x91NuP+GCn07rDdPt28czmuuMntd1uzIWPAuH2a4wcrLYwxvgeRlxw0/Pwzxx1c+4sTsxALqaly8FptDsydk1oHxilPN5Ccyfw5eBBafq6G2HgJEb6w0ALKwTXgnJyTDk715SAthO4lm+Sj2cMhW5kohcuAteGYAj9rtCGWKTgCoE5YQ/hjRnHn0wbRmDrfNKgbBBkcFO66yebDYze2r13GPWnz1RBYucvcZMi6POF4TH3HF/aejPQhhxGnc+pobJPzd/8i+v+qWYWlHHUr/6Qmh/pkuMucGn5UqGw82j15ZbfGCOvCh+XrIp+mGb4MbiK0PMl0HtLVaMSdsoP8W6QOLpDE9quNb10oPRccyIo6DhDOQeRiibeWHN0rgmckVVQkJTlbffrAfiBRtIB1wrKZKBsxwsrSqP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4454D4F0E5DDF76A78005CE8C6C50@BYAPR02MB4454.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(192813158149592)(9452136761055)(258649278758335); 
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(4982022)(52105095)(93006095)(93004095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:BYAPR02MB4454; BCL:0; PCL:0; RULEID:; SRVR:BYAPR02MB4454; 
X-Microsoft-Exchange-Diagnostics: 1; BYAPR02MB4454;
 4:8g8Gs/5GPFSQURXd58nZrIybN9JgFsTQFAII8aS37kCmUZkdO3hEHPytWBOvV6COh0nx6OYtSJh8yxphUA4Lr4aZPULmrcNeai3JldyJHXutdBHkSwDR+TdjMeCgHchEGwQAbw6jSOahsqqBtpd3C7TZLPiasXoE1JUUU76lxinBPisID2oS9QrGNBYAdtcq1aq6u/SJWFoEVAEqeaMNGkdUwiKqReC6gxAJeoEJVyTXhzaHt7OaL6qAsKYmSe36jbqokSAH86Z57wCQ2cLon0vIIMUybbNxj3kSFQqRQsamhcd3giqkmeQuFBWPpxODh+3Mk89PJvw2sRualbS0op19PK5nVL9plSghsYVK14OQgOlaVG7mRXcU7WfjRz+Igyz37k/ic393b8yQAXUgiq/QITxgC77i3oy5fjgOWeU=
X-Forefront-PRVS: 0850800A29
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NDU0OzIzOmF4V1hDQjFuRDYzc244d2cyVnNMemVkVVVW?=
 =?utf-8?B?S0VPSlpUZ0Q0UlIxTjgzZTF1MndvYjhZMkYwV29EQ1lxSm93RXNhYmJOczZh?=
 =?utf-8?B?c2RIYkk3eE14amFJUmpjQXNTRERLZTRNTlFLN2J5RE5RWFd2cTBvV1E0N3Fo?=
 =?utf-8?B?clRSbVJmcEJkSjJuL3FGeWtGeC9VUjZydUR4TTB2VFljQlplN3F4L0FPNXFL?=
 =?utf-8?B?a0QzaHZpQnRqWW85QnF0bG93d3Z3bFYyTWhhaU5LdCt1VFc0QzdmZk12aGl2?=
 =?utf-8?B?cVFQZnRmMzlLSjZJT1ZZb0FBZTlMSTJDaFpKN2k0cWtycjY1L09CRHFBcmRS?=
 =?utf-8?B?dm85SlNlUjlQdnIvZ2FGY09hb3lKeFh1Qmh4NW5xUEdWL3RhbGFTbStad2Rh?=
 =?utf-8?B?MVNBYTJrVHJXald5dlZ6MmdWSWkxK3BRUVQ3anpjTDdKdklQOC9YOGVHS201?=
 =?utf-8?B?cXlWbmdPQis3eHZ0WXVFTGdnNC91N0tTMmhScmh6cUMvUGRxWWQvK2kzd0Q0?=
 =?utf-8?B?YjNiT2t1OVlYZjlDNDNOTktKbHB0RmZDOWxZZDlhTU1JcTFXcmxDV2cwdnEx?=
 =?utf-8?B?dTVrNVo1MjVvS2tDeThGOHFHZHl2eENYWDIyZmRSOHhmNzI5MTI5ZjlkVWxL?=
 =?utf-8?B?eFVxdEtOVzMrenpLV1VRKzN3Y2hxNlFPTXBqNXh4Zm5rQm1KSm5kMjhoVS9s?=
 =?utf-8?B?V2NyN09aT21OSEtWdUFkdnJPZjJNSDY5eFV1NmZpZktqc0UzNWRaVG1HRDZp?=
 =?utf-8?B?cUtTKzlrdTBCMnZHS2RYdTRMRTd5a3hOUkJkY0RmRUg1U1Blb3lXRTM1TTdX?=
 =?utf-8?B?WVkxZ1h4WDY4RFRKZFExWC8yNGZJbW5GSkRua0pmaTFYcU1GbHBmSkRTY1lC?=
 =?utf-8?B?MGplbDdPQUJkUkVRdGRIcHlhL1l1ZWJaUS9aYTBBblBwbWV6UTJTMXpTbWQ0?=
 =?utf-8?B?cEExY2FJbzd6eUtZWXUxRGZISnhmYk0zNFhyLzBiNS9JbXZZTU9Bb3R0YjF5?=
 =?utf-8?B?eDFrRU0zOFU3ZzFDVU5nWEFNdklWSER1YmFmaFBBZUVuQ2dzZFlxVnZwNkFR?=
 =?utf-8?B?S2VNK1lTeTZVV2hnRFdONkZIODZMV3dIaHB4ZTg0eEcwN0x4L1M3dXdqQmY4?=
 =?utf-8?B?K2FDdENsNXdMZ0dLTXNrbWhzempkb3pSYXhPQ3FVNUF6aktNY2NpNFdaMStG?=
 =?utf-8?B?L0oxWlA0Mmwya3N1U2M0aktHM053UmN6SDhiM2c4QThoRHppUkZZVXEvVHV1?=
 =?utf-8?B?SDlHb3R3ZTFoOG81cTNVVmpDMGl3V3Z6aEZFUnZuWnZCb1B3RitMTWpYRG5T?=
 =?utf-8?B?cXZmdFF4UjR3N2t3ZCswckZLaWFYcGFoTlcyR2pDcVptYWxZS1Z4OHZaMkMw?=
 =?utf-8?B?YVA2NEl3VHowV2J2R3N5NkQrMXhoVVNGQmNZMnRYK3NHQndMVGVwZGVWbXNQ?=
 =?utf-8?B?eWprNEp1QUxSRlJKRjM2K1MvdlIzYmxmbUcrc2I4ZDRUeXIwTFNCY3J0eU9J?=
 =?utf-8?B?RTZ5TSttZHY3YTBVRFVsNTlCWVVlQTd2UXFGMGZUK1RDd0RwRkJoZFk4UDNt?=
 =?utf-8?B?UjFzTkNJbUlnNlFEREZ4N204WkZDQTJ3bGlsZHJQaGJjMzRFOVBZZHNzS0VS?=
 =?utf-8?B?ZjBJSFcrMlV4dHBDZ2w3bXdBVUxrYTFVK1FYYndqaTNVd3NTRzZLU0lxSDRU?=
 =?utf-8?B?OVlySHZ4M0lRYUlwUWx6ckNLRHl1V1FXdFlKT01xM2ZqWEREWTNyb0hRd01Q?=
 =?utf-8?B?UWxScXZsWXpCOStjMUJsZmlPNU1lTUN2WFdESHY4SEV4VXVTSElWVTA2WUdr?=
 =?utf-8?B?bzcrZ2RGcmJ5SkdZYjRyQ3RwZGdrMkI4TnVpTloxVENwbi9oUkxpWkhsTThO?=
 =?utf-8?B?bmJ5RE1rWUxaazcreU9xWTlMY3YrdWNyOVBVV0ZoeWZ5VUxsZFRFT29HMDRF?=
 =?utf-8?B?RXF2ekNqMW53PT0=?=
X-Microsoft-Antispam-Message-Info: D/iLuiiawoFhEAeg/QT16C7wEfvsbehmWHvtmU2zzmA01D+BjNgR21ZEMY63KGNCkiR8RaDL8EA/gGBDu12s7Lz5fBovTC51h4jkv5Wncrv7BrNtiyjvmbE/VtxFv7b4LdFj9eNwp73AvCnvMXNwe0pFKFpHdgIAX4gzYxU+p9KzrK1RwpPefCSONRHbcALIr/zKltvDRi72k3gW+jl5qeoWDHZ30QyUfta9b7n/71eSRn1sSZleCzj/4lzPStRqjFXfdQVArsSYKJPwJSOAuklj/Ot/Ww0L5RpV16P8hGZudGt7dFhBRzRkwVsI6EXI/yKvztmyvQkjVoDqA4KbJz7TssCi7rJeUykEYBIAkCc=
X-Microsoft-Exchange-Diagnostics: 1; BYAPR02MB4454;
 6:YUl0KwJbW5GkE2j0Jeah8kM/+zoh+NtJCU4vqKKHi4e+OG+e7HqzjefCXuZVnKNXXdDB7BUdB2Z73ErN5mPum6r9908BxAfZACUJizNHGWUykQHWtotlxK1jQ6mP+iyCfNtWKt8DehSDwr3JZspC0HJ7MZZWupk+Rgk2I2/72gVAVR3sPrJlnyL0FZ+oSizoKSJXzMjxBblfLAQz1cmE3Aw7N/uglE3lWsILdef7AttRIYp4LxubqzXEnelgujOBjuGIf438dIuPEAtqj+dVf+gI281DPH9iVdDOwuM9geLAgVyds+N2R9QcE6jV5aACYmAb3/WMTdByz8YRY9lxX/8NaPuPyVG8rsH5iwS1YfWgX4HuMZK2kT3BJgIDzrX2OTH5mldi9ZRg4zzBKOIpBlX/ZbzesyCLTSBhkPPoOjAT3+q8mFt4P8kdaPtL5mYl44FImTVDcoe6UtTChj4OJA==;
 5:yZp3cSXrrC1hM9HjGOU3djTE/t37707RGnmbLEsS25gWnm3HKvSpNvBYHFcNK2m6Aj3zJdJ2ZoZfSQfggO8McQ2HrkqLBM/NgDA91HWG8cmqcocJ8OSJdeT5+rliBQPtTNG67IxK/544cXavrNiw0tz7oVDSbiQwSHXQU0EBoxg=;
 7:FGfDr1Sz1DFRL4BGtRL+n2EVUkmcsw+QX1QTuXc4UVQD10SfTKYfVwSC6cVDXlkvbsVy3SIYEc7EFbM7c3obozuf8eZLk8GLCeDuQUJ6hmv/ywua+wkP9vclYvD/JvjnVHPwo5CzVc3cRCotPytWIA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2018 13:34:58.0020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e898898-eb15-4dd4-0b06-08d6457efa0f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
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
 Michal Simek <michal.simek@xilinx.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Olof Johansson <olof@lixom.net>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 05. 10. 18 18:58, Rob Herring wrote:
> Convert Xilinx SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 83 -------------------
>  .../devicetree/bindings/arm/xilinx.yaml       | 81 ++++++++++++++++++
>  2 files changed, 81 insertions(+), 83 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/xilinx.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/xilinx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> deleted file mode 100644
> index 26fe5ecc4332..000000000000
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ /dev/null
> @@ -1,83 +0,0 @@
> -Xilinx Zynq Platforms Device Tree Bindings
> -
> -Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
> -shall have the following properties.
> -
> -Required root node properties:
> -    - compatible = "xlnx,zynq-7000";
> -
> -Additional compatible strings:
> -
> -- Adapteva Parallella board
> -  "adapteva,parallella"
> -
> -- Avnet MicroZed board
> -  "avnet,zynq-microzed"
> -  "xlnx,zynq-microzed"
> -
> -- Avnet ZedBoard board
> -  "avnet,zynq-zed"
> -  "xlnx,zynq-zed"
> -
> -- Digilent Zybo board
> -  "digilent,zynq-zybo"
> -
> -- Digilent Zybo Z7 board
> -  "digilent,zynq-zybo-z7"
> -
> -- Xilinx CC108 internal board
> -  "xlnx,zynq-cc108"
> -
> -- Xilinx ZC702 internal board
> -  "xlnx,zynq-zc702"
> -
> -- Xilinx ZC706 internal board
> -  "xlnx,zynq-zc706"
> -
> -- Xilinx ZC770 internal board, with different FMC cards
> -  "xlnx,zynq-zc770-xm010"
> -  "xlnx,zynq-zc770-xm011"
> -  "xlnx,zynq-zc770-xm012"
> -  "xlnx,zynq-zc770-xm013"
> -
> ----------------------------------------------------------------
> -
> -Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
> -
> -Boards with ZynqMP SOC based on an ARM Cortex A53 processor
> -shall have the following properties.
> -
> -Required root node properties:
> -    - compatible = "xlnx,zynqmp";
> -
> -
> -Additional compatible strings:
> -
> -- Xilinx internal board zc1232
> -  "xlnx,zynqmp-zc1232-revA", "xlnx,zynqmp-zc1232"
> -
> -- Xilinx internal board zc1254
> -  "xlnx,zynqmp-zc1254-revA", "xlnx,zynqmp-zc1254"
> -
> -- Xilinx internal board zc1275
> -  "xlnx,zynqmp-zc1275-revA", "xlnx,zynqmp-zc1275"
> -
> -- Xilinx internal board zc1751
> -  "xlnx,zynqmp-zc1751"
> -
> -- Xilinx 96boards compatible board zcu100
> -  "xlnx,zynqmp-zcu100-revC", "xlnx,zynqmp-zcu100"
> -
> -- Xilinx evaluation board zcu102
> -  "xlnx,zynqmp-zcu102-revA", "xlnx,zynqmp-zcu102"
> -  "xlnx,zynqmp-zcu102-revB", "xlnx,zynqmp-zcu102"
> -  "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102"
> -
> -- Xilinx evaluation board zcu104
> -  "xlnx,zynqmp-zcu104-revA", "xlnx,zynqmp-zcu104"
> -
> -- Xilinx evaluation board zcu106
> -  "xlnx,zynqmp-zcu106-revA", "xlnx,zynqmp-zcu106"
> -
> -- Xilinx evaluation board zcu111
> -  "xlnx,zynqmp-zcu111-revA", "xlnx,zynqmp-zcu111"
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
> new file mode 100644
> index 000000000000..dd227bccf015
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
> @@ -0,0 +1,81 @@
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/arm/xilinx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynq Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +
> +description: |
> +  Xilinx boards with Zynq-7000 SOC or Zynq UltraScale+ MPSoC
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - adapteva,parallella
> +              - digilent,zynq-zybo
> +              - digilent,zynq-zybo-z7
> +              - xlnx,zynq-cc108
> +              - xlnx,zynq-zc702
> +              - xlnx,zynq-zc706
> +              - xlnx,zynq-zc770-xm010
> +              - xlnx,zynq-zc770-xm011
> +              - xlnx,zynq-zc770-xm012
> +              - xlnx,zynq-zc770-xm013
> +          - const: xlnx,zynq-7000
> +
> +      - items:
> +          - const: avnet,zynq-microzed
> +          - const: xlnx,zynq-microzed
> +          - const: xlnx,zynq-7000
> +
> +      - items:
> +          - const: avnet,zynq-zed
> +          - const: xlnx,zynq-zed
> +          - const: xlnx,zynq-7000
> +
> +      - items:
> +          - enum:
> +              - xlnx,zynqmp-zc1751
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx internal board zc1232
> +        items:
> +          - const: xlnx,zynqmp-zc1232-revA
> +          - const: xlnx,zynqmp-zc1232
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx internal board zc1254
> +        items:
> +          - const: xlnx,zynqmp-zc1254-revA
> +          - const: xlnx,zynqmp-zc1254
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx internal board zc1275
> +        items:
> +          - const: xlnx,zynqmp-zc1275-revA
> +          - const: xlnx,zynqmp-zc1275
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx 96boards compatible board zcu100
> +        items:
> +          - const: xlnx,zynqmp-zcu100-revC
> +          - const: xlnx,zynqmp-zcu100
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx evaluation board zcu102
> +        items:
> +          - enum:
> +              - xlnx,zynqmp-zcu102-revA
> +              - xlnx,zynqmp-zcu102-revB
> +              - xlnx,zynqmp-zcu102-rev1.0
> +          - const: xlnx,zynqmp-zcu102
> +          - const: xlnx,zynqmp
> +
> +...
> 

Conversion looks good. I have also found that we are missing some boards
when I was playing with your branch. But this can be added on the top of
this patch.
I have sent you separate patch for that.

Also I have found that we are missing one property which can go to the
tree directly and I am going to send a patch for it too.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
