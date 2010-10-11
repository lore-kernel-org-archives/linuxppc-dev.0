Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (unknown [212.235.17.194])
	by ozlabs.org (Postfix) with SMTP id CF4D6B6EE9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2010 21:24:30 +1100 (EST)
Message-ID: <4CB2E517.8020401@extricom.com>
Date: Mon, 11 Oct 2010 12:21:11 +0200
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Freescale P2020 / 85xx PCIe and Advance Error Reporting (AER)
	service problem
References: <4CADBD7B.3000506@extricom.com> <1286756363.2463.517.camel@pasglop>
In-Reply-To: <1286756363.2463.517.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>  - pcie_portdrv_probe() will be called for every BRIDGE class PCI device. P2020 PCIe is a PCI-PCI BRIDGE class so no problem here. 
>>  - The code will continue to check that we have PCI_CAP_ID_EXP capability, which we have and continue to pcie_port_device_register().
>>  - Now ,the function pcie_port_device_register() will FAIL. It will fail because it will call assign_interrupt_mode(), return with PCIE_PORT_NO_IRQ, and giveup with a reasonable remark in the code
>> "/*
>>   * Don't use service devices that require interrupts if there is
>>   * no way to generate them.
>>   */"
>>
>> So now the question is why calling assign_interrupt_mode() with the P2020 PCIe ROOT device return empty? Well...
>>  - First assign_interrupt_mode() will test for PCIE_PORT_MSIX_MODE. Freescale PCIe does not support this...
>>  - Second attampt is made to discover PCIE_PORT_MSI_MODE, which Freescale should support but the PCIe PCI_CAP_ID_MSI capability is published on the device side of the bridge and NOT on the PCIe ROOT device, which is the one probed and thus fails.
>>  - Last it attempts to look at "dev->pin" in order to set PCIE_PORT_INTx_MODE. On top of being the less recommended way (the old way), The Freescale PCIE ROOT device pin is not set anywhere.
>>
>> Failing all those the probe fails and the AER service is not activated for the PCIE device.
>
> So the question boils down to how does the bridge generate the AER
> interrupts. This should be documented in the FSL docs no ? The MSI in
> the child/device should be unrelated (it's your device MSI) no ? So the
> question is where's the missing interrupt.
>
> If it's a SoC interrupt, coming from the device-tree, then perhaps the
> generic AER code should be extended to recognize those.
>
> Cheers,
> Ben.
>
I agree...

BUT if we take into consideration that:
1. Freescale is a serious dude in the hood and on the whole does a good 
job with its products and their Linux support.
2. The P2020 does state it has an MSI mechanism support (although one is 
not present as a PCIe capability header for some reason)
3. Errors in general and AER are major features in PCIe.
4. PCIe has been here quite a while and it is not new to Freescale or 
anyone else.
I am much more inclined to believe that I have missed something by a 
mile then that Freescale did. I just don't know what I am missing.

My device tree is a clone of "arch/ powerpc/ boot/ dts/ p2020rdb.dts"

It has a PCI node that looks like this:
----------------------------- snip -----------------------------
    pci0: pcie@ffe09000 {
        cell-index = <1>;
        compatible = "fsl,mpc8548-pcie";
        device_type = "pci";
        #interrupt-cells = <1>;
        #size-cells = <2>;
        #address-cells = <3>;
        reg = <0 0xffe09000 0 0x1000>;
        bus-range = <0 255>;
        ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
              0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
        clock-frequency = <33333333>;
        interrupt-parent = <&mpic>;
        interrupts = <25 2>;
        interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
        interrupt-map = <
            /* IDSEL 0x0 */
            0000 0x0 0x0 0x1 &mpic 0x4 0x1
            0000 0x0 0x0 0x2 &mpic 0x5 0x1
            0000 0x0 0x0 0x3 &mpic 0x6 0x1
            0000 0x0 0x0 0x4 &mpic 0x7 0x1
            >;
        pcie@0 {
            reg = <0x0 0x0 0x0 0x0 0x0>;
            #size-cells = <2>;
            #address-cells = <3>;
            device_type = "pci";
            ranges = <0x2000000 0x0 0xa0000000
                  0x2000000 0x0 0xa0000000
                  0x0 0x20000000

                  0x1000000 0x0 0x0
                  0x1000000 0x0 0x0
                  0x0 0x100000>;
        };
    };
----------------------------- snap -----------------------------

and under "soc" it has an MSI node that looks like that:
----------------------------- snip -----------------------------
        msi@41600 {
            compatible = "fsl,p2020-msi", "fsl,mpic-msi";
            reg = <0x41600 0x80>;
            msi-available-ranges = <0 0x100>;
            interrupts = <
                0xe0 0
                0xe1 0
                0xe2 0
                0xe3 0
                0xe4 0
                0xe5 0
                0xe6 0
                0xe7 0>;
            interrupt-parent = <&mpic>;
        };
----------------------------- snap -----------------------------

-- Liberty
