Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id 0FB09DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 12:44:03 +1100 (EST)
Message-ID: <405889728.25141@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: "Scott Wood" <scottwood@freescale.com>
Date: Wed, 19 Mar 2008 09:22:08 +0800
Subject: Re: Hi,friends, the question about the u-boot and device tree?
Content-Type: text/plain
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,Scott

My board is MPC8360EMDS, my bootm command is "bootm uImage ramdisk_ppc
mpc836x_mds.dtb", I used the MPC8360E_PB_K26_20071012-LTIB.iso to generate above
uImage, ramdisk_ppc,mpc836x_mds.dtb. 
 
If I fill the frequency to zero on mpc836x_mds.dts, then the linux-2.6.22 is
crashed, the output of serial is nothing. if I fill the right frequency value same
as the HRCW on mpc836x_mds.dts, the linux is normal. So I think if the frequency
is zero on mpc836x_mds.dts, the u-boot did not pass the right frequency value to
dtb.

I think maybe that we need to define some on u-boot, then the u-boot can pass the
parameter to linux dtb?


I also has another question, I modified the HRCW to config the cpu as 660/330/400
MHZ during power on, I used the "clocks" command on u-boot to see that the clock
is real 660/330/400 MHZ, then I changed the frequency value on dts to 660/330/400,
after the bootm command, the linux was not carshed after serial configuration, but
the output is random.

"
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
[output from serial is random]
"

I have config the frequency both on HRCW and devie tree is the same, why the
frequency for serial on linux is not right?  Why the 528/260/400 is Ok, the
660/330/400 has problem on serial.

Thank you very much.





>From: Scott Wood <scottwood@freescale.com>
>Reply-To: 
>To:  <guojin02@tsinghua.org.cn>
>Subject: Re: Hi,friends, the question about the u-boot and device tree?
>Date:Tue, 18 Mar 2008 13:28:41 -0500
>
>On Thu, Mar 13, 2008 at 11:31:11PM +0800, wrote:
>> I make all the frequency(timebase-frequency;bus-frequency;clock-frequency)
value
>> on device tree file equal to zero, I think those frequency will filled by
u-boot
>> during bootm, but in fact, the u-boot did not fill any frequency. after bootm,
>> crashed. Why?
>
>What board?  Are you using a device-tree-aware u-boot and the three-argument
>form of bootm?  What sort of crash?  How do you know it's not filling in the
>frequencies?
>
>> Why so many document point out that the zero value will be filled by u-boot?
>
>Because it does. :-)
>If it's not doing so on your board, that needs to be fixed.
>
>-Scott
> 
