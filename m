Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63DBCDE240
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 06:27:44 +1000 (EST)
In-Reply-To: <49DF933F.7030101@freescale.com>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>	<1239167335.10104.26.camel@localhost>	<20090408055126.GG16602@bilbo.ozlabs.org>	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>	<20090409224553.GO16602@bilbo.ozlabs.org>	<20090410091149.5068d8e1.sfr@canb.auug.org.au>	<1AAD5906-66FA-4850-8C62-8C030816E44E@kernel.crashing.org>	<49DF89F7.2070403@freescale.com>
	<m2bpr4l5m0.fsf@igel.home> <49DF933F.7030101@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <63473184-83D7-44C0-80E0-35673075A7CD@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Date: Fri, 10 Apr 2009 22:28:28 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> The problem is that GCC does not give an error (only a warning)  
>>> even for
>>> things like this where it should be trivial to detect that the  
>>> usage *is*
>>> uninitialized, not just might be:
>>>
>>> int foo(void)
>>> {
>>>    int a;
>>>
>>>    return a;
>>> }
>> The compiler must not reject this code, because the undefined  
>> behavior
>> only occurs if executed.  There is no constraint violated.
>
> Fine (though GCC could have something similar to -Werror but more  
> limited in scope to the really serious stuff that *should* be  
> illegal even if it isn't), but it should at least be a separate  
> warning class.
>
> My point was to counter Segher's assertion that the compiler  
> currently gives an error on the obvious stuff.

I never said that, or didn't intend to anyway; what I was trying to say
is that the compiler makes a difference between cases where it knows
something is uninitialized vs. cases where it cannot prove either way:

$ cat mm.c
int bork(void)
{
         int a;

         return a;
}

int main(void)
{
         return bork();
}

$ powerpc-linux-gcc -Wall -W -Os -c mm.c
mm.c: In function 'bork':
mm.c:5: warning: 'a' is used uninitialized in this function

Note: _is_ used uninitialized, not "may be" like in cases where the  
compiler
isn't sure.

I don't know why this isn't an error; perhaps GCC does not assume main 
() to
always be executed.  I don't think it could prove much anything to be
executed in non-toy examples, anyway.


Segher
