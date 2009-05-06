Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 38E9FDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 22:42:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MSR_SPE - being turned off... 
Date: Wed, 6 May 2009 08:42:42 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110C94615@EMPBEDEX.empirix.com>
In-Reply-To: <343F1A10-459E-4024-B0DD-ADB1D6DCDB9D@kernel.crashing.org>
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
	<13221.1241568099@neuling.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C94528@EMPBEDEX.empirix.com>
	<B5440F25-74DB-46BB-9374-837441826097@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D9010EEBF67D@EMPBEDEX.empirix.com>
	<343F1A10-459E-4024-B0DD-ADB1D6DCDB9D@kernel.crashing.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm sorry I forgot to put that, this issue was found with our=20
currently running kernel 2.6.23.final (what comes with the=20
Freescale LTIB BSP package dated 05/23/2009).=20

I am sorry if I don't understand your statement that the SMP might
be broken on this kernel, because I tried to analyze the kernel that=20
came with the latest BSP LTIB [ackage from Freescale (dated 12/18/2009=20
(where we got the 4.2.171 compiler from)), and the associated 'switch=20
context' code is exactly the same. Unfortunately, I have not started=20
the process of porting my current platform's BSP to this new kernel -=20
otherwise, I would have done the test on that platform (this also=20
requires a new version of u-boot in order to test correctly))..

I may have mis-interpreted something and/or I am sure I don't=20
understand everything about the SMP resource management (and=20
associated SPE management), so thank you for any insight you=20
may have on this front...

Tom

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Wednesday, May 06, 2009 8:32 AM
>> To: Morrison, Tom
>> Cc: Michael Neuling; linuxppc-dev@ozlabs.org
>> Subject: Re: MSR_SPE - being turned off...
>>=20
>>=20
>> On May 6, 2009, at 3:31 AM, Morrison, Tom wrote:
>>=20
>> > Kumar,
>> >
>> > What about the case of a context switch (i.e.: when things are
setup
>> > in registers for the SPE, but then a context switch happens before
>> > the SPE is executed)?
>>=20
>> context switches will be fine.  What we normally do is keep track of
>> which user app used SPE last and when some other app needs it we
clear
>> MSR_SPE for the old app, save its registers.  Than we load up the
>> registers for the new app and set MSR_SPE.  When the old app context
>> switches in it will get an SPE unavail exception at the point it
>> executes its next SPE insn and we will repeat the process.
>>=20
>> > As to load_up_spe & give_up_spe, it was pointed out to me tonight
by
>> > a co-worker
>> > to look at how things are saved in those routines, I definitely
will
>> > look at this again,
c>> > and see how it is done...
>> >
>> > This is happening for us on an 8572 SMP. We are trying to get it to
>> > happen
>> > on 8548 (and single core 8572), but we haven't been able to push
>> > this part
>> > of the application as hard as it is being pushed on 8572...but we
>> > will keep trying....
>>=20
>> Again, what kernel version for 8572?  Its possible old SMP kernels
are
>> broken on 8572.
>>=20
>> - k
>>=20
>> > ________________________________
>> >
<snip previous emails>
