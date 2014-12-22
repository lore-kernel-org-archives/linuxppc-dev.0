Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75B251A0DAC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 17:49:05 +1100 (AEDT)
Message-ID: <1419230944.20221.6.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc: Don't use local named register variable in
 current_thread_info
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 22 Dec 2014 17:49:04 +1100
In-Reply-To: <54914C85.30107@suse.de>
References: <1414727247-31838-1-git-send-email-anton__19440.5086375356$1414727300$gmane$org@samba.org>
 <5490D981.7040905@suse.de> <20141217144459.09701a76@kryten>
 <54914C85.30107@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ulrich.weigand@de.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-17 at 10:27 +0100, Alexander Graf wrote:
> 
> On 17.12.14 04:44, Anton Blanchard wrote:
> > Hi Alex,
> > 
> >> Git bisect managed to point me to this commit as the offender for
> >> OOPSes on e5500 and e6500 (and maybe the G4 as well, not sure).
> >>
> >> Doing a git revert of this commit on top of linus/master makes things
> >> work fine for me again.
> > 
> > Ouch, sorry for that, I'll work to reproduce. What gcc version are you
> > using?
> 
> I'm running
> 
>   gcc (SUSE Linux) 4.7.2 20130108 [gcc-4_7-branch revision 195012]
> 
> which is basically the one from openSUSE 12.3 for ppc64.

OK. I've also reproduced it with what I think is stock 4.7.3.

I only see it in __skb_checksum() though, which is a bit odd. It is a fairly
large routine, so maybe it's just register pressure?

I tried for a while to create a self contained test case, but couldn't get
anything to work.

I guess we'll have to revert the kernel patch, unless someone can identify the
gcc bug soon.

I also wonder if it's fixed in later versions, or we're just not seeing it due
to good luck.

Below is the broken vs working code. For some reason in the bad case it backs
up r1, as if it thinks it will be clobbered by the rldicr.

Bad:

c00000000076df84:	7c 29 0b 78 	mr      r9,r1		<-- save of r1 ?
c00000000076df88:	78 27 04 64 	rldicr  r7,r1,0,49	<-- current_thread_info()
c00000000076df8c:	7d 08 ea 14 	add     r8,r8,r29
c00000000076df90:	7c 9f 40 50 	subf    r4,r31,r8
c00000000076df94:	7d 12 07 b4 	extsw   r18,r8
c00000000076df98:	2f 04 00 00 	cmpwi   cr6,r4,0
c00000000076df9c:	7c 9c 23 78 	mr      r28,r4
c00000000076dfa0:	7f 84 f0 00 	cmpw    cr7,r4,r30
c00000000076dfa4:	40 99 00 cc 	ble-    cr6,c00000000076e070 <.__skb_checksum+0x220>
c00000000076dfa8:	40 9d 00 08 	ble-    cr7,c00000000076dfb0 <.__skb_checksum+0x160>
c00000000076dfac:	7f dc f3 78 	mr      r28,r30
c00000000076dfb0:	81 07 00 14 	lwz     r8,20(r7)
c00000000076dfb4:	e8 6a 00 00 	ld      r3,0(r10)
c00000000076dfb8:	7f 94 07 b4 	extsw   r20,r28
c00000000076dfbc:	39 08 00 01 	addi    r8,r8,1
c00000000076dfc0:	91 07 00 14 	stw     r8,20(r7)
c00000000076dfc4:	7c 63 b2 14 	add     r3,r3,r22
c00000000076dfc8:	7e 84 a3 78 	mr      r4,r20
c00000000076dfcc:	7c 63 1e 74 	sradi   r3,r3,3
c00000000076dfd0:	38 a0 00 00 	li      r5,0
c00000000076dfd4:	7c 63 c1 d2 	mulld   r3,r3,r24
c00000000076dfd8:	81 0a 00 08 	lwz     r8,8(r10)
c00000000076dfdc:	7d 1f 42 14 	add     r8,r31,r8
c00000000076dfe0:	78 63 83 e4 	rldicr  r3,r3,16,47
c00000000076dfe4:	7f bd 40 50 	subf    r29,r29,r8
c00000000076dfe8:	7c 63 bb 78 	or      r3,r3,r23
c00000000076dfec:	7c 63 ea 14 	add     r3,r3,r29
c00000000076dff0:	e9 59 00 00 	ld      r10,0(r25)
c00000000076dff4:	e9 0a 00 00 	ld      r8,0(r10)
c00000000076dff8:	f8 49 00 28 	std     r2,40(r9)	<-- use of r9 which is OK
c00000000076dffc:	7d 09 03 a6 	mtctr   r8
c00000000076e000:	e8 4a 00 08 	ld      r2,8(r10)
c00000000076e004:	4e 80 04 21 	bctrl
c00000000076e008:	e8 49 00 28 	ld      r2,40(r9)	<-- but not OK here


