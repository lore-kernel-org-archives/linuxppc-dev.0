Return-Path: <scottwood@freescale.com>
Date: Tue, 23 Sep 2008 13:43:14 -0500
From: Scott Wood <scottwood@freescale.com>
To: Exchange Admin <Exchange.Admin@plexus.com>
Subject: Re: FW: U-Boot 1.3.0 with Linux 2.6.25-11 on MPC8641D - Machine
	checkexception
Message-ID: <20080923184314.GB9984@ld0162-tx32.am.freescale.net>
References: <EB1085FDCA2C0D47832130CBDF9B36A00571CE0D@CO-MAIL-001.ms1.plexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EB1085FDCA2C0D47832130CBDF9B36A00571CE0D@CO-MAIL-001.ms1.plexus.com>
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

On Thu, Sep 18, 2008 at 08:50:33AM -0500, Exchange Admin wrote:
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

Check that the PCI controller config matches the MMIO region specified in
the device tree.

-Scott
