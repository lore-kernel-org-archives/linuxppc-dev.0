Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF11C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:58:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5102084D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a9YTqQqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5102084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHZt2qYTzDqYL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:58:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="a9YTqQqy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.66; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=pankaj.bansal@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="a9YTqQqy"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50066.outbound.protection.outlook.com [40.107.5.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RFTR1chPzF3BN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 13:23:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVaw9os+6likyjMwo8CLE2+Q50YYW9rKc/j2dHGqnIE=;
 b=a9YTqQqykEf7bqvoBn1N+5+UnA8DJrUVS/DqsaKVKz4QIKyv1UAVEn/HcfXnnRlOElxO93YDLJjYcaHgcx+gDJuMMHHZEHjF1i3Z3OfAamjnRVq68zU5Q2bSwaC5Fooiala77BsoL1eUB1syY8tTLtWNrxefi5h85WIvSBATH9o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
Received: from uefi-workstation-2.ap.freescale.net (14.143.30.134) by
 HE1PR0402MB3324.eurprd04.prod.outlook.com (2603:10a6:7:81::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Fri, 5 Oct 2018 03:23:21 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: [PATCH 0/2] add i2c controlled qixis driver
Date: Fri,  5 Oct 2018 14:25:03 +0530
Message-Id: <20181005085505.29024-1-pankaj.bansal@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::21) To HE1PR0402MB3324.eurprd04.prod.outlook.com
 (2603:10a6:7:81::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8722bd-6672-4f47-1671-08d62a71e7ff
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB3324; 
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 3:zIzVeC+Au+ouZqDnpWr34yjeJjtMsqUzAxcmNIR7WLqL83+xzd85rKKAjUY1SV5ep7AVrMjNWRaLThnWwt6xcet5rq3CX1W4/f4FU3d0PZu5b/V9QTYIfeymBlOvw5pU1mx7AdwfkW4/pwBLSpiJIDnNVqxddlAF6eSMbDasMqI/dnKYEBhjx+sNUl9YPVpYQVFlwzX/5w/oD3MwCspbhj7AoK4WJT/NoMi0u/jvimIpEME1PJneUbsfOBzHXX06;
 25:TcRiVa89nU2PiG4yrIG5k0mprk3fM4XwTC+La1w9InEBn7bhP+3QD+7rhfYfJMVdjz/jD2qeWECE6gPKyoU6ZUBiPMlOznZUAjDepYvUtpYIaYgMgLM1tT1JexmSM0/zJlPyx87nOhl+yA8mTF1u4FCLn8/sMVUwMN0eAXncp2TSwE/Z4aXGJlFVs2LRyCo083fPZ0/qOkdUB/d94YWzmpREg4mT7HAb0WnzpAu6qbuG2z/l38x2ad9aZ8Rj9SY0Dtn7wMzJYQg96OavXpHKYibY7rK78tcoUxCCHEvnW9f2s/i86t7JNUm6vC1k6J4GkEc/8tuvvbG5ao+CZ3Q5Xw==;
 31:h54wbLFMxGImXbq29agfL2GWRfj3GKyGz3CSjoVvysmcozz6zo8mJsEo1PM32tQ99qZzvDj6yFIj/O1z+vBPcVMzfmRLaNPYHKt9CzJB2uR59lehpz98Yj8p0A3e7kz0yCdb/0M9Pzsf3zqTlGSKozi0gm4fxnnXeAx5oL+gmWizO67Uhm0z5YS3YhvwBv2aY0szXAgDi8ZjZ9GM37+wFimsIcTzEdbqfDhbOkhPaFs=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3324:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 20:knHW+8/hXrrzJSoPTcdNO4s/1dGacbY/ipuYyIIJ4N1LNvaBDlgDJl93UKWW1NoklpqTmiCzJ2Gv3WZAqqRe4z3NbSMvtXJWpx9Mr9qB2PfY8PeJNuKxr2VScFRGksgaMQl58Hg82pEkAkAFCqhjdr+DU5kiimuTOK+uU1Kj/daHecKrreezMZPp/bbpMUI21wDYoLGK9LwE+U9pyCFHB7VISuGKnV/mnXJWceg3WJlCBbc3iwpOe7SdkpHRPE44WVEWbEdGjdn09GcbgOwjdHA7gPOFylr6jnYxdHTlGkxWkgESYstW7YFYSOsS+nVL8lwsqPWZAoXQzkWZ7rgcxC5MFnADYQDDgyY4vSP5v7ohTvNh0YNhZ/jCPm2eaMUKsR3MQDeiI6rRTk6e2qnG/o1ynuv4t6LTIJG+uf2TslweY7Vrh9LD6JSocc2BttGuSJNWoslVTDAU1atl5/TaWJG4i4s0QksYAzgk5w6egjPx2e+KYgODGQRM1vbBdnpo;
 4:DUgWbPDc3phmuOrBXBH0Fo0HnoOGU4STthJHdjt6vatDi+R8fELJ8kCctV3qHsdP28KNZqWOQcL8Ycv3A//X4VH3AQsmd4cSFOmQ8KqqDl5YA6mYM7vfUfsE8gtj0Fw6xQ+bmuKok6qp4vMQNbM7OfCH9wvaVc3U/lV5qI32L4sh3990cPMXuhLldV9GQH/y+epQj+wpBTnz2z+Gc4drxi0hkGV3Zofd4yB4oma+CPTBriquNsyMPAJREBAr6nc6+FfchGLFIhLSfylRDaHWSgIeND1f/JSKY6yygPz+YCFsYU5O8xvzaa6ZUCrb3Nva
X-Microsoft-Antispam-PRVS: <HE1PR0402MB33242F90D209A596E1522016F1EB0@HE1PR0402MB3324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);
 SRVR:HE1PR0402MB3324; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB3324; 
