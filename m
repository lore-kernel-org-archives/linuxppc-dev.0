Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a00b3aba2034899@[192.168.0.2]>
In-Reply-To: <8x673uf29y.fsf@s53.informatik.uni-bremen.de>
References: Sacha Varma's message of Fri, 09 Jul 1999 12:29:35 +0100
 <3785DD1F.B853E731@ssl.co.uk>
Date: Fri, 9 Jul 1999 08:04:03 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Mike DeSimone <Hot-Wire@mail.utexas.edu>
Subject: Re: altivec
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> 2. would it be possible to trap altivec instructions on a non-altivec
>>    processor and reroute them through code using generic instructions?
>
>Possible - yes. Dead slow - absolutely. (Apple's simulator is strictly a
>development tool, nothing more.)

It shouldn't be dead slow, but it will be much slower than it would be on
Altivec processors (esp. since cache pipelining won't work nearly the
same).  Basically, most Altivec instructions can be replaced with for
loops.  So long as the iteration count of the loop is high, the overhead
from the illegal instruction trap activity should be minimized, so it
should boil down to about the same time as an assembly-coded loop.

>> 3. has anyone written a C library to simulate the altivec instructions?
>>
>Apple's simulator is the only such program I know of.

Something like this wouldn't be a library, it would have to be a kernel
addition.  A SIGILL handler just doesn't tell you enough to be able to
trap, analyze, and execute the instruction, then adjust the return pointer
and resume at the next instruction (and what about multiple Altivec
instructions in sequence?).

Personally, I'm looking for a LINPACK/CLASSPACK-like library that has an
Altivec and a non-Altivec version, so you can install whatever one is
appropriate on the machine. ^_^

I'm also wondering what has been done on this issue on the Intel side of
the fence, since KNI and 3Dnow! are similar to Altivec in concept and, at
least for 3Dnow!, implementation.
_________________________________________________________________________
                                __________
##   ##   ###   #####   #####   \********/   #####    ###    ##### ######
### ###  ## ##  ##  ## ##        \*/\/\*/    ##  ##  ## ##  ##     ##
#######  ## ##  #####   ####       /\/\      #####   ## ##   ####  ####
## # ## ####### ##  ##     ##      \**/      ##  ## #######     ## ##
##   ## ##   ## ##  ## #####        \/       #####  ##   ## #####  ######
_________________________________________________________________________
### Mike DeSimone ### Hot-Wire@mail.utexas.edu ### ares.marsbase.mars ###

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
