Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85F011A03A0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 14:52:30 +1000 (AEST)
Date: Mon, 10 Aug 2015 14:52:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Bill Schmidt <wschmidt@us.ibm.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra
 <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org, Michael Gschwind
 <mkg@us.ibm.com>, paulus@samba.org, Ulrich Weigand
 <Ulrich.Weigand@de.ibm.com>
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
Message-ID: <20150810145228.3f78c8e4@kryten>
In-Reply-To: <OFD0811845.CF7950C1-ON86257E9A.002065FB-C1257E9A.00208EE6@us.ibm.com>
References: <20150805140300.218ef661@kryten>
 <20150805041928.GA32178@gate.crashing.org>
 <OFD0811845.CF7950C1-ON86257E9A.002065FB-C1257E9A.00208EE6@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bill, Segher,

> I agree with Segher.  We already know we have opportunities to do a
> better job with shrink-wrapping (pushing this kind of useless
> activity down past early exits), so having examples of code to look
> at to improve this would be useful.

I'll look out for specific examples. I noticed this one today when
analysing malloc(8). It is an instruction trace of _int_malloc().

The overall function is pretty huge, which I assume leads to gcc using
so many non volatiles. Perhaps in this case we should separate out the
slow path into another function marked noinline.

This is just an upstream glibc build, but I'll send the preprocessed
source off list.

Anton
--

