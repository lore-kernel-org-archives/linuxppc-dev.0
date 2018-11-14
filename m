Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF39C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 00:33:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A471A21582
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 00:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="zRLmON83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A471A21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vlps4M0hzDrj0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 11:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="zRLmON83";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.149.218; helo=esa8.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="zRLmON83";
 dkim-atps=neutral
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com
 [68.232.149.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vlm81hLQzF3Ln
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 11:31:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542155480; x=1573691480;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZtOQ29/cvWpRBNtxeWx0syMkcEv4/RledEdseLfTv4Q=;
 b=zRLmON832TSLtIY+KWiIIaGUCAv5vjWVxR/bFM0L3lv3WdtBQNXRh142
 2zbVC+pC1mP5RJ8phfSb2+cCgtQuZtLB34UD+Bnwv8g0srtJjBIoe/bX/
 5hI3f1iIEuUBHSVO7i8F05EX/Ip2Gc+uFEDW47Hqt0MpXfm4GmoW0DDvW 0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ERAADca+tbhyeV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBg2snCowGX40qlzWBegsBAYRsgz8iNA0NAQMBAQIBAQIBAQI?=
 =?us-ascii?q?QAQEBCgsJCCkvgjYigmQBAQEDEig/EAIBCBgeEFcCBBMIGoJ/ggKdEQKBEIl?=
 =?us-ascii?q?YAQEBgh2KLIwCghaBEYMShH5NhQ4CiwCUVgkFkRUgkHOCdZRhAgQCBAUCFIF?=
 =?us-ascii?q?Dgg5wgzyCNRuOCkABMYxagR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2ERAADca+tbhyeV50NkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?2snCowGX40qlzWBegsBAYRsgz8iNA0NAQMBAQIBAQIBAQIQAQEBCgsJCCkvg?=
 =?us-ascii?q?jYigmQBAQEDEig/EAIBCBgeEFcCBBMIGoJ/ggKdEQKBEIlYAQEBgh2KLIwCg?=
 =?us-ascii?q?haBEYMShH5NhQ4CiwCUVgkFkRUgkHOCdZRhAgQCBAUCFIFDgg5wgzyCNRuOC?=
 =?us-ascii?q?kABMYxagR8BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
 by esa8.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 13 Nov 2018 18:31:16 -0600
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAE0SLuo123292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:31:16 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com
 [68.232.154.98])
 by mx0a-00154901.pphosted.com with ESMTP id 2nr7ccgeac-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:31:16 -0500
Received: from ausxippc106.us.dell.com ([143.166.85.156])
 by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 14 Nov 2018 06:31:15 +0600
X-LoopCount0: from 10.166.134.87
X-IronPort-AV: E=Sophos;i="5.56,230,1539666000"; d="scan'208";a="318281823"
From: <Alex_Gagniuc@Dellteam.com>
To: <keith.busch@intel.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date: Wed, 14 Nov 2018 00:31:13 +0000
Message-ID: <1f7776f2901b40368c847353b74a8cf7@ausx13mps321.AMER.DELL.COM>
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
 <20181113225232.GB10134@localhost.localdomain>
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
 definitions=2018-11-13_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=995 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140002
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

On 11/13/2018 04:56 PM, Keith Busch wrote:=0A=
> On Tue, Nov 13, 2018 at 10:39:15PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 11/12/2018 11:02 PM, Bjorn Helgaas wrote:=0A=
>>> The whole issue of firmware-first, the mechanism by which firmware=0A=
>>> gets control, the System Error enables in Root Port Root Control=0A=
>>> registers, etc., is very murky to me.  Jon has a sort of similar issue=
=0A=
>>> with VMD where he needs to leave System Errors enabled instead of=0A=
>>> disabling them as we currently do.=0A=
>>=0A=
>> Well, OS gets control via _OSC method, and based on that it should=0A=
>> touch/not touch the AER bits. The bits that get set/cleared come from=0A=
>> _HPX method, and there's a more about the FFS described in ACPI spec. It=
=0A=
>> seems that if platform, wants to enable VMD, it should pass the correct=
=0A=
>> bits via _HPX. I'm curious to know in what new twisted way FFS doesn't=
=0A=
>> work as intended.=0A=
> =0A=
> When VMD is enabled, the platform sees a VMD endpoint. It doesn't see=0A=
> any of the root ports on that domain, so ACPI can't provide policies for=
=0A=
> them nor AER registers for the platform to consider controlling.=0A=
=0A=
I'm not understanding the interdependency between RP AER settings and =0A=
VMD. My understanding of VMD is quite rudimentary though, so I'll take =0A=
your word for it.=0A=
=0A=
Alex=0A=
=0A=
