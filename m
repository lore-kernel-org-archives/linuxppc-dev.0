Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 319C0DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Nov 2008 11:10:00 +1100 (EST)
In-Reply-To: <ed82fe3e0811070743l1e0f7430o6bbb2b3d5e5a446f@mail.gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Using DMA
MIME-Version: 1.0
Message-ID: <OFA76D8B60.24A9D6A0-ON882574FC.0082F8AB-882574FD.0000DE16@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Sun, 9 Nov 2008 16:09:51 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: timur.tabi@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> 
> The Elo device driver is an async DMA back-end driver.  That is, you
> don't communicate with that driver directly, you communicate with the
> async library (which is new - so you won't find it in LDD3).
> 

Okay, has anyone actually _used_ the Elo driver?  I can't get the probe 
function to run.  I get into of_fsl_dma_init(), but of_fsl_dma_probe() 
never executes.  I have CONFIG_DMADEVICES and CONFIG_FSL_DMA set in my 
.config, obviously since the init function runs.  Here's the relevant SOC 
portion of my device tree:

        soc8349@e0000000 {
                #address-cells = <1>;
                #size-cells = <1>;
                #interrupt-cells = <2>;
                device_type = "soc";
                ranges = <0 e0000000 00100000>;
                reg = <e0000000 00000200>;
                bus-frequency = <0>;                    // from bootloader

<<<<<<<<<<<<<<< snip >>>>>>>>>>>>>>>>>>>

                dma@82a8 {
                        #address-cells = <1>;
                        #size-cells = <1>;
                        compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
                        reg = <82a8 4>;
                        ranges = <0 8100 1a8>;
                        interrupt-parent = <&ipic>;
                        interrupts = <71 8>;
                        cell-index = <0>;
                        dma-channel@0 {
                                compatible = "fsl,mpc8349-dma-channel", 
"fsl,elo-dma-channel";
                                reg = <0 80>;
                                cell-index = <0>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                        dma-channel@80 {
                                compatible = "fsl,mpc8349-dma-channel", 
"fsl,elo-dma-channel";
                                reg = <80 80>;
                                cell-index = <1>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                        dma-channel@100 {
                                compatible = "fsl,mpc8349-dma-channel", 
"fsl,elo-dma-channel";
                                reg = <100 80>;
                                cell-index = <2>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                        dma-channel@180 {
                                compatible = "fsl,mpc8349-dma-channel", 
"fsl,elo-dma-channel";
                                reg = <180 28>;
                                cell-index = <3>;
                                interrupt-parent = <&ipic>;
                                interrupts = <71 8>;
                        };
                };
<<<<<<<<<<<<<< snip >>>>>>>>>>>>>>>>>>>>
        };

Is there something else I need to do?  Or is there something wrong with my 
device tree (always a possibility :)  ).  Any help is appreciated.

Thanks.

Bruce
