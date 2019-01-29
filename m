Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61587C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 10:45:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDD320881
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 10:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDD320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pjnm6gr8zDqMH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 21:45:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pjly4Gl2zDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 21:43:58 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0TAdee3035451
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 05:43:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qamd43ar0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 05:43:55 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 29 Jan 2019 10:43:54 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 10:43:50 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0TAhnFc56950932
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Jan 2019 10:43:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5373F11C04A;
 Tue, 29 Jan 2019 10:43:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D1C511C05B;
 Tue, 29 Jan 2019 10:43:47 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.71.101])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 10:43:47 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, akpm@linux-foundation.org, x86@kernel.org
Subject: Re: [PATCH V5 0/5] NestMMU pte upgrade workaround for mprotect
In-Reply-To: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 29 Jan 2019 16:13:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012910-0020-0000-0000-0000030D407E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012910-0021-0000-0000-0000215E4385
Message-Id: <87va27agm6.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=526 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290082
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Andrew,

How do you want to merge this? Michael Ellerman suggests this should go
via -mm tree.

-aneesh


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> We can upgrade pte access (R -> RW transition) via mprotect. We need
> to make sure we follow the recommended pte update sequence as outlined in
> commit bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
> for such updates. This patch series do that.
>
> Changes from V4:
> * Drop EXPORT_SYMBOL 
>
> Changes from V3:
> * Build fix for x86
>
> Changes from V2:
> * Update commit message for patch 4
> * use radix tlb flush routines directly.
>
> Changes from V1:
> * Restrict ths only for R->RW upgrade. We don't need to do this for Autonuma
> * Restrict this only for radix translation mode.
>
>
> Aneesh Kumar K.V (5):
>   mm: Update ptep_modify_prot_start/commit to take vm_area_struct as arg
>   mm: update ptep_modify_prot_commit to take old pte value as arg
>   arch/powerpc/mm: Nest MMU workaround for mprotect RW upgrade.
>   mm/hugetlb: Add prot_modify_start/commit sequence for hugetlb update
>   arch/powerpc/mm/hugetlb: NestMMU workaround for hugetlb mprotect RW
>     upgrade
>
>  arch/powerpc/include/asm/book3s/64/hugetlb.h | 12 ++++++++++
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++++
>  arch/powerpc/include/asm/book3s/64/radix.h   |  4 ++++
>  arch/powerpc/mm/hugetlbpage-hash64.c         | 25 ++++++++++++++++++++
>  arch/powerpc/mm/hugetlbpage-radix.c          | 17 +++++++++++++
>  arch/powerpc/mm/pgtable-book3s64.c           | 25 ++++++++++++++++++++
>  arch/powerpc/mm/pgtable-radix.c              | 18 ++++++++++++++
>  arch/s390/include/asm/pgtable.h              |  5 ++--
>  arch/s390/mm/pgtable.c                       |  8 ++++---
>  arch/x86/include/asm/paravirt.h              | 13 +++++-----
>  arch/x86/include/asm/paravirt_types.h        |  5 ++--
>  arch/x86/xen/mmu.h                           |  4 ++--
>  arch/x86/xen/mmu_pv.c                        |  8 +++----
>  fs/proc/task_mmu.c                           |  8 ++++---
>  include/asm-generic/pgtable.h                | 18 +++++++-------
>  include/linux/hugetlb.h                      | 20 ++++++++++++++++
>  mm/hugetlb.c                                 |  8 ++++---
>  mm/memory.c                                  |  8 +++----
>  mm/mprotect.c                                |  6 ++---
>  19 files changed, 189 insertions(+), 41 deletions(-)
>
> -- 
> 2.20.1

