Date: Fri, 10 Sep 1999 10:43:27 -0700 (PDT)
From: Brad Midgley <brad@pht.com>
To: Sacha Varma <sacha@ssl.co.uk>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: altivec
In-Reply-To: <37D8F922.67F18F1F@ssl.co.uk>
Message-ID: <Pine.LNX.4.10.9909101030100.31612-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


urlich drepper put a lot of work into glibc2.1 and processor capabilities 
for exactly this problem.

so the RIGHT way to do this is by having two dynamic libraries, one for g4
and one for processors without altivec. the libraries just have to be put
in different places; glibc's search path is defined dynamically based on
processor capabilities so the appropriate shared library is linked in.

also, we can avoid the problem of binaries that blow up because they were
compiled for a different powerpc.

the assembler needs to know the new opcodes.

the kernel needs to know how & when to stack and unstack the altivec
registers.

for capabilities, i suspect we just need a little kernel work so the
kernel identifies altivec capability and makes that info available; then
glibc will need to know the symbolic name to look for.

the tough part will be designing a shared library and abstracting its
entry points with an eye on performance both with and without simd
capability. this is a problem that transcends altivec--it is relevant to
simd processor extensions on other architectures too.

> 3. People who want code that's optimised for G4 but also builds on G3
> You could use the altivec API when coding and then have a header (as I
>  #ifndef __VEC__
>    /* software emulation */
>  #else
>    /* use native instructions */
>  #endif


Brad
brad@pht.com | http://www.pht.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
