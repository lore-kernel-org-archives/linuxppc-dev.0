Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773EEC169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 04:44:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCEE620870
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 04:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEE620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qngm57tgzDqWh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 15:44:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qndy5wqBzDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 15:42:30 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0V4YSeR080729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 23:42:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qbss2s13e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 23:42:28 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Thu, 31 Jan 2019 04:42:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 31 Jan 2019 04:42:23 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0V4gMYH8061232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 31 Jan 2019 04:42:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B029A4054;
 Thu, 31 Jan 2019 04:42:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E68E0A405F;
 Thu, 31 Jan 2019 04:42:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.38.122])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 31 Jan 2019 04:42:19 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org,
 Michal Hocko <mhocko@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH V7 3/4] powerpc/mm/iommu: Allow migration of cma allocated
 pages during mm_iommu_do_alloc
In-Reply-To: <874l9qqsz4.fsf@concordia.ellerman.id.au>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
 <20190114095438.32470-5-aneesh.kumar@linux.ibm.com>
 <874l9qqsz4.fsf@concordia.ellerman.id.au>
Date: Thu, 31 Jan 2019 10:12:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19013104-4275-0000-0000-000003081F78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013104-4276-0000-0000-00003816274C
Message-Id: <87pnsdo2ty.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-31_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310036
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> The current code doesn't do page migration if the page allocated is a compound page.
>> With HugeTLB migration support, we can end up allocating hugetlb pages from
>> CMA region. Also, THP pages can be allocated from CMA region. This patch updates
>> the code to handle compound pages correctly. The patch also switches to a single
>> get_user_pages with the right count, instead of doing one get_user_pages per page.
>> That avoids reading page table multiple times.
>
> It's not very obvious from the above description that the migration
> logic is now being done by get_user_pages_longterm(), it just looks like
> it's all being deleted in this patch. Would be good to mention that.
>
>> Since these page reference updates are long term pin, switch to
>> get_user_pages_longterm. That makes sure we fail correctly if the guest RAM
>> is backed by DAX pages.
>
> Can you explain that in more detail?

DAX pages lifetime is dictated by file system rules and as such, we need
to make sure that we free these pages on operations like truncate and
punch hole. If we have long term pin on these pages, which are mostly
return to userspace with elevated page count, the entity holding the
long term pin may not be aware of the fact that file got truncated and
the file system blocks possibly got reused. That can result in corruption.

Work is going on to solve this issue by either making operations like
truncate wait or to make these elevated reference counted page/file
system blocks not to be released back to the file system free list.

Till then we prevent long term pin on DAX pages.

Now that we have an API for long term pin, we should ideally be using
that in the vfio code.


>
>> The patch also converts the hpas member of mm_iommu_table_group_mem_t to a union.
>> We use the same storage location to store pointers to struct page. We cannot
>> update all the code path use struct page *, because we access hpas in real mode
>> and we can't do that struct page * to pfn conversion in real mode.
>
> That's a pain, it's asking for bugs mixing two different values in the
> same array. But I guess it's the least worst option.
>
> It sounds like that's a separate change you could do in a separate
> patch. But it's not, because it's tied to the fact that we're doing a
> single GUP call.

-aneesh

