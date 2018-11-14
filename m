Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32AC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 19:28:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E490522360
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 19:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="RTXdtqUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E490522360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wF0d5pYNzF3Fc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 06:28:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="RTXdtqUg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.149.218; helo=esa8.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="RTXdtqUg";
 dkim-atps=neutral
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com
 [68.232.149.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wDs11DftzF3JT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 06:22:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542223333; x=1573759333;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=u1Zvib28hFLkZLIbgSGhz4o7P/pZdL5a27D/ZoPHxq8=;
 b=RTXdtqUgwMSwGgJhVPthlcPzQE8HFH21Cp0AIc5C9EImPIGv16YkF3Vq
 iPDlAs9QpL8saotCYz0JfDGZa6CNB9Uf2UHCpQ9lfAE4klmMNisjCs2S/
 ZZLqJK6k+FLMyNKQTXHyR8gC1w8PQpvdumNXkZD8899VfAihK28fwa0fc s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EYAAAJdexbhiWd50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBAYNqJwqMBl+LGYINlzYUgWYLAQGEbINMIjQNDQEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBAQoJCwgpL0IBEAGBYiKCYwEBAQECARIVEy0SBQsCAQgYHhBXAgQ?=
 =?us-ascii?q?TCBqCf4F6CJ1gAoEQiVgBAQGBajOKKIwFghaBEYMShEsBEgEJBBIshS8CiRO?=
 =?us-ascii?q?BcJRbCQWRFSCBWIUFihiCdZRlAgQCBAUCFIFFgR1xcIM8gicOCRKOCkABMYI?=
 =?us-ascii?q?HiUGBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EYAAAJdexbhiWd50NjHAEBAQQBAQcEAQGBUQcBAQsBA?=
 =?us-ascii?q?YNqJwqMBl+LGYINlzYUgWYLAQGEbINMIjQNDQEDAQECAQECAQECEAEBAQoJC?=
 =?us-ascii?q?wgpL0IBEAGBYiKCYwEBAQECARIVEy0SBQsCAQgYHhBXAgQTCBqCf4F6CJ1gA?=
 =?us-ascii?q?oEQiVgBAQGBajOKKIwFghaBEYMShEsBEgEJBBIshS8CiROBcJRbCQWRFSCBW?=
 =?us-ascii?q?IUFihiCdZRlAgQCBAUCFIFFgR1xcIM8gicOCRKOCkABMYIHiUGBH4EfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
 by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 14 Nov 2018 13:22:08 -0600
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAEJDVR3164901
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:22:08 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com
 [68.232.154.99])
 by mx0a-00154901.pphosted.com with ESMTP id 2nrnyeheu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 14:22:07 -0500
Received: from ausxipps306.us.dell.com ([143.166.148.156])
 by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 15 Nov 2018 01:22:06 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.56,233,1539666000"; d="scan'208";a="238430554"
From: <Alex_Gagniuc@Dellteam.com>
To: <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date: Wed, 14 Nov 2018 19:22:04 +0000
Message-ID: <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
References: <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
 <20181114055956.GA144931@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-14_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140171
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
Cc: Shyam.Iyer@dell.com, sbobroff@linux.ibm.com, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, keith.busch@intel.com,
 lukas@wunner.de, oohall@gmail.com, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/14/2018 12:00 AM, Bjorn Helgaas wrote:=0A=
> On Tue, Nov 13, 2018 at 10:39:15PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 11/12/2018 11:02 PM, Bjorn Helgaas wrote:=0A=
>>>=0A=
>>> [EXTERNAL EMAIL]=0A=
>>> Please report any suspicious attachments, links, or requests for sensit=
ive information.=0A=
> =0A=
> It looks like Dell's email system adds the above in such a way that the=
=0A=
> email quoting convention suggests that *I* wrote it, when I did not.=0A=
=0A=
I was wondering why you thought I was suspicious. It's a recent =0A=
(server-side) change. You used to be able to disable these sort of =0A=
notices. I'm told back in the day people were asked to delete emails =0A=
before reading them.=0A=
=0A=
>> ...=0A=
>>> Do you think Linux observes the rule about not touching AER bits on=0A=
>>> FFS?  I'm not sure it does.  I'm not even sure what section of the=0A=
>>> spec is relevant.=0A=
>>=0A=
>> I haven't found any place where linux breaks this rule. I'm very=0A=
>> confident that, unless otherwise instructed, we follow this rule.=0A=
> =0A=
> Just to make sure we're on the same page, can you point me to this=0A=
> rule?  I do see that OSPM must request control of AER using _OSC=0A=
> before it touches the AER registers.  What I don't see is the=0A=
> connection between firmware-first and the AER registers.=0A=
=0A=
ACPI 6.2 - 6.2.11.3, Table 6-197:=0A=
=0A=
PCI Express Advanced Error Reporting control:=0A=
  * The firmware sets this bit to 1 to grant control over PCI Express =0A=
