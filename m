Date: Fri, 31 Mar 2000 17:18:54 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Josh Huber <huberj@wpi.edu>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gcc bug
In-Reply-To: <20000331092707.C354@wpi.edu>
Message-ID: <Pine.HPX.4.10.10003311657580.13384-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 31 Mar 2000, Josh Huber wrote:

>
> Interesting gcc bug here...

No.

>
> in both cases this should print 0xDEADBEEF, but in the second case, garbage
> is printed.
>
> main()
> {
> 	unsigned long t1 = 32;
> 	unsigned long long t2 = 64;
>
> 	printf("%x\n", 1 ? 0xDEADBEEF : t1);
> 	printf("%x\n", 1 ? 0xDEADBEEF : t2);
> }
>
> as expected, the 1 ? ... operation is optimized away, but the compiler seems
> to screw things up ...
>
> working case:
> 	li 4,15
> 	crxor 6,6,6
> 	bl printf
>
> failure case:
> 	li 5,0
> 	li 6,15
> 	crxor 6,6,6
> 	bl printf
>
> in the failure case, r4 is not loaded with anything, so this is were the
> garbage probably comes from.

The compiler is right, it chooses to pass the parameter as a long long
because of promotion rules among the types of the two expressions of a ? :
operator.

But you have to tell printf that the variable is a long long for varargs
in the library functions to find it, so replace your last statement with
printf("%llx\n", 1 ? 0xDEADBEEF : t2) and it will work properly.

There have been various bugs in this area with GCC on PPC, in some cases
due to varargs problems and the ABI actually took some time to stabilize
and to be properly implemeted IIRC. But in this case the compiler is
right: if it is a long long it can only be passed in r3:r4, r5:r6, r7:r8,
r9:r10, or on the stack.

Think at what happens if you don't tell that the argument is a long long
and you have more arguments after that one, everything will be off. And
it's not an endian issue either, it will just give the impression to work
when this is the last parameter on most little endian machines but the bug
would stil be here. Little endian is great to hide bugs, it's basically
the only "advantage" it has, and I regard this as a fundamental flaw.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
