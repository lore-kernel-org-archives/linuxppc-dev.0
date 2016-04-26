Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvBm36P9czDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 15:41:23 +1000 (AEST)
Received: by mail-pa0-x235.google.com with SMTP id iv1so2368119pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Apr 2016 22:41:23 -0700 (PDT)
Subject: Re: [RFC v6 04/10] PCI: Add support for enforcing all MMIO BARs to be
 page aligned
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-doc@vger.kernel.org
References: <1460976961-29328-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1460976961-29328-4-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 corbet@lwn.net, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <571EFF78.2050603@ozlabs.ru>
Date: Tue, 26 Apr 2016 15:41:12 +1000
MIME-Version: 1.0
In-Reply-To: <1460976961-29328-4-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/2016 08:56 PM, Yongji Xie wrote:
> When vfio passthrough a PCI device of which MMIO BARs are
> smaller than PAGE_SIZE, guest will not handle the mmio
> accesses to the BARs which leads to mmio emulations in host.
>
> This is because vfio will not allow to passthrough one BAR's
> mmio page which may be shared with other BARs. Otherwise,
> there will be a backdoor that guest can use to access BARs
> of other guest.
>
> To solve this issue, this patch modifies resource_alignment
> to support syntax where multiple devices get the same
> alignment. So we can use something like
> "pci=resource_alignment=*:*:*.*:noresize" to enforce the
> alignment of all MMIO BARs to be at least PAGE_SIZE so that
> one BAR's mmio page would not be shared with other BARs.
>
> And we also define a macro PCIBIOS_MIN_ALIGNMENT to enable this
> automatically on PPC64 platform which can easily hit this issue
> because its PAGE_SIZE is 64KB.
>
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>   Documentation/kernel-parameters.txt |    2 ++
>   arch/powerpc/include/asm/pci.h      |    2 ++
>   drivers/pci/pci.c                   |   64 +++++++++++++++++++++++++++++------
>   3 files changed, 57 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index d8b29ab..542be4a 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -2918,6 +2918,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>   				aligned memory resources.
>   				If <order of align> is not specified,
>   				PAGE_SIZE is used as alignment.
> +				<domain>, <bus>, <slot> and <func> can be set to
> +				"*" which means match all values.
>   				PCI-PCI bridge can be specified, if resource
>   				windows need to be expanded.
>   				noresize: Don't change the resources' sizes when
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index 6f8065a..78f230f 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -30,6 +30,8 @@
>   #define PCIBIOS_MIN_IO		0x1000
>   #define PCIBIOS_MIN_MEM		0x10000000
>
> +#define PCIBIOS_MIN_ALIGNMENT  PAGE_SIZE
> +
>   struct pci_dev;
>
>   /* Values for the `which' argument to sys_pciconfig_iobase syscall.  */
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7564ccc..0381c28 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4605,7 +4605,12 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>   	int seg, bus, slot, func, align_order, count;
>   	resource_size_t align = 0;
>   	char *p;
> +	bool invalid = false;
>
> +#ifdef PCIBIOS_MIN_ALIGNMENT
> +	align = PCIBIOS_MIN_ALIGNMENT;
> +	*resize = false;
> +#endif
>   	spin_lock(&resource_alignment_lock);
>   	p = resource_alignment_param;
>   	while (*p) {
> @@ -4622,16 +4627,49 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>   		} else {
>   			align_order = -1;
>   		}
> -		if (sscanf(p, "%x:%x:%x.%x%n",
> -			&seg, &bus, &slot, &func, &count) != 4) {


I'd replace the above lines with:

	char segstr[5] = "*", busstr[3] = "*";
	char slotstr[3] = "*", funstr[2] = "*";

	if (sscanf(p, "%4[^:]:%2[^:]:%2[^.].%1s%n",
		&segstr, &busstr, &slotstr, &funcstr, &count) != 4) {


and add some wrapper like:

static bool glob_match_hex(char const *pat, int val)
{
	char valstr[5]; /* 5 should be enough for PCI */
	snprintf(valstr, sizeof(valstr) - 1, "%4x", val);
	return glob_match(pat, valstr);
}

and then use glob_match_hex() (or make a wrapper like above on top of 
fnmatch()), this would enable better mask handling.

If anyone finds this useful (which I am not sure about).




> +		if (p[0] == '*' && p[1] == ':') {
> +			seg = -1;
> +			count = 1;
> +		} else if (sscanf(p, "%x%n", &seg, &count) != 1 ||
> +				p[count] != ':') {
> +			invalid = true;
> +			break;
> +		}
> +		p += count + 1;
> +		if (*p == '*') {
> +			bus = -1;
> +			count = 1;
> +		} else if (sscanf(p, "%x%n", &bus, &count) != 1) {
> +			invalid = true;
> +			break;
> +		}
> +		p += count;
> +		if (*p == '.') {
> +			slot = bus;
> +			bus = seg;
>   			seg = 0;
> -			if (sscanf(p, "%x:%x.%x%n",
> -					&bus, &slot, &func, &count) != 3) {
> -				/* Invalid format */
> -				printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
> -					p);
> +			p++;
> +		} else if (*p == ':') {
> +			p++;
> +			if (p[0] == '*' && p[1] == '.') {
> +				slot = -1;
> +				count = 1;
> +			} else if (sscanf(p, "%x%n", &slot, &count) != 1 ||
> +					p[count] != '.') {
> +				invalid = true;
>   				break;
>   			}
> +			p += count + 1;
> +		} else {
> +			invalid = true;
> +			break;
> +		}
> +		if (*p == '*') {
> +			func = -1;
> +			count = 1;
> +		} else if (sscanf(p, "%x%n", &func, &count) != 1) {
> +			invalid = true;
> +			break;
>   		}
>   		p += count;
>   		if (!strncmp(p, ":noresize", 9)) {
> @@ -4639,10 +4677,10 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>   			p += 9;
>   		} else
>   			*resize = true;
> -		if (seg == pci_domain_nr(dev->bus) &&
> -			bus == dev->bus->number &&
> -			slot == PCI_SLOT(dev->devfn) &&
> -			func == PCI_FUNC(dev->devfn)) {
> +		if ((seg == pci_domain_nr(dev->bus) || seg == -1) &&
> +			(bus == dev->bus->number || bus == -1) &&
> +			(slot == PCI_SLOT(dev->devfn) || slot == -1) &&
> +			(func == PCI_FUNC(dev->devfn) || func == -1)) {
>   			if (align_order == -1)
>   				align = PAGE_SIZE;
>   			else
> @@ -4652,10 +4690,14 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>   		}
>   		if (*p != ';' && *p != ',') {
>   			/* End of param or invalid format */
> +			invalid = true;
>   			break;
>   		}
>   		p++;
>   	}
> +	if (invalid)
> +		printk(KERN_ERR "PCI: Can't parse resource_alignment parameter:%s\n",
> +				p);
>   	spin_unlock(&resource_alignment_lock);
>   	return align;
>   }
>


-- 
Alexey
