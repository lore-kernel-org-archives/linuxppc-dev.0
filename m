Return-Path: <kishon@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v21lq4d6ZzDqRT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 16:20:38 +1100 (AEDT)
Subject: Re: [PATCH 09/37] PCI: dwc: designware: Parse *num-lanes* property in
 dw_pcie_setup_rc
To: Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-10-git-send-email-kishon@ti.com>
 <c3c55af3-29d1-dc59-3ae4-9a4132c99092@synopsys.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <587C57FD.7050601@ti.com>
Date: Mon, 16 Jan 2017 10:49:57 +0530
MIME-Version: 1.0
In-Reply-To: <c3c55af3-29d1-dc59-3ae4-9a4132c99092@synopsys.com>
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

On Friday 13 January 2017 10:43 PM, Joao Pinto wrote:
> Hi,
> 
> Às 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
>> *num-lanes* dt property is parsed in dw_pcie_host_init. However
>> *num-lanes* property is applicable to both root complex mode and
>> endpoint mode. As a first step, move the parsing of this property
>> outside dw_pcie_host_init. This is in preparation for splitting
>> pcie-designware.c to pcie-designware.c and pcie-designware-host.c
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/pci/dwc/pcie-designware.c |   18 +++++++++++-------
>>  drivers/pci/dwc/pcie-designware.h |    1 -
>>  2 files changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
>> index 00a0fdc..89cdb6b 100644
>> --- a/drivers/pci/dwc/pcie-designware.c
>> +++ b/drivers/pci/dwc/pcie-designware.c
>> @@ -551,10 +551,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  		}
>>  	}
>>  
>> -	ret = of_property_read_u32(np, "num-lanes", &pci->lanes);
>> -	if (ret)
>> -		pci->lanes = 0;
>> -
>>  	ret = of_property_read_u32(np, "num-viewport", &pci->num_viewport);
>>  	if (ret)
>>  		pci->num_viewport = 2;
>> @@ -751,18 +747,26 @@ static int dw_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
>>  
>>  void dw_pcie_setup_rc(struct pcie_port *pp)
>>  {
>> +	int ret;
>> +	u32 lanes;
>>  	u32 val;
>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct device *dev = pci->dev;
>> +	struct device_node *np = dev->of_node;
>>  
>>  	/* get iATU unroll support */
>>  	pci->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pci);
>>  	dev_dbg(pci->dev, "iATU unroll: %s\n",
>>  		pci->iatu_unroll_enabled ? "enabled" : "disabled");
>>  
>> +	ret = of_property_read_u32(np, "num-lanes", &lanes);
>> +	if (ret)
>> +		lanes = 0;
> 
> You moved from host_init to root complex setup function, which in my opinion did
> not improve (in this scope).
> 
> I suggest that instead of making so much intermediary patches, which is nice to
> understand your development sequence, but hard to review. Wouldn't be better to
> condense some of the patches? We would have a cloear vision of the final product :)

I thought the other way. If squashing patches is easier to review, I'll do it.

Btw, thanks for reviewing.

Cheers
Kishon
