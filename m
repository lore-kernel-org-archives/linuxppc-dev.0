Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE52C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 17:10:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE70120700
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 17:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z2YShWpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445dBv1kJQzDqXr
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 04:10:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=microsoft.com
 (client-ip=2a01:111:f400:fe44::720;
 helo=nam02-sn1-obe.outbound.protection.outlook.com;
 envelope-from=sthemmin@microsoft.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=microsoft.com header.i=@microsoft.com
 header.b="Z2YShWpo"; dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe44::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445d8t3xY4zDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 04:08:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zcsm9VxctEi9bkYvuW5sKEvEw50Fq4+uy6LfOzpS0M=;
 b=Z2YShWpoh9l/bzM6QI3PBQs9Prc2wE8yPzU2XFnPL4MQUGYNVFtghZZLORxJC/O0PZhdTko1jbxYaGtzucFMuOXKE+UZAgPK2yd8rQloDT7984OchBp+EpcP8NqdjhMNVINJfiqrNdKEh2JSpNrDrnmoTvjVMDJXx2c5LNNT4QM=
Received: from SN6PR2101MB0912.namprd21.prod.outlook.com (52.132.117.13) by
 SN6PR2101MB0896.namprd21.prod.outlook.com (52.132.116.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.4; Fri, 22 Feb 2019 17:08:41 +0000
Received: from SN6PR2101MB0912.namprd21.prod.outlook.com
 ([fe80::f103:1a6d:8837:1153]) by SN6PR2101MB0912.namprd21.prod.outlook.com
 ([fe80::f103:1a6d:8837:1153%6]) with mapi id 15.20.1665.002; Fri, 22 Feb 2019
 17:08:41 +0000
From: Stephen Hemminger <sthemmin@microsoft.com>
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>
Subject: RE: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Thread-Topic: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for
 hyperv_fill_flush_guest_mapping_list()
Thread-Index: AQHUysBHD5XLcndsGEGj5wzptavVTKXsDLuw
Date: Fri, 22 Feb 2019 17:08:41 +0000
Message-ID: <SN6PR2101MB0912C24CD03D22248C868196CC7F0@SN6PR2101MB0912.namprd21.prod.outlook.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
 <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=sthemmin@microsoft.com; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-22T17:08:38.0176008Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e404e21f-d99a-455b-a00f-02600ceba6bc;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [204.195.22.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46f00424-7fde-446e-c198-08d698e86513
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:SN6PR2101MB0896; 
x-ms-traffictypediagnostic: SN6PR2101MB0896:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; SN6PR2101MB0896;
 23:isxqKglvU8hm1GqL8+Ucrr7IExy4b7BP9MnP8lq?=
 =?us-ascii?Q?sBzMt/l3iouZ0XG9+TYrRYZne1BJbPbnJpVg/1PMowca8MylIdZNqn/LMjaa?=
 =?us-ascii?Q?4YODFn9L5z/WsakGanbz1NnH+jSECUG50/Ma3aSdWsQVgXzdROaHezhzQj72?=
 =?us-ascii?Q?cnT/WpO6QP68OcGrOLYuepEXT32dZWBZaarOd7At+6FIoe8Q+OSm55NpXn5s?=
 =?us-ascii?Q?H4WqKXWDVYrodtU63ERahJ5+qTC4F4d1o2dWxKNyFPMm4lEWa+7kAKvGBOkc?=
 =?us-ascii?Q?usDfjKcHTIJVKQ9L3Eo8ePjfiOcTuW5aVkswEqygQIVGjxi2u1J654svSuN0?=
 =?us-ascii?Q?Iz95rmXr74WT2WT35k152+GM+sJR9xeloCxsXPi3wDA0F2jXVSDVtG61DUqd?=
 =?us-ascii?Q?p/PCVD/7QONsn0RHd/1FrF4FfkyN8MzzKWvfZ8/a7XdbV+HcxER7g5qLOsVE?=
 =?us-ascii?Q?6z0JAYIDpxkqPyj5tiYEBf8aK0MUFttbZ3ILf1sDvYjYDPvrZDedq46dIlgl?=
 =?us-ascii?Q?7V0mxwO7mpX4MeGLJ861edrG9dnhRDa+9SyqzvZWG5lL+xoaOKRk7Wif5jJp?=
 =?us-ascii?Q?F2i+U9FWVKanJkWyefC1RhQHT0smYs4pY60/VZMKQQ3SJQ++HD/su6E4BYyD?=
 =?us-ascii?Q?ROky0HF/FuOah9pmYh6S37JZG/X31pkGnHM5thnje9QE0s3U1Qgk+gu1aeyc?=
 =?us-ascii?Q?HUJ4DNCnMVFkqLdDrXwYOHFGtVoARtfX7eaZcZvlT4DaUiALIboYTKOOsm/X?=
 =?us-ascii?Q?L54IKagB4mrW+XC3G7j0g+AYnNPSLCHFn2lThKIHCCqkXb1J6F5wckAihg+T?=
 =?us-ascii?Q?L9F1o/0QzNiI0XDWU08FQVmcwFxxzpf1+lnU7GBAaMg6nb+VjBnUQb4ibqlx?=
 =?us-ascii?Q?Pcwxw3Qj9+zb5IcpEwIOQX8r/yh/lkyPUX4mZ6F1AxJB5rMpyd2WuGnMRxi5?=
 =?us-ascii?Q?sgoYw7TVC50RvAO2gk4JY9P0kElwqTOm3k2ehvgZgZxTfVCkyl0o388rHL/+?=
 =?us-ascii?Q?i3xgiN1MJxeEMM5QkLlfaQjwhVrt7cbF+SHOs0mFlHXqNFq4CNSulV8Euxnp?=
 =?us-ascii?Q?ddHCAC3Vj4MfKGP0l03mFhcWA+n2MpvrMLaQQFAgNLfWNpxFyXXtgtMPhZ27?=
 =?us-ascii?Q?G2oE5BuKLCmnGrZlj0Omx0zAo125TcyXL5IR6Qoti1IsorDivi8vswtlNxBk?=
 =?us-ascii?Q?gSG+NGB2/tkRDFYrBJKuXB7lJ2Spq0akrbDW3r4A6+FI2O73UYG0hD5D524F?=
 =?us-ascii?Q?R34ToygR3khSfmCtuDRd9eZzW7N5tT+jA7YJGvGkXr1gdYTLkAa8O7miz9A3?=
 =?us-ascii?Q?Lt6EbO0oMPXja+gDQF3j91f4zFg4KNh/uN/v1ihzi8g82ZOH7XDdwsBv3ky9?=
 =?us-ascii?Q?Z/uSCXiMhKg+yUFuFFJ2OnIqSi7Bvb9XwhLPEU4tdj/r+wvqsEXzqsVuKKBV?=
 =?us-ascii?Q?DIXB8jBF+DKOX9Y5qCmt+/zpVkmRSdRkkLxkLkymIw4UCgXsGYkB7?=
x-microsoft-antispam-prvs: <SN6PR2101MB08966AA9227E954E2268598ECC7F0@SN6PR2101MB0896.namprd21.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(189003)(199004)(316002)(74316002)(66066001)(71190400001)(71200400001)(25786009)(22452003)(1411001)(4326008)(2501003)(8990500004)(99286004)(26005)(33656002)(6246003)(55016002)(10290500003)(486006)(9686003)(76176011)(5640700003)(53936002)(6506007)(6436002)(4744005)(102836004)(7416002)(11346002)(7696005)(446003)(54906003)(476003)(97736004)(1361003)(7736002)(6346003)(68736007)(478600001)(8676002)(81156014)(81166006)(2906002)(14454004)(305945005)(8936002)(10090500001)(229853002)(6116002)(105586002)(256004)(2351001)(86362001)(5660300002)(3846002)(86612001)(106356001)(6916009)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR2101MB0896;
 H:SN6PR2101MB0912.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sthemmin@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6zpyScMsCNqC4SbhQ7mljeDH9jDDTchOC+WMtywETHLrIbmMjSj5ef8ps8QIibtV6pjwTkr1DOjpuGG8a63hbvcc/1XTbULf3f+DYOBcZoO+6OekL/FUZx25L4v28kXx4VjcChMw4g+WZM7RbB47TLdosBuLzGclD7gAqddjFZs9a5arkhc3GJO5h0csOE0lLEbe7eGXGtYKu2cMmCfhoQsIyuRj8UmwZclwhzKqPqgBbq6B9Z0/g4/VayLbUC9Fy8S8vwZybI+qqrKTXT9VtxEmEGQwxfTfJAvcX2MkcbcUOv/wnHvenDhrQfIUc/+vqAEFJGTidV50KvWT607j1zfG3tF0/fV9bMLpZXslfdHE7k4lIGdc3hsuHZtC0aPigUDJ43n7cHqMeQ88rcl6RcQty+xYxFCU3KoNzZ/Csvs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f00424-7fde-446e-c198-08d698e86513
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 17:08:41.2853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0896
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "sashal@kernel.org" <sashal@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "mingo@redhat.com" <mingo@redhat.com>, "jhogan@kernel.org" <jhogan@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 Michael Kelley <mikelley@microsoft.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, vkuznets <vkuznets@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 pages)
+		int offset, u64 start_gfn, u64 pages)
 {
 	u64 cur =3D start_gfn;
 	u64 additional_pages;
-	int gpa_n =3D 0;
+	int gpa_n =3D offset;
=20
 	do {
 		/*

Do you mean to support negative offsets here? Maybe unsigned would be bette=
r?
