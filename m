Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90BFC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 21:50:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6071B2080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 21:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="GOb1HPX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6071B2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zzs42SZhzF3Fh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 08:50:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="GOb1HPX9";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.149.218; helo=esa8.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="GOb1HPX9";
 dkim-atps=neutral
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com
 [68.232.149.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zzmW5XZmzF3Zq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 08:46:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542750379; x=1574286379;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=E8Cv1jVOYyVT9xK6rqBcVwMN7EPVaji1/ATmt84YejA=;
 b=GOb1HPX9BF4Qh2wrpOARw2y/4OeTY4AB+UTaBICJFE/yoy3KBWyLXjvl
 wF2EvFSlYfkEOdmIa24KKM+JB7siW9Gn0eP8txNsPRJPOEGlQTUp7M57Q
 lxmq0K9k0YPOjulNdMh2EcMMuS9VSObhs9iMROKRwvJ//HCAQGjhyjYBY Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EkAABmf/RbhyeV50NaChwBAQEEAQE?=
 =?us-ascii?q?HBAEBgVIGAQELAQGDaicKjGWNK5c3gXoLAQGEbIN4IjUIDQEDAQECAQECAQE?=
 =?us-ascii?q?CEAEBAQoLCQgpL0IBEAGBYiKCZQEBAQECARIoPwULAgEIGB4QVwIEARIIGoJ?=
 =?us-ascii?q?/gXoIngkCgRCJWAEBAYIdiieMBYIWgRGDEoRTK4VbAosNlGoJBZEdIJEBLJd?=
 =?us-ascii?q?UAgQCBAUCFIFIAYILcIM8gicOCY4cQAExggmKeYEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EkAABmf/RbhyeV50NaChwBAQEEAQEHBAEBgVIGAQELA?=
 =?us-ascii?q?QGDaicKjGWNK5c3gXoLAQGEbIN4IjUIDQEDAQECAQECAQECEAEBAQoLCQgpL?=
 =?us-ascii?q?0IBEAGBYiKCZQEBAQECARIoPwULAgEIGB4QVwIEARIIGoJ/gXoIngkCgRCJW?=
 =?us-ascii?q?AEBAYIdiieMBYIWgRGDEoRTK4VbAosNlGoJBZEdIJEBLJdUAgQCBAUCFIFIA?=
 =?us-ascii?q?YILcIM8gicOCY4cQAExggmKeYEfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
 by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 20 Nov 2018 15:46:16 -0600
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAKLhE8s127739
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 16:46:15 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com
 [68.232.153.202])
 by mx0a-00154901.pphosted.com with ESMTP id 2nvkfpk75m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 16:46:15 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
 by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 21 Nov 2018 03:46:06 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.56,258,1539666000"; d="scan'208";a="1228364035"
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@kernel.org>, <mr.nuke.me@gmail.com>, <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk2X+FUHiVWnkuZssuLn5DqDg==
Date: Tue, 20 Nov 2018 21:46:13 +0000
Message-ID: <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
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
 definitions=2018-11-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200190
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

On 11/20/2018 03:02 PM, Sinan Kaya wrote:=0A=
> On 11/20/2018 3:44 PM, Alex_Gagniuc@Dellteam.com wrote:=0A=
>> I'd prefer "sure" instead of "think". "I think it breaks some system I'm=
=0A=
>> not telling you about" doesn't help much in figuring out how not to=0A=
>> break said system(s).:)=0A=
> =0A=
> Sorry, I thought I mentioned why it would break but let me repeat.=0A=
=0A=
Why, yes, but bets are still being placed on the systems allegedly =0A=
suffering from this.=0A=
=0A=
=0A=
> The systems I have seen rely on the HEST table presence as an indicator=
=0A=
> to the OS that firmware first is enabled. If you go look at the _OSC bits=
=0A=
> on such systems, it still says OS owns the AER service.=0A=
> =0A=
> The assumption here is that HEST table has precedence over the _OSC bits.=
=0A=
> That's what needs to be clarified in the UEFI forum.=0A=
> =0A=
> If this code is to go in and ignore the HEST table presence, then firmwar=
e=0A=
> will think that it owns AER service and OS will think that it owns AER=0A=
> service too.=0A=
=0A=
So this seems like exactly the scenario we were hypothesizing.=0A=
=0A=
  * System boots up with FFS enabled. Everything is fine so far.=0A=
  * OSPM requests control of AER (set bit 3 in _OSC)=0A=
  * FW grants OS control of AER (set bit 3 in _OSC reply)=0A=
=0A=
That's how things are designed to work.=0A=
=0A=
=0A=
Now, let's assume, for the sake of argument, that the firmware on those =0A=
system's is broken, and it didn't intend to give the OS control of AER. =0A=
OSPM checking HEST instead of _OSC is still wrong, according to the =0A=
spec. Two wrongs don't make a right, they just don't crash.=0A=
=0A=
I think the correct way is to identify those broken systems, and add =0A=
quirks for them. Continuing to have inconsistent and over-complicated =0A=
logic that is not spec compliant is not any better.=0A=
=0A=
Alex=0A=
