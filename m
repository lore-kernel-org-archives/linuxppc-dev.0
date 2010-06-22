Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 5882EB6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 23 Jun 2010 01:46:05 +1000 (EST)
Message-ID: <4C20DABA.5030301@mlbassoc.com>
Date: Tue, 22 Jun 2010 09:46:02 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Chuck Meade <chuck@ThePTRGroup.com>
Subject: Re: UCC UART
References: <4C20CECB.9050609@mlbassoc.com>
	<4C20D27D.5000503@ThePTRGroup.com>	<4C20D34A.80202@mlbassoc.com>
	<4C20D699.1080404@ThePTRGroup.com>
In-Reply-To: <4C20D699.1080404@ThePTRGroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2010 09:28 AM, Chuck Meade wrote:
>>> Hi Gary,
>>>
>>> According to the errata, it looks like the MPC8358 is subject to
>>> erratum QE_UART6.  You'll need to use soft UART mode and load the
>>> microcode patch.  Once that is done you will also need to use two
>>> different BRG's, one for tx and one for rx, since the soft UART mode
>>> microcode patch requires them to be set to different rates (I believe
>>> Rx is 16*baud under soft UART mode, and Tx is 1*baud).
>>
>> As I feared!  Can you tell me where/how to get the microcode patch?
>>
>>> Also, I don't know if it matters or not, but you should change your
>>> dts entry "serial@4000" to "serial@2200", just like you recently changed
>>> your "reg =" to 0x2200.
>>
>> I did that as soon as I sent this and saw the glaring inconsistency :-)
>>
>> Thanks
>
> Sure.  Go to opensource.freescale.com/firmware and download (for your MPC8358)
> the 8360 soft UART mode microcode patch.  You will need to know if your CPU
> is a 2.0 or 2.1 silicon, since there is a different microcode patch for each.
>
> Then in the kernel config I believe I included CONFIG_FW_LOADER and CONFIG_HOTPLUG
> (one of those may have autoselected the other).
>
> Make sure in your ucc_uart.c driver that soft uart mode is enabled.
>
> At boot time, the driver will kick off a 10 second timer that will expect
> the microcode patch to be loaded before the end of that 10 secs.
>
> Very early in my boot sequence, I have a startup script send the microcode patch
> file to the driver through the firmware-loading sysfs entry.  But you need to
> be aware that the UCC number in the sysfs path will be offset by one.  Since you
> are using UCC3, you should use a '2' in the path as shown below.  This sequence
> worked for me (I changed the number for you to '2' in my command sequence, since
> I use a different UCC):
>
>    echo 1>  /sys/class/firmware/fsl-ucc-uart2/loading
>    cat /root/fsl_qe_ucode_uart_8360_21.bin>  /sys/class/firmware/fsl-ucc-uart2/data
>    echo 0>  /sys/class/firmware/fsl-ucc-uart2/loading
>
> Note that the above presupposes you are using the file for silicon 2.1.
> Also presupposes that you have put the microcode under your rootfs /root directory.

Thanks, I'll give this a try.  When I download the firmware this way,
do I need to follow the directions in
   Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/firmware.txt

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
