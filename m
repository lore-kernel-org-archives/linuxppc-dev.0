Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DEC46465
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 20:47:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C8C2080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 20:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="PMIbj4Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C8C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zySM1W4FzF3XR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 07:47:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="PMIbj4Ia";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.149.220; helo=esa2.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="PMIbj4Ia";
 dkim-atps=neutral
Received: from esa2.dell-outbound.iphmx.com (esa2.dell-outbound.iphmx.com
 [68.232.149.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zyPg4L8XzF3Qc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 07:44:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542746695; x=1574282695;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ul/Qwa4C0Z9giykch425HBPzkowp1Hdp/zq4CDc+lkg=;
 b=PMIbj4Ia38lhVgeRTJmtIzUP7ODw8+K+/b9+2LyxT3zJi5cGw+yg2GT+
 li7pkKl6+HoBiB7ZEZ6keb83JweXg1ps/HqedETXfLwVyouM82V+UJkHu
 X+8fHeuw1k3+VFKl8uq+BLZE5XyQI1mc3q/Q/XB8MY1SHxouC4hakwOhc Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EXAACGcfRbhiWd50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBAYNqJwqMBl+NK5c3gXoLAQGEbIN4IjQJDQEDAQECAQECAQE?=
 =?us-ascii?q?CEAEBAQoJCwgpL0IBEAGBYiKCZgEBAQMSKD8QAgEIGB4QVwIEARIIGoJ/ggK?=
 =?us-ascii?q?eIAKBEIlYAQEBgh2KKIwFghaBEYMShH6FWwKLDZRqCQWRHSCRASyXVAIEAgQ?=
 =?us-ascii?q?FAhSBRoIOcIM8gicOCY4cQAExggmKeYEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EXAACGcfRbhiWd50NjHAEBAQQBAQcEAQGBUQcBAQsBA?=
 =?us-ascii?q?YNqJwqMBl+NK5c3gXoLAQGEbIN4IjQJDQEDAQECAQECAQECEAEBAQoJCwgpL?=
 =?us-ascii?q?0IBEAGBYiKCZgEBAQMSKD8QAgEIGB4QVwIEARIIGoJ/ggKeIAKBEIlYAQEBg?=
 =?us-ascii?q?h2KKIwFghaBEYMShH6FWwKLDZRqCQWRHSCRASyXVAIEAgQFAhSBRoIOcIM8g?=
 =?us-ascii?q?icOCY4cQAExggmKeYEfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
 by esa2.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 20 Nov 2018 14:44:50 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAKKhbeW090701
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 15:44:49 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com
 [68.232.153.201])
 by mx0b-00154901.pphosted.com with ESMTP id 2nvk162d16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 15:44:49 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
 by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 21 Nov 2018 02:44:10 +0600
X-LoopCount0: from 10.166.134.85
X-IronPort-AV: E=Sophos;i="5.56,258,1539666000"; d="scan'208";a="1228347735"
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@kernel.org>, <mr.nuke.me@gmail.com>, <keith.busch@intel.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk2X+FUHiVWnkuZssuLn5DqDg==
Date: Tue, 20 Nov 2018 20:44:46 +0000
Message-ID: <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
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
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811200182
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

On 11/19/2018 07:54 PM, Sinan Kaya wrote:=0A=
> On 11/19/2018 6:49 PM, Alex_Gagniuc@Dellteam.com wrote:=0A=
>> On 11/19/2018 02:33 PM, Sinan Kaya wrote:=0A=
>>> However; table assumes governance about for which entities firmware fir=
st=0A=
>>> should be enabled. There is no cross reference to _OSC or permission=0A=
>>> negotiation like _OST.=0A=
>>=0A=
>> Well, from an OSPM perspective, is FFS something that can be enabled or=
=0A=
>> disabled? FFS seems to be static to OSPM, which would change the sort of=
=0A=
>> assumptions we can reasonably make here.=0A=
> =0A=
> IMO, it can be enabled/disabled in BIOS. I have seen this implementation =
before.=0A=
> If the trigger is the presence of a statically compiled ACPI HEST table (=
as the=0A=
> current code does); presence of FFS would be static from OSPM perspective=
.=0A=
> BIOS could patch this table or hide it during boot.=0A=
> =0A=
> If FFS were to be negotiated via _OSC as indirectly implied in this serie=
s, then=0A=
> same BIOS could patch the ACPI table to return different values for the _=
OSC=0A=
> return.=0A=
=0A=
It is theoretically possible to have proprietary BIOS settings to =0A=
disable FFS. The platform vendors that I've spoken to do not offer this =0A=
option. Though even if, hypothetically, BIOS clears the FFS bit in HEST, =
=0A=
it won't stop it from commandeering the CPU and doing whatever it wants.=0A=
=0A=
Although, I'm not quite sure why we'd want to negotiate FFS itself. FFS =0A=
is too big of a can of worms (goes far beyond AER error reporting), when =
=0A=
what we really care about is if OS can use a specific feature or not.=0A=
>> Cool. While the UEFI Secret Society debates, can we figure out if/how=0A=
>> [patch 1/2] breaks those systems, or is it only [patch 2/2] of this=0A=
>> series that we suspect?=0A=
> =0A=
> I went back and looked at both patches. Both of them are removing referen=
ces to=0A=
> HEST table. I think both patches are impacted by this discussion.=0A=
=0A=
I'd prefer "sure" instead of "think". "I think it breaks some system I'm =
=0A=
not telling you about" doesn't help much in figuring out how not to =0A=
break said system(s). :)=0A=
=0A=
Alex=0A=
