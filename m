Date: Tue, 08 Apr 2003 12:47:55 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
In-reply-to: <IGEFJKJNHJDCBKALBJLLEELJFLAA.joakim.tjernlund@lumentis.se>
To: Till Straumann <strauman@SLAC.Stanford.EDU>,
	Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLMENAFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > CONCLUSION:
> >
> >    - the only correct workaround for TLBError
> >      is the one I suggested earlier: TLBError
> >      handler has to inspect the faulting opcode
> >      and fixup DAR and MD_EPN based on the GPR
> >      values if the faulting instruction is any
> >      of dcbf, dcbi, dcbst or dcbz.
> >      Performance of this solution could be
> >      improved (eliminate opcode-check in the
> >      vast majority of the cases) by storing
> >      a 'tag' value in DAR.
>
> Hi again
>
> I have been hacking on dcxx address decoder. Since assembler isn't my cup of tea,
> I used C mixed with asm statements. The resulting assembler isn't too bad either IMHO.
>
> To load the instruction into r21 I used:
> 	mfspr	r20,SRR0
> 	andis.	r21, r20, 0x8000
> 	beq	56f
>
> 	tophys(r21, r20)
> 	lwz r21,0(r21)
> 56:
> This only works for kernel space addresses. I can't figure out how to get to user space as well.
> I can live without user space anyway.
>
> I am still thinking about the 'tag'. Since MD_EPN isn't set as well as DAR I thinking about
> storing a tag in MD_EPN instead. It's less intrusive. Maybe it is enough to look at the
> valid bit in MD_EPN?
>
> What do you think so far?
> Oh, this should go into the DTLB Error handler.

Me again :-)

I have completed and tested my workaround for the dcbx instructions. The workaround
handles ALL dcbx instructions, ANY register combination and works both on
kernel space and user space addresses.

During my testing I noticed that memory allocated with
consistent_alloc() or kmalloc() causes TLB Errors while vmalloc does not.
If this is true(confirmation wanted) it means that the current impl. is fragile.
Both dcbi and dcbz does not update DAR when a TLB error happens, instead the
the previous setting of DAR is used.

I also did some benchmarking using copy_page(dcbz enabled) and memcpy to
memory allocated with kmalloc and/or vmalloc. copy_page is about 30% faster
than memcpy even with the workaround applied.

There is one concern left. I tag DAR with a "bad address" just before
an exception is finished. In the TLB Error handler, check if DAR contains
the "bad address" and if it does then the workaround is executed.

I need find all exceptions where DAR is modified. Currently I tag DAR in
STD_EXCEPTON(), DataAccess, Alignment, DataStore and DataTLBError. Have I
missed any exception?

I also need to find a good value for the "bad address". Currently I use
0xdead0000 and that's probably not the best value.
Tagging with this value is a two instruction operation:
   lis r20, 0xdead
   mtspr DAR, r20

The test in the TLB Error handler look like this:
  mfspr r21, DAR
  lis   r20, 0xdead
  cmpw	cr0, r20, r21
  beq-  <workaround address>

I can not see any reason NOT to add this to the BK tree(after some minor modifications
mentioned above and a little cleanup). It fixes a real problem
with dcbi and as a bonus you can use dcbz as well since it has the same problem
that dcbi has and the fix is generic for all dcbx instructions. Dan's argument,
"It's interesting to watch these hacks, but I can't justify
 complicating a general purpose function with more bus cycles by
 emulating a functional problem.  By not using these instructions
 we have a working system that costs just a few more cycles during
 the memory copy/zero operations.  If we had _working_ dcbz
 instructions, it would be a gain to use them, but from a system
 perspective it is going to cost more to "fix up" these than
 the code that already exists", is not valid. This is not only about
optimization, but also about correctness of existing use of dcbi.

Patch against 2.4.20 devel available on request until I have cleaned it up a little.

   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
