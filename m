Message-ID: <3D3292B8.4020501@cambridgebroadband.com>
Date: Mon, 15 Jul 2002 10:15:36 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: rajib majila <rajib.majila@wipro.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with PPC 857 MMU
References: <72D09F11CC09B645ADE2890F6B442FD815E4A5@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Don't use zImage.initrd  PPCBoot won't understand that format.  Use mkimage to build either:

i) pImage - the stand alone kernel
ii) pRamdisk - a stand alone ramdisk
iii) pMulti - combined ramdisk/kernel

see SELF on ftp.denx.de/pub/LinuxPPC/usr/src/SELF for an example of how to build these

rajib majila wrote:

> Hi,
> We are trying to port mvista linux on Power PC 857T based board. We are loading the zImage.initrd file into 0x120000 address and our bootloader looks for an elf file at that address and then copies the kernel into 0x400000 adrress.
> After that the boot-loader jumps to that location and the pro-kernel starts uncompressing the kernel into 0x000000. After that it jumps to 0x0. From head_8xx.S, control is transffered to start_kernel by using a rfi instruction. Our kernel crashes at this location. We would like to hear about any such problem faced by any of you and how you solved the problem.
> We are downloading our boot-loader into the RAM (at 0x100000) using BDM and we run the boot-loader from there as we are
> Not able to write the on-board flash.
> All the addresses mentioned above RAM physical address.
> Thanx a lot in advance for your help.
> --Rajib
>
>
> ------------------------------------------------------------------------
>
> **************************Disclaimer**************************************************
>
>  Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged'
> and 'confidential' and intended for use only by the individual or entity to which it is
> addressed. You are notified that any use, copying or dissemination of the information
> contained in the E-MAIL in any manner whatsoever is strictly prohibited.
>
> ****************************************************************************************
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
