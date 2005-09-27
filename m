Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7B779683E4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 04:50:41 +1000 (EST)
In-Reply-To: <000a01c5c38a$0f77cda0$5201a8c0@GEG2400>
References: <000a01c5c38a$0f77cda0$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <B310BDDC-A773-4D85-8314-F4320C5FA90C@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Tue, 27 Sep 2005 13:50:43 -0500
To: =?ISO-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 27, 2005, at 12:36, G=E9rard Gu=E9vel wrote:

>
>
>
>> You say the application runs, right?  So what made you check the SPE
>> bit state?  The kernel keeps SPE disabled by default so it doesn't
>> have to save the upper 32 bits of the registers every context
>> switch.  When a process uses SPE for the first time, an exception is
>> triggered, the kernel enables SPE for that process, and then that
>> process should be able to use SPE every time it gets cpu time.
>>
>> How are you determining that the SPE bit is not set?  Is your
>> application not executing the SPE instructions?
>>
>> Andy
>>
>
> Yes the application runs. I wrote a mini driver with an ioctl which
> performs a mfmsr() call and  returns the value to the user =20
> application.
> I called this ioctl at several times before and after executing SPE =20=

> code.
> I already tried to manually force the SPE bit with another ioctl which
> performs a enable_kernel_spe() call. The bit SPE is right set at =20
> this time
> but disappears later.

Your driver runs in kernel space.  The kernel has the SPE bit off.  =20
The MSR state is process-specific.  If the code executes, the MSR bit =20=

is set.  Why do you want to see if the bit is set?
