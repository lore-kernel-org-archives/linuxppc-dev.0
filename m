Return-Path: <Joao.Pinto@synopsys.com>
Received: from smtprelay.synopsys.com (us01smtprelay-2.synopsys.com
 [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v28ZY6yRFzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 21:28:04 +1100 (AEDT)
Subject: Re: [PATCH 11/37] PCI: dwc: Split pcie-designware.c into host and
 core files
To: Kishon Vijay Abraham I <kishon@ti.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han
 <jingoohan1@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-12-git-send-email-kishon@ti.com>
 <4a89fb45-af84-d660-5ef0-12227b141cda@synopsys.com> <587C586C.6070003@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <0a16c862-312f-655e-3d66-bdb0c1f78584@synopsys.com>
Date: Mon, 16 Jan 2017 10:27:58 +0000
MIME-Version: 1.0
In-Reply-To: <587C586C.6070003@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Às 5:21 AM de 1/16/2017, Kishon Vijay Abraham I escreveu:
> Hi Joao,
> 
> On Friday 13 January 2017 10:19 PM, Joao Pinto wrote:
>> Às 10:26 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
>>> Split pcie-designware.c into pcie-designware-host.c that contains
>>> the host specific parts of the driver and pcie-designware.c that
>>> contains the parts used by both host driver and endpoint driver.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  drivers/pci/dwc/Makefile               |    2 +-
>>>  drivers/pci/dwc/pcie-designware-host.c |  619 ++++++++++++++++++++++++++++++++
>>>  drivers/pci/dwc/pcie-designware.c      |  613 +------------------------------
>>>  drivers/pci/dwc/pcie-designware.h      |    8 +
>>>  4 files changed, 634 insertions(+), 608 deletions(-)
>>>  create mode 100644 drivers/pci/dwc/pcie-designware-host.c
>>>
>>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>>> index 7d27c14..3b57e55 100644
>>> --- a/drivers/pci/dwc/Makefile
>>> +++ b/drivers/pci/dwc/Makefile
>>> @@ -1,4 +1,4 @@
>>
>> (snip...)
>>
>>> -static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>>> -				      int type, u64 cpu_addr, u64 pci_addr,
>>> -				      u32 size)
>>> +void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
>>> +			       u64 cpu_addr, u64 pci_addr, u32 size)
>>>  {
>>>  	u32 retries, val;
>>>  
>>> @@ -186,220 +151,6 @@ static void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>>>  	dev_err(pci->dev, "iATU is not being enabled\n");
>>>  }
>>
>> Kishon, iATU only makes sense in The Root Complex (host), so it should be inside
>> the pcie-designware-host.
> 
> That is not true. Outbound ATU should be programmed to access host side buffers
> and inbound ATU should be programmed for the host to access EP mem space.

Sorry, I was not clear enough. What I was trying to suggest is, since the ATU
programming is done by the host, wouldn't be better to include it in the
pcie-designware-host? It is just an architectural detail.

> 
> Thanks
> Kishon
> 
