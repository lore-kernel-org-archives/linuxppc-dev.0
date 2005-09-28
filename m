Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 320F0683F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 01:32:01 +1000 (EST)
In-Reply-To: <003201c5c402$fb80d430$5201a8c0@GEG2400>
References: <003201c5c402$fb80d430$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <AD2A3D43-57D8-4198-BAD3-FB5E3B549361@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Wed, 28 Sep 2005 10:32:02 -0500
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


On Sep 28, 2005, at 03:02, G=E9rard Gu=E9vel wrote:

>
> Andy,
>
>
>> Your driver runs in kernel space.  The kernel has the SPE bit off.
>> The MSR state is process-specific.  If the code executes, the
>> MSR bit
>> is set.  Why do you want to see if the bit is set?
>>
>
> OK, this is a bad idea to use a driver to check the msr register.
>
> I don't especially want to see if the bit is set, I just want
> to improve the board performance for a Linux application :-).
>
> To check the performance, I used the Dhrystone 2.1 benchmark with
> the standard glibc (strcpy, strcmp, ...) on one part, and with
> the freescale SPE library on the other part (vstrcpy, vstrcmp, ...).
>
> I already verified in the binary elf file that the right functions are
> called.
> When I run the benchmark, I get the same MIPS with and without SPE =20
> code.

Hmm... This is very strange, because Dhrystone is exactly the =20
benchmark this was tested on.  How did you determine that the SPE =20
functions are called?


> I ran the same benchmark on the same board without OS,
> with a personal pseudo glibc, I have the same MIPS as under Linux,
> with the freescale library, I gain 40% of perf.
>
> That's I want to retreive with the Linux OS.

I'm not sure why you aren't seeing a performance gain, but I assure =20
you that, if SPE instructions weren't working, Dhrystone would =20
crash.  The only other possibility I can think of is that the SPE =20
versions of the functions aren't being called.=
