Date: Sat, 22 Jan 2000 11:01:55 -0500 (EST)
From: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS6000 to G4 assembly changes
In-Reply-To: <Pine.HPX.4.10.10001221230260.18916-100000@gra-ux1.iram.es>
Message-ID: <Pine.SOL.3.96.1000122110042.17750A-100000@fitch.math.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you for the information. Most likely I won't be able to get it
working then.

Bob


On Sat, 22 Jan 2000, Gabriel Paubert wrote:

>
>
> On Sat, 22 Jan 2000, Robert Neugebauer wrote:
>
> >
> > I am not trying to build a cross compiler, I am not trying to build GCC.
> > My course at university uses its own compiler called uC++ (Micro C++).
> >
> > The compiler thus far only has the following targets that work:
> >         dmake sun-sparc-sunos
> >         dmake sun-sparc-svr4
> >         dmake sun-m68k-sunos
> >         dmake dec-ultrix-mips
> >         dmake dec-alpha
> >         dmake sgi-mips-r4000
> >         dmake sgi-mips-r3000
> >         dmake ibm-rs6000
> >         dmake hp-hppa
> >         dmake pc-i386-linux
> >         dmake gizmo
> >
> > By my knowledge rs6000 is a RISC based architecture, thus I tried to build
> > uC++ using the target ibm-rs6000. This resulted in an unrecognized opcode
> > movl during compilation.
>
> Then your compiler is seriously buggy since there is no such instruction
> in the RS6000 or PPC assembly. There significant differences between
> the architectures (for application level code) are:
>
> a) multiply and divides are different (not even the same opcode for most
> of them), the RS6000 has an MQ register for remainders and widening
> multiplies. The PPC does not have this register.
>
> b) all the extended shifts in the RS6000 which use the MQ register do not
> exist in the PPC architecture, so you have to synthesize multiword shifts
> (how to do this is documented in an appendix of the programmer's
> environment manual, see below).
>
> c) a few other oddball RS6000 instructions do not exist in the PPC:
> lscbx (that one was indeed very odd), doz, dozi, abs, nabs, rlmi, maskir,
> maskg, and I certainly forget a few more...
>
> d) the PPC has a full complement of single precision floating point
> operations, the RS6000 does not
>
> For a C compiler, a) is very important, b) affects only compilers which
> support 64 bit operations, c) the only critical instruction is abs which
> can be replaced with a simple sequence and d) can safely be ignored by
> performing all FP operations in double precision.
>
> For more information you can download the programming environments
> manuals from IBM or Motorola website:
>
> http://www.chips.ibm.com/techlib/products/powerpc/manuals/
> http://www.motorola.com/SPS/PowerPC/teksupport/teklibrary/index.html
>
> and if you are interested in improving your compiler, you might find the
> compiler writer's guide (link on IBM's website) interesting.
>
> 	Gabriel.
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
