Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA094C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 02:34:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1806120840
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 02:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="NsJznimj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1806120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rkk80qbczF3Sd
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 13:34:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="NsJznimj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.153.90; helo=esa1.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="NsJznimj";
 dkim-atps=neutral
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com
 [68.232.153.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rdkg606CzDqjV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 09:49:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1541717341; x=1573253341;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=N60mzE6xZJ2Jy7Icwu1jrfOXy7ZLretMSb1Cfesa4Tg=;
 b=NsJznimjghwtZabR+P77kIQe8QZAxiQ7GJPCnkK2fvCoVmGITOYh9wk2
 VMpSOwUyvOdSEMugxj1QCtoFi94W24sBQtkf6JUytYNKhspJPLhcw2Gvd
 a2YcZkjjzpY6NOPn5lN7xIpzpyjRJM6ENajJzmihE68Axjtgc87QQK+Ts E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EFAAB5vORbhiWd50NYDBsBAQEBAwE?=
 =?us-ascii?q?BAQcDAQEBgVEGAQEBCwGDazGMBl+LHYINepY4FIFmCwEBgXeCdYMbIjQNDQE?=
 =?us-ascii?q?DAQECAQECAQECEAEBAQoJCwgpL4I2IoJkAQEBAxILHT8QAgEIGB4QVwIEARo?=
 =?us-ascii?q?agn+CApxrAoEQiVgBAQGCHIosi3mCF4ERgl01hD4BDAESAQcGEiyFLwKKfZR?=
 =?us-ascii?q?LCQWRCSCBV4UBgyKGcoJ0lFUCBAIEBQIUgUOBHXFwgz2CNBuOCkABi0iBH4E?=
 =?us-ascii?q?fAQE?=
X-IPAS-Result: =?us-ascii?q?A2EFAAB5vORbhiWd50NYDBsBAQEBAwEBAQcDAQEBgVEGA?=
 =?us-ascii?q?QEBCwGDazGMBl+LHYINepY4FIFmCwEBgXeCdYMbIjQNDQEDAQECAQECAQECE?=
 =?us-ascii?q?AEBAQoJCwgpL4I2IoJkAQEBAxILHT8QAgEIGB4QVwIEARoagn+CApxrAoEQi?=
 =?us-ascii?q?VgBAQGCHIosi3mCF4ERgl01hD4BDAESAQcGEiyFLwKKfZRLCQWRCSCBV4UBg?=
 =?us-ascii?q?yKGcoJ0lFUCBAIEBQIUgUOBHXFwgz2CNBuOCkABi0iBH4EfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
 by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 08 Nov 2018 16:48:58 -0600
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA8Mm9WN167538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Nov 2018 17:49:12 -0500
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com
 [68.232.153.202])
 by mx0b-00154901.pphosted.com with ESMTP id 2nmtq09323-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 17:49:12 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
 by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 09 Nov 2018 04:48:59 +0600
X-LoopCount0: from 10.166.134.87
X-IronPort-AV: E=Sophos;i="5.54,481,1534827600"; d="scan'208";a="1323441867"
From: <Alex_Gagniuc@Dellteam.com>
To: <gregkh@linuxfoundation.org>, <keith.busch@intel.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date: Thu, 8 Nov 2018 22:49:08 +0000
Message-ID: <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.90.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-08_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080192
X-Mailman-Approved-At: Fri, 09 Nov 2018 13:29:42 +1100
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
Cc: sbobroff@linux.ibm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam.Iyer@dell.com, lukas@wunner.de,
 helgaas@kernel.org, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 oohall@gmail.com, linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/08/2018 04:43 PM, Greg Kroah-Hartman wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> Please report any suspicious attachments, links, or requests for sensitiv=
e information.=0A=
> =0A=
> =0A=
> On Thu, Nov 08, 2018 at 03:32:58PM -0700, Keith Busch wrote:=0A=
>> On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:=0A=
>>> On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:=0A=
>>>> I'm having second thoughts about this.  One thing I'm uncomfortable=0A=
>>>> with is that sprinkling pci_dev_is_disconnected() around feels ad hoc=
=0A=
>>>> instead of systematic, in the sense that I don't know how we convince=
=0A=
>>>> ourselves that this (and only this) is the correct place to put it.=0A=
>>>=0A=
>>> I think my stance always has been that this call is not good at all=0A=
>>> because once you call it you never really know if it is still true as=
=0A=
>>> the device could have been removed right afterward.=0A=
>>>=0A=
>>> So almost any code that relies on it is broken, there is no locking and=
=0A=
>>> it can and will race and you will loose.=0A=
>>=0A=
>> AIUI, we're not trying to create code to rely on this. This more about=
=0A=
>> reducing reliance on hardware. If the software misses the race once and=
=0A=
>> accesses disconnected device memory, that's usually not a big deal to=0A=
>> let hardware sort it out, but the point is not to push our luck.=0A=
> =0A=
> Then why even care about this call at all?  If you need to really know=0A=
> if the read worked, you have to check the value.  If the value is FF=0A=
> then you have a huge hint that the hardware is now gone.  And you can=0A=
> rely on it being gone, you can never rely on making the call to the=0A=
> function to check if the hardware is there to be still valid any point=0A=
> in time after the call returns.=0A=
=0A=
In the case that we're trying to fix, this code executing is a result of =
=0A=
the device being gone, so we can guarantee race-free operation. I agree =0A=
that there is a race, in the general case. As far as checking the result =
=0A=
for all F's, that's not an option when firmware crashes the system as a =0A=
result of the mmio read/write. It's never pretty when firmware gets =0A=
involved.=0A=
=0A=
Alex=0A=
