Return-Path: <chuck@ThePTRGroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id DCEA1B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 01:53:10 +1000 (EST)
Received: from [10.11.13.50] (unknown [10.11.13.50])
	by mail.theptrgroup.com (Postfix) with ESMTP id B1FB61E002
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Jun 2010 11:53:09 -0400 (EDT)
Message-ID: <4C20DC5F.80902@ThePTRGroup.com>
Date: Tue, 22 Jun 2010 11:53:03 -0400
From: Chuck Meade <chuck@ThePTRGroup.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com>	<4C20D27D.5000503@ThePTRGroup.com>	<4C20D34A.80202@mlbassoc.com>	<4C20D699.1080404@ThePTRGroup.com>
	<4C20DABA.5030301@mlbassoc.com>
In-Reply-To: <4C20DABA.5030301@mlbassoc.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Sure.  Go to opensource.freescale.com/firmware and download (for your
>> MPC8358)
>> the 8360 soft UART mode microcode patch.  You will need to know if
>> your CPU
>> is a 2.0 or 2.1 silicon, since there is a different microcode patch
>> for each.
>>
>> Then in the kernel config I believe I included CONFIG_FW_LOADER and
>> CONFIG_HOTPLUG
>> (one of those may have autoselected the other).
>>
>> Make sure in your ucc_uart.c driver that soft uart mode is enabled.
>>
>> At boot time, the driver will kick off a 10 second timer that will expect
>> the microcode patch to be loaded before the end of that 10 secs.
>>
>> Very early in my boot sequence, I have a startup script send the
>> microcode patch
>> file to the driver through the firmware-loading sysfs entry.  But you
>> need to
>> be aware that the UCC number in the sysfs path will be offset by one. 
>> Since you
>> are using UCC3, you should use a '2' in the path as shown below.  This
>> sequence
>> worked for me (I changed the number for you to '2' in my command
>> sequence, since
>> I use a different UCC):
>>
>>    echo 1>  /sys/class/firmware/fsl-ucc-uart2/loading
>>    cat /root/fsl_qe_ucode_uart_8360_21.bin> 
>> /sys/class/firmware/fsl-ucc-uart2/data
>>    echo 0>  /sys/class/firmware/fsl-ucc-uart2/loading
>>
>> Note that the above presupposes you are using the file for silicon 2.1.
>> Also presupposes that you have put the microcode under your rootfs
>> /root directory.
> 
> Thanks, I'll give this a try.  When I download the firmware this way,
> do I need to follow the directions in
>   Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/firmware.txt

I did not do that, and I have it running here.  I will say though that I
hardcoded the driver to run in soft UART mode.  You will need to at least
add the appropriate line to your dts to get the driver to operate in
Soft UART mode.

I hardcoded mine because I had to backport this UCC UART driver to an older
Linux kernel, and that kernel was from before dts existed.

Add whatever you need to your dts to make it run in soft UART mode and get
the firmware loaded.  Use two different BRGs for tx and rx.  Make sure your
BRG choice is valid for your UCC3.

I believe that the UCC UART support has not had too much use so far, but
I do have it working (in that older kernel after backporting).

Chuck Meade
chuck@ThePTRGroup.com
