Date: Wed, 26 Mar 2003 14:42:45 -0800
From: Till Straumann <strauman@SLAC.Stanford.EDU>
Subject: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
To: Dan Malek <dan@embeddededge.com>, joakim.tjernlund@lumentis.se
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3E822CE5.5020100@slac.stanford.edu>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
References: <IGEFJKJNHJDCBKALBJLLGEHAFLAA.joakim.tjernlund@lumentis.se>
 <3E810DA7.1060605@slac.stanford.edu> <3E81C4B3.2080006@embeddededge.com>
 <3E81ED56.7050105@slac.stanford.edu> <3E81FA3A.9010306@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here are the results of some tests I ran
on my mpc860t (XPC860TZP50B5 / 3J21M).

I use mpc8bug on a FADS board to load motorola's
'init860.S' example. The example was slightly
modified to include (1-4 use differend EAs, of
course).

  1) a 1:1 TLB to DRAM, R/W access (already present
     in the vanilla code)

  2) a TLB to map DRAM r/w, caching inhibited

  3) a TLB to map DRAM r/o (behavior is the same
     if for a 'real RO' mapping and for a RW
     mapping with the 'CHANGE' bit cleared).

  4) a TLB to map DRAM r/w but with the VALID
     bit clear.

  5) a 'main' routine which executes the
     instructions under test through one
     of the aforementioned TLB mappings.

Here's what I found (I generally load bogus
values into MD_EPN/DAR prior to executing any
of the cache instructions under test)

A) All of dcbf, dcbi, dcbst, dcbz (dcbt and dcbtst
    should not and do not) raise a TLBMiss exception
    with MD_EPN set correctly but failing to set DAR
    (i.e. DAR is left unmodified) when trying to
    access an address not in any of the TLBs.

B) All of dcbf, dcbi, dcbst, dcbz raise a TLBError
    exception when accessing mapping 4) [as they should].

    Unlike regular loads/stores (non-cache instructions),
    DAR is NOT SET, however (i.e. left unmodified).
    MD_EPN is set to 0x00000000 which does NOT point to
    the faulting EA.

C) dcbi and dcbz behave like B) when accessing
    through 3) [RO mapping]. Note that dcbf and
    dcbst are treated like 'loads' and hence do
    not raise a TLBError due to protection violation
    (in accordance with the docs).

D) dcbz through a cache inhibited mapping (2)) does
    not generate an alignment exception but
    transparently clears the memory (either is allowed
    according to the PPC specs).

Note: dcbt/dcbtst were included in all of the
tests but they never raise an exception which is
the correct behavior.

CONCLUSION:

  - the only correct workaround for TLBError
    is the one I suggested earlier: TLBError
    handler has to inspect the faulting opcode
    and fixup DAR and MD_EPN based on the GPR
    values if the faulting instruction is any
    of dcbf, dcbi, dcbst or dcbz.
    Performance of this solution could be
    improved (eliminate opcode-check in the
    vast majority of the cases) by storing
    a 'tag' value in DAR.

  - the aforementioned workaround also could handle
    TLBMiss - although performance is more of an issue
    there.
    Alternatives are
       a) Jocke's workaround: copy MD_EPN -> DAR
          (disadvantage: DAR truncated to page
          boundary).
       b) like a) but do this only if the faulting
          instruction is any dcbxx (disadvantage:
          performance loss).
       c) merge significant bits of MD_EPN into
          DAR. Thus, only cache instructions suffer
          from an incorrect page offset in DAR.
          At the same time, it's cheap.

Based on the analysis, I'd suggest to implement
the 'fixup' workaround for TLBError and alternative
c) for TLBMiss

-- Till

PS. due to unclear re-distribution terms of init860.S,
I refrain from appending it to this message. Send me
email for details about the test software.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
