MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Possbile bug in hashtable.S : add_hash_page
Date: Mon, 28 Jun 2004 14:16:57 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB09228F@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Bob
> Doiron
> Sent: Monday, June 28, 2004 2:40 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Possbile bug in hashtable.S : add_hash_page
>
>
>
> Hi all. I'm working on an embedded ppc / linux project and
> I've run into
> what looks like a possible bug.
>
> On entry to add_hash_page the return address is stored on the
> stack like so:
>
>    _GLOBAL(add_hash_page)
>       mflr  r0
>       stw   r0,4(r1)  <-- store into *(r1) + 4
>
> 	< do some magic >
>       < then disabled interrupts >
>
>
> then upon return, it's retreived like so:
>
>       mtmsr	r10 <--- interrupts enabled here
> 	SYNC_601
> 	isync
>
> 	lwz	r0,4(r1) <-- read out *(r1) + 4
> 	mtlr	r0
> 	blr
>
>
> However - r1 remains unchanged within the function. As it
> stands, it seems
> that an interrupt could come along and scrible on our return
> address by
> using the unchanged stack pointer. What I've been seeing is
> that when under
> heavy interrupt load (nfs mount kernel compile for example)
> my ppc gets
> stuck in a "here: jump here" loop right at the blr
> instruction listed above.
> Inspecting the stack @ 4(r1) showed that it did in fact have
> the address of
> the blr instruction there, which led me to beleive that it is getting
> corrupted by an interrupt. Simply changing the "4" offset in
> 4(r1) to 12
> makes for a rock stable kernel, but it's a horrific hack.
>
> I guess my question is, am I missing something? or is this a
> real bug? My
> extremely limited ppc assembly tells seems to think that r1
> should be moved
> prior to using stack space...
>
> --Bob


Hi Bob,

I don't claim to be a PPC guru, but the PPC stack is rather unconventional.

This is based on the PowerPC Embedded Application Binary Interface (EABI) and ABI

The link register (return address) is stored in the second entry of the previous stack (frame pointers and return addresses from the current and previous stack frames get intertwined in a horribly confusing way). This is odd to us traditional stack types, but it is the PPC convention the caller has saved an unused 32 bit word on his stack for this.

The only problems you can run into is if someone doesn't reserve the extra room. This happens in power up initialization or hand written assembly language routines you need to have the reserved room in your stack and it is easy to forget. Your initial stack should have two entries of zeros (EABI stacks are 8 byte aligned - ABI conformant stacks are 16 byte aligned). One entry is reserved for the callee's return address and one entry terminates the back chain.

EABI:
          +----------+
     xxxC | 00000000 | reserved for callee's return address
r1-> xxx8 | 00000000 | back chain pointer (zeros terminates the back chain)
        ^
        +- address (least significant nibble)

ABI:
          +----------+
     xxxC | 00000000 | \ alignment padding
     xxx8 | 00000000 | /
     xxx4 | 00000000 | reserved for callee's return address
r1-> xxx0 | 00000000 | back chain pointer (zeros terminates the back chain)

In your hash example, I'm assuming it is a leaf function -- it doesn't call anybody else -- in which case it would not need to allocate any stack space for subroutines because it doesn't call any.

You will need to look at your interrupt handler support to see what the interrupt handler does with the stack.  This will be even more confusing and it is different for the different flavors of PPC processors (PPCs are application code compatible but not system level code compatible).

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