0x410d538       mflr    r0
0x410d53c       li      r9,-65
0x410d540       std     r14,-144(r1)     # 0x0000000fff00efe0
0x410d544       std     r15,-136(r1)     # 0x0000000fff00efe8
0x410d548       cmpld   cr7,r4,r9
0x410d54c       std     r16,-128(r1)     # 0x0000000fff00eff0
0x410d550       std     r17,-120(r1)     # 0x0000000fff00eff8
0x410d554       std     r18,-112(r1)     # 0x0000000fff00f000
0x410d558       std     r19,-104(r1)     # 0x0000000fff00f008
0x410d55c       std     r20,-96(r1)      # 0x0000000fff00f010
0x410d560       std     r21,-88(r1)      # 0x0000000fff00f018
0x410d564       std     r22,-80(r1)      # 0x0000000fff00f020
0x410d568       std     r23,-72(r1)      # 0x0000000fff00f028
0x410d56c       std     r0,16(r1)        # 0x0000000fff00f080
0x410d570       std     r24,-64(r1)      # 0x0000000fff00f030
0x410d574       std     r25,-56(r1)      # 0x0000000fff00f038
0x410d578       std     r26,-48(r1)      # 0x0000000fff00f040
0x410d57c       std     r27,-40(r1)      # 0x0000000fff00f048
0x410d580       std     r28,-32(r1)      # 0x0000000fff00f050
0x410d584       std     r29,-24(r1)      # 0x0000000fff00f058
0x410d588       std     r30,-16(r1)      # 0x0000000fff00f060
0x410d58c       std     r31,-8(r1)       # 0x0000000fff00f068
0x410d590       stdu    r1,-224(r1)      # 0x0000000fff00ef90
0x410d594       bgt     cr7,0x410dda4
0x410d598       addi    r9,r4,23
0x410d59c       li      r16,32
0x410d5a0       cmpldi  cr7,r9,31
0x410d5a4       bgt     cr7,0x410d700
0x410d5a8       cmpdi   cr7,r3,0
0x410d5ac       mr      r14,r3
0x410d5b0       mr      r30,r4
0x410d5b4       beq     cr7,0x410ddc0
0x410d5b8       nop
0x410d5bc       ld      r9,-19136(r2)    # 0x0000000004222840
0x410d5c0       rlwinm  r29,r16,28,4,31
0x410d5c4       cmpld   cr7,r16,r9
0x410d5c8       bgt     cr7,0x410d650
0x410d5cc       addi    r6,r29,-2
0x410d5d0       clrldi  r9,r6,32
0x410d5d4       rldicr  r10,r9,3,60
0x410d5d8       addi    r7,r9,1
0x410d5dc       add     r10,r3,r10
0x410d5e0       rldicr  r7,r7,3,60
0x410d5e4       add     r7,r3,r7
0x410d5e8       ld      r9,8(r10)        # 0x0000000004220ce0
0x410d5ec       cmpdi   cr7,r9,0
0x410d5f0       beq     cr7,0x410d650
0x410d5f4       ld      r10,16(r9)       # 0x0000000010030010
0x410d5f8       ldarx   r15,0,r7,1       # 0x0000000004220ce0
0x410d5fc       cmpd    r15,r9
0x410d600       bne     0x410d60c
0x410d604       stdcx.  r10,0,r7         # 0x0000000004220ce0
0x410d608       bne-    0x410d5f8
0x410d60c       isync
0x410d610       cmpld   cr7,r15,r9
0x410d614       bne     cr7,0x410d648
0x410d618       b       0x410da40
0x410da40       ld      r9,8(r15)        # 0x0000000010030008
0x410da44       rlwinm  r9,r9,28,4,31
0x410da48       addi    r9,r9,-2
0x410da4c       cmplw   cr7,r9,r6
0x410da50       bne     cr7,0x410de08
0x410da54       nop
0x410da58       addi    r31,r15,16
0x410da5c       lwa     r9,-19080(r2)    # 0x0000000004222878
0x410da60       cmpdi   cr7,r9,0
0x410da64       bne     cr7,0x410d6e4
0x410da68       addi    r1,r1,224
0x410da6c       mr      r3,r31
0x410da70       ld      r0,16(r1)        # 0x0000000fff00f080
0x410da74       ld      r14,-144(r1)     # 0x0000000fff00efe0
0x410da78       ld      r15,-136(r1)     # 0x0000000fff00efe8
0x410da7c       ld      r16,-128(r1)     # 0x0000000fff00eff0
0x410da80       ld      r17,-120(r1)     # 0x0000000fff00eff8
0x410da84       ld      r18,-112(r1)     # 0x0000000fff00f000
0x410da88       ld      r19,-104(r1)     # 0x0000000fff00f008
0x410da8c       ld      r20,-96(r1)      # 0x0000000fff00f010
0x410da90       ld      r21,-88(r1)      # 0x0000000fff00f018
0x410da94       ld      r22,-80(r1)      # 0x0000000fff00f020
0x410da98       ld      r23,-72(r1)      # 0x0000000fff00f028
0x410da9c       ld      r24,-64(r1)      # 0x0000000fff00f030
0x410daa0       mtlr    r0
0x410da70       ld      r0,16(r1)        # 0x0000000fff00f080
0x410da74       ld      r14,-144(r1)     # 0x0000000fff00efe0
0x410da78       ld      r15,-136(r1)     # 0x0000000fff00efe8
0x410da7c       ld      r16,-128(r1)     # 0x0000000fff00eff0
0x410da80       ld      r17,-120(r1)     # 0x0000000fff00eff8
0x410da84       ld      r18,-112(r1)     # 0x0000000fff00f000
0x410da88       ld      r19,-104(r1)     # 0x0000000fff00f008
0x410da8c       ld      r20,-96(r1)      # 0x0000000fff00f010
0x410da90       ld      r21,-88(r1)      # 0x0000000fff00f018
0x410da94       ld      r22,-80(r1)      # 0x0000000fff00f020
0x410da98       ld      r23,-72(r1)      # 0x0000000fff00f028
0x410da9c       ld      r24,-64(r1)      # 0x0000000fff00f030
0x410daa0       mtlr    r0
0x410daa4       ld      r25,-56(r1)      # 0x0000000fff00f038
0x410daa8       ld      r26,-48(r1)      # 0x0000000fff00f040
0x410daac       ld      r27,-40(r1)      # 0x0000000fff00f048
0x410dab0       ld      r28,-32(r1)      # 0x0000000fff00f050
0x410dab4       ld      r29,-24(r1)      # 0x0000000fff00f058
0x410dab8       ld      r30,-16(r1)      # 0x0000000fff00f060
0x410dabc       ld      r31,-8(r1)       # 0x0000000fff00f068
0x410dac0       blr
