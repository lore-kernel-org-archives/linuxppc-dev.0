Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF608C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 19:31:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3B32148D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 19:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="jz1sHBck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3B32148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Qg1r07t5zDq7w
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 06:31:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="jz1sHBck";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.153.94; helo=esa3.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="jz1sHBck";
 dkim-atps=neutral
Received: from esa3.dell-outbound.iphmx.com (esa3.dell-outbound.iphmx.com
 [68.232.153.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Qfz20LVKzDqGC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 06:29:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1545938938; x=1577474938;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Q+UMh7jY8U1VIkQH4DCkm2HjF2/QZr37Q90LowfjR4U=;
 b=jz1sHBckS94f9rKmLBW34Gjy30YpyjN49mr4a0VtmS+tUpe2Ouvx31Ts
 TXLetmY55HnfdDVWlesliqpwjXpaqAoBAVp5KH6vpxdoNuUMyNNvOag9M
 8XhThh8AA0l5iBArrkqwO4U5WK7r8Qj4ThIQDU6m523Jg/rzakykqd91U o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EXAAB/JyVchyeV50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBAYNqJwqMDV+LFIINiRiOSxSBZwsBAYRsgkQiNAkNAQMBAQI?=
 =?us-ascii?q?BAQIBAQIQAQEBFQkIKSMMQgEQAYFmIoJwAQEEEig/EAIBCBgeECE2AgQBEgg?=
 =?us-ascii?q?agwCBagMVmlM9AoFuiQYBAQGCHYd3DYIdjD+CFoQjgleBdwESAQcGEoVfAok?=
 =?us-ascii?q?pghyVLCczCQWOMYMrIIFghSGKZYMQhkmGE4oWAgQCBAUCFIFGN2dxcIM8gjU?=
 =?us-ascii?q?bh0GGSkABMQGDOIgjgR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EXAAB/JyVchyeV50NjHAEBAQQBAQcEAQGBUQcBAQsBA?=
 =?us-ascii?q?YNqJwqMDV+LFIINiRiOSxSBZwsBAYRsgkQiNAkNAQMBAQIBAQIBAQIQAQEBF?=
 =?us-ascii?q?QkIKSMMQgEQAYFmIoJwAQEEEig/EAIBCBgeECE2AgQBEggagwCBagMVmlM9A?=
 =?us-ascii?q?oFuiQYBAQGCHYd3DYIdjD+CFoQjgleBdwESAQcGEoVfAokpghyVLCczCQWOM?=
 =?us-ascii?q?YMrIIFghSGKZYMQhkmGE4oWAgQCBAUCFIFGN2dxcIM8gjUbh0GGSkABMQGDO?=
 =?us-ascii?q?IgjgR+BHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
 by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 27 Dec 2018 13:28:54 -0600
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 wBRJRpC7170838
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 14:28:58 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com
 [68.232.153.201])
 by mx0a-00154901.pphosted.com with ESMTP id 2phgcx6b7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 14:28:58 -0500
Received: from ausxippc110.us.dell.com ([143.166.85.200])
 by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 28 Dec 2018 01:28:57 +0600
X-LoopCount0: from 10.166.134.84
X-IronPort-AV: E=Sophos;i="5.56,406,1539666000"; d="scan'208";a="745242649"
From: <Alex_Gagniuc@Dellteam.com>
To: <helgaas@kernel.org>, <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date: Thu, 27 Dec 2018 19:28:55 +0000
Message-ID: <4bc22b1696f345e483a21da16ac4b745@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.192]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-27_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812270171
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
Cc: Shyam.Iyer@dell.com, gregkh@linuxfoundation.org, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, keith.busch@intel.com,
 lukas@wunner.de, oohall@gmail.com, Austin.Bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/8/18 2:09 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> [+cc Jonathan, Greg, Lukas, Russell, Sam, Oliver for discussion about=0A=
> PCI error recovery in general]=0A=
> =0A=
> On Wed, Nov 07, 2018 at 05:42:57PM -0600, Bjorn Helgaas wrote:=0A=
>> On Tue, Sep 18, 2018 at 05:15:00PM -0500, Alexandru Gagniuc wrote:=0A=
>>> When a PCI device is gone, we don't want to send IO to it if we can=0A=
>>> avoid it. We expose functionality via the irq_chip structure. As=0A=
>>> users of that structure may not know about the underlying PCI device,=
=0A=
>>> it's our responsibility to guard against removed devices.=0A=
>>>=0A=
>>> .irq_write_msi_msg() is already guarded inside __pci_write_msi_msg().=
=0A=
>>> .irq_mask/unmask() are not. Guard them for completeness.=0A=
>>>=0A=
>>> For example, surprise removal of a PCIe device triggers teardown. This=
=0A=
>>> touches the irq_chips ops some point to disable the interrupts. I/O=0A=
>>> generated here can crash the system on firmware-first machines.=0A=
>>> Not triggering the IO in the first place greatly reduces the=0A=
>>> possibility of the problem occurring.=0A=
>>>=0A=
>>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>=0A=
>>=0A=
>> Applied to pci/misc for v4.21, thanks!=0A=
> =0A=
> I'm having second thoughts about this. =0A=
=0A=
Do we have a verdict on this? If you don't like this approach, then I'll =
=0A=
have to fix the problem in some other way, but the problem still needs =0A=
to be fixed.=0A=
=0A=
Alex=0A=
