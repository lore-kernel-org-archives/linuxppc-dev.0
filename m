Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 63C0168336
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 01:56:34 +1000 (EST)
In-Reply-To: <000d01c5c378$64610960$5201a8c0@GEG2400>
References: <000d01c5c378$64610960$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <5D83ECE9-90F7-4BE2-B173-C20CB868E9F6@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Tue, 27 Sep 2005 10:56:36 -0500
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


On Sep 27, 2005, at 10:30, G=E9rard Gu=E9vel wrote:

>
> Hi,
>
> I am running a Linux 2.6.9 on a MPC8541 custom board.
>
> I would like to run a user application which contains
> some SPE code extracted from a freescale library.
>
> I compiled the kernel with the CONFIG_SPE set to yes.
> The application also compiles and I can run it on the
> board.
>
> But it seems the SPE bit from the MSR register
> is not set when the process runs.
>
> I tried to use a call to the enable_kernel_spe function
> to force the bit, but it is always erased by the kernel (??)
> when scheduling task and never set again.
>
> Must I compile the application with some special flags
> to instruct the kernel I want to use SPE ?


You say the application runs, right?  So what made you check the SPE =20
bit state?  The kernel keeps SPE disabled by default so it doesn't =20
have to save the upper 32 bits of the registers every context =20
switch.  When a process uses SPE for the first time, an exception is =20
triggered, the kernel enables SPE for that process, and then that =20
process should be able to use SPE every time it gets cpu time.

How are you determining that the SPE bit is not set?  Is your =20
application not executing the SPE instructions?

Andy
