Return-Path: <elohimes@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vr0R104gHzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 23:46:37 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id r137so2473082pfr.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Mar 2017 05:46:36 -0700 (PDT)
From: Yongji Xie <elohimes@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com, aik@ozlabs.ru,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 3/3] PCI: Don't extend device's size when using default
 alignment for all devices
Date: Sat, 25 Mar 2017 20:46:32 +0800
Message-Id: <1490445992-4102-1-git-send-email-elohimes@gmail.com>
In-Reply-To: <20170323215558.GC23612@bhelgaas-glaptop.roam.corp.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 23, 2017 at 04:55:58PM -0500, Bjorn Helgaas wrote:
>
> On Wed, Feb 15, 2017 at 02:45:06PM +0800, Yongji Xie wrote:
>> Currently we reassign the alignment by extending resources' size in
>> pci_reassigndev_resource_alignment(). This could potentially break
>> some drivers when the driver uses the size to locate register
>> whose length is related to the size. Some examples as below:
>
> I understand the motivation to stop changing the resource size.  That
> makes good sense.
>
>> - misc\Hpilo.c:
>
> This isn't Windows; please use regular Linux forward slashes here.
>

Will fix it.

>> off = pci_resource_len(pdev, bar) - 0x2000;
>>
>> - net\ethernet\chelsio\cxgb4\cxgb4_uld.h:
>> (pci_resource_len((pdev), 2) - roundup_pow_of_two((vres)->ocq.size))
>>
>> - infiniband\hw\nes\Nes_hw.c:
>> num_pds = pci_resource_len(nesdev->pcidev, BAR_1) >> PAGE_SHIFT;
>>
>> This risk could be easily prevented before because we only had one way
>> (kernel parameter resource_alignment) to touch those codes. And even
>> some users may be happy to see the extended size.
>>
>> But now we define a default alignment for all devices which would also
>> touch those codes. It would be hard to prevent the risk in this case. So
>> this patch tries to use START_ALIGNMENT to identify the resource's
>> alignment without extending the size when the alignment reassigning is
>> caused by the default alignment.
>
> But I don't understand the new START_ALIGNMENT case.
>

The START_ALIGNMENT case will be used when we have default alignment
for PCI devices, which can identify the resource's alignment without
extending the size. If we don't use START_ALIGNMENT for default alignment,
resources' size would be extended by default, that means the system's 
default action could potentially break drivers, it looks unreasonable.

>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> ---
>> drivers/pci/pci.c |   34 ++++++++++++++++++++++++----------
>> 1 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 2622e9b..0017e5e 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4958,7 +4958,8 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>>  * RETURNS: Resource alignment if it is specified.
>>  *          Zero if it is not specified.
>
> Since there's function doc, please update it to reflect the new
> "resize" return parameter.
>

Will do it.

> What does "resize" mean?  I can't figure it out from your code.

"resize" means we will update the resource'alignment by extending the 
resource's size. This would happen when we use kernel parameter to identify 
resource's alignment. If the resource's alignment is identified by the default 
alignment function(macro) rather than kernel parameter, "resize" should be 
false, which means we update the resource'alignment without extending the 
resource's size.

Thanks,
Yongji