X-Forefront-PRVS: 0816F1D86E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(186003)(23676004)(81156014)(81166006)(478600001)(1076002)(6486002)(52116002)(50226002)(8936002)(386003)(55236004)(97736004)(5009440100003)(6506007)(6862004)(316002)(8676002)(5660300001)(16526019)(26005)(66066001)(44832011)(105586002)(106356001)(476003)(6512007)(6116002)(3846002)(6636002)(7736002)(4326008)(486006)(37006003)(53936002)(68736007)(54906003)(956004)(25786009)(2870700001)(50466002)(36756003)(305945005)(86362001)(6666003)(47776003)(2906002)(110426005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB3324;
 H:uefi-workstation-2.ap.freescale.net; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA0MDJNQjMzMjQ7MjM6ZDEyajMzN2VvRzhqaFVmMWdPdk9FVDVW?=
 =?utf-8?B?R3JsZk5qcFFqUWhkbGxLNjdobXhGbWR0dldJeG1XcnFxUko3ZWtNc3E2T1hM?=
 =?utf-8?B?TWIzcmtlQmN6TUxCajE2QW1wQ1E3cTZxbEZ1SGF6cDhPbUs0a0Y3R1VsbDEx?=
 =?utf-8?B?RFhvZEs3RDRTNlB3VVpENUlIcWFnTzMxNUgwOUorQ0JBRStMNGRTcnY1cUoy?=
 =?utf-8?B?c1hMTUU4WXJCcWJzdHBpZmRYVW9vbEZ0WWlkaS91dXN3QWZMTXIrendVNURq?=
 =?utf-8?B?VmxqejY1akhsV1pNWEVubUhWUkRKUVl0bWw0N2ZmTjlhbEJvMTg4VmtVR01M?=
 =?utf-8?B?UEF2dzltaUdlWGtteGZiSVdqMTRkZ0JzR0RpQTZRQlgza3lWazd0NUJ3Tmpw?=
 =?utf-8?B?Rnh2RHRPUlFkMzJuSG1pcFRvemdUM2tYMCtvQ3BPeFRBZ3B2VEUvQXpic2c2?=
 =?utf-8?B?S21BN0d6UE9iVFh2QjhyYThLNjFqMTZnMjk1RWZvYytuRUcyRXlqNC9zMkQr?=
 =?utf-8?B?RHp5N1FsNmYzbExtTlc5TTZLT3ZIeGF4OWFIYldPYjlQVHZnakxIdjZZYjM3?=
 =?utf-8?B?bGlseHk3ZDhwdWFkUXQ5ZVZkUmpMQ2dCYVE4V0daL3pRTmlaUTM2TkczeFlO?=
 =?utf-8?B?cXU4Y05PRDc4OFFWaHNLeUR1Wno1bU5Ed3Vnc0JoZFp4cWRnSGdyVldxd1Nh?=
 =?utf-8?B?WFl0Z2hxRTNzNkJ5OERVa3krSWtONnZuMCtTdnJWL29mL3NKU3UyU1NPTnpK?=
 =?utf-8?B?RnlxS3lmVzVFY3Z3MGZmWS9pK2RXWHZVa25lb045REVPdVZ6UnA0d2EzZm5T?=
 =?utf-8?B?TGxrOEhjZUg1K1FaaitjMlQ5bk1tb0dmMWZwY2lMQW1jdER3ZGlxM3VZazQ5?=
 =?utf-8?B?QVFYSzl4bkdsb1ZxcDB2c1JPeDZaVER6TnF4M3QyYlIvS3pIR3hpaUtsRmta?=
 =?utf-8?B?dHFkQUxTVkhIUzM5SC9VVFpjb3pURmh1bXpkMC9pSkhxRDV1dkg4OHlrdUdY?=
 =?utf-8?B?S3NuQ1VqSDJDcnlwSStnSnBrc3JSM21zaUMvVy83VWVoWC9hempqMFdEenJI?=
 =?utf-8?B?SXJsNC9rOEIrNmRiRVpndlk4OEtVeHNhY01FMnQ0K3hZMUJiYmRoQXgyK0lK?=
 =?utf-8?B?S2p3VEFBL1o0aGc4b3BhRE5PL2MrVjNOMEo3VnB4L3hJT25HMmI4blNpemJ2?=
 =?utf-8?B?WWxVZ1haVXovK1JheERqb0N5K0RMM0E2ODFHako4UDdoQXVlaURnTEc2Q1k2?=
 =?utf-8?B?KzBxVEVhWlgxSmpMSFVwNUxPZGVaS1RLQ2t1TUxoVEFNSy8wT0p0TXdWNC8r?=
 =?utf-8?B?aXROdWwrdGw5bi9zYkc3UG1YemRXbHhOUmVvVXlYcFMwZWp1ZDFJU1QwVm1s?=
 =?utf-8?B?VWQ4bUtCQ3ByQVZ3aXhac1lPWnBtTVlESUtLTEJudDFHNVlCVHA4OG4vVVU3?=
 =?utf-8?B?QkhqTk5oakpXamtlTVpwU2ZXaE9QZnFaT1dtcFZJeVBxNElPQkE5QnlrRjRw?=
 =?utf-8?B?L1ZzMUh0b3FMWkpkdmJINzlkV3pxSERKMkkrQlNTNnY3VEVOM1g2My9hdlBS?=
 =?utf-8?B?V1dLOVV4Rm9tYy9PWjV1b2ZPUlVXT1BWUHE5TG5SanlGTnRoYVFIMDl4L3JH?=
 =?utf-8?B?QXhqajFrcWluZzFHSDR6TFp1N3lPZDdEL3hMWjJWS2IwZUlQYkhJSjcwOWhH?=
 =?utf-8?Q?Fdg829tenjf35o9JngutxSsV93sPhlk1oo2FHEI1u?=
X-Microsoft-Antispam-Message-Info: CvtmQwlhn2L1weGrrXKDYpym0DjCY4O187dc17YvHmTSacj+Ih62kvqF1x7nBqZ3Fn1m+iIakOUxKBf4pwO2rfMNzKeXAKGtJlUGyo9g2Iq6CJK7TWRvETt1snWCMidabvSQzvLlSszekqzGBkpL8TRwHIIGZmA4zSN/zVpHQ4OUT+yONxGH6LdhuGF7E+nLUGj0CgkZ+hq0enrm4/FHnKB8uAfdd8Oxmbs1P2J8O35Hi/328WtY46Hncz0XN7f/08biTLbwhv2bweInrHHr1J7g2UKGAEvG4oiTdtGLUjy1tLkQDIiSfnZXlPHiSqEz7Yx2VC5AnJV9C148wTksQL1ONbhVS0iuE9qPLO3uU90=
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB3324;
 6:b/01LXMb6rLxvgipE8yHzBjhYfhiJgNG4grVkVslJFsno+G17FOVG/OQyofdThFHJggRcOcKziX4WM8b6NPFDiFt3M9hcs1K4g30hOnVXAnTW6HzZngjbOpCfJuyzJarfF1gKpS91CYT1is4DuIAcZdk3N3glM5rFxJUYiBAprIBCoX+A60j1hR8Bqj3GnzY2QXxbndWt4VmbUmAO0M0v4NjnLtr4USJ2p4ItdIj5JzUhGitTDWC7whjGLdvuPXtb51+k61a1HVgvEL5nsKgIyI+ZN67bkXh4r3lMdmBHRMbuv8/iFnJwzf9wk/tsy7v2ayolwq/W0wNRCw0moRyRRwDbCjChPO4yyxr+4px1bkxDzSkyJ64QSmXvpAYAiQvdiNY2eXPiqdU/I6GOUSoNY6iSThhx/2MUoi0OE8iQnZCIiPNGfIM4vxX0gUgLfFPYJtoHtPhD+tcFqjcOVxmPw==;
 5:bfK9CVTJR7hpkfBkZ/+a77ht/JRbcKzDhjRosGJW4Pvb+dgE7JHkPx1U/Xu+crO+uZ9lMJBLWQS3184Qt1TFKXuWP84wvK1NxnTMqK9Dbc9YY1Y55GxtVk3/KJSkvbHrSwBn6s+flZ9rSmcMKUsL9D5OeBXYebYu9glghL0tjrc=;
 7:BthRCx5bv0rRRqV8bYguW4WWyDilaZs61rcjmrUXQ96uw6Mv7SeMF27FAckfXzKk2NbgnCmvVByNNpswNz0Parr03YbmtFv6PiKlRP/55CBpBZdqpNDsoZbGueInE0TDEPWMPtFYutCVPXs50vE0jh+Pp2IIBWkjzFzW0eUJpeN5ps1v2tgpjIaqhJYLOrGDCNk4mEQcfa5LOJbzCrQki5cNWb1JKhnicynlk2dKNzLvV9vfWJ+qaYfdZlziz3XT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2018 03:23:21.7679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8722bd-6672-4f47-1671-08d62a71e7ff
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
 Varun Sethi <V.Sethi@nxp.com>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
driver which is basically an i2c client driver to control FPGA.

This driver is essential to control MDIO mux multiplexing.

Cc: Varun Sethi <V.Sethi@nxp.com>

Pankaj Bansal (2):
  dt-bindings: soc: fsl: Document Qixis FPGA usage
  fsl: add i2c controlled qixis driver

 .../bindings/soc/fsl/qixis_ctrl.txt           | 33 ++++++++
 drivers/soc/fsl/Kconfig                       |  9 +++
 drivers/soc/fsl/Makefile                      |  1 +
 drivers/soc/fsl/qixis_ctrl.c                  | 75 +++++++++++++++++++
 include/linux/fsl/qixis_ctrl.h                | 20 +++++
 5 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/qixis_ctrl.txt
 create mode 100644 drivers/soc/fsl/qixis_ctrl.c
 create mode 100644 include/linux/fsl/qixis_ctrl.h

-- 
2.17.1

