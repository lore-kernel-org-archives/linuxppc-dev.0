Return-Path: <SRS0=ts8b=SV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5BC282E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 22:38:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B822C2171F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 22:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B822C2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44m9qH4dCRzDqVc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Apr 2019 08:38:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44m9nT1Qk6zDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 08:36:43 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3JMYED6140990
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 18:36:39 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ryjuwg3sh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 18:36:38 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 19 Apr 2019 23:36:38 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 19 Apr 2019 23:36:36 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3JMaa3c33423384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Apr 2019 22:36:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAC7FAC062;
 Fri, 19 Apr 2019 22:36:35 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80A32AC059;
 Fri, 19 Apr 2019 22:36:35 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.238.207])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 19 Apr 2019 22:36:35 +0000 (GMT)
Subject: Re: [PATCH 0/8]
To: Sam Bobroff <sbobroff@linux.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <b0406238-9480-3423-20ef-27c29c31b313@linux.vnet.ibm.com>
 <20190415034109.GA9045@tungsten.ozlabs.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 19 Apr 2019 15:36:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190415034109.GA9045@tungsten.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041922-2213-0000-0000-000003799761
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010958; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01191516; UDB=6.00624461; IPR=6.00972317; 
 MB=3.00026520; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-19 22:36:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041922-2214-0000-0000-00005E1755A9
Message-Id: <a9d78cf8-4d50-d0f7-7545-4469034ec1d8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-19_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904190156
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 04/14/2019 08:41 PM, Sam Bobroff wrote:
> On Thu, Apr 11, 2019 at 05:55:33PM -0700, Tyrel Datwyler wrote:
>> On 03/19/2019 07:58 PM, Sam Bobroff wrote:
>>> Hi all,
>>>
>>> This patch set adds support for EEH recovery of hot plugged devices on pSeries
>>> machines. Specifically, devices discovered by PCI rescanning using
>>> /sys/bus/pci/rescan, which includes devices hotplugged by QEMU's device_add
>>> command. (pSeries doesn't currently use slot power control for hotplugging.)
>>
>> Slight nit that its not that pSeries doesn't support slot power control
>> hotplugging, its that QEMU pSeries guests don't support it. We most definitely
>> use the slot power control for hotplugging in PowerVM pSeries Linux guests. More
> 
> Ah, I think I see what you mean: pSeries can (and does!) use slot power
> control for hotplugging, it's just that Linux doesn't. Right :-) I'll
> change it to "Linux on pSeries doesn't...." for the next version.

Not quite. A pSeries Linux PowerVM LPAR does use the slot power hotplugging. It
is only the pSeries Linux qemu guest that doesn't. The way that hotplug is
initiated is different for PowerVM and qemu. On PowerVM the command is sent from
the HMC down the RSCT stack which calls drmgr whereas with qemu hotplug
generates an interrupt which logs an event that is picked up by rtas_errd which
then calls drmgr with the "-V" flag. That flag was a special case that we added
to drmgr to work around the slot power hotplugging with rpaphp not working
correctly with qemu guests.

