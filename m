Return-Path: <robherring2@gmail.com>
Received: from mail-wg0-x230.google.com (mail-wg0-x230.google.com
 [IPv6:2a00:1450:400c:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452211A0B82
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Apr 2015 05:49:24 +1000 (AEST)
Received: by wgbdm7 with SMTP id dm7so711065wgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2015 12:49:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
 <1427857069-6789-2-git-send-email-yinghai@kernel.org>
 <20150403193234.GD10892@google.com>
 <20150403205201.GF10892@google.com>
 <CAE9FiQVqAEvoLDRZMcNFki0gLMQiyQd2VYivjAh1teRGeuNwBw@mail.gmail.com>
 <CAErSpo55rpO6SNeY57zZ8ah0PJ3eY+-L92vUJwYiRn4tCfLtJg@mail.gmail.com>
From: Rob Herring <robherring2@gmail.com>
Date: Sat, 4 Apr 2015 14:48:59 -0500
Message-ID: <CAL_JsqJyH==8OtkcU8_P4_47U6qe6FYqj-WUZ20_Y+iC_OF4_w@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Introduce pci_bus_addr_t
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Ahern <david.ahern@oracle.com>, Russell King <linux@arm.linux.org.uk>,
 Sam Ravnborg <sam@ravnborg.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Yinghai Lu <yinghai@kernel.org>, David Miller <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 4, 2015 at 7:46 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Apr 3, 2015 at 10:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Apr 3, 2015 at 1:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> [+cc Sam (commented on previous versions), Russell, linux-arm-kernel, Ralf,
>>> linux-mips, Ben, linuxppc-dev, x86]
>>>
>>> On Fri, Apr 03, 2015 at 02:32:34PM -0500, Bjorn Helgaas wrote:
>>>> On Tue, Mar 31, 2015 at 07:57:47PM -0700, Yinghai Lu wrote:
>>>> > David Ahern found commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows
>>>> > to fit in upstream windows") broke booting on sparc/T5-8.
>>>> >
>>>> > In the boot log, there is
>>>> >   pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
>>>> >   0x110204000)
>>>> > but that only could happen when dma_addr_t is 32-bit.
>>>> >
>>>> > According to David Miller, all DMA occurs behind an IOMMU and these
>>>> > IOMMUs only support 32-bit addressing, therefore dma_addr_t is
>>>> > 32-bit on sparc64.
>>>> >
>>>> > Let's introduce pci_bus_addr_t instead of using dma_addr_t,
>>>> > and pci_bus_addr_t will be 64-bit on 64-bit platform or X86_PAE.
>>>> >
>>>> > Fixes: commit d63e2e1f3df9 ("sparc/PCI: Clip bridge windows to fit in upstream windows")
>>>> > Fixes: commit 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
>>>> > Link: http://lkml.kernel.org/r/CAE9FiQU1gJY1LYrxs+ma5LCTEEe4xmtjRG0aXJ9K_Tsu+m9Wuw@mail.gmail.com
>>>> > Reported-by: David Ahern <david.ahern@oracle.com>
>>>> > Tested-by: David Ahern <david.ahern@oracle.com>
>>>> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>>> > Cc: <stable@vger.kernel.org> #3.19
>>>> > ---
>>>> >  drivers/pci/Kconfig |  4 ++++
>>>> >  drivers/pci/bus.c   | 10 +++++-----
>>>> >  drivers/pci/probe.c | 12 ++++++------
>>>> >  include/linux/pci.h | 12 +++++++++---
>>>> >  4 files changed, 24 insertions(+), 14 deletions(-)
>>>> >
>>>> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>>> > index 7a8f1c5..6a5a269 100644
>>>> > --- a/drivers/pci/Kconfig
>>>> > +++ b/drivers/pci/Kconfig
>>>> > @@ -1,6 +1,10 @@
>>>> >  #
>>>> >  # PCI configuration
>>>> >  #
>>>> > +config PCI_BUS_ADDR_T_64BIT
>>>> > +   def_bool y if (64BIT || X86_PAE)
>>>> > +   depends on PCI
>>>>
>>>> We're going to use pci_bus_addr_t in some places where we previously used
>>>> dma_addr_t, which means pci_bus_addr_t should be at least as large as
>>>> dma_addr_t.  Can you enforce that directly, e.g., with something like this?
>>>>
>>>>     def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT || X86_PAE)
>>
>> then should use
>>
>> def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
>
> OK, would you mind updating this series, incorporating the doc
> updates, and reposting it?
>
> I think there's still an unresolved question about the OF parsing code.

Got a pointer to what that is? I'll take a guess. Generally, we make
the parsing code independent of the kernel addr sizes and use u64
types. The DT sizes and kernel sizes are not always aligned. For
example, an LPAE capable platform running a non-LPAE kernel build.

Rob

>
> Bjorn
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
