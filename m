Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CF9C10F13
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 00:57:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6312084D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 00:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6312084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gKHN4k6pzDqS8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 10:57:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gKFY2dvQzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 10:55:43 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3C0sU8Y009074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 20:55:39 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rtd7uptg5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 20:55:39 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 12 Apr 2019 01:55:37 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 12 Apr 2019 01:55:35 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3C0tY7w35979442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Apr 2019 00:55:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B200EAC059;
 Fri, 12 Apr 2019 00:55:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49CECAC05B;
 Fri, 12 Apr 2019 00:55:34 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.238.207])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 12 Apr 2019 00:55:34 +0000 (GMT)
Subject: Re: [PATCH 0/8]
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 11 Apr 2019 17:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1553050609.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041200-0060-0000-0000-0000032BD786
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010911; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187775; UDB=6.00622192; IPR=6.00968538; 
 MB=3.00026401; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-12 00:55:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041200-0061-0000-0000-000048EB462F
Message-Id: <b0406238-9480-3423-20ef-27c29c31b313@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-12_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120005
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/19/2019 07:58 PM, Sam Bobroff wrote:
> Hi all,
> 
> This patch set adds support for EEH recovery of hot plugged devices on pSeries
> machines. Specifically, devices discovered by PCI rescanning using
> /sys/bus/pci/rescan, which includes devices hotplugged by QEMU's device_add
> command. (pSeries doesn't currently use slot power control for hotplugging.)

Slight nit that its not that pSeries doesn't support slot power control
hotplugging, its that QEMU pSeries guests don't support it. We most definitely
use the slot power control for hotplugging in PowerVM pSeries Linux guests. More
specifically we had to work around short comings in the rpaphp driver when
dealing with QEMU. This being that while at initial glance the design implies
that it had multiple devices per PHB in mind, it didn't, and only actually
supported a single slot per PHB. Further, when we developed the QEMU pci hotplug
feature we had to deal with only having a single PHB per QEMU guest and as a
result needed a way to plug multiple pci devices into a single PHB. Hence, came
the pci rescan work around in drmgr.

Mike Roth and I have had discussions over the years to get the slot power
control hotplugging working properly with QEMU, and while I did get the RPA
hotplug driver fixed to register all available slots associated with a PHB, EEH
remained an issue. So, I'm very happy to see this patchset get that working with
the rescan work around.

> 
> As a side effect this also provides EEH support for devices removed by
> /sys/bus/pci/devices/*/remove and re-discovered by writing to /sys/bus/pci/rescan,
> on all platforms.

+1, this seems like icing on the cake. ;)

> 
> The approach I've taken is to use the fact that the existing
> pcibios_bus_add_device() platform hooks (which are used to set up EEH on
> Virtual Function devices (VFs)) are actually called for all devices, so I've
> widened their scope and made other adjustments necessary to allow them to work
> for hotplugged and boot-time devices as well.
> 
> Because some of the changes are in generic PowerPC code, it's
> possible that I've disturbed something for another PowerPC platform. I've tried
> to minimize this by leaving that code alone as much as possible and so there
> are a few cases where eeh_add_device_{early,late}() or eeh_add_sysfs_files() is
> called more than once. I think these can be looked at later, as duplicate calls
> are not harmful.
> 
> The patch "Convert PNV_PHB_FLAG_EEH" isn't strictly necessary and I'm not sure
> if it's better to keep it, because it simplifies the code or drop it, because
> we may need a separate flag per PHB later on. Thoughts anyone?
> 
> The first patch is a rework of the pcibios_init reordering patch I posted
> earlier, which I've included here because it's necessary for this set.
> 
> I have done some testing for PowerNV on Power9 using a modified pnv_php module
> and some testing on pSeries with slot power control using a modified rpaphp
> module, and the EEH-related parts seem to work.

I'm interested in what modifications with rpaphp. Its unclear if you are saying
rpaphp modified so that slot power hotplug works with a QEMU pSeries guest? If
thats the case it would be optimal to get that upstream and remove the work
rescan workaround for guests that don't need it.

-Tyrel

> 
> Cheers,
> Sam.
> 
> Sam Bobroff (8):
>   powerpc/64: Adjust order in pcibios_init()
>   powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
>   powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
>   powerpc/eeh: Improve debug messages around device addition
>   powerpc/eeh: Add eeh_show_enabled()
>   powerpc/eeh: Initialize EEH address cache earlier
>   powerpc/eeh: EEH for pSeries hot plug
>   powerpc/eeh: Remove eeh_probe_devices() and eeh_addr_cache_build()
> 
>  arch/powerpc/include/asm/eeh.h               | 19 +++--
>  arch/powerpc/kernel/eeh.c                    | 33 ++++-----
>  arch/powerpc/kernel/eeh_cache.c              | 29 +-------
>  arch/powerpc/kernel/eeh_driver.c             |  4 ++
>  arch/powerpc/kernel/of_platform.c            |  3 +-
>  arch/powerpc/kernel/pci-common.c             |  4 --
>  arch/powerpc/kernel/pci_32.c                 |  4 ++
>  arch/powerpc/kernel/pci_64.c                 | 12 +++-
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++------
>  arch/powerpc/platforms/powernv/pci.c         |  7 +-
>  arch/powerpc/platforms/powernv/pci.h         |  2 -
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 75 +++++++++++---------
>  arch/powerpc/platforms/pseries/pci.c         |  7 +-
>  13 files changed, 122 insertions(+), 118 deletions(-)
> 

