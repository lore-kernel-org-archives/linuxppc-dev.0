Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B497CDDDA1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 10:01:39 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: MSR_SPE - being turned off... 
In-reply-to: <BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com> 
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
Date: Wed, 06 May 2009 10:01:39 +1000
Message-ID: <13221.1241568099@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi Kumar/Michael...
> 
> Sorry, I really didn't explain myself very well...
> 
> The Problem (answer to Michael):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D=3D=3D=3D=3D=3D
> We started using a new compiler that upon -O2 optimization - added
> heavy SPE related instructions into our applications (where the older
> compiler might not use as many). Once this was done, we started=20
> experiencing problems with data being 'shifted' and/or corrupted=20
> throughout the applications which didn't immediately cause problems,
> but either scribbled on someone else's memory and/or bad results...
> We knew where one of the offending scribbles started (by the shifting=20
> by 1 byte of a structure) and found by comparing binaries with 'older'
> compiler vs. this one that the only major difference was the 'density'=20
> of the SPE instructions...
> 
> As to your question, Kumar:=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
> =3D=3D
> Naively, I explicitly enabled the SPE in a BSP 'early_init' program=20
> (as well as enabling Machine Checks) - which is what I meant by
> Enabling SPE...

Yeah, you don't want to do this.  It'll potentially break your
application.

I'm not that familiar with the CPU you are using but I'm guessing that
you can't write the MSR from user space anyway.

> Michael explained that it is 'normal' if we asynchronously polled
> the MSR (in an application and/or in the kernel) that it might be
> disabled at the moment, but that you do a 'lazy switch' that=20
> enables it...and gets turned on when an SPE exception comes in...
> 
> ...ok...I can live with that...
> 
> -------where I was really going---------
> 
> This is where I was trying to go. A developer at our company (who no
> longer works for us) - did some research/development on the SPE=20
> functionality, in the hopes that we could create an optimized library.
> The results were successful, but because of some of the restrictions=20
> (including 8 byte alignment for some instructions) - we decided not
> to incorporate this library into our application(s)
> 
> But, this developer in his results, indicated that he believed our
> kernels were NOT properly saving/restoring the upper 32bits of the
> GPR (which can/will be used in the SPE instructions)... Thus, if the
> upper 32bits were not saved (and restored when the application got
> the SPE to operate on)...then, he thought there would be problems.
> He unfortunately, was unable to finish his work and fix these 'bugs'
> before he left our company...
> 
> Again, I am only going on his results, and not my own investigations
> (I am not sure where to start to find this problem to begin with)...
> 
> So, I was REALLY asking - has anybody else run into this type of
> problem, and/or the Linux community has recognized this problem and
> has fixed this?

If GPRs where getting corrupted in userspace, that would be a serious
bug and would be noticed by someone pretty quickly.

We'd really need a test case to get anywhere with this report.  

Mikey
