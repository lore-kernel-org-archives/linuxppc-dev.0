Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 81226B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Jun 2010 23:48:15 +1000 (EST)
Message-ID: <4C23621D.1010600@mlbassoc.com>
Date: Thu, 24 Jun 2010 07:48:13 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Chuck Meade <chuck@ThePTRGroup.com>
Subject: Re: Continuing UCC UART woes
References: <4C2355A3.8000708@mlbassoc.com> <4C235FD0.4040608@ThePTRGroup.com>
In-Reply-To: <4C235FD0.4040608@ThePTRGroup.com>
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

On 06/24/2010 07:38 AM, Chuck Meade wrote:
>> One thing I noticed is that the firmware patch seems quite old.
>> I got the firmware package from http://opensource.freescale.com/firmware/
>> We were also told (by FreeScale) to look at
>> https://www.freescale.com/webapp/Download?colCode=QERAMPKG
>>
>> Looking at these two packages, it's unclear that they match.  Certainly
>> the dates are very different:
>>
>> [gthomas@hermes 8358]$ ls -l fsl_qe_ucode QERAMPKG
>> fsl_qe_ucode:
>> total 16
>> -rw-rw-r-- 1 gthomas gthomas 5940 2007-12-10 14:39
>> fsl_qe_ucode_uart_8360_21.bin
>> -rw-r--r-- 1 gthomas gthomas 7892 2007-11-30 10:14 license.txt
>>
>> QERAMPKG:
>> total 972
>> -rw-rw-r-- 1 gthomas gthomas 132915 2009-04-07 14:04
>> SlowProtocols_8323rev11.c
>> -rw-rw-r-- 1 gthomas gthomas 455446 2009-09-16 15:44
>> Soft_UART_Microcode_Rel_0_1_2.pdf
>> -rw-rw-r-- 1 gthomas gthomas  29379 2009-09-16 15:49
>> Soft_UART_mpc8360_r2.0.h
>> -rw-rw-r-- 1 gthomas gthomas  29379 2009-09-16 15:14
>> Soft_UART_mpc8360_r2.1.h
>> -rw-rw-r-- 1 gthomas gthomas  29379 2009-09-16 15:14
>> Soft_UART_mpc8568_r1.1.h
>> -rw-rw-r-- 1 gthomas gthomas 105457 2009-09-16 16:00 SWUART_8360rev20.c
>> -rw-rw-r-- 1 gthomas gthomas  34689 2009-09-16 15:32 SWUART_8360rev20.srx
>> -rw-rw-r-- 1 gthomas gthomas 105318 2009-09-16 15:59 SWUART_8360rev21.c
>> -rw-rw-r-- 1 gthomas gthomas  34689 2009-09-16 15:14 SWUART_8360rev21.srx
>>
>> Any ideas what I'm doing wrong?
>
> Hi Gary,
>
> At http://opensource.freescale.com/firmware there is a script make_qe_firmware.py
> that Timur said would create a firmware binary out of the firmware header file.
> I have not used this script, since the existing binary worked for me.
> But I am using only one UCC UART, so you are going beyond what I have done
> with this firmware.
>
> You can try to use that script to create a newer firmware binary from the header
> in that zip file.  Make sure you are using the right one for your silicon rev.

As reported, I've done this - no change.

>
> You can use strategic printk debugging in the ucc_uart.c driver to determine
> on the Tx side what is going wrong.  For example, after you tell the QE to
> output chars, wait a bit and printk out the BD.  See if the QE is clearing the
> READY bit in that BD.  That will tell you if the QE is even processing the BD
> or not.

I've also done this - the descriptors are set up, never touched by the QE
Odd that input always works, output works only very rarely.

> Also ensure that for all these other UCCs that you are using that the CD, CTS,
> RTS pins are set up as plain GPIO pins if you do not have them hooked up to
> actual CD, CTS, RTS signals.  If you *are* using HW flow control, probe all the
> signals to be sure they are all correct.

No change whether these pins are configured or not.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