Good:

c00000000076e0b0:       78 39 04 64     rldicr  r25,r1,0,49	<-- current_thread_info()
c00000000076e0b4:       7a 94 07 c6     rldicr  r20,r20,32,31
c00000000076e0b8:       62 d6 6d b7     ori     r22,r22,28087
c00000000076e0bc:       7a b5 00 44     rldicr  r21,r21,0,1
c00000000076e0c0:       7d 5f f2 14     add     r10,r31,r30
c00000000076e0c4:       39 1a 00 03     addi    r8,r26,3
c00000000076e0c8:       79 08 26 e4     rldicr  r8,r8,4,59
c00000000076e0cc:       7f 8a e8 00     cmpw    cr7,r10,r29
c00000000076e0d0:       7d 40 00 26     mfcr    r10
c00000000076e0d4:       55 4a ef fe     rlwinm  r10,r10,29,31,31
c00000000076e0d8:       7d 29 42 14     add     r9,r9,r8
c00000000076e0dc:       0b 0a 00 00     tdnei   r10,0
c00000000076e0e0:       81 49 00 0c     lwz     r10,12(r9)
c00000000076e0e4:       7d 4a ea 14     add     r10,r10,r29
c00000000076e0e8:       7d 1f 50 50     subf    r8,r31,r10
c00000000076e0ec:       7d 51 07 b4     extsw   r17,r10
c00000000076e0f0:       2f 08 00 00     cmpwi   cr6,r8,0
c00000000076e0f4:       7d 1c 43 78     mr      r28,r8
c00000000076e0f8:       7f 88 f0 00     cmpw    cr7,r8,r30
c00000000076e0fc:       40 99 00 c8     ble-    cr6,c00000000076e1c4 <.__skb_checksum+0x214>
c00000000076e100:       40 9d 00 08     ble-    cr7,c00000000076e108 <.__skb_checksum+0x158>
c00000000076e104:       7f dc f3 78     mr      r28,r30
c00000000076e108:       81 59 00 14     lwz     r10,20(r25)
c00000000076e10c:       e8 69 00 00     ld      r3,0(r9)
c00000000076e110:       7f 93 07 b4     extsw   r19,r28
c00000000076e114:       39 4a 00 01     addi    r10,r10,1
c00000000076e118:       91 59 00 14     stw     r10,20(r25)
c00000000076e11c:       7c 63 a2 14     add     r3,r3,r20
c00000000076e120:       7e 64 9b 78     mr      r4,r19
c00000000076e124:       7c 63 1e 74     sradi   r3,r3,3
c00000000076e128:       38 a0 00 00     li      r5,0
c00000000076e12c:       7c 63 b1 d2     mulld   r3,r3,r22
c00000000076e130:       81 49 00 08     lwz     r10,8(r9)
c00000000076e134:       7d 5f 52 14     add     r10,r31,r10
c00000000076e138:       78 63 83 e4     rldicr  r3,r3,16,47
c00000000076e13c:       7f bd 50 50     subf    r29,r29,r10
c00000000076e140:       7c 63 ab 78     or      r3,r3,r21
c00000000076e144:       7c 63 ea 14     add     r3,r3,r29
c00000000076e148:       e9 37 00 00     ld      r9,0(r23)
c00000000076e14c:       e9 49 00 00     ld      r10,0(r9)
c00000000076e150:       f8 41 00 28     std     r2,40(r1)	<-- correct use of r1
c00000000076e154:       7d 49 03 a6     mtctr   r10
c00000000076e158:       e8 49 00 08     ld      r2,8(r9)
c00000000076e15c:       4e 80 04 21     bctrl
c00000000076e160:       e8 41 00 28     ld      r2,40(r1)	<-- correct use of r1


cheers
