Date: Thu, 27 Mar 2003 15:01:15 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
In-reply-to: <3E825307.8000404@slac.stanford.edu>
To: Till Straumann <strauman@SLAC.Stanford.EDU>,
	Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLGEIBFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Great job Till!

I have forwarded this to Motorola. Primarly I want to know if never silicon
behaves the same way.

> Here are the (corrected) results of some tests I ran
> on my mpc860t (XPC860TZP50B5 / 3J21M).
>
> I use mpc8bug on a FADS board to load motorola's
> 'init860.S' example. The example was slightly
> modified to include (1-4 use differend EAs, of
> course).
>
>    1) a 1:1 TLB to DRAM, R/W access (already present
>       in the vanilla code)
>
>    2) a TLB to map DRAM r/w, caching inhibited
>
>    3) a TLB to map DRAM r/o (behavior is the same
>       if for a 'real RO' mapping and for a RW
>       mapping with the 'CHANGE' bit cleared).
>
>    4) a TLB to map DRAM r/w but with the VALID
>       bit clear.

Level1 or Level2 valid bit? Does it matter which one?

>
>    5) a 'main' routine which executes the
>       instructions under test through one
>       of the aforementioned TLB mappings.

hmm, I wonder if the Guarded bit would change anything.

>
> Here's what I found (I generally load bogus
> values into MD_EPN/DAR prior to executing any
> of the cache instructions under test)
>
> A) All of dcbf, dcbi, dcbst, dcbz (dcbt and dcbtst
>      should not and do not) raise a TLBMiss exception
>      with MD_EPN set correctly but failing to set DAR
>      (i.e. DAR is left unmodified) when trying to
>      access an address not in any of the TLBs.
>
> B) All of dcbf, dcbi, dcbst, dcbz raise a TLBError
>      exception when accessing mapping 4) [as they should].
>
>      Unlike regular loads/stores (non-cache instructions),
>      NEITHER DAR not MD_EPN are set, however. DAR is left
>      unmodified MD_EPN has the CASID and reserved bits set/reset
>      but leaves the EPN bits unmodified.
>
> C) dcbi and dcbz behave like B) when accessing
>      through 3) [RO mapping]. Note that dcbf and
>      dcbst are treated like 'loads' and hence do
>      not raise a TLBError due to protection violation
>      (in accordance with the docs).
>
> D) dcbz through a cache inhibited mapping (2)) does
>      not generate an alignment exception but
>      transparently clears the memory (either is allowed
>      according to the PPC specs).
>
> Note: dcbt/dcbtst were included in all of the
> tests but they never raise an exception which is
> the correct behavior.
>
> CONCLUSION:
>
>    - the only correct workaround for TLBError
>      is the one I suggested earlier: TLBError
>      handler has to inspect the faulting opcode
>      and fixup DAR and MD_EPN based on the GPR
>      values if the faulting instruction is any
>      of dcbf, dcbi, dcbst or dcbz.
>      Performance of this solution could be
>      improved (eliminate opcode-check in the
>      vast majority of the cases) by storing
>      a 'tag' value in DAR.

Yes, but I can't even figure out how to read the instruction. Address translation
is off so how do I figure out the real address?

hmm, what does mfspr r20, M_TWB return when MD_EPN contain old EPN? The old EPN in
MD_EPN or does M_TWB know real address that generated the fault?

>
>    - the aforementioned workaround also could handle
>      TLBMiss - although performance is more of an issue
>      there.
>      Alternatives are
>         a) Jocke's workaround: copy MD_EPN -> DAR
>            (disadvantage: DAR truncated to page
>            boundary).
>         b) like a) but do this only if the faulting
>            instruction is any dcbxx (disadvantage:
>            performance loss).
>         c) merge significant bits of MD_EPN into
>            DAR. Thus, only cache instructions suffer
>            from an incorrect page offset in DAR.
>            At the same time, it's cheap.
>
> Based on the analysis, I'd suggest to implement
> the 'fixup' workaround for TLBError and alternative
> c) for TLBMiss

The TLB Miss workaround only needs to be in the slow path(DataAccess path) and
yes, it should be alternative c).


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
