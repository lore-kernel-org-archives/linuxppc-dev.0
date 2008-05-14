Return-Path: <will.kritikos@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 7EFC8DDF46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 05:20:24 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so20311ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 12:20:21 -0700 (PDT)
Message-ID: <3ee6f9e50805141220g2440bd4am6846b416ce20f721@mail.gmail.com>
Date: Wed, 14 May 2008 15:20:21 -0400
From: "Will Kritikos" <will.kritikos@gmail.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: xilinx_hwicap driver problems
In-Reply-To: <20080514183731.04FE920053@mail163-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3ee6f9e50805140903o381346f5kddbce29a3d06ba1f@mail.gmail.com>
	<20080514183731.04FE920053@mail163-sin.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Steve,
Yes, this fixed that problem.  the following is now printed when
booting the kernel.

[    5.866230] icap icap.0: Xilinx icap port driver
[    5.866401] icap icap.0: ioremap 40200000 to c5000000 with size 10000

The icap is at address 0x40200000 on my system, so that seems correct.

However, when I copy partial bitstreams to the device, I get strange
results.  Here is what I am seeing.

 # mknod /dev/icap c 259 0
# cp opb_prr_0_lin_partial.bit /dev/icap
cp: write error: Bad address
# cp opb_prr_0_lin_partial.bit /dev/icap
[   66.566107] icap icap.0: Failed to open file#
# cp opb_prr_0_lin_partial.bit /dev/icap
#

I know that this file exists in the current directory, and is a
working partial bitstream.

Thanks for the help.
Will


On Wed, May 14, 2008 at 2:37 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> I bet you're using ARCH ppc...
>
> It looks like in arch/ppc/syslib/virtex_devices.c:
>
> #define XPAR_HWICAP(num) { \
>        .name = "xilinx_icap", \
>
> Should probably be:
>
> #define XPAR_HWICAP(num) { \
>        .name = "icap", \
>
> now.
>
> Can you make this change locally and verify that it solves the problem?
>
> Steve
>
>> -----Original Message-----
>> From: linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
>> bounces+stephen=neuendorffer.name@ozlabs.org] On Behalf Of Will
> Kritikos
>> Sent: Wednesday, May 14, 2008 9:03 AM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: xilinx_hwicap driver problems
>>
>> I am having some trouble using the xilinx_hwicap driver in Linux.
>> I am using version 2.6.24-rc8-xlnx of the Linux kernel from the Xilinx
>> GIT repository.
>> The xilinx_hwicap driver is statically compiled in - not a loadable
> module.
>> I am using the opb_hwicap device on a V4FX60 FPGA, Linux running on
> the PPC405.
>>
>> The driver successfully is initialized on boot - I added a printk to
>> the init function to verify this.   However, as far as I can tell, the
>> probe function is never called.  There is nothing in dmesg from the
>> icap driver.
>>
>> After boot, the following files exist in /sys
>>
>> /sys/bus/platform/xilinx_icap.0
>> /sys/bus/platform/drivers/icap/bind
>> /sys/bus/platform/drivers/icap/uevent
>> /sys/bus/platform/drivers/icap/unbind
>> /sys/devices/platform/xilinx_icap.0
>>
>> I can make a device node /dev/icap, major number 259 minor number 0,
>> and copy partial bitstreams to it, but again nothing happens, and no
>> output in dmesg.
>>
>> Any help is appreciated.  I am probably overlooking something simple.
>>
>> Thanks,
>> Will Kritikos
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>
>
