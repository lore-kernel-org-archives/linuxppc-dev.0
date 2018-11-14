Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51358C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:55:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980CA22360
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="iMZEF4WA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980CA22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wGwD1mvTzF3TM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 07:55:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="iMZEF4WA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.153.94; helo=esa3.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="iMZEF4WA";
 dkim-atps=neutral
Received: from esa3.dell-outbound.iphmx.com (esa3.dell-outbound.iphmx.com
 [68.232.153.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wGsG2ckTzF3Mq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 07:52:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542228748; x=1573764748;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OK57INNTIDwKwcDqWEq68OIXp0NJI6SwNBEEbFIte+0=;
 b=iMZEF4WAOsQtYDZYDjMiaQrXihEuaZH/eCznfyVDhNaQz1bNxypms/a4
 AGOu9ikWZsr8Z0DzlM4/adX8GTxCy2dUAYr6R3+P9QJjm8zM5/GqHaPyh
 L0cFsBp8xxmaf5M9LMgHcGmg1QQIAFcslkdj7g5++H0M7CRJ+osS8ROK7 s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EiAAAJiuxbhiWd50NiHQEBBQEHBQG?=
 =?us-ascii?q?BUQgBCwEBg2onCowGX4sagg2XNoF6CwEBhGyDTCI0DQ0BAwEBAgEBAgEBAhA?=
 =?us-ascii?q?BAQEKCQsIKS9CARABgWIigmMBAQEBAgESFRM4BwULAgEIGB4QVwIEEwgagn+?=
 =?us-ascii?q?BegieRwKBEIlYAQEBgWoziieMBYIWgRGDEoR+TYUOAosDlFsJBZEVIJB1gnW?=
 =?us-ascii?q?UZQIEAgQFAhSBRYIOcIM8gjUbjgpAATGCB4pggR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2EiAAAJiuxbhiWd50NiHQEBBQEHBQGBUQgBCwEBg2onC?=
 =?us-ascii?q?owGX4sagg2XNoF6CwEBhGyDTCI0DQ0BAwEBAgEBAgEBAhABAQEKCQsIKS9CA?=
 =?us-ascii?q?RABgWIigmMBAQEBAgESFRM4BwULAgEIGB4QVwIEEwgagn+BegieRwKBEIlYA?=
 =?us-ascii?q?QEBgWoziieMBYIWgRGDEoR+TYUOAosDlFsJBZEVIJB1gnWUZQIEAgQFAhSBR?=
 =?us-ascii?q?YIOcIM8gjUbjgpAATGCB4pggR8BAQ?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
 by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 14 Nov 2018 14:52:11 -0600
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAEKm6M5021369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 15:52:13 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com
 [68.232.154.63])
 by mx0b-00154901.pphosted.com with ESMTP id 2nrmxktch5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 15:52:13 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
 by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 15 Nov 2018 02:52:10 +0600
X-LoopCount0: from 10.166.134.87
X-IronPort-AV: E=Sophos;i="5.56,233,1539666000"; d="scan'208";a="1325421759"
From: <Alex_Gagniuc@Dellteam.com>
To: <keith.busch@intel.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date: Wed, 14 Nov 2018 20:52:10 +0000
Message-ID: <644fd16cf02c4fe5b7e250c226c80f2e@ausx13mps321.AMER.DELL.COM>
References: <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
 <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
 <df85813c9860463d85f6c302dfe07b12@ausx13mps321.AMER.DELL.COM>
 <20181113050240.GA182139@google.com>
 <19136f44cd5c45e79bbef7e78a6bf332@ausx13mps321.AMER.DELL.COM>
 <20181114055956.GA144931@google.com>
 <1eb0fa27924f426992715684f5e63346@ausx13mps321.AMER.DELL.COM>
 <20181114202333.GE11416@localhost.localdomain>
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
 definitions=2018-11-14_16:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140185
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
Cc: gregkh@linuxfoundation.org, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Shyam.Iyer@dell.com,
 lukas@wunner.de, oohall@gmail.com, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 helgaas@kernel.org, linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/14/2018 02:27 PM, Keith Busch wrote:=0A=
> On Wed, Nov 14, 2018 at 07:22:04PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 11/14/2018 12:00 AM, Bjorn Helgaas wrote:=0A=
>>> Just to make sure we're on the same page, can you point me to this=0A=
>>> rule?  I do see that OSPM must request control of AER using _OSC=0A=
>>> before it touches the AER registers.  What I don't see is the=0A=
>>> connection between firmware-first and the AER registers.=0A=
>>=0A=
>> ACPI 6.2 - 6.2.11.3, Table 6-197:=0A=
>>[...]=0A=
>> Maybe Keith knows better why we're doing it this way. From ACPI text, it=
=0A=
>> doesn't seem that control of AER would be tied to HEST entries, although=
=0A=
>> in practice, it is.=0A=
> =0A=
> I'm not sure, that predates me.  HEST does have a FIRMWARE_FIRST flag, bu=
t=0A=
> spec does not say anymore on relation to _OSC control or AER capability.=
=0A=
> Nothing in PCIe spec either.=0A=
=0A=
Speaking to one of the PCIe (and _HPX type 3) spec authors, ownership of =
=0A=
AER should be determined by _OSC. period. The result of _OSC applies to =0A=
every device under the root port. This crap we do with checking HEST is =0A=
crap.=0A=
=0A=
If I'm not stepping on anyone toes, and there's no known unintended =0A=
consequences, I can look at patching this up. I'm not promising a patch, =
=0A=
though, but it's exactly the sort of thing I like to fix.=0A=
=0A=
> I also don't know why Linux disables the AER driver if only one=0A=
> device has a FIRMWARE_FIRST HEST. Shouldn't that just be a per-device=0A=
> decision?=0A=
=0A=
I think the logic is if one HEST entry has both FFS and GLOBAL flags =0A=
set, then then disable AER services for all devices. It works in =0A=
practice better than it works in theory. I think _OSC should be the =0A=
determining factor here, not HEST.=0A=
=0A=
>>> The closest I can find is the "Enabled" field in the HEST PCIe=0A=
>>> AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:=0A=
>>> [...]=0A=
>>> AFAICT, Linux completely ignores the Enabled field in these=0A=
>>> structures.=0A=
>>=0A=
>> I don't think ignoring the field is a problem:=0A=
>>    * With FFS, OS should ignore it.=0A=
>>    * Without FFS, we have control, and we get to make the decisions anyw=
ay.=0A=
>> In the latter case we decide whether to use AER, independent of the crap=
=0A=
>> in ACPI. I'm not even sure why "Enabled" matters in native AER handling.=
=0A=
>> Probably one of the check-boxes in "Binary table designer's handbook"?=
=0A=
> =0A=
> And why doesn't Linux do anything with _OSC response other than logging=
=0A=
> it? If OS control wasn't granted, shouldn't that take priority over HEST?=
=0A=
=0A=
But it does in portdrv_core.c:=0A=
=0A=
	if (dev->aer_cap && pci_aer_available() &&=0A=
	    (pcie_ports_native || host->native_aer)) {=0A=
		services |=3D PCIE_PORT_SERVICE_AER;=0A=
=0A=
That flag later creates a pcie device that allows aerdrv to attach to.=0A=
=0A=
Alex=0A=
