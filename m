Return-Path: <dave.jiang@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by ozlabs.org (Postfix) with ESMTP id A487CDDDFE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 07:46:33 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so2002598wxd
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 12:46:32 -0800 (PST)
Message-ID: <8746466a0701161246wbe4268esab51bc07a7efb2a3@mail.gmail.com>
Date: Tue, 16 Jan 2007 13:46:28 -0700
From: Dave <dave.jiang@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: EDAC platform devices for fsl_soc
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to write an EDAC driver for the mpc8560 board. I will need
to access the DDR error management registers, the L2 error management
registers, the PCI management registers, and also the related IRQs
(internal 0, 2, and 8). So I would like to insert some entries into
the 8560 fdt in order to parse them and map the hw irq to virq in
order to setup the platform device resources.

Below is what I was thinking the fdt should look like. Is that reasonable?

     soc8560@e0000000 {
        #address-cells = <1>;
        #size-cells = <1>;
        #interrupt-cells = <2>;
        device_type = "soc";
        ranges = <0 e0000000 00100000>;
        reg = <e0000000 00000200>;
        bus-frequency = <13ab6680>;

        dram_control@2000 {
            device_type = "edac";
            compatible = "85xx";
            reg = <2000 e5c>;
            linux,phandle = <2000>;
            interrupt-parent = <40000>;
            interrupts = <2 1>;
        };

        l2_error@20e00 {
            device_type = "edac";
            compatible = "85xx";
            reg = <20e00 5c>;
            linux,phandle = <20e00>;
            interrupt-parent = <40000>;
            interrupts = <0 1>;
        };

        pci_error@8e00 {
            device_type = "edac";
            compatible = "85xx";
            reg = <8e00 20>;
            linux,phandle = <8e00>;
            interrupt-parent = <40000>;
            interrupts = <8 0>;
        };
.....

-- 
-= Dave =-
