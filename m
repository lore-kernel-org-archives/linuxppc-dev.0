Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD0C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 00:23:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FFA21019
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 00:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="BfYe38RQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FFA21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wzTv0FQYzF3gT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 11:23:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="BfYe38RQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=dellteam.com
 (client-ip=68.232.153.90; helo=esa1.dell-outbound.iphmx.com;
 envelope-from=alex_gagniuc@dellteam.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=Dellteam.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=dellteam.com header.i=@dellteam.com header.b="BfYe38RQ";
 dkim-atps=neutral
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com
 [68.232.153.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wzQ44FHJzF3gB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 11:19:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
 t=1542327574; x=1573863574;
 h=cc:from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MvjbAK62sxqNV5+o1lwvIv5ucRTJ4VMmMbmHn/VJPzg=;
 b=BfYe38RQnd6tJglYxX/TLzuRUskOBLK8F3ARaTAX3DTyndTVKQw5ex+A
 4GeDkVBt2mqvNkEBJ9bLAgOucmHMip4aa+ibagKeKT4tTDBo/jPynYqef
 2GITjdeyD+q23/fbRvJV/IEWtKBpR0lJw4eMQ/WURoLwK205anhRZh/bA E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EUAACXDO5bhiWd50NjHQEBBQEHBQG?=
 =?us-ascii?q?BUQgBCwGCaYECJwqMBl+LHIINlzaBegsBAR8PhD6DUyI0CQ0BAwEBAgEBAgE?=
 =?us-ascii?q?BAhABAQEKCQsIKSMMgjYiEk1rAQEBAQEBIwINYwEBAQECARIoPwULAgEIGB4?=
 =?us-ascii?q?QVwIEEwgagn8BgXkID5wAAoEQiVgBAQGCHYQtAYV0BYwFghaBEYMSgwIZAYF?=
 =?us-ascii?q?ihVsCiRSBcJQLVQkFhnSKIyCBWIgohnaCdYo6ijECBAIEBQIUgUaCDnCDPB+?=
 =?us-ascii?q?CCA4JEohMhT5AATGMQIEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EUAACXDO5bhiWd50NjHQEBBQEHBQGBUQgBCwGCaYECJ?=
 =?us-ascii?q?wqMBl+LHIINlzaBegsBAR8PhD6DUyI0CQ0BAwEBAgEBAgEBAhABAQEKCQsIK?=
 =?us-ascii?q?SMMgjYiEk1rAQEBAQEBIwINYwEBAQECARIoPwULAgEIGB4QVwIEEwgagn8Bg?=
 =?us-ascii?q?XkID5wAAoEQiVgBAQGCHYQtAYV0BYwFghaBEYMSgwIZAYFihVsCiRSBcJQLV?=
 =?us-ascii?q?QkFhnSKIyCBWIgohnaCdYo6ijECBAIEBQIUgUaCDnCDPB+CCA4JEohMhT5AA?=
 =?us-ascii?q?TGMQIEfAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
 by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256;
 15 Nov 2018 18:19:29 -0600
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAG0Hnk4090039
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 19:19:50 -0500
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com
 [68.232.153.201])
 by mx0b-00154901.pphosted.com with ESMTP id 2nsdrahmv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 19:19:50 -0500
Received: from ausxipps306.us.dell.com ([143.166.148.156])
 by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 16 Nov 2018 06:19:44 +0600
X-LoopCount0: from 10.166.134.89
X-IronPort-AV: E=Sophos;i="5.56,238,1539666000"; d="scan'208";a="238996346"
From: <Alex_Gagniuc@Dellteam.com>
To: <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Topic: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Thread-Index: AQHUT50UQ290XPGvJEGnaSTTjbCF+g==
Date: Fri, 16 Nov 2018 00:19:46 +0000
Message-ID: <8775f80440fd437da083fb188718f5e0@ausx13mps321.AMER.DELL.COM>
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
 <20181115062423.GA94998@google.com>
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
 definitions=2018-11-15_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160000
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
 bp@alien8.de, linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+ Borislav (ACPI guy, maybe he can answer more about HEST)=0A=
=0A=
On 11/15/2018 12:24 AM, Bjorn Helgaas wrote:=0A=
> On Wed, Nov 14, 2018 at 07:22:04PM +0000, Alex_Gagniuc@Dellteam.com wrote=
:=0A=
>> On 11/14/2018 12:00 AM, Bjorn Helgaas wrote:=0A=
>>> On Tue, Nov 13, 2018 at 10:39:15PM +0000, Alex_Gagniuc@Dellteam.com wro=
te:=0A=
>> ACPI 6.2 - 6.2.11.3, Table 6-197:=0A=
>>=0A=
>> PCI Express Advanced Error Reporting control:=0A=
>>    * The firmware sets this bit to 1 to grant control over PCI Express=
=0A=
>> Advanced Error Reporting. If firmware allows the OS control of this=0A=
>> feature, then in the context of the _OSC method it must ensure that=0A=
>> error messages are routed to device interrupts as described in the PCI=
=0A=
>> Express Base Specification[...]=0A=
> =0A=
> The PCIe Base Spec is pretty big, so I wish this reference were a=0A=
> little more explicit.  I *guess* maybe it's referring to PCIe r4.0,=0A=
> figure 6-3 in sec 6.2.6, where PCIe ERR_* Messages can be routed to=0A=
> "INTx or MSI Error Interrupts" and/or "platform-specific System Error"=0A=
> interrupts.=0A=
=0A=
It's engineering slang for "I don't know what the spec says, but do what =
=0A=
the spec says." What it means is that FW should set up HW in such a way, =
=0A=
that PCIe-compliant OS which enables interrupts will get interrupts the =0A=
way it expects. For example, some FW might set the root port to trigger =0A=
an SMI instead of firing up the proper MSI vector. In this case FW must =0A=
ensure that AER interrupts fire up the MSI vector instead of triggering SMI=
.=0A=
=0A=
> "Device interrupts" seems like it refers to the "INTx or MSI"=0A=
> interrupts, not the platform-specific System Errors, so I would read=0A=
> that as saying "if firmware grants OS control of AER via _OSC,=0A=
> firmware must set the AER Reporting Enables in the AER Root Error=0A=
> Command register."  But that seems a little silly because the OS now=0A=
> *owns* the AER capability and it can set the AER Root Error Command=0A=
> register itself if it wants to.=0A=
=0A=
When OS takes control of AER, it is responsible for setting things up, =0A=
at least as far as standard PCIe registers are concerned. So setting up =0A=
the the root command register would still be the OS's responsibility. =0A=
Proprietary registers, like routing to SMI/SCI/MSI would have to be done =
=0A=
by FW.=0A=
=0A=
=0A=
> And I still don't see the connection here with Firmware-First.  I'm=0A=
> pretty sure firmware could not be notified via INTx or MSI interrupts=0A=
> because those are totally managed by OSPM.=0A=
=0A=
The connection with FFS is that FFS needs to be notified by some other =0A=
method. FW can't commandeer interrupt vectors willie-nillie. FW gets =0A=
notified by platform-specific mechanisms. In my case, it happens to be =0A=
SMM, but it could be a number of other proprietary mechanisms.=0A=
=0A=
=0A=
>>> The closest I can find is the "Enabled" field in the HEST PCIe=0A=
>>> AER structures (ACPI v6.2, sec 18.3.2.4, .5, .6), where it says:=0A=
>>>[...] =0A=
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
> =0A=
> It seems like these HEST structures are "here's how firmware thinks=0A=
> you should set up AER on this device".  But I agree, I have no idea=0A=
> how to interpret "Enabled".  The rest of the HEST fields cover all the=0A=
> useful AER registers, including the Reporting Enables in the AER Root=0A=
> Error Command register *and* the Error Reporting Enables in the Device=0A=
> Control register.  So I don't know what the "Enabled" field adds to=0A=
> all that.  =0A=
=0A=
"This table contains information platform firmware supplies to OSPM for =0A=
configuring AER support on a given PCI Express device."=0A=
=0A=
I don't fully get the point of the HEST structures for PCIe. I'm hoping =0A=
Borislav can shed enlightment on this. I think we can ignore them in PCI =
=0A=
core, with a note to revisit them if something ever goes horribly wrong. =
=0A=
I've patched some changes to reduce reliance on HEST [1].=0A=
=0A=
> What a mess.=0A=
=0A=
It's ACPI. What else did you expect?=0A=
=0A=
>>> For firmware-first to work, firmware has to get control.  How does=0A=
>>> it get control?  How does OSPM know to either set up that=0A=
>>> mechanism or keep its mitts off something firmware set up before=0A=
>>> handoff?=0A=
>>=0A=
>> My understanding is that, if FW keeps control of AER in _OSC, then=0A=
>> it will have set things up to get notified instead of the OS. OSPM=0A=
>> not touching AER bits is to make sure it doesn't mess up FW's setup.=0A=
>> I think there are some proprietary bits in the root port to route=0A=
>> interrupts to SMIs instead of the AER vectors.=0A=
> =0A=
> It makes good sense that if OSPM doesn't have AER control, firmware=0A=
> does all AER handling, including any setup for firmware-first=0A=
> notification.  If we can assume that firmware-first notification is=0A=
> done in some way the OS doesn't know about and can't mess up, that=0A=
> would be awesome.=0A=
=0A=
I think that's a reasonable assumption as long as OS respects AER ownership=
.=0A=
=0A=
> But I think the VMD model really has nothing to do with the APEI=0A=
> firmware-first model.  With VMD, it sounds like OSPM owns the AER=0A=
> capability and doesn't know firmware exists *except* that it has to be=0A=
> careful not to step on firmware's interrupt.  So maybe we can handle it=
=0A=
> separately.=0A=
=0A=
<sarcasm_alert>=0A=
Sounds like VMD is qualified to become part of ACPI spec.=0A=
<\sarcasm_alert>=0A=
=0A=
I'll have to look into VMD in more detail, but this sounds like a design =
=0A=
flaw. It's possible to use the values in HEST to set up AER, but that =0A=
might conflict with the OS's wish on how to set up AER.=0A=
=0A=
Alex=0A=
=0A=
=0A=
[1] https://lkml.org/lkml/2018/11/16/202=0A=
=0A=
