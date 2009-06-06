Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5EFB6B709D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 05:51:38 +1000 (EST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [59.145.155.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BAD9DDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 05:51:36 +1000 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id n56JpTeD002277
	for <linuxppc-dev@ozlabs.org>; Sun, 7 Jun 2009 01:21:29 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n56JpTWA3010722
	for <linuxppc-dev@ozlabs.org>; Sun, 7 Jun 2009 01:21:29 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n56JpTkL031162
	for <linuxppc-dev@ozlabs.org>; Sun, 7 Jun 2009 01:21:29 +0530
Message-ID: <4A2AC8BF.6090403@in.ibm.com>
Date: Sun, 07 Jun 2009 01:21:27 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [OOPS] hugetlbfs tests with 2.6.30-rc8-git1
References: <4A290195.3080807@in.ibm.com> <1244233062.31984.6.camel@pasglop>
In-Reply-To: <1244233062.31984.6.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------020807010305010603040300"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020807010305010603040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
> No, Mel's patch is for a different problem and has been fixed upstream
> already. This is more concerning... I'm not sure what's up but would
> you be able to send a disassembly of the hpte_need_flush() function in
> your kernel binary for me to see what access precisely caused the
> fault ?
>   
Was able to recreate this with git3 kernel. Here is the disassembly

shm-fork 10 10 (64):    PASS
shm-fork 10 20 (32):    cpu 0x1: Vector: 300 (Data Access) at [c0000000faa13490]
    pc: c000000000038240: .hpte_need_flush+0x1bc/0x2d8
    lr: c0000000000380f0: .hpte_need_flush+0x6c/0x2d8
    sp: c0000000faa13710
   msr: 8000000000009032
   dar: c00000005e5e0480
 dsisr: 40000000
  current = 0xc0000000f9bde3e0
  paca    = 0xc000000000b72600
    pid   = 12152, comm = shm-fork
enter ? for help
[c0000000faa13710] c000000000038264 .hpte_need_flush+0x1e0/0x2d8 (unreliable)
[c0000000faa137d0] c000000000039fa4 .huge_ptep_get_and_clear+0x40/0x5c
[c0000000faa13850] c00000000012d044 .__unmap_hugepage_range+0x178/0x2b8
[c0000000faa13940] c00000000012d1d8 .unmap_hugepage_range+0x54/0x88
[c0000000faa139e0] c000000000116f78 .unmap_vmas+0x178/0x8f4
[c0000000faa13b30] c00000000011c690 .unmap_region+0xfc/0x1e4
[c0000000faa13c00] c00000000011de20 .do_munmap+0x2f4/0x38c
[c0000000faa13cc0] c0000000002f6a08 .SyS_shmdt+0xc0/0x188
[c0000000faa13d70] c00000000000c430 .sys_ipc+0x274/0x2fc
[c0000000faa13e30] c000000000008534 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000004000021d2dc
SP (fffee026010) is in userspace
1:mon> di $.hpte_need_flush
c000000000038084  fac1ffb0      std     r22,-80(r1)
c000000000038088  7c0802a6      mflr    r0
c00000000003808c  f8010010      std     r0,16(r1)
c000000000038090  2fa70000      cmpdi   cr7,r7,0
c000000000038094  fb21ffc8      std     r25,-56(r1)
c000000000038098  6cc01000      xoris   r0,r6,4096
c00000000003809c  fb41ffd0      std     r26,-48(r1)
c0000000000380a0  7cd93378      mr      r25,r6
c0000000000380a4  fb61ffd8      std     r27,-40(r1)
c0000000000380a8  7cb62b78      mr      r22,r5
c0000000000380ac  fb81ffe0      std     r28,-32(r1)
......... <SNIP> .........
1:mon>
c000000000038204  38090001      addi    r0,r9,1
c000000000038208  78004602      rldicl  r0,r0,40,24
c00000000003820c  7c004a14      add     r0,r0,r9
c000000000038210  78090220      clrldi  r9,r0,40
c000000000038214  2fbd0000      cmpdi   cr7,r29,0
c000000000038218  409e0010      bne     cr7,c000000000038228    # .hpte_need_flush+0x1a4/0x2d8
c00000000003821c  7929e0e4      rldicr  r9,r9,28,35
c000000000038220  7be00120      clrldi  r0,r31,36
c000000000038224  4800000c      b       c000000000038230        # .hpte_need_flush+0x1ac/0x2d8
c000000000038228  792945c6      rldicr  r9,r9,40,23
c00000000003822c  7be00600      clrldi  r0,r31,24
c000000000038230  7d3f0378      or      r31,r9,r0
c000000000038234  7c1cb82e      lwzx    r0,r28,r23
c000000000038238  3d360001      addis   r9,r22,1
c00000000003823c  2f800000      cmpwi   cr7,r0,0
c000000000038240  eb898000      ld      r28,-32768(r9)  <<== +0x1bc should be this
1:mon>  r
R00 = 0000000000000000   R16 = 0000000023aa4db0
R01 = c0000000faa13710   R17 = 0000000000000000
R02 = c000000000a9d788   R18 = ffffffffffff9010
R03 = 0000000000000004   R19 = 0000000000000000
R04 = 000003fff0000000   R20 = 0000000000000000
R05 = c00000005e5d8480   R21 = 0000040000000000
R06 = 0000364008000393   R22 = c00000005e5d8480
R07 = 0000000000000001   R23 = 0000000000750000
R08 = 0000000000000004   R24 = 0000000000000000
R09 = c00000005e5e8480   R25 = 0000364008000393
R10 = 000000000003fff0   R26 = c0000000673f0680
R11 = 0000000000000280   R27 = 0000000000000004
R12 = 0000000044022422   R28 = c000000000890430
R13 = c000000000b72600   R29 = 0000000000000001
R14 = 00000000ffffffff   R30 = c000000000fe0430
R15 = ffffffffffffffff   R31 = 8812ebfff0000000
pc  = c000000000038240 .hpte_need_flush+0x1bc/0x2d8
lr  = c0000000000380f0 .hpte_need_flush+0x6c/0x2d8
msr = 8000000000009032   cr  = 44022422
ctr = c00000000025cc28   xer = 0000000000000001   trap =  300
dar = c00000005e5e0480   dsisr = 40000000
1:mon>

Have attached the complete disassembly. 

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


--------------020807010305010603040300
Content-Type: text/x-log;
 name="disassembly.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="disassembly.log"

shm-fork 10 10 (64):    PASS
shm-fork 10 20 (32):    cpu 0x1: Vector: 300 (Data Access) at [c0000000faa13490]
    pc: c000000000038240: .hpte_need_flush+0x1bc/0x2d8
    lr: c0000000000380f0: .hpte_need_flush+0x6c/0x2d8
    sp: c0000000faa13710
   msr: 8000000000009032
   dar: c00000005e5e0480
 dsisr: 40000000
  current = 0xc0000000f9bde3e0
  paca    = 0xc000000000b72600
    pid   = 12152, comm = shm-fork
enter ? for help
[c0000000faa13710] c000000000038264 .hpte_need_flush+0x1e0/0x2d8 (unreliable)
[c0000000faa137d0] c000000000039fa4 .huge_ptep_get_and_clear+0x40/0x5c
[c0000000faa13850] c00000000012d044 .__unmap_hugepage_range+0x178/0x2b8
[c0000000faa13940] c00000000012d1d8 .unmap_hugepage_range+0x54/0x88
[c0000000faa139e0] c000000000116f78 .unmap_vmas+0x178/0x8f4
[c0000000faa13b30] c00000000011c690 .unmap_region+0xfc/0x1e4
[c0000000faa13c00] c00000000011de20 .do_munmap+0x2f4/0x38c
[c0000000faa13cc0] c0000000002f6a08 .SyS_shmdt+0xc0/0x188
[c0000000faa13d70] c00000000000c430 .sys_ipc+0x274/0x2fc
[c0000000faa13e30] c000000000008534 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000004000021d2dc
SP (fffee026010) is in userspace
1:mon> di $.hpte_need_flush
c000000000038084  fac1ffb0      std     r22,-80(r1)
c000000000038088  7c0802a6      mflr    r0
c00000000003808c  f8010010      std     r0,16(r1)
c000000000038090  2fa70000      cmpdi   cr7,r7,0
c000000000038094  fb21ffc8      std     r25,-56(r1)
c000000000038098  6cc01000      xoris   r0,r6,4096
c00000000003809c  fb41ffd0      std     r26,-48(r1)
c0000000000380a0  7cd93378      mr      r25,r6
c0000000000380a4  fb61ffd8      std     r27,-40(r1)
c0000000000380a8  7cb62b78      mr      r22,r5
c0000000000380ac  fb81ffe0      std     r28,-32(r1)
c0000000000380b0  eb828d30      ld      r28,-29392(r2)
c0000000000380b4  fbc1fff0      std     r30,-16(r1)
c0000000000380b8  781b27e2      rldicl  r27,r0,36,63
c0000000000380bc  fbe1fff8      std     r31,-8(r1)
c0000000000380c0  7c7a1b78      mr      r26,r3
1:mon> 
c0000000000380c4  fae1ffb8      std     r23,-72(r1)
c0000000000380c8  789f03e4      rldicr  r31,r4,0,47
c0000000000380cc  fb01ffc0      std     r24,-64(r1)
c0000000000380d0  fba1ffe8      std     r29,-24(r1)
c0000000000380d4  f821ff41      stdu    r1,-192(r1)
c0000000000380d8  eaed0040      ld      r23,64(r13)
c0000000000380dc  7fdcba14      add     r30,r28,r23
c0000000000380e0  eb1e0008      ld      r24,8(r30)
c0000000000380e4  419e0014      beq     cr7,c0000000000380f8    # .hpte_need_flush+0x74/0x2d8
c0000000000380e8  7fe4fb78      mr      r4,r31
c0000000000380ec  48000d85      bl      c000000000038e70        # .get_slice_psize+0x0/0x38
c0000000000380f0  60000000      nop
c0000000000380f4  7c7b1b78      mr      r27,r3
c0000000000380f8  e8028d38      ld      r0,-29384(r2)
c0000000000380fc  7fbf0040      cmpld   cr7,r31,r0
c000000000038100  419d00a8      bgt     cr7,c0000000000381a8    # .hpte_need_flush+0x124/0x2d8
1:mon> 
c000000000038104  3800ffff      li      r0,-1
c000000000038108  3ba00000      li      r29,0
c00000000003810c  78000600      clrldi  r0,r0,24
c000000000038110  7fbf0040      cmpld   cr7,r31,r0
c000000000038114  409d000c      ble     cr7,c000000000038120    # .hpte_need_flush+0x9c/0x2d8
c000000000038118  e9228d40      ld      r9,-29376(r2)
c00000000003811c  eba90002      lwa     r29,0(r9)
c000000000038120  2fbd0000      cmpdi   cr7,r29,0
c000000000038124  e97a0390      ld      r11,912(r26)
c000000000038128  409e003c      bne     cr7,c000000000038164    # .hpte_need_flush+0xe0/0x2d8
c00000000003812c  796b83e4      rldicr  r11,r11,16,47
c000000000038130  7be02702      rldicl  r0,r31,36,28
c000000000038134  3d200bf6      lis     r9,3062
c000000000038138  7c005b78      or      r0,r0,r11
c00000000003813c  6129e61b      ori     r9,r9,58907
c000000000038140  7c0049d2      mulld   r0,r0,r9
1:mon> 
c000000000038144  78090700      clrldi  r9,r0,28
c000000000038148  7800e120      rldicl  r0,r0,28,36
c00000000003814c  7d290214      add     r9,r9,r0
c000000000038150  38090001      addi    r0,r9,1
c000000000038154  7800e120      rldicl  r0,r0,28,36
c000000000038158  7c004a14      add     r0,r0,r9
c00000000003815c  78090700      clrldi  r9,r0,28
c000000000038160  48000038      b       c000000000038198        # .hpte_need_flush+0x114/0x2d8
c000000000038164  796b26e4      rldicr  r11,r11,4,59
c000000000038168  7be0c220      rldicl  r0,r31,24,40
c00000000003816c  3d2000bf      lis     r9,191
c000000000038170  7c005b78      or      r0,r0,r11
c000000000038174  612950d9      ori     r9,r9,20697
c000000000038178  7c0049d2      mulld   r0,r0,r9
c00000000003817c  78090220      clrldi  r9,r0,40
c000000000038180  78004602      rldicl  r0,r0,40,24
1:mon> 
c000000000038184  7d290214      add     r9,r9,r0
c000000000038188  38090001      addi    r0,r9,1
c00000000003818c  78004602      rldicl  r0,r0,40,24
c000000000038190  7c004a14      add     r0,r0,r9
c000000000038194  78090220      clrldi  r9,r0,40
c000000000038198  7d200074      cntlzd  r0,r9
c00000000003819c  7800d182      rldicl  r0,r0,58,6
c0000000000381a0  0b000000      tdnei   r0,0
c0000000000381a4  48000070      b       c000000000038214        # .hpte_need_flush+0x190/0x2d8
c0000000000381a8  e9228d48      ld      r9,-29368(r2)
c0000000000381ac  eba90002      lwa     r29,0(r9)
c0000000000381b0  2fbd0000      cmpdi   cr7,r29,0
c0000000000381b4  409e0034      bne     cr7,c0000000000381e8    # .hpte_need_flush+0x164/0x2d8
c0000000000381b8  3d200bf6      lis     r9,3062
c0000000000381bc  7be02702      rldicl  r0,r31,36,28
c0000000000381c0  6129e61b      ori     r9,r9,58907
1:mon> 
c0000000000381c4  7c0049d2      mulld   r0,r0,r9
c0000000000381c8  78090700      clrldi  r9,r0,28
c0000000000381cc  7800e120      rldicl  r0,r0,28,36
c0000000000381d0  7d290214      add     r9,r9,r0
c0000000000381d4  38090001      addi    r0,r9,1
c0000000000381d8  7800e120      rldicl  r0,r0,28,36
c0000000000381dc  7c004a14      add     r0,r0,r9
c0000000000381e0  78090700      clrldi  r9,r0,28
c0000000000381e4  48000038      b       c00000000003821c        # .hpte_need_flush+0x198/0x2d8
c0000000000381e8  3d2000bf      lis     r9,191
c0000000000381ec  7be0c220      rldicl  r0,r31,24,40
c0000000000381f0  612950d9      ori     r9,r9,20697
c0000000000381f4  7c0049d2      mulld   r0,r0,r9
c0000000000381f8  78090220      clrldi  r9,r0,40
c0000000000381fc  78004602      rldicl  r0,r0,40,24
c000000000038200  7d290214      add     r9,r9,r0
1:mon> 
c000000000038204  38090001      addi    r0,r9,1
c000000000038208  78004602      rldicl  r0,r0,40,24
c00000000003820c  7c004a14      add     r0,r0,r9
c000000000038210  78090220      clrldi  r9,r0,40
c000000000038214  2fbd0000      cmpdi   cr7,r29,0
c000000000038218  409e0010      bne     cr7,c000000000038228    # .hpte_need_flush+0x1a4/0x2d8
c00000000003821c  7929e0e4      rldicr  r9,r9,28,35
c000000000038220  7be00120      clrldi  r0,r31,36
c000000000038224  4800000c      b       c000000000038230        # .hpte_need_flush+0x1ac/0x2d8
c000000000038228  792945c6      rldicr  r9,r9,40,23
c00000000003822c  7be00600      clrldi  r0,r31,24
c000000000038230  7d3f0378      or      r31,r9,r0
c000000000038234  7c1cb82e      lwzx    r0,r28,r23
c000000000038238  3d360001      addis   r9,r22,1
c00000000003823c  2f800000      cmpwi   cr7,r0,0
c000000000038240  eb898000      ld      r28,-32768(r9)
1:mon>  r
R00 = 0000000000000000   R16 = 0000000023aa4db0
R01 = c0000000faa13710   R17 = 0000000000000000
R02 = c000000000a9d788   R18 = ffffffffffff9010
R03 = 0000000000000004   R19 = 0000000000000000
R04 = 000003fff0000000   R20 = 0000000000000000
R05 = c00000005e5d8480   R21 = 0000040000000000
R06 = 0000364008000393   R22 = c00000005e5d8480
R07 = 0000000000000001   R23 = 0000000000750000
R08 = 0000000000000004   R24 = 0000000000000000
R09 = c00000005e5e8480   R25 = 0000364008000393
R10 = 000000000003fff0   R26 = c0000000673f0680
R11 = 0000000000000280   R27 = 0000000000000004
R12 = 0000000044022422   R28 = c000000000890430
R13 = c000000000b72600   R29 = 0000000000000001
R14 = 00000000ffffffff   R30 = c000000000fe0430
R15 = ffffffffffffffff   R31 = 8812ebfff0000000
pc  = c000000000038240 .hpte_need_flush+0x1bc/0x2d8
lr  = c0000000000380f0 .hpte_need_flush+0x6c/0x2d8
msr = 8000000000009032   cr  = 44022422
ctr = c00000000025cc28   xer = 0000000000000001   trap =  300
dar = c00000005e5e0480   dsisr = 40000000
1:mon>


--------------020807010305010603040300--
