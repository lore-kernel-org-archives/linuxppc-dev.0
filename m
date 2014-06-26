Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D22FB1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:34:32 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 26 Jun 2014 16:34:29 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 665DC2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:34:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5Q6YCjE7930174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:34:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q6YRHd025579
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:34:28 +1000
Message-ID: <53ABBEF1.8090202@linux.vnet.ibm.com>
Date: Thu, 26 Jun 2014 14:34:25 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Create eeh sysfs entry in post_init()
References: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140625053312.GA3808@shangw> <53AA79FB.5000202@linux.vnet.ibm.com>
 <20140626001204.GA6787@shangw>
In-Reply-To: <20140626001204.GA6787@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2014 08:12 AM, Gavin Shan wrote:
> On Wed, Jun 25, 2014 at 03:27:55PM +0800, Mike Qiu wrote:
>> On 06/25/2014 01:33 PM, Gavin Shan wrote:
>>> On Tue, Jun 24, 2014 at 11:32:07PM -0400, Mike Qiu wrote:
>>>
>>> [ cc Richard ]
>>>
>>>> Eeh sysfs entry created must be after EEH_ENABLED been set
>>>> in eeh_subsystem_flags.
>>>>
>>>> In PowerNV platform, it try to create sysfs entry before
>>>> EEH_ENABLED been set, when boot up. So nothing will be
>>>> created for eeh in sysfs.
>>>>
>>> Could you please make the commit log more clear? :-)
>>>
>>> I guess the issue is introduced by commit 2213fb1 ("
>>> powerpc/eeh: Skip eeh sysfs when eeh is disabled"). The
>>> commit checks EEH is enabled while creating PCI device
>>> EEH sysfs files. If not, the sysfs files won't be created.
>>> That's to avoid warning reported during PCI hotplug.
>>>
>>> The problem you're reporting (if I understand completely):
>>> You don't see the sysfs files after the system boots up.
>>> If it's the case, you probably need following changes in
>>> arch/powerpc/platforms/powernv/pci.c::pnv_pci_ioda_fixup().
>>> Could you have a try with it?
>>>
>>> #ifdef CONFIG_EEH
>>> 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
>>> -	eeh_addr_cache_build();
>>> 	eeh_init();
>>> +	eeh_addr_cache_build();
>>> #endif
>> But this was not work, as I test, see boot log below:
>>
> Yeah, we can't convert eeh_dev to pci_dev that time. The
> association is populated by eeh_addr_cache_build(). The
> attached patch should fix your issue. I tried on P7 machine
> and sysfs entries created. Could you help having a test
> on your machine? :-)

I have tested, works good.

Thanks
Mike
>
> Thanks,
> Gavin
