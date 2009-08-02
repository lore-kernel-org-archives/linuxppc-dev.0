Return-Path: <wilbur512@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 3AE12B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 Aug 2009 09:59:16 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id c5so427123rvf.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 02 Aug 2009 16:59:14 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 3 Aug 2009 07:59:14 +0800
Message-ID: <e997b7420908021659t7a55b649rfcaf50cfb0de4de1@mail.gmail.com>
Subject: How to setup a 1:1 mapping on E500 v2 ?
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we know, we can't turn off MMU on E500.

I want to setup a 1:1 mapping on SMP  E500 v2, and I used 4 Entries of
256M to form a 1G mapping.

Here are my codes, but when I used rfi , it didn't jump to the
required  instruction.

0---256M:
                lis     r6,FSL_BOOKE_MAS0(1, 14, 0)@h
	ori     r6,r6,FSL_BOOKE_MAS0(1, 14, 0)@l

	lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_4M)@h
	ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_4M)@l

	lis     r8,FSL_BOOKE_MAS2(0x00000000, (MAS2_I|MAS2_G))@h
	ori     r8,r8,FSL_BOOKE_MAS2(0x00000000, (MAS2_I|MAS2_G))@l

               lis     r9,FSL_BOOKE_MAS3(0x00000000, 0,
(MAS3_SX|MAS3_SW|MAS3_SR))@h
	ori     r9,r9,FSL_BOOKE_MAS3(0x00000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

256---512M:
                 lis     r6,FSL_BOOKE_MAS0(1, 13, 0)@h
	ori     r6,r6,FSL_BOOKE_MAS0(1, 13, 0)@l

	lis     r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_4M)@h
	ori     r7,r7,FSL_BOOKE_MAS1(1, 1, 0, 0, BOOKE_PAGESZ_4M)@l

	lis     r8,FSL_BOOKE_MAS2(0x10000000, (MAS2_I|MAS2_G))@h
	ori     r8,r8,FSL_BOOKE_MAS2(0x10000000, (MAS2_I|MAS2_G))@l

                lis     r9,FSL_BOOKE_MAS3(0x10000000, 0,
(MAS3_SX|MAS3_SW|MAS3_SR))@h
	ori     r9,r9,FSL_BOOKE_MAS3(0x10000000, 0, (MAS3_SX|MAS3_SW|MAS3_SR))@l

So are 512---768M, 768M----1GB...

#define FSL_BOOKE_MAS0(tlbsel,esel,nv) \
		(MAS0_TLBSEL(tlbsel) | MAS0_ESEL(esel) | MAS0_NV(nv))
#define FSL_BOOKE_MAS1(v,iprot,tid,ts,tsize) \
		((((v) << 31) & MAS1_VALID)             |\
		(((iprot) << 30) & MAS1_IPROT)          |\
		(MAS1_TID(tid))				|\
		(((ts) << 12) & MAS1_TS)                |\
		(MAS1_TSIZE(tsize)))
#define FSL_BOOKE_MAS2(epn, wimge) \
		(((epn) & MAS3_RPN) | (wimge))
#define FSL_BOOKE_MAS3(rpn, user, perms) \
		(((rpn) & MAS3_RPN) | (user) | (perms))




I also setup a 1MB mapping for serial,so I can trap the codes,and it
works well.However, rfi doesn't:

Pseudo-code :

relocate_new_kernel:

     setup_entry_for_serial();

     print('x');

     setup_entry(EPN=512M,RPN=512M,size=256M);

     addi      r8, r4, 1f - relocate_new_kernel

     mtspr     SPRN_SRR0, r8

    rfi

1:  print('y');

Here, x is printed, but y isn't.


Anyone please tell me why ?

Thank you very much.


regards,

wilbur
