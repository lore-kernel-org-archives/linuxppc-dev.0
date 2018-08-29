Return-Path: <srs0=r+d+=lm=emerson.com=sachin.gosavi@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 420jqq70NxzF1RN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 21:21:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 420jqq65RKz8tRT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 21:21:27 +1000 (AEST)
Received: from n7.nabble.com (n7.nabble.com [162.253.133.57])
 by ozlabs.org (Postfix) with ESMTP id 420jqq21TNz9rvt
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 21:21:27 +1000 (AEST)
Received: from n7.nabble.com (localhost [127.0.0.1])
 by n7.nabble.com (Postfix) with ESMTP id A54616A0DE0A
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2018 04:14:36 -0700 (MST)
Date: Wed, 29 Aug 2018 04:14:36 -0700 (MST)
From: sgosavi1 <Sachin.Gosavi@emerson.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1535541276673-0.post@n7.nabble.com>
Subject: Not able to boot cuImage for the target board with MPC8270 processor
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Everyone,

Recently I took up the activity of switching from Linux kernel version
2.16.17.6 to version 4.15.13 for our target board that supports MPC8270
PowerPC  processor. As I understand the new kernel version mandates the use
of a device tree in the kernel source to describe the target board. I took
"pq2fads.dts" as a reference device tree file to port the kernel for our
target board. The U-boot version 1.1.4 that we currently use does not
support passing of device tree to kernel but passes the board information
structure used by the older kernel version we have been using so far. 

As suggested in the new kernel documentation I created a "cuImage.pq2fads"
kernel image which has the device tree and boot wrapper code embedded in the
image to support booting the kernel with older U-boot. However I am unable
to see any debug output after the dump from U-boot below.

U-Boot 1.1.4 (Aug  2 2018 - 06:27:35)

MPC8260 Reset Status: Check Stop, External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x1a, busdf 5, cpmdf 1, plldf 0, pllmf 5
 - vco_out  394515000, scc_clk   98628750, brg_clk   24657187
 - cpu_clk  263010000, cpm_clk  197257500, bus_clk   65752500

CPU:   MPC8260 (HiP7 Rev 14, Mask 1.0 1K49M) at 263.010 MHz
Board: Emerson MPC8270 CCB
Init SRAM, CAN, DOC...
UPMA done. Setting up UPMB
Rev B or Higher CPU Board
I2C:   ready
DRAM:  128 MB
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC1 ETHERNET, FCC2 ETHERNET
Press <foo> to STOP AUTOBOOT!:autoboot in 2 seconds
## Booting image at ffc00000 ...
   Image Name:   Linux-4.15.13
   Created:      2018-08-29  10:45:39 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1166748 Bytes =  1.1 MB
   Load Address: 00400000
   Entry Point:  004007a4
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK


I also checked the kernel dump at location associated with "_log_buf" symbol
in the System.map file in RAM but did not get any debug info.

Please can anyone suggest if I am missing something here and how can I get
the debug output on my serial console during bootup.

Thanks,
Sachin.
 



--
Sent from: http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html
