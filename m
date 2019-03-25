Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6BDC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:39:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA2D20830
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 06:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA2D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SPkp6D20zDqHP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 17:39:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SPhv0vndzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:38:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44SPht3ny1z8tP4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 17:38:06 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44SPht31brz9sSq; Mon, 25 Mar 2019 17:38:06 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=chandan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44SPhs6NNBz9sSh
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2019 17:38:05 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2P6ScHZ108630
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2019 02:38:02 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2req236bpd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Mar 2019 02:38:02 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <chandan@linux.ibm.com>;
 Mon, 25 Mar 2019 06:38:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 25 Mar 2019 06:37:57 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2P6buWC59506820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2019 06:37:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C177A4059;
 Mon, 25 Mar 2019 06:37:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA6FEA4053;
 Mon, 25 Mar 2019 06:37:55 +0000 (GMT)
Received: from dhcp-9-109-212-56.localnet (unknown [9.124.35.173])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2019 06:37:55 +0000 (GMT)
From: Chandan Rajendra <chandan@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc/64: Fix memcmp reading past the end of src/dest
Date: Mon, 25 Mar 2019 12:08:46 +0530
Organization: IBM
In-Reply-To: <20190322123724.28435-1-mpe@ellerman.id.au>
References: <20190322123724.28435-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19032506-0028-0000-0000-00000357DCCE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032506-0029-0000-0000-000024168DE3
Message-Id: <2997030.PB4NAd2PaR@dhcp-9-109-212-56>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-25_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=10 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250049
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Friday, March 22, 2019 6:07:24 PM IST Michael Ellerman wrote:
> Chandan reported that fstests' generic/026 test hit a crash:
> 
>   BUG: Unable to handle kernel data access at 0xc00000062ac40000
>   Faulting instruction address: 0xc000000000092240
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   LE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
>   CPU: 0 PID: 27828 Comm: chacl Not tainted 5.0.0-rc2-next-20190115-00001-g6de6dba64dda #1
>   NIP:  c000000000092240 LR: c00000000066a55c CTR: 0000000000000000
>   REGS: c00000062c0c3430 TRAP: 0300   Not tainted  (5.0.0-rc2-next-20190115-00001-g6de6dba64dda)
>   MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000842  XER: 20000000
>   CFAR: 00007fff7f3108ac DAR: c00000062ac40000 DSISR: 40000000 IRQMASK: 0
>   GPR00: 0000000000000000 c00000062c0c36c0 c0000000017f4c00 c00000000121a660
>   GPR04: c00000062ac3fff9 0000000000000004 0000000000000020 00000000275b19c4
>   GPR08: 000000000000000c 46494c4500000000 5347495f41434c5f c0000000026073a0
>   GPR12: 0000000000000000 c0000000027a0000 0000000000000000 0000000000000000
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   GPR20: c00000062ea70020 c00000062c0c38d0 0000000000000002 0000000000000002
>   GPR24: c00000062ac3ffe8 00000000275b19c4 0000000000000001 c00000062ac30000
>   GPR28: c00000062c0c38d0 c00000062ac30050 c00000062ac30058 0000000000000000
>   NIP memcmp+0x120/0x690
>   LR  xfs_attr3_leaf_lookup_int+0x53c/0x5b0
>   Call Trace:
>     xfs_attr3_leaf_lookup_int+0x78/0x5b0 (unreliable)
>     xfs_da3_node_lookup_int+0x32c/0x5a0
>     xfs_attr_node_addname+0x170/0x6b0
>     xfs_attr_set+0x2ac/0x340
>     __xfs_set_acl+0xf0/0x230
>     xfs_set_acl+0xd0/0x160
>     set_posix_acl+0xc0/0x130
>     posix_acl_xattr_set+0x68/0x110
>     __vfs_setxattr+0xa4/0x110
>     __vfs_setxattr_noperm+0xac/0x240
>     vfs_setxattr+0x128/0x130
>     setxattr+0x248/0x600
>     path_setxattr+0x108/0x120
>     sys_setxattr+0x28/0x40
>     system_call+0x5c/0x70
>   Instruction dump:
>   7d201c28 7d402428 7c295040 38630008 38840008 408201f0 4200ffe8 2c050000
>   4182ff6c 20c50008 54c61838 7d201c28 <7d402428> 7d293436 7d4a3436 7c295040
> 
> The instruction dump decodes as:
>   subfic  r6,r5,8
>   rlwinm  r6,r6,3,0,28
>   ldbrx   r9,0,r3
>   ldbrx   r10,0,r4      <-
> 
> Which shows us doing an 8 byte load from c00000062ac3fff9, which
> crosses the page boundary at c00000062ac40000 and faults.
> 
> It's not OK for memcmp to read past the end of the source or
> destination buffers if that would cross a page boundary, because we
> don't know that the next page is mapped.
> 
> As pointed out by Segher, we can read past the end of the source or
> destination as long as we don't cross a 4K boundary, because that's
> our minimum page size on all platforms.
> 
> The bug is in the code at the .Lcmp_rest_lt8bytes label. When we get
> there we know that s1 is 8-byte aligned and we have at least 1 byte to
> read, so a single 8-byte load won't read past the end of s1 and cross
> a page boundary.
> 
> But we have to be more careful with s2. So check if it's within 8
> bytes of a 4K boundary and if so go to the byte-by-byte loop.
> 
> Fixes: 2d9ee327adce ("powerpc/64: Align bytes before fall back to .Lshort in powerpc64 memcmp()")
> Cc: stable@vger.kernel.org # v4.19+
> Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

For unknown reasons, I am unable to recreate this bug on the unmodified
next-20190115 which was the original kernel I had found this bug on.

FWIW, I have executed generic/026 on a next-20190115 kernel with this patch
applied and I wasn't able to recreate the bug. Hence,

Tested-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan



