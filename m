Return-Path: <B31939@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A388D2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 16:58:26 +1100 (EST)
Message-ID: <526A086E.305@freescale.com>
Date: Fri, 25 Oct 2013 13:58:06 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, Minghuan Lian
 <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH 02/12][v3] pci: fsl: add structure fsl_pci
References: <1382524894-15164-1-git-send-email-Minghuan.Lian@freescale.com>
 <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
 <2B28E421-9B64-4CEC-9E00-8893502CE12F@kernel.crashing.org>
In-Reply-To: <2B28E421-9B64-4CEC-9E00-8893502CE12F@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Zang Roy-R61911 <r61911@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

please see my comment inline.

On 10/24/2013 12:11 PM, Kumar Gala wrote:
> On Oct 23, 2013, at 5:41 AM, Minghuan Lian wrote:
>
>> PowerPC uses structure pci_controller to describe PCI controller,
>> but ARM uses structure pci_sys_data. In order to support PowerPC
>> and ARM simultaneously, the patch adds a structure fsl_pci that
>> contains most of the members of the pci_controller and pci_sys_data.
>> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
>> be implemented in architecture-specific PCI controller driver to
>> convert pci_controller or pci_sys_data to fsl_pci.
>>
>> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
>> ---
>> change log:
>> v1-v3:
>> Derived from http://patchwork.ozlabs.org/patch/278965/
>>
>> Based on upstream master.
>> Based on the discussion of RFC version here
>> http://patchwork.ozlabs.org/patch/274487/
>>
>> include/linux/fsl/pci-common.h | 41 +++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 41 insertions(+)
> NAK.
>
> We discussed this some at the ARM Summit this week and the feeling is we need to move to a common interface between the various ARCHs.
[Minghuan] Do you mean we will use the common interface instead of 
arch/powerpc/kernel/pci-common.c...
and arch/arm/kernel/bios32.c?  Who will do the code movement and when 
will the work be completed? The patches just move the common functions 
of FSL PCI controller operation which can be re-used by PowerPC and ARM. 
LS1 is coming, I worry about not having enough time to wait for the move 
is completed.

> - k
>
>> diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
>> index 5e4f683..e56a040 100644
>> --- a/include/linux/fsl/pci-common.h
>> +++ b/include/linux/fsl/pci-common.h
>> @@ -102,5 +102,46 @@ struct ccsr_pci {
>>
>> };
>>
>> +/*
>> + * Structure of a PCI controller (host bridge)
>> + */
>> +struct fsl_pci {
>> +	struct list_head node;
>> +	bool is_pcie;
>> +	struct device_node *dn;
>> +	struct device *dev;
>> +
>> +	int first_busno;
>> +	int last_busno;
>> +	int self_busno;
>> +	struct resource busn;
>> +
>> +	struct pci_ops *ops;
>> +	struct ccsr_pci __iomem *regs;
>> +
>> +	u32 indirect_type;
>> +
>> +	struct resource io_resource;
>> +	resource_size_t io_base_phys;
>> +	resource_size_t pci_io_size;
>> +
>> +	struct resource mem_resources[3];
>> +	resource_size_t mem_offset[3];
>> +
>> +	int global_number;	/* PCI domain number */
>> +
>> +	resource_size_t dma_window_base_cur;
>> +	resource_size_t dma_window_size;
>> +
>> +	void *sys;
>> +};
>> +
>> +/*
>> + * Convert architecture specific pci controller structure to fsl_pci
>> + * PowerPC uses structure pci_controller and ARM uses structure pci_sys_data
>> + * to describe pci controller.
>> + */
>> +extern struct fsl_pci *fsl_arch_sys_to_pci(void *sys);
>> +
>> #endif /* __PCI_COMMON_H */
>> #endif /* __KERNEL__ */
>> -- 
>> 1.8.1.2
>>
>
