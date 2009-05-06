Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 86106DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 10:41:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MSR_SPE - being turned off... 
Date: Tue, 5 May 2009 20:42:15 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110C94528@EMPBEDEX.empirix.com>
In-Reply-To: <13221.1241568099@neuling.org>
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
	<13221.1241568099@neuling.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Michael Neuling" <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The test case we found is under 'extreme' duress=20
(intense loading on an MPC8572)...with many applications....
using A LOT of SPE instructions...

----

If you look at the context switch code (in latest code entry_32.S),=20
I believe the context switch performs a SAVE_NVGPR() - which in our=20
interpretation (in ppc_asm.h) - only saves the lower 32 bits of=20
the GPR (stw/lwz)...

This is only a guess of where the problem lies - based upon the single
SPE instruction that seemingly got misinterpreted, and shifts the data
By '1 byte' (and this code gets executed successfully MANY more times=20
at lower bandwidths - than failures seen at higher bandwidths)...

----

I am not sure how to proceed...we know how to recreate with our=20
application, but we would love to know how to change (safely)=20
the pt_regs to "long long" for the GPRs and then safely move
all 64bits of each GPR into these doubles...

We could then re-test and see if this helps?

Tom



>> -----Original Message-----
>> From: Michael Neuling [mailto:mikey@neuling.org]
>> Sent: Tuesday, May 05, 2009 8:02 PM
>> To: Morrison, Tom
>> Cc: Kumar Gala; linuxppc-dev@ozlabs.org
>> Subject: Re: MSR_SPE - being turned off...
>>=20
>> > Hi Kumar/Michael...
>> >
>> > Sorry, I really didn't explain myself very well...
>> >
>> > The Problem (answer to Michael):
>> >
>>
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D=
3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D
=3D
>> 3D=3D
>> > =3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D
>> > We started using a new compiler that upon -O2 optimization - added
>> > heavy SPE related instructions into our applications (where the
older
>> > compiler might not use as many). Once this was done, we =
started=3D20
>> > experiencing problems with data being 'shifted' and/or =
corrupted=3D20
>> > throughout the applications which didn't immediately cause
problems,
>> > but either scribbled on someone else's memory and/or bad results...
>> > We knew where one of the offending scribbles started (by the
>> shifting=3D20
>> > by 1 byte of a structure) and found by comparing binaries with
'older'
>> > compiler vs. this one that the only major difference was the
>> 'density'=3D20
>> > of the SPE instructions...
>> >
>> > As to your question, Kumar:=3D20
>> >
>>
=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D=
3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D=3D3D
=3D
>> 3D=3D
>> > =3D3D=3D3D
>> > Naively, I explicitly enabled the SPE in a BSP 'early_init'
program=3D20
>> > (as well as enabling Machine Checks) - which is what I meant by
>> > Enabling SPE...
>>=20
>> Yeah, you don't want to do this.  It'll potentially break your
>> application.
>>=20
>> I'm not that familiar with the CPU you are using but I'm guessing
that
>> you can't write the MSR from user space anyway.
>>=20
>> > Michael explained that it is 'normal' if we asynchronously polled
>> > the MSR (in an application and/or in the kernel) that it might be
>> > disabled at the moment, but that you do a 'lazy switch' that=3D20
>> > enables it...and gets turned on when an SPE exception comes in...
>> >
>> > ...ok...I can live with that...
>> >
>> > -------where I was really going---------
>> >
>> > This is where I was trying to go. A developer at our company (who
no
>> > longer works for us) - did some research/development on the =
SPE=3D20
>> > functionality, in the hopes that we could create an optimized
library.
>> > The results were successful, but because of some of the
restrictions=3D20
>> > (including 8 byte alignment for some instructions) - we decided not
>> > to incorporate this library into our application(s)
>> >
>> > But, this developer in his results, indicated that he believed our
>> > kernels were NOT properly saving/restoring the upper 32bits of the
>> > GPR (which can/will be used in the SPE instructions)... Thus, if
the
>> > upper 32bits were not saved (and restored when the application got
>> > the SPE to operate on)...then, he thought there would be problems.
>> > He unfortunately, was unable to finish his work and fix these
'bugs'
>> > before he left our company...
>> >
>> > Again, I am only going on his results, and not my own
investigations
>> > (I am not sure where to start to find this problem to begin
with)...
>> >
>> > So, I was REALLY asking - has anybody else run into this type of
>> > problem, and/or the Linux community has recognized this problem and
>> > has fixed this?
>>=20
>> If GPRs where getting corrupted in userspace, that would be a serious
>> bug and would be noticed by someone pretty quickly.
>>=20
>> We'd really need a test case to get anywhere with this report.
>>=20
>> Mikey
