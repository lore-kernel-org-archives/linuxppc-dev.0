Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E6FE1A1A60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 07:04:25 +1000 (AEST)
Date: Fri, 14 Aug 2015 07:04:24 +1000
From: Anton Blanchard <anton@samba.org>
To: Bill Schmidt <wschmidt@us.ibm.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra
 <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org, Michael Gschwind
 <mkg@us.ibm.com>, paulus@samba.org, Ulrich Weigand
 <Ulrich.Weigand@de.ibm.com>, David Edelsohn <dje.gcc@gmail.com>
Subject: Re: RFC: Reducing the number of non volatile GPRs in the ppc64 kernel
Message-ID: <20150814070424.2f8984ac@kryten>
In-Reply-To: <20150810145228.3f78c8e4@kryten>
References: <20150805140300.218ef661@kryten>
 <20150805041928.GA32178@gate.crashing.org>
 <OFD0811845.CF7950C1-ON86257E9A.002065FB-C1257E9A.00208EE6@us.ibm.com>
 <20150810145228.3f78c8e4@kryten>
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

Hi,

Here is another instruction trace from a kernel context switch trace.
Quite a lot of register and CR save/restore code.

Regards,
Anton

c0000000002943d8 <fsnotify+0x8> mfcr    r12
c0000000002943dc <fsnotify+0xc> std     r20,-96(r1)
c0000000002943e0 <fsnotify+0x10> std     r21,-88(r1)
c0000000002943e4 <fsnotify+0x14> rldicl. r9,r4,63,63
c0000000002943e8 <fsnotify+0x18> std     r22,-80(r1)
c0000000002943ec <fsnotify+0x1c> mflr    r0
c0000000002943f0 <fsnotify+0x20> std     r24,-64(r1)
c0000000002943f4 <fsnotify+0x24> std     r25,-56(r1)
c0000000002943f8 <fsnotify+0x28> std     r26,-48(r1)
c0000000002943fc <fsnotify+0x2c> std     r27,-40(r1)
c000000000294400 <fsnotify+0x30> std     r31,-8(r1)
c000000000294404 <fsnotify+0x34> std     r15,-136(r1)
c000000000294408 <fsnotify+0x38> stw     r12,8(r1)
c00000000029440c <fsnotify+0x3c> std     r16,-128(r1)
c000000000294410 <fsnotify+0x40> mcrf    cr4,cr0
c000000000294414 <fsnotify+0x44> std     r0,16(r1)
c000000000294418 <fsnotify+0x48> std     r17,-120(r1)
c00000000029441c <fsnotify+0x4c> std     r18,-112(r1)
c000000000294420 <fsnotify+0x50> std     r19,-104(r1)
c000000000294424 <fsnotify+0x54> std     r23,-72(r1)
c000000000294428 <fsnotify+0x58> std     r28,-32(r1)
c00000000029442c <fsnotify+0x5c> std     r29,-24(r1)
c000000000294430 <fsnotify+0x60> std     r30,-16(r1)
c000000000294434 <fsnotify+0x64> stdu    r1,-272(r1)
c000000000294438 <fsnotify+0x68> cmpwi   cr7,r6,1
c00000000029443c <fsnotify+0x6c> rlwinm  r31,r4,4,1,31
c000000000294440 <fsnotify+0x70> li      r9,0
c000000000294444 <fsnotify+0x74> rotlwi  r31,r31,28
c000000000294448 <fsnotify+0x78> mr      r24,r6
c00000000029444c <fsnotify+0x7c> mr      r26,r4
c000000000294450 <fsnotify+0x80> mr      r25,r3
c000000000294454 <fsnotify+0x84> mr      r22,r5
c000000000294458 <fsnotify+0x88> mr      r21,r7
c00000000029445c <fsnotify+0x8c> mr      r20,r8
c000000000294460 <fsnotify+0x90> std     r9,120(r1)
c000000000294464 <fsnotify+0x94> std     r9,112(r1)
c000000000294468 <fsnotify+0x98> clrldi  r27,r31,32
c00000000029446c <fsnotify+0x9c> beq     cr7,c000000000294888 <fsnotify+0x4b8> 
c000000000294888 <fsnotify+0x4b8> ld      r29,0(r5)
c00000000029488c <fsnotify+0x4bc> addi    r29,r29,-32
c000000000294890 <fsnotify+0x4c0> beq     c000000000294478 <fsnotify+0xa8> 
c000000000294478 <fsnotify+0xa8> lwz     r9,516(r25)
c00000000029447c <fsnotify+0xac> and     r10,r9,r31
c000000000294480 <fsnotify+0xb0> cmpwi   r10,0
c000000000294484 <fsnotify+0xb4> bne     c0000000002945d0 <fsnotify+0x200> 
c000000000294488 <fsnotify+0xb8> cmpdi   cr7,r29,0
c00000000029448c <fsnotify+0xbc> beq     cr7,c0000000002948c4 <fsnotify+0x4f4> 
c000000000294490 <fsnotify+0xc0> lwz     r9,264(r29)
c000000000294494 <fsnotify+0xc4> and     r10,r9,r31
c000000000294498 <fsnotify+0xc8> cmpwi   r10,0
c00000000029449c <fsnotify+0xcc> beq     c0000000002948c4 <fsnotify+0x4f4> 
c0000000002948c4 <fsnotify+0x4f4> li      r3,0
c0000000002948c8 <fsnotify+0x4f8> b       c0000000002947cc <fsnotify+0x3fc> 
c0000000002947cc <fsnotify+0x3fc> addi    r1,r1,272
c0000000002947d0 <fsnotify+0x400> ld      r0,16(r1)
c0000000002947d4 <fsnotify+0x404> lwz     r12,8(r1)
c0000000002947d8 <fsnotify+0x408> ld      r15,-136(r1)
c0000000002947dc <fsnotify+0x40c> ld      r16,-128(r1)
c0000000002947e0 <fsnotify+0x410> mtlr    r0
c0000000002947e4 <fsnotify+0x414> ld      r17,-120(r1)
c0000000002947e8 <fsnotify+0x418> ld      r18,-112(r1)
c0000000002947ec <fsnotify+0x41c> mtocrf  32,r12
c0000000002947f0 <fsnotify+0x420> mtocrf  16,r12
c0000000002947f4 <fsnotify+0x424> mtocrf  8,r12
c0000000002947f8 <fsnotify+0x428> ld      r19,-104(r1)
c0000000002947fc <fsnotify+0x42c> ld      r20,-96(r1)
c000000000294800 <fsnotify+0x430> ld      r21,-88(r1)
c000000000294804 <fsnotify+0x434> ld      r22,-80(r1)
c000000000294808 <fsnotify+0x438> ld      r23,-72(r1)
c00000000029480c <fsnotify+0x43c> ld      r24,-64(r1)
c000000000294810 <fsnotify+0x440> ld      r25,-56(r1)
c000000000294814 <fsnotify+0x444> ld      r26,-48(r1)
c000000000294818 <fsnotify+0x448> ld      r27,-40(r1)
c00000000029481c <fsnotify+0x44c> ld      r28,-32(r1)
c000000000294820 <fsnotify+0x450> ld      r29,-24(r1)
c000000000294824 <fsnotify+0x454> ld      r30,-16(r1)
c000000000294828 <fsnotify+0x458> ld      r31,-8(r1)
c00000000029482c <fsnotify+0x45c> blr
