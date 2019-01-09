Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F461C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:37:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B04B20821
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 08:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B04B20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZMvJ2m2CzDqgH
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 19:37:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=de.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=schwidefsky@de.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=de.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ZMsW03jczDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 19:35:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x098XnGG013596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Jan 2019 03:35:52 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pw924j8kv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 03:35:52 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <schwidefsky@de.ibm.com>;
 Wed, 9 Jan 2019 08:35:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 9 Jan 2019 08:35:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x098ZkuW6619562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Jan 2019 08:35:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06FD2A4060;
 Wed,  9 Jan 2019 08:35:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2C3EA405B;
 Wed,  9 Jan 2019 08:35:45 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.99.88])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  9 Jan 2019 08:35:45 +0000 (GMT)
Date: Wed, 9 Jan 2019 09:35:44 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Kconfig label updates
In-Reply-To: <20190108223024.GA147017@google.com>
References: <20190108223024.GA147017@google.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19010908-0028-0000-0000-000003365CA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010908-0029-0000-0000-000023F36C9F
Message-Id: <20190109093544.28fc136f@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=829 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090074
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
Cc: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 8 Jan 2019 16:30:24 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> Hi,
> 
> I want to update the PCI Kconfig labels so they're more consistent and
> useful to users, something like the patch below.  IIUC, the items
> below are all IBM-related; please correct me if not.
> 
> I'd also like to expand (or remove) "RPA" because Google doesn't find
> anything about "IBM RPA", except Robotic Process Automation, which I
> think must be something else.
> 
> Is there some text expansion of RPA that we could use that would be
> meaningful to a user, i.e., something he/she might find on a nameplate
> or in a user manual?
> 
> Ideally the PCI Kconfig labels would match the terms used in
> arch/.../Kconfig, e.g.,
> 
>   config PPC_POWERNV
>     bool "IBM PowerNV (Non-Virtualized) platform support"
> 
>   config PPC_PSERIES
>     bool "IBM pSeries & new (POWER5-based) iSeries"
> 
>   config MARCH_Z900
>     bool "IBM zSeries model z800 and z900"
> 
>   config MARCH_Z9_109
>     bool "IBM System z9"
> 
> Bjorn
> 
> 
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index e9f78eb390d2..1c1d145bfd84 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -112,7 +112,7 @@ config HOTPLUG_PCI_SHPC
>  	  When in doubt, say N.
> 
>  config HOTPLUG_PCI_POWERNV
> -	tristate "PowerPC PowerNV PCI Hotplug driver"
> +	tristate "IBM PowerNV PCI Hotplug driver"
>  	depends on PPC_POWERNV && EEH
>  	select OF_DYNAMIC
>  	help
> @@ -125,10 +125,11 @@ config HOTPLUG_PCI_POWERNV
>  	  When in doubt, say N.
> 
>  config HOTPLUG_PCI_RPA
> -	tristate "RPA PCI Hotplug driver"
> +	tristate "IBM Power Systems RPA PCI Hotplug driver"
>  	depends on PPC_PSERIES && EEH
>  	help
>  	  Say Y here if you have a RPA system that supports PCI Hotplug.
> +	  This includes the earlier pSeries and iSeries.
> 
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called rpaphp.
> @@ -136,7 +137,7 @@ config HOTPLUG_PCI_RPA
>  	  When in doubt, say N.
> 
>  config HOTPLUG_PCI_RPA_DLPAR
> -	tristate "RPA Dynamic Logical Partitioning for I/O slots"
> +	tristate "IBM RPA Dynamic Logical Partitioning for I/O slots"
>  	depends on HOTPLUG_PCI_RPA
>  	help
>  	  Say Y here if your system supports Dynamic Logical Partitioning
> @@ -157,7 +158,7 @@ config HOTPLUG_PCI_SGI
>  	  When in doubt, say N.
> 
>  config HOTPLUG_PCI_S390
> -	bool "System z PCI Hotplug Support"
> +	bool "IBM System z PCI Hotplug Support"
>  	depends on S390 && 64BIT
>  	help
>  	  Say Y here if you want to use the System z PCI Hotplug
> 

The rewording of the HOTPLUG_PCI_S390 entry is fine with me.
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

