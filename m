Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F674C169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:44:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DC920B1F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DC920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vh323wJ7zDqR2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 23:44:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=chandan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vh0M2vr2zDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 23:41:55 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x16Cdggm031671
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Feb 2019 07:41:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qfy84a8ju-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Feb 2019 07:41:51 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.ibm.com>;
 Wed, 6 Feb 2019 12:41:50 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 6 Feb 2019 12:41:47 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x16CfkND54001850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Feb 2019 12:41:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45D8C4204F;
 Wed,  6 Feb 2019 12:41:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DD9E42045;
 Wed,  6 Feb 2019 12:41:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.0.46])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  6 Feb 2019 12:41:45 +0000 (GMT)
From: Chandan Rajendra <chandan@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: BUG: memcmp(): Accessing invalid memory location
Date: Wed, 06 Feb 2019 18:12:21 +0530
Organization: IBM
In-Reply-To: <87tvhhkufn.fsf@concordia.ellerman.id.au>
References: <17042269.pB4heZKTbK@localhost.localdomain>
 <3007738.Qcfhteo05g@localhost.localdomain>
 <87tvhhkufn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19020612-0016-0000-0000-00000253209E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020612-0017-0000-0000-000032AD29AC
Message-Id: <8003799.llySgfcyUA@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-06_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Simon Guo <wei.guo.simon@gmail.com>, Anton Blanchard <anton@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wednesday, February 6, 2019 5:20:04 PM IST Michael Ellerman wrote:
> Chandan Rajendra <chandan@linux.ibm.com> writes:
> > On Friday, February 1, 2019 4:43:52 PM IST Michael Ellerman wrote:
> >> Michael Ellerman <mpe@ellerman.id.au> writes:
> >> 
> >> > Adding Simon who wrote the code.
> >> >
> >> > Chandan Rajendra <chandan@linux.ibm.com> writes:
> >> >> When executing fstests' generic/026 test, I hit the following call trace,
> >> >>
> >> >> [  417.061038] BUG: Unable to handle kernel data access at 0xc00000062ac40000
> >> >> [  417.062172] Faulting instruction address: 0xc000000000092240
> >> >> [  417.062242] Oops: Kernel access of bad area, sig: 11 [#1]
> >> >> [  417.062299] LE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
> >> >> [  417.062366] Modules linked in:
> >> >> [  417.062401] CPU: 0 PID: 27828 Comm: chacl Not tainted 5.0.0-rc2-next-20190115-00001-g6de6dba64dda #1
> >> >> [  417.062495] NIP:  c000000000092240 LR: c00000000066a55c CTR: 0000000000000000
> >> >> [  417.062567] REGS: c00000062c0c3430 TRAP: 0300   Not tainted  (5.0.0-rc2-next-20190115-00001-g6de6dba64dda)
> >> >> [  417.062660] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000842  XER: 20000000
> >> >> [  417.062750] CFAR: 00007fff7f3108ac DAR: c00000062ac40000 DSISR: 40000000 IRQMASK: 0
> >> >>                GPR00: 0000000000000000 c00000062c0c36c0 c0000000017f4c00 c00000000121a660
> >> >>                GPR04: c00000062ac3fff9 0000000000000004 0000000000000020 00000000275b19c4
> >> >>                GPR08: 000000000000000c 46494c4500000000 5347495f41434c5f c0000000026073a0
> >> >>                GPR12: 0000000000000000 c0000000027a0000 0000000000000000 0000000000000000
> >> >>                GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> >> >>                GPR20: c00000062ea70020 c00000062c0c38d0 0000000000000002 0000000000000002
> >> >>                GPR24: c00000062ac3ffe8 00000000275b19c4 0000000000000001 c00000062ac30000
> >> >>                GPR28: c00000062c0c38d0 c00000062ac30050 c00000062ac30058 0000000000000000
> >> >> [  417.063563] NIP [c000000000092240] memcmp+0x120/0x690
> >> >> [  417.063635] LR [c00000000066a55c] xfs_attr3_leaf_lookup_int+0x53c/0x5b0
> >> >> [  417.063709] Call Trace:
> >> >> [  417.063744] [c00000062c0c36c0] [c00000000066a098] xfs_attr3_leaf_lookup_int+0x78/0x5b0 (unreliable)
> >> >> [  417.063851] [c00000062c0c3760] [c000000000693f8c] xfs_da3_node_lookup_int+0x32c/0x5a0
> >> >> [  417.063944] [c00000062c0c3820] [c0000000006634a0] xfs_attr_node_addname+0x170/0x6b0
> >> >> [  417.064034] [c00000062c0c38b0] [c000000000664ffc] xfs_attr_set+0x2ac/0x340
> >> >> [  417.064118] [c00000062c0c39a0] [c000000000758d40] __xfs_set_acl+0xf0/0x230
> >> >> [  417.064190] [c00000062c0c3a00] [c000000000758f50] xfs_set_acl+0xd0/0x160
> >> >> [  417.064268] [c00000062c0c3aa0] [c0000000004b69b0] set_posix_acl+0xc0/0x130
> >> >> [  417.064339] [c00000062c0c3ae0] [c0000000004b6a88] posix_acl_xattr_set+0x68/0x110
> >> >> [  417.064412] [c00000062c0c3b20] [c0000000004532d4] __vfs_setxattr+0xa4/0x110
> >> >> [  417.064485] [c00000062c0c3b80] [c000000000454c2c] __vfs_setxattr_noperm+0xac/0x240
> >> >> [  417.064566] [c00000062c0c3bd0] [c000000000454ee8] vfs_setxattr+0x128/0x130
> >> >> [  417.064638] [c00000062c0c3c30] [c000000000455138] setxattr+0x248/0x600
> >> >> [  417.064710] [c00000062c0c3d90] [c000000000455738] path_setxattr+0x108/0x120
> >> >> [  417.064785] [c00000062c0c3e00] [c000000000455778] sys_setxattr+0x28/0x40
> >> >> [  417.064858] [c00000062c0c3e20] [c00000000000bae4] system_call+0x5c/0x70
> >> >> [  417.064930] Instruction dump:
> >> >> [  417.064964] 7d201c28 7d402428 7c295040 38630008 38840008 408201f0 4200ffe8 2c050000
> >> >> [  417.065051] 4182ff6c 20c50008 54c61838 7d201c28 <7d402428> 7d293436 7d4a3436 7c295040
> >> >> [  417.065150] ---[ end trace 0d060411b5e3741b ]---
> >> >>
> >> >>
> >> >> Both the memory locations passed to memcmp() had "SGI_ACL_FILE" and len
> >> >> argument of memcmp() was set to 12. s1 argument of memcmp() had the value
> >> >> 0x00000000f4af0485, while s2 argument had the value 0x00000000ce9e316f.
> >> >>
> >> >> The following is the code path within memcmp() that gets executed for the
> >> >> above mentioned values,
> >> >>
> >> >> - Since len (i.e. 12) is greater than 7, we branch to .Lno_short.
> >> >> - We then prefetch the contents of r3 & r4 and branch to
> >> >>   .Ldiffoffset_8bytes_make_align_start.
> >> >> - Under .Ldiffoffset_novmx_cmp, Since r3 is unaligned we end up comparing
> >> >>   "SGI" part of the string. r3's value is then aligned. r4's value is
> >> >>   incremented by 3. For comparing the remaining 9 bytes, we jump to
> >> >>   .Lcmp_lt32bytes.
> >> >> - Here, 8 bytes of the remaining 9 bytes are compared and execution moves to
> >> >>   .Lcmp_rest_lt8bytes.
> >> >> - Here we execute "LD rB,0,r4". In the case of this bug, r4 has an unaligned
> >> >>   value and hence ends up accessing the "next" double word. The "next" double
> >> >>   word happens to occur after the last page mapped into the kernel's address
> >> >>   space and hence this leads to the previously listed oops.
> >> >
> >> > Thanks for the analysis.
> >> >
> >> > This is just a bug, we can't read past the end of the source or dest.
> >> 
> >> How about this, works for me.
> >> 
> >> cheers
> >> 
> >> diff --git a/arch/powerpc/lib/memcmp_64.S b/arch/powerpc/lib/memcmp_64.S
> >> index 844d8e774492..2a302158cb53 100644
> >> --- a/arch/powerpc/lib/memcmp_64.S
> >> +++ b/arch/powerpc/lib/memcmp_64.S
> >> @@ -215,20 +215,29 @@ _GLOBAL_TOC(memcmp)
> >>  	beq	.Lzero
> >>  
> >>  .Lcmp_rest_lt8bytes:
> >> -	/* Here we have only less than 8 bytes to compare with. at least s1
> >> -	 * Address is aligned with 8 bytes.
> >> -	 * The next double words are load and shift right with appropriate
> >> -	 * bits.
> >> +	/*
> >> +	 * Here we have less than 8 bytes left to compare with. We mustn't read
> >> +	 * past the end of either source or dest.
> >>  	 */
> >> -	subfic  r6,r5,8
> >> -	slwi	r6,r6,3
> >> -	LD	rA,0,r3
> >> -	LD	rB,0,r4
> >> -	srd	rA,rA,r6
> >> -	srd	rB,rB,r6
> >> -	cmpld	cr0,rA,rB
> >> +
> >> +	/* If we have less than 4 bytes, just do byte at a time */
> >> +	cmpwi   cr1, r5, 4
> >> +	blt	cr1, .Lshort
> >> +
> >> +	/* Compare 4 bytes */
> >> +	LW	rA,0,r3
> >> +	LW	rB,0,r4
> >> +	cmpd	cr0,rA,rB
> >>  	bne	cr0,.LcmpAB_lightweight
> >> -	b	.Lzero
> >> +
> >> +	/* If we had exactly 4 bytes left, we're done now */
> >> +	beq	cr1, .Lzero
> >> +
> >> +	/* Otherwise do what ever's left a byte at a time */
> >> +	subi	r5, r5, 4
> >> +	addi	r3, r3, 4
> >> +	addi	r4, r4, 4
> >> +	b	.Lshort
> >>  
> >>  .Lnon_zero:
> >>  	mr	r3,rC
> >> 
> >> 
> >
> > With the above patch, Linux kernel does not end up in oops. Hence,
> >
> > Tested-by: Chandan Rajendra <chandan@linux.ibm.com>
> 
> Thanks.
> 
> How many times had you hit the original oops? ie. was it easily
> reproducible?

I could recreate the issue within 20 iterations of the test. For verifying
your patch, I let the test run for 500 iterations.

-- 
chandan



