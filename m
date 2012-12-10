Return-Path: <monstr@monstr.eu>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 174FD2C023D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2012 02:05:40 +1100 (EST)
Received: by mail-la0-f51.google.com with SMTP id e4so1898820lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2012 07:05:36 -0800 (PST)
Message-ID: <50C5FA3E.9030303@monstr.eu>
Date: Mon, 10 Dec 2012 16:05:34 +0100
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
In-Reply-To: <50C5F11D.9060006@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 Rob Herring <rob.herring@calxeda.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/2012 03:26 PM, Rob Herring wrote:
> On 12/10/2012 06:20 AM, Michal Simek wrote:
>> Hi Grant and others,
>>
>> I have a question regarding number of cells in ranges property
>> for pci and pcie nodes.
>>
>> Linux pci/pcie powerpc DTSes contain 7 cells (xpedite5370.dts,
>> sequoia.dts, etc)
>> but also 6 cells format too (mpc832x_mds.dts)
>>
>> Here is shown 6 cells ranges format and describe
>> http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
>>
>> And also in documentation in the linux
>> Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
>>
>> Both format uses:
>> #size-cells = <2>;
>> #address-cells = <3>;
>>
>> What is valid format?
>
> Both. 7 cells are valid when the host (parent) bus is 64-bit and 6 cells
> are valid when the host bus is 32-bit. The ranges property is <<child
> address> <parent address> <size>>. The parent address #address-cells is
> taken from the parent node.

Ok. Got it.

Here is what we use on zynq and microblaze - both 32bit which should be fine.

	ps7_axi_interconnect_0: axi@0 {
		#address-cells = <1>;
		#size-cells = <1>;
		axi_pcie_0: axi-pcie@50000000 {
			#address-cells = <3>;
			#size-cells = <2>;
			compatible = "xlnx,axi-pcie-1.05.a";
			ranges = < 0x02000000 0 0x60000000 0x60000000 0 0x10000000 >;
			...
		}
	}

What I am wondering is pci_process_bridge_OF_ranges() at arch/powerpc/kernel/pci-common.c
where there are used some hardcoded values which should be probably loaded from device-tree.

For example:
683         int np = pna + 5;
...
702                 pci_addr = of_read_number(ranges + 1, 2);
703                 cpu_addr = of_translate_address(dev, ranges + 3);
704                 size = of_read_number(ranges + pna + 3, 2);


Unfortunately we have copied it to microblaze.

Thanks,
Michal






-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