Advanced Error Reporting. If firmware allows the OS control of this =0A=
feature, then in the context of the _OSC method it must ensure that =0A=
error messages are routed to device interrupts as described in the PCI =0A=
Express Base Specification[...]=0A=
=0A=
Now I'm confused too:=0A=
  * HEST -> __aer_firmware_first=0A=
	This is used for touching/not touching AER bits=0A=
  * _OSC -> bridge->native_aer=0A=
	Used to enable/not enable AER portdrv service=0A=
Maybe Keith knows better why we're doing it this way. From ACPI text, it =
=0A=
doesn't seem that control of AER would be tied to HEST entries, although =
=0A=
in practice, it is.=0A=
=0A=
> The closest I can find is the "Enabled" field in the HEST PCIe=0A=
> AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:=0A=
> =0A=
>    If the field value is 1, indicates this error source is=0A=
>    to be enabled.=0A=
> =0A=
>    If the field value is 0, indicates that the error source=0A=
>    is not to be enabled.=0A=
> =0A=
>    If FIRMWARE_FIRST is set in the flags field, the Enabled=0A=
>    field is ignored by the OSPM.=0A=
> =0A=
> AFAICT, Linux completely ignores the Enabled field in these=0A=
> structures.=0A=
=0A=
I don't think ignoring the field is a problem:=0A=
  * With FFS, OS should ignore it.=0A=
  * Without FFS, we have control, and we get to make the decisions anyway.=
=0A=
In the latter case we decide whether to use AER, independent of the crap =
=0A=
in ACPI. I'm not even sure why "Enabled" matters in native AER handling. =
=0A=
Probably one of the check-boxes in "Binary table designer's handbook"?=0A=
=0A=
> These structures also contain values the OS is apparently supposed to=0A=
> write to Device Control and several AER registers (in struct=0A=
> acpi_hest_aer_common).  Linux ignores these as well.=0A=
> =0A=
> These seem like fairly serious omissions in Linux.=0A=
=0A=
I think HPX carries the same sort of information (except for Root =0A=
Command reg). FW is supposed to program those registers anyway, so even =0A=
if OS doesn't touch them, I'd expect things to just work.=0A=
=0A=
>>> The whole issue of firmware-first, the mechanism by which firmware=0A=
>>> gets control, the System Error enables in Root Port Root Control=0A=
>>> registers, etc., is very murky to me.  Jon has a sort of similar issue=
=0A=
>>> with VMD where he needs to leave System Errors enabled instead of=0A=
>>> disabling them as we currently do.=0A=
>>=0A=
>> Well, OS gets control via _OSC method, and based on that it should=0A=
>> touch/not touch the AER bits.=0A=
> =0A=
> I agree so far.=0A=
> =0A=
>> The bits that get set/cleared come from _HPX method,=0A=
> =0A=
> _HPX tells us about some AER registers, Device Control, Link Control,=0A=
> and some bridge registers.  It doesn't say anything about the Root=0A=
> Control register that Jon is concerned with.=0A=
=0A=
_HPX type 3 (yay!!!) got approved recently, and that will have more =0A=
fine-grained control. It will be able to handle root control reg.=0A=
=0A=
> For firmware-first to work, firmware has to get control.  How does it=0A=
> get control?  How does OSPM know to either set up that mechanism or=0A=
> keep its mitts off something firmware set up before handoff?=0A=
=0A=
My understanding is that, if FW keeps control of AER in _OSC, then it =0A=
will have set things up to get notified instead of the OS. OSPM not =0A=
touching AER bits is to make sure it doesn't mess up FW's setup. I think =
=0A=
there are some proprietary bits in the root port to route interrupts to =0A=
SMIs instead of the AER vectors.=0A=
=0A=
> In Jon's=0A=
> VMD case, I think firmware-first relies on the System Error controlled=0A=
> by the Root Control register.  Linux thinks it owns that, and I don't=0A=
> know how to learn otherwise.=0A=
=0A=
Didn't Keith say the root port is not visible to the OS?=0A=
=0A=
Alex=0A=
