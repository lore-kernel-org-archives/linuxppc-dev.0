Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9DDC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 09:52:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5B320892
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 09:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5B320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42xD6H5BlVzF3kP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 20:52:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sandipan@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42xD4C6kXszF3jl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 20:50:16 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAG9iDwo117644
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 04:50:14 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nst9akgxk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 04:50:13 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Fri, 16 Nov 2018 09:50:11 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 16 Nov 2018 09:50:10 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAG9o9GI10617144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Nov 2018 09:50:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 694BEAE045;
 Fri, 16 Nov 2018 09:50:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC1FAAE055;
 Fri, 16 Nov 2018 09:50:08 +0000 (GMT)
Received: from [9.124.31.81] (unknown [9.124.31.81])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 16 Nov 2018 09:50:08 +0000 (GMT)
Subject: Re: [PATCH] powerpc/64: Fix kernel stack 16-byte alignment
To: Nicholas Piggin <npiggin@gmail.com>
References: <20181115023427.31033-1-npiggin@gmail.com>
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Fri, 16 Nov 2018 15:20:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115023427.31033-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111609-0008-0000-0000-00000293B6BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111609-0009-0000-0000-000021FDD51A
Message-Id: <6627fcee-17c9-4e04-35c8-898663aac85c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160089
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 15/11/18 8:04 AM, Nicholas Piggin wrote:
> Commit 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
> than thread_struct") changed sizeof(struct pt_regs) % 16 from 0 to 8,
> which causes the interrupt frame allocation on kernel entry to put the
> kernel stack out of alignment.
> 
> Add a pad field to fix alignment, and add a BUILD_BUG_ON to catch this
> in future.
> 
> Fixes: 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
> than thread_struct")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [...]

Thanks for fixing this. Commit 4c2de74cc869 ("powerpc/64: Interrupts save
PPR on stack rather than thread_struct") was also leading to incorrect
kernel stack traces.

E.g.
If you are using `perf record -g` and expect to see a stack trace like this:

        c0000000002b19a0 bpf_check+0x1910 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
        c0000000002a5554 bpf_prog_load+0x684 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
        c0000000002a6938 sys_bpf+0xaf8 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
        c00000000000b9e4 system_call+0x5c (/usr/lib/debug/lib/modules/4.18.17-200.fc28.ppc64le/vmlinux)
            7fff815bca90 syscall+0x50 (/usr/lib64/libc-2.27.so)
            7fff7d96ee0c bpf_prog_load+0x16c (/usr/lib64/libbcc.so.0.7.0)
[...]

you would instead see something like this:

        c0000000002bdb88 bpf_check+0xb88 (/lib/modules/4.20.0-rc1+/build/vmlinux)
        c0000000002bdb60 bpf_check+0xb60 (/lib/modules/4.20.0-rc1+/build/vmlinux)
            3fff8f350a90 syscall+0x50 (/usr/lib64/libc-2.27.so)
            3fff8b788e0c bpf_prog_load+0x16c (/usr/lib64/libbcc.so.0.7.0)
[...]

--
With Regards,
Sandipan

