Return-Path: <peter.ryser@xilinx.com>
Received: from mail17-ash-R.bigfish.com (mail-ash.bigfish.com [206.16.192.253])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4B341688DE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 03:38:30 +1100 (EST)
Received: from mail17-ash.bigfish.com (localhost.localdomain [127.0.0.1])
	by mail17-ash-R.bigfish.com (Postfix) with ESMTP id D1D6C3202FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 16:17:29 +0000 (UTC)
Received: from newsgate.xilinx.com (gateway4.xilinx.com [149.199.60.204])
	by mail17-ash.bigfish.com (Postfix) with ESMTP id 57F08320297
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 16:17:29 +0000 (UTC)
Received: from cliff.xilinx.com (cliff [149.199.38.103])
	by newsgate.xilinx.com (8.11.6p2/8.11.6) with ESMTP id jB8GHQe11784
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Dec 2005 08:17:26 -0800 (PST)
Received: from XSJ-EXCHVS1.xlnx.xilinx.com (localhost [127.0.0.1])
	by cliff.xilinx.com (8.12.9/8.11.6) with ESMTP id jB8GHHLY021715
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Dec 2005 08:17:26 -0800 (PST)
Message-ID: <43985BD5.9090505@xilinx.com>
Date: Thu, 08 Dec 2005 08:14:13 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Paulinha <gnathita@gmail.com>
References: <259581790512070010s3be8b3cfg6cfd17d2f503b0f7@mail.gmail.com>
In-Reply-To: <259581790512070010s3be8b3cfg6cfd17d2f503b0f7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux 2.4 on Xilinx ml403
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Make sure your system.mss contains something like:

BEGIN OS
 PARAMETER OS_NAME = linux_mvl31
 PARAMETER OS_VER = 1.01.a
 PARAMETER PROC_INSTANCE = ppc405_0
 PARAMETER MEM_SIZE = 0x4000000
 PARAMETER PLB_CLOCK_FREQ_HZ = 100000000
 PARAMETER connected_periphs = 
(RS232_Uart,IIC_EEPROM,SysACE_CompactFlash,Ethernet_MAC,opb_intc_0)
END

If it does not use XPS and in the menu select Platform Software 
Settings. Use linux as Operating System and linux_mvl31_v1_01_a as the 
MLD. The rerun the library generation. Also make sure that you have 
enabled the interrupts for System ACE CF in the hardware.

- Peter


Paulinha wrote:

> Hi all,
>
> I have been trying to run linux 2.4.26 on Virtex 4 for a while and 
> without success.
>
> I am trying to implement a simple design, with an UART, SystemACE and 
> everything interrupt driven. When I try to make bzImage, there is an 
> error in (SysACE) adapter.c file, because XPAR_INTC_0_SYSACE_0_VEC_ID 
> is not defined.
>
> I have applied the patch given by Xilinx for switching from the ml300 
> to the ml403, which copies the bsp, .config and xparameter files into 
> the kernel.
>
> I am stucked here, and do not know how to keep going from that.
> Could anyone help me a little bit?
>
> Thanks and have a good day!
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
