Return-Path: <robherring2@gmail.com>
Message-ID: <50C6078A.8080408@gmail.com>
Date: Mon, 10 Dec 2012 10:02:18 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: monstr@monstr.eu
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu>
In-Reply-To: <50C601B6.2080107@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2012 09:37 AM, Michal Simek wrote:
> On 12/10/2012 04:21 PM, Rob Herring wrote:
>> On 12/10/2012 09:05 AM, Michal Simek wrote:
>>> On 12/10/2012 03:26 PM, Rob Herring wrote:
>>>> On 12/10/2012 06:20 AM, Michal Simek wrote:
>>>>> Hi Grant and others,
>>>>>
>>>>> I have a question regarding number of cells in ranges property
>>>>> for pci and pcie nodes.
>>>>>
>>>>> Linux pci/pcie powerpc DTSes contain 7 cells (xpedite5370.dts,
>>>>> sequoia.dts, etc)
>>>>> but also 6 cells format too (mpc832x_mds.dts)
>>>>>
>>>>> Here is shown 6 cells ranges format and describe
>>>>> http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
>>>>>
>>>>> And also in documentation in the linux
>>>>> Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
>>>>>
>>>>> Both format uses:
>>>>> #size-cells = <2>;
>>>>> #address-cells = <3>;
>>>>>
>>>>> What is valid format?
>>>>
>>>> Both. 7 cells are valid when the host (parent) bus is 64-bit and 6
>>>> cells
>>>> are valid when the host bus is 32-bit. The ranges property is <<child
>>>> address> <parent address> <size>>. The parent address #address-cells is
>>>> taken from the parent node.
>>>
>>> Ok. Got it.
>>>
>>> Here is what we use on zynq and microblaze - both 32bit which should be
>>> fine.
>>>
>>>      ps7_axi_interconnect_0: axi@0 {
>>>          #address-cells = <1>;
>>>          #size-cells = <1>;
>>>          axi_pcie_0: axi-pcie@50000000 {
>>>              #address-cells = <3>;
>>>              #size-cells = <2>;
>>>              compatible = "xlnx,axi-pcie-1.05.a";
>>>              ranges = < 0x02000000 0 0x60000000 0x60000000 0
>>> 0x10000000 >;
>>>              ...
>>>          }
>>>      }
>>>
>>> What I am wondering is pci_process_bridge_OF_ranges() at
>>> arch/powerpc/kernel/pci-common.c
>>> where there are used some hardcoded values which should be probably
>>> loaded from device-tree.
>>>
>>> For example:
>>> 683         int np = pna + 5;
>>> ...
>>> 702                 pci_addr = of_read_number(ranges + 1, 2);
>>> 703                 cpu_addr = of_translate_address(dev, ranges + 3);
>>> 704                 size = of_read_number(ranges + pna + 3, 2);
>>
>> These would always be correct whether you have 6 or 7 cells. pna is the
>> parent bus address cells size. The pci address is fixed at 3 cells.
> 
> Sorry for my pci ignorance (have never got hw for mb/zynq)
> I just want to get better overview how we should we our drivers to be
> compatible.
> 
> Does it mean that pci is supposed be always 64 bit wide?
> And there is no option to have just 32bit values.

That's what the DT documentation says.

BTW, you can use 2 cells even if you only have a 32-bit bus.

> 
>>> Unfortunately we have copied it to microblaze.
>>
>> I look at the PCI DT code in powerpc and see a whole bunch of code that
>> seems like it should be common. The different per arch pci structs
>> complicates that. No one has really gotten to looking at PCI DT on ARM
>> yet except you and Thierry for Tegra. We definitely don't want to create
>> a 3rd copy. Starting the process of moving it to something like
>> drivers/pci/pci-of.c would be great.
> 
> We have done pcie working on zynq and the same pcie host is working on
> Microblaze too.
> There are just small differences. That's why I have sent another email
> ("Sharing PCIE driver between Microblaze and Arm zynq") to find out
> proper location.

Yes, I've followed the thread. There are lots of areas for consolidation
with PCIe hosts both across architectures and within ARM. There are
multiple people using DW PCIe IP although not upstream yet that I'm
aware of.

Rob

> 
> PCI: Microblaze shares almost the same code with powerpc that's why I am
> definitely open
> to move this code out of architecture.
> 
> Thanks,
> Michal
> 
> 
> 
