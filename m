Return-Path: <marco.stornelli@coritel.it>
Message-ID: <48CF59F5.10700@coritel.it>
Date: Tue, 16 Sep 2008 09:02:13 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Kevin Dockan <Kevin.Dockan@plexus.com>
Subject: Re: U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine
	checkexception
References: <C23D99018D2D774E8BF7B052C0009F1F0297BAA6@CO-MAIL-001.ms1.plexus.com>
In-Reply-To: <C23D99018D2D774E8BF7B052C0009F1F0297BAA6@CO-MAIL-001.ms1.plexus.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Try to check out the configuration of the outbound and inbound windows.

Regards.

Kevin Dockan ha scritto:
> Hello everybody, 
>
> I am trying to put into operation a proprietary board using a freescale MPC8641D. I use U-boot 1.3.0 and Linux kernel 2.6.25-11. 
> On one PCIe-bus I have a PEX8518 followed by a PEX8114. A USB-controller is connected to the 8114. 
>
>
>     +--------------------------+ 
>     |                          | 
>     |       MPC 8641 D         | 
>     |                          | 
>     +--------------------------+ 
>                   | 
>                PEX8518 <----------------- PCIe switch 
>                   | 
>                PEX8114 <----------------- PCIe to PCI bridge 
>                   | 
>                ISP1562 <----------------- USB controller 
>
> The PCIe-components are scanned correctly, resources (mem and IO) are assigned (correctly as far as I understand), 
> but on the first read access to a control register of the usb-device the kernel generates "Oops: Machine check, sig: 7 [#1]". 
> Writing to the same register does not produce an "Oops". 
>
> The PCIe bus is defined in dts file as follows (dump from U-boot): 
>
>     pcie@d4008000 { 
>         cell-index = <0>; 
>         compatible = "fsl,mpc8641-pcie"; 
>         device_type = "pci"; 
>         #interrupt-cells = <1>; 
>         #size-cells = <2>; 
>         #address-cells = <3>; 
>         reg = <1000>; 
>         bus-range = <4>; 
>         ranges = [02 00 00 00 00 00 00 00 40 00 00 00 40 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00]; 
>         clock-frequency = <1fca055>; 
>         interrupt-parent = <40000>; 
>         interrupts = <2>; 
>         interrupt-map-mask = [00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00 07]; 
>         interrupt-map = [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 04 00 00 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 04 00 00 00 00 00 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 04 00 00 00 00 00 03 00 00 00 01]; 
>         pcie@0 { 
>             reg = [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]; 
>             #size-cells = <2>; 
>             #address-cells = <3>; 
>             device_type = "pci"; 
>             ranges = [02 00 00 00 00 00 00 00 40 00 00 00 02 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 01 00 00 00 00 00 00 00 c0 00 00 00 00 00 00 00 00 10 00 00]; 
>         }; 
>     }; 
>     pcie@d4009000 { 
>         cell-index = <1>; 
>         compatible = "fsl,mpc8641-pcie"; 
>         device_type = "pci"; 
>         #interrupt-cells = <1>; 
>         #size-cells = <2>; 
>         #address-cells = <3>; 
>         reg = <1000>; 
>         bus-range = <6>; 
>         ranges = [02 00 00 00 00 00 00 00 80 00 00 00 80 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 c0 10 00 00 00 00 00 00 00 10 00 00]; 
>         clock-frequency = <1fca055>; 
>         interrupt-parent = <40000>; 
>         interrupts = <2>; 
>         interrupt-map-mask = [00 00 f8 00 00 00 00 00 00 00 00 00 00 00 00 07]; 
>         interrupt-map = [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 04 00 00 00 00 00 04 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 04 00 00 00 00 00 05 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 04 00 00 00 00 00 06 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 04 00 04 00 00 00 00 00 07 00 00 00 01]; 
>         pcie@0 { 
>             reg = [00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]; 
>             #size-cells = <2>; 
>             #address-cells = <3>; 
>             device_type = "pci"; 
>             ranges = [02 00 00 00 00 00 00 00 80 00 00 00 02 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00 40 00 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 01 00 00 00 00 00 00 00 c0 10 00 00 00 00 00 00 00 10 00 00]; 
>         }; 
>     }; 
>
> and here the output from kernel: 
>
> quirk_usb_handoff_ohci: resource start = 0x80000000, len = 0x00001000 
> quirk_usb_handoff_ohci: base = 0xe1056000, offset = 0x00000004 
> Machine check in kernel mode. 
> Caused by (from SRR1=149030): Transfer error ack signal 
> Oops: Machine check, sig: 7 [#1] 
> TAURUS 
> NIP: c0297f4c LR: c0297f44 CTR: c00115d0 
> REGS: df821e60 TRAP: 0200   Not tainted  (2.6.25.11) 
> MSR: 00149030 <EE,ME,IR,DR>  CR: 24000022  XER: 00000000 
> TASK = df805410[1] 'swapper' THREAD: df820000 
> GPR00: c0297f44 df821f10 df805410 00000042 00000001 00000001 00000000 00020000 
> GPR08: 00000036 c0333fe4 00006b61 c0360000 44000028 f7fbfffc 0fffac00 ffffffff 
> GPR16: 00800000 007fff00 df821f78 c02d0000 c0330000 c0330000 00000000 0fff5464 
> GPR24: c0330000 c02d0000 00000000 00000000 e1056000 df841218 df841218 e1056004 
> NIP [c0297f4c] 0xc0297f4c 
> LR [c0297f44] 0xc0297f44 
> Call Trace: 
> [df821f10] [c0297f44] 0xc0297f44 (unreliable) 
> [df821f40] [c01617dc] pci_fixup_device+0xec/0x140 
> [df821f60] [c0295ae0] 0xc0295ae0 
> [df821f70] [c030c198] kernel_init+0x9c/0x290 
> [df821ff0] [c0010a6c] kernel_thread+0x44/0x60 
> Instruction dump: 
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
> ---[ end trace 97996e90be8a1237 ]--- 
> Kernel panic - not syncing: Attempted to kill init! 
> Rebooting in 180 seconds.. 
>
> where resource start = 0x80000000 is the physical address of the USB controller, base = 0xe1056000 is the virtual address. 
>
> Does anyone know this kind of problem and can give me a hint. 
>
> Kind Regards, 
> Joachim 
>
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
