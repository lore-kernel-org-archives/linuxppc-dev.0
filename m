Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA003C520D3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:40:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA8A2080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="G87KwwGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA8A2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4300yj2bTvzF3Ng
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 09:40:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="G87KwwGD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.149.214; helo=esa4.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="G87KwwGD";
 dkim-atps=neutral
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com
 [68.232.149.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4300tW0xyGzF3Md
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 09:36:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542753395; x=1574289395;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=g9bGY0w1RiX+KxvzQn/s7uMWB3hj2Vwazn2fnJg+q6g=;
 b=G87KwwGDWztI9WnxnANjNoKlh48R5H8ixFCwglU2Vee1/Nf8AkuOnHFB
 5Oh+95eyjQrIkUEaPQLfMrMiPRDyySocxpAWMnkEpgs/YSfB5voq3HdoK
 o8jSM8sEGwO7wIOVHhFah4FqYWkfGCd1blaabVAUcGPQpnnWC2Jslm6OD o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FsAADhi/RbhiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBVAQBAQsBAYNqMYxljSx6mDcLAQGEbIN4IjcGDQEDAQECAQECAQECEAE?=
 =?us-ascii?q?BAQoJCwgpL0IBEAGBYiKCZgEBAQMSKD8QAgEIGB4QVwIEAQkRGoJ/ggKeMQK?=
 =?us-ascii?q?BEIlYAQEBgh2KKYwFghaBEYJdNYR+hVsCiQyCAYVMjx4JBZEdIIFYjyksiT6?=
 =?us-ascii?q?OFgIEAgQFAhSBXIF4cIM9gjSOJUABgjqKeYEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2FsAADhi/RbhiWd50NkHAEBAQQBAQcEAQGBVAQBAQsBA?=
 =?us-ascii?q?YNqMYxljSx6mDcLAQGEbIN4IjcGDQEDAQECAQECAQECEAEBAQoJCwgpL0IBE?=
 =?us-ascii?q?AGBYiKCZgEBAQMSKD8QAgEIGB4QVwIEAQkRGoJ/ggKeMQKBEIlYAQEBgh2KK?=
 =?us-ascii?q?YwFghaBEYJdNYR+hVsCiQyCAYVMjx4JBZEdIIFYjyksiT6OFgIEAgQFAhSBX?=
 =?us-ascii?q?IF4cIM9gjSOJUABgjqKeYEfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
 by esa4.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 20 Nov 2018 16:36:30 -0600
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAKMXThT031311
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 17:36:29 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com
 [68.232.153.202])
 by mx0b-00154901.pphosted.com with ESMTP id 2nvhgtueta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 17:36:29 -0500
Received: from ausxippc106.us.dell.com ([143.166.85.156])
 by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 21 Nov 2018 04:35:54 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.56,258,1539666000"; d="scan'208";a="321417490"
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@kernel.org>, <mr.nuke.me@gmail.com>, <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk2X+FUHiVWnkuZssuLn5DqDg==
Date: Tue, 20 Nov 2018 22:36:26 +0000
Message-ID: <e92c6c4f33c84f23ae47137f4ecb11f0@ausx13mps321.AMER.DELL.COM>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
 <bac2c78a-cd56-7287-e4fd-6042e9b3432c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.193]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-20_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=569 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200198
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
Cc: baicar.tyler@gmail.com, sbobroff@linux.ibm.com, linux-pci@vger.kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Shyam.Iyer@dell.com,
 linux-acpi@vger.kernel.org, lukas@wunner.de, oohall@gmail.com,
 Austin.Bolen@dell.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/20/2018 04:08 PM, Sinan Kaya wrote:=0A=
> One version is:=0A=
> "if HEST table is present, ignore _OSC"=0A=
> or=0A=
> Another version is:=0A=
> "if HEST table is present, make sure that FW sets _OSC bit for AER to=0A=
> false. Otherwise, warn like crazy that this BIOS is broken and needs=0A=
> an update and can cause all sorts of trouble"=0A=
=0A=
ACPI 6.2 Ch 6.2.11.3, Table 6-197=0A=
	PCI Express Advanced Error Reporting control=0A=
=0A=
	The firmware sets this bit to 1 to grant control over PCI=0A=
	Express Advanced Error Reporting.=0A=
	If firmware allows the OS control of this feature, then in the=0A=
	context of the _OSC method it must ensure that error messages=0A=
	are routed to device interrupts as described in the PCI=0A=
	Express Base Specification. Additionally, after control is=0A=
	transferred to the OS, firmware must not modify the Advanced=0A=
	Error Reporting Capability. If control of this feature was=0A=
	requested and denied or was not requested, firmware returns=0A=
	this bit set to 0.=0A=
