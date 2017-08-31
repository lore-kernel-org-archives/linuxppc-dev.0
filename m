Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjS4n72zqzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 13:08:40 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id a2so5424665pfj.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 20:08:40 -0700 (PDT)
Subject: Re: [PATCH kernel] PCI: Disable IOV before pcibios_sriov_disable()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, shan.gavin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170811081933.17474-1-aik@ozlabs.ru>
 <20170830190206.GU8154@bhelgaas-glaptop.roam.corp.google.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <830677fa-cba8-1339-197e-07b5a0400144@ozlabs.ru>
Date: Thu, 31 Aug 2017 13:08:31 +1000
MIME-Version: 1.0
In-Reply-To: <20170830190206.GU8154@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/08/17 05:02, Bjorn Helgaas wrote:
> On Fri, Aug 11, 2017 at 06:19:33PM +1000, Alexey Kardashevskiy wrote:
>> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>> The PowerNV platform is the only user of pcibios_sriov_disable().
>> The IOV BAR could be shifted by pci_iov_update_resource(). The
>> warning message in the function is printed if the IOV capability
>> is in enabled (PCI_SRIOV_CTRL_VFE && PCI_SRIOV_CTRL_MSE) state.
>>
>> This is the backtrace of what is happening:
>>    pci_disable_sriov
>>    sriov_disable
>>    pnv_pci_sriov_disable
>>    pnv_pci_vf_resource_shift
>>    pci_update_resource
>>    pci_iov_update_resource
>>
>> This fixes the issue by disabling IOV capability before calling
>> pcibios_sriov_disable(). With it, the disabling path matches
>> the enabling path: pcibios_sriov_enable() is called before the
>> IOV capability is enabled.
>>
>> Cc: shan.gavin@gmail.com
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Reported-by: Carol L Soto <clsoto@us.ibm.com>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Tested-by: Carol L Soto <clsoto@us.ibm.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This is repost. Since Gavin left the team, I am trying to push it out.
>> The previos converstion is here: https://patchwork.ozlabs.org/patch/732653/
> 
> I gave up on the previous issue.  I think this patch makes sense as-is
> at least as far as the fact that we can't update a struct resource
> while the device is still consuming it.  I reworked the changelog to
> emphasize that.
> 
> I assume the fact that pci_iov_update_resource() dropped the resource
> update caused some user-visible issue later on, and I might mention
> that, too, if I knew what it was.

I could not identify any issue so far in my test setup - I recreated VFs
several times, run some traffic through them on one of mellanox'es so the
message+backtrace seems to be the only issue for now.


> Here's what I would consider putting on pci/virtualization (the diff
> is unchanged from your post):


This sounds good to me, thanks for updating the commit log.

I'll still try and finish my homework with updating that comment about the
hole in arch/powerpc/platforms/powernv/pci-ioda.c.

Cheers.

> 
> 
> commit 08132e7759b3929bea0ccdf8afe81ebf05351389
> Author: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Date:   Fri Aug 11 18:19:33 2017 +1000
> 
>     PCI: Disable VF decoding before updating resources in pcibios_sriov_disable()
>     
>     A struct resource represents the address space consumed by a device.  We
>     should not modify that resource while the device is actively using the
>     address space.  For VFs, pci_iov_update_resource() enforces this by
>     printing a warning and doing nothing if the VFE (VF Enable) and MSE (VF
>     Memory Space Enable) bits are set.
>     
>     Previously, both sriov_enable() and sriov_disable() called the
>     pcibios_sriov_disable() arch hook, which may update the struct resource,
>     while VFE and MSE were enabled.  This effectively dropped the resource
>     update pcibios_sriov_disable() intended to do.
>     
>     Disable VF memory decoding before calling pcibios_sriov_disable().
>     
>     Reported-by: Carol L Soto <clsoto@us.ibm.com>
>     Tested-by: Carol L Soto <clsoto@us.ibm.com>
>     Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>     Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>     [bhelgaas: changelog]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Cc: shan.gavin@gmail.com
>     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Cc: Paul Mackerras <paulus@samba.org>

> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 120485d6f352..ac41c8be9200 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -331,7 +331,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	while (i--)
>  		pci_iov_remove_virtfn(dev, i, 0);
>  
> -	pcibios_sriov_disable(dev);
>  err_pcibios:
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
> @@ -339,6 +338,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	ssleep(1);
>  	pci_cfg_access_unlock(dev);
>  
> +	pcibios_sriov_disable(dev);
> +
>  	if (iov->link != dev->devfn)
>  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>  
> @@ -357,14 +358,14 @@ static void sriov_disable(struct pci_dev *dev)
>  	for (i = 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i, 0);
>  
> -	pcibios_sriov_disable(dev);
> -
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>  	ssleep(1);
>  	pci_cfg_access_unlock(dev);
>  
> +	pcibios_sriov_disable(dev);
> +
>  	if (iov->link != dev->devfn)
>  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>  
> 


-- 
Alexey