> 
>> specifically we had to work around short comings in the rpaphp driver when
>> dealing with QEMU. This being that while at initial glance the design implies
>> that it had multiple devices per PHB in mind, it didn't, and only actually
>> supported a single slot per PHB. Further, when we developed the QEMU pci hotplug
>> feature we had to deal with only having a single PHB per QEMU guest and as a
>> result needed a way to plug multiple pci devices into a single PHB. Hence, came
>> the pci rescan work around in drmgr.
>>
>> Mike Roth and I have had discussions over the years to get the slot power
>> control hotplugging working properly with QEMU, and while I did get the RPA
>> hotplug driver fixed to register all available slots associated with a PHB, EEH
>> remained an issue. So, I'm very happy to see this patchset get that working with
>> the rescan work around.
>>
>>>
>>> As a side effect this also provides EEH support for devices removed by
>>> /sys/bus/pci/devices/*/remove and re-discovered by writing to /sys/bus/pci/rescan,
>>> on all platforms.
>>
>> +1, this seems like icing on the cake. ;)
> 
> Yes :-)
> 
> Although maybe I should mention that we can't really benefit from this
> on PowerNV *yet* because there seem to be some other problems with
> removing and re-scanning devices: in my tests devices are often unusable
> after being rediscovered.
> 
> (I'm hoping to take a look at that soon.)

Interesting.

> 
>>>
>>> The approach I've taken is to use the fact that the existing
>>> pcibios_bus_add_device() platform hooks (which are used to set up EEH on
>>> Virtual Function devices (VFs)) are actually called for all devices, so I've
>>> widened their scope and made other adjustments necessary to allow them to work
>>> for hotplugged and boot-time devices as well.
>>>
>>> Because some of the changes are in generic PowerPC code, it's
>>> possible that I've disturbed something for another PowerPC platform. I've tried
>>> to minimize this by leaving that code alone as much as possible and so there
>>> are a few cases where eeh_add_device_{early,late}() or eeh_add_sysfs_files() is
>>> called more than once. I think these can be looked at later, as duplicate calls
>>> are not harmful.
>>>
>>> The patch "Convert PNV_PHB_FLAG_EEH" isn't strictly necessary and I'm not sure
>>> if it's better to keep it, because it simplifies the code or drop it, because
>>> we may need a separate flag per PHB later on. Thoughts anyone?
>>>
>>> The first patch is a rework of the pcibios_init reordering patch I posted
>>> earlier, which I've included here because it's necessary for this set.
>>>
>>> I have done some testing for PowerNV on Power9 using a modified pnv_php module
>>> and some testing on pSeries with slot power control using a modified rpaphp
>>> module, and the EEH-related parts seem to work.
>>
>> I'm interested in what modifications with rpaphp. Its unclear if you are saying
>> rpaphp modified so that slot power hotplug works with a QEMU pSeries guest? If
>> thats the case it would be optimal to get that upstream and remove the work
>> rescan workaround for guests that don't need it.
> 
> Unfortunately no, I didn't do enough work to really get it working.  I
> just wanted to get an idea of how that code path interacted with the EEH
> code I was changing, so that hopefully when we get to fixing it, the EEH
> part will be easier to do.
> 
> The hack I tested with was:
> 
> - rtas_errd changed so that it doesn't pass -V to drmgr (-V seems to
>   trigger drmgr to use the PCI rescan system rather that slot power
>   control).

Correct, as I mentioned above we did that on purpose to basically hack around
rpaphp not working with qemu guests.

-Tyrel

> - of_pci_parse_addrs() changed so that if the assigned-addresses node
>   is missing (which it is when the guest is running under QEMU/KVM) we
>   call pci_setup_device() to configure the BARs.
> 
> It did look pretty good -- the EEH part may actually work fine once we get
> the rest sorted out.
> 
>>
>> -Tyrel
>>
>>>
>>> Cheers,
>>> Sam.
>>>
>>> Sam Bobroff (8):
>>>   powerpc/64: Adjust order in pcibios_init()
>>>   powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
>>>   powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
>>>   powerpc/eeh: Improve debug messages around device addition
>>>   powerpc/eeh: Add eeh_show_enabled()
>>>   powerpc/eeh: Initialize EEH address cache earlier
>>>   powerpc/eeh: EEH for pSeries hot plug
>>>   powerpc/eeh: Remove eeh_probe_devices() and eeh_addr_cache_build()
>>>
>>>  arch/powerpc/include/asm/eeh.h               | 19 +++--
>>>  arch/powerpc/kernel/eeh.c                    | 33 ++++-----
>>>  arch/powerpc/kernel/eeh_cache.c              | 29 +-------
>>>  arch/powerpc/kernel/eeh_driver.c             |  4 ++
>>>  arch/powerpc/kernel/of_platform.c            |  3 +-
>>>  arch/powerpc/kernel/pci-common.c             |  4 --
>>>  arch/powerpc/kernel/pci_32.c                 |  4 ++
>>>  arch/powerpc/kernel/pci_64.c                 | 12 +++-
>>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++------
>>>  arch/powerpc/platforms/powernv/pci.c         |  7 +-
>>>  arch/powerpc/platforms/powernv/pci.h         |  2 -
>>>  arch/powerpc/platforms/pseries/eeh_pseries.c | 75 +++++++++++---------
>>>  arch/powerpc/platforms/pseries/pci.c         |  7 +-
>>>  13 files changed, 122 insertions(+), 118 deletions(-)
>>>
>>

