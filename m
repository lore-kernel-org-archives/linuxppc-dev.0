Message-Id: <5.1.0.14.0.20010817164756.00ab8b40@spudcentral.com>
Date: Fri, 17 Aug 2001 16:54:00 -0600
To: Mark Hatle <fray@mvista.com>
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: init fails w/ new build of gcc & glibc
Cc: Mark Pilon <mark.pilon@minolta-qms.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3B7D9921.8CB7F6AE@mvista.com>
References: <3B7D82D5.DD98A109@minolta-qms.com>
 <5.1.0.14.0.20010817160848.00abfec0@spudcentral.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:22 PM 8/17/2001 -0500, Mark Hatle wrote:
>> Mark,
>>
>> You mentioned these two exclusive ABIs a couple days ago. If you want to compile the
>> toolchain and the kernel correctly to insure run-time compatibility (in my case for 8xx),
>> would you do this
>>
>> for kernel fp emulation
>> compile kernel with CONFIG_MATH_EMULATION=y, (do you use -msoft-float while compiling
>> kernel?)
>> then compile the toolchain without -msoft-float
>
>Use the kernel parameters as they stand, I wouldn't mess with them....
>(floating point is not supposed to happen in the kernel anyway, and when
>it does it's almost always assembly that is trapped anyway.)
>
>> or
>>
>> for soft-floating point - no kernel emulation
>> compile kernel CONFIG_MATH_EMULATION is not set (do you use -msoft-float while compiling kernel?)
>> then compile the toolchain with -msoft-float
>
>Basically.. One thing to keep in mind on the 8xx (due to cache line
>size) it'll never truely be compatable with the rest of the PPC world.
>But on a processor like the 405 it "can be" compatable using the
>CONFIG_MATH_EMULATION.  The catch is that you have a lot more overhead
>doing emulation.... (The emulation itself is pretty fast, certainly no
>slower then the software code invoked in -msoft-float..)  However, you
>have much more context switching over head and possible cache
>invalidation.  Also, your software could be using floating point
>registers w/o you expliciting using float's or double's due to gcc
>optimizations to argument passing.  All in all you will have a penalty
>for using hard floating point on a soft-floating point architecture.
>
>This is the reason that MontaVista has chosen to go the route of
>soft-float...





To summarize for me (and others), "leave kernel parameters as they stand" means

CONFIG_MATH_EMULATION=y and compile with -msoft-float

"MontaVista has chosen to go the route of soft-float..." means that MontaVista's tools are compiled with -msoft-float and --without-fp. I should compile my apps and toolchain (or use MV's) the same way.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
