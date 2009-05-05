Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 01379DDDA2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 22:55:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MSR_SPE - being turned off...
Date: Tue, 5 May 2009 08:56:33 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
In-Reply-To: <D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
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

Hi Kumar/Michael...

Sorry, I really didn't explain myself very well...

The Problem (answer to Michael):
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
We started using a new compiler that upon -O2 optimization - added
heavy SPE related instructions into our applications (where the older
compiler might not use as many). Once this was done, we started=20
experiencing problems with data being 'shifted' and/or corrupted=20
throughout the applications which didn't immediately cause problems,
but either scribbled on someone else's memory and/or bad results...
We knew where one of the offending scribbles started (by the shifting=20
by 1 byte of a structure) and found by comparing binaries with 'older'
compiler vs. this one that the only major difference was the 'density'=20
of the SPE instructions...

As to your question, Kumar:=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Naively, I explicitly enabled the SPE in a BSP 'early_init' program=20
(as well as enabling Machine Checks) - which is what I meant by
Enabling SPE...

Michael explained that it is 'normal' if we asynchronously polled=20
the MSR (in an application and/or in the kernel) that it might be=20
disabled at the moment, but that you do a 'lazy switch' that=20
enables it...and gets turned on when an SPE exception comes in...

...ok...I can live with that...

-------where I was really going---------

This is where I was trying to go. A developer at our company (who no
longer works for us) - did some research/development on the SPE=20
functionality, in the hopes that we could create an optimized library.
The results were successful, but because of some of the restrictions=20
(including 8 byte alignment for some instructions) - we decided not
to incorporate this library into our application(s)

But, this developer in his results, indicated that he believed our
kernels were NOT properly saving/restoring the upper 32bits of the=20
GPR (which can/will be used in the SPE instructions)... Thus, if the
upper 32bits were not saved (and restored when the application got
the SPE to operate on)...then, he thought there would be problems.
He unfortunately, was unable to finish his work and fix these 'bugs'
before he left our company...

Again, I am only going on his results, and not my own investigations
(I am not sure where to start to find this problem to begin with)...

So, I was REALLY asking - has anybody else run into this type of
problem,=20
and/or the Linux community has recognized this problem and has fixed
this?

------

I hope I am a little clearer in the history / and outline of the=20
problem I am trying to solve this time?

Thanks in advance!

Tom Morrison


>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Tuesday, May 05, 2009 7:08 AM
>> To: Morrison, Tom
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: MSR_SPE - being turned off...
>>=20
>>=20
>> On May 4, 2009, at 5:25 PM, Morrison, Tom wrote:
>>=20
>> > I have both a MPC8548 SBC and MPC8572 system that are running
>> > different flavors of the
>> > same Linux - 2.6.23.
>> >
>> > I explicitly am turning it on very early on. Later, I have an
>> > application that is compiled
>> > with SPE instructions (e.g.: evstdd) , and there is where the
>> > problems happen. If I explicitly
>> > make sure there are NO SPE instructions in the application, nothing
>> > bad happens!
>> >
>> > I am polling the MSR - and it seems the SPE is turned OFF?
>> >
>> > What have I done wrong and/or has there been fixes in later kernels
>> > that I should be aware of that might help this issue?
>>=20
>> Can you explain what you mean by explicitly am turning it on very
>> early on.
>>=20
>> I can't think of anything that has changed w/regards to SPE handling.
>>=20
>> - k
