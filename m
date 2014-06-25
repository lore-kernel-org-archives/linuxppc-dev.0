Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEE141A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 13:05:08 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 08:35:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 49A1F1258054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 08:34:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P35HsX41156652
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 08:35:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P352Bt029877
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 08:35:02 +0530
Message-ID: <53AA3C5C.4080807@linux.vnet.ibm.com>
Date: Wed, 25 Jun 2014 11:05:00 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <53A91819.1010900@linux.vnet.ibm.com> <1403591761.4587.161.camel@pasglop>
 <53A9216C.8050904@linux.vnet.ibm.com> <1403593252.4587.163.camel@pasglop>
 <20140625000305.GA5742@shangw>
In-Reply-To: <20140625000305.GA5742@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 08:03 AM, Gavin Shan wrote:
> On Tue, Jun 24, 2014 at 05:00:52PM +1000, Benjamin Herrenschmidt wrote:
>> On Tue, 2014-06-24 at 14:57 +0800, Mike Qiu wrote:
>>> Is that mean *host* side error injection should base on
>>> "CONFIG_IOMMU_API" ? If it is just host side(no guest, no pass through),
>>> can't we do error inject?
>>>
>>> Maybe I misunderstand :)
>> Ah no, make different patches, we don't want to use IOMMU group ID, just
>> PE numbers. Maybe we should expose in sysfs the PEs from the platform
>> code with the error injection files underneath ...
>>
> Yeah, "errinjct" needs grab PCI_domain_nr+PE number from sysfs. We
> already had PE number sysfs file:
>
> [root@ltcfbl8eb 0000:01:00.1]# pwd
> /sys/bus/pci/devices/0000:01:00.1
> [root@ltcfbl8eb 0000:01:00.1]# cat eeh_pe_config_addr
> 0x1
>
> For guest support, we will rely on VFIO group ioctl command, which
> naturally depends on pass-through.
>
> ---
>
> We probably implement it like this. If there're anything wrong, please
> correct me:
>
> - Introduce EEH callback struct eeh_ops::err_inject(), which will be
>    implemented for PowerNV (NULL for pSeries) by calling the PCI error
>    injection dedicated OPAL API (opal_pci_err_inject()).
> - Introduce global function eeh.c::eeh_err_inject(), which calls to
>    eeh_ops::err_inject() and newly introduced VFIO EEH operation
>    will be implemented based on this function.
> - Introduce debugfs /sys/kernel/debug/powerpc/PCIxxxx/errinjct, which

Here maybe  "/sys/kernel/debug/powerpc/errinjct" is better, because it 
will supply "PCI_domain_nr" in parameters, so no need supply errinjct 
for each PCI domain.

Another reason is error inject not only for PCI(in future), so better 
not in PCI domain entry.

Also it simple for userland tools to has a fixed path.

Thanks
Mike

>    receives PCI error injection parameters from "errinjct". It could
>    have format: "ei_token:addr:mask:PCI_domain_nr:PE_num:function".
>    Eventually, eeh_err_inject() is invoked to call the corresponding
>    OPAL API.
>
> Thanks,
> Gavin
>
