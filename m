Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:40:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8586C20879
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 20:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8586C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bHtj4FXvzDqvN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 07:40:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bHqd4q6CzDqrT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 07:37:33 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0AKYKYJ119624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 15:37:31 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pxawje307-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 15:37:30 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 10 Jan 2019 20:37:30 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 10 Jan 2019 20:37:26 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0AKbOLG24051864
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Jan 2019 20:37:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 982D6112062;
 Thu, 10 Jan 2019 20:37:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 320BA112061;
 Thu, 10 Jan 2019 20:37:23 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.156.211])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 10 Jan 2019 20:37:23 +0000 (GMT)
Subject: Re: Kconfig label updates
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>
References: <20190108223024.GA147017@google.com>
 <87tviiroqy.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 10 Jan 2019 12:37:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87tviiroqy.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011020-2213-0000-0000-0000033A6073
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010380; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144600; UDB=6.00595983; IPR=6.00924864; 
 MB=3.00025073; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 20:37:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011020-2214-0000-0000-00005CEB636C
Message-Id: <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=752 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100159
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
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-pci@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 01/09/2019 04:37 AM, Michael Ellerman wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> writes:
>> Hi,
>>
>> I want to update the PCI Kconfig labels so they're more consistent and
>> useful to users, something like the patch below.  IIUC, the items
>> below are all IBM-related; please correct me if not.
>>
>> I'd also like to expand (or remove) "RPA" because Google doesn't find
>> anything about "IBM RPA", except Robotic Process Automation, which I
>> think must be something else.
> 
> Yeah I think just remove it, it's not a well known term and is unlikely
> to help anyone these days.
> 
> It stands for "RISC Platform Architecture", which was some kind of
> specification for Power machines back in the day, but from what I can
> tell it was never used in marketing or manuals much (hence so few hits
> on Google).

It is basically the predecessor to PAPR "Power Architecture Platform Reference".
Which the LoPAPR document is available through power.org. Not sure if there is
any desire to adopt PAPR in place of RPA. It is the platform reference doc that
outlines how we do DLPAR and PCI Hotplug.

> 
>> Is there some text expansion of RPA that we could use that would be
>> meaningful to a user, i.e., something he/she might find on a nameplate
>> or in a user manual?
> 
> No I don't think so.
> 
>> Ideally the PCI Kconfig labels would match the terms used in
>> arch/.../Kconfig, e.g.,
>>
>>   config PPC_POWERNV
>>     bool "IBM PowerNV (Non-Virtualized) platform support"
>>
>>   config PPC_PSERIES
>>     bool "IBM pSeries & new (POWER5-based) iSeries"
> 
> TBH these are pretty unhelpful too. PowerNV is not a marketing name and
> so doesn't appear anywhere much in official manuals or brochures and
> it's also used on non-IBM branded machines. And pSeries & iSeries were
> marketing names but are no longer used.

pseries is still used as a machine type for PAPR compliant qemu/kvm instances.

Again, just my 2 cents. I'm pretty open to whatever makes the most sense.

-Tyrel

> 
> We should probably update that text, but we can do that later, rather
> than blocking this patch.
> 
>> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>> index e9f78eb390d2..1c1d145bfd84 100644
>> --- a/drivers/pci/hotplug/Kconfig
>> +++ b/drivers/pci/hotplug/Kconfig
>> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>>  	  When in doubt, say N.
>>  
>>  config HOTPLUG_PCI_POWERNV
>> -	tristate "PowerPC PowerNV PCI Hotplug driver"
>> +	tristate "IBM PowerNV PCI Hotplug driver"
> 
> This is used in non-IBM machines as well.
> 
> So perhaps: ?
> 
> 	tristate "IBM/OpenPower PowerNV (bare metal) PCI Hotplug driver"
> 
>> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>>  	  When in doubt, say N.
>>  
>>  config HOTPLUG_PCI_RPA
>> -	tristate "RPA PCI Hotplug driver"
>> +	tristate "IBM Power Systems RPA PCI Hotplug driver"
> 
> I think just drop RPA here.
> 
>>  	depends on PPC_PSERIES && EEH
>>  	help
>>  	  Say Y here if you have a RPA system that supports PCI Hotplug.
> 
> s/RPA/IBM Power Systems/
> 
>> +	  This includes the earlier pSeries and iSeries.
> 
> To be complete:
> 	  This includes the earlier System p, System i, pSeries and iSeries.
> 
>>  
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called rpaphp.
>> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>>  	  When in doubt, say N.
>>  
>>  config HOTPLUG_PCI_RPA_DLPAR
>> -	tristate "RPA Dynamic Logical Partitioning for I/O slots"
>> +	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
> 
> Again just drop RPA.
> 
> 
> cheers
> 

