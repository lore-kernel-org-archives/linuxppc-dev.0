Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0022C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 09:19:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E83206DD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 09:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E83206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Dp9g1818zDqF0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 20:19:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Dp7w64xCzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2019 20:17:48 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x26949tB086454
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2019 04:17:46 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r29u4da98-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 04:17:45 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 6 Mar 2019 09:17:42 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 6 Mar 2019 09:17:39 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x269Hc9p24641788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Mar 2019 09:17:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2DF911C052;
 Wed,  6 Mar 2019 09:17:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10D9E11C050;
 Wed,  6 Mar 2019 09:17:36 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.59.8])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  6 Mar 2019 09:17:35 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, Oliver <oohall@gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
In-Reply-To: <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
Date: Wed, 06 Mar 2019 14:47:33 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
x-cbid: 19030609-0016-0000-0000-0000025E6DC4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030609-0017-0000-0000-000032B8F4B1
Message-Id: <87k1hc8iqa.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-06_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060063
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Ross Zwisler <zwisler@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dan Williams <dan.j.williams@intel.com> writes:

> On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
>>
>> On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
>> <aneesh.kumar@linux.ibm.com> wrote:
>> >
>> > Add a flag to indicate the ability to do huge page dax mapping. On arc=
hitecture
>> > like ppc64, the hypervisor can disable huge page support in the guest.=
 In
>> > such a case, we should not enable huge page dax mapping. This patch ad=
ds
>> > a flag which the architecture code will update to indicate huge page
>> > dax mapping support.
>>
>> *groan*
>>
>> > Architectures mostly do transparent_hugepage_flag =3D 0; if they can't
>> > do hugepages. That also takes care of disabling dax hugepage mapping
>> > with this change.
>> >
>> > Without this patch we get the below error with kvm on ppc64.
>> >
>> > [  118.849975] lpar: Failed hash pte insert with error -4
>> >
>> > NOTE: The patch also use
>> >
>> > echo never > /sys/kernel/mm/transparent_hugepage/enabled
>> > to disable dax huge page mapping.
>> >
>> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> > ---
>> > TODO:
>> > * Add Fixes: tag
>> >
>> >  include/linux/huge_mm.h | 4 +++-
>> >  mm/huge_memory.c        | 4 ++++
>> >  2 files changed, 7 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> > index 381e872bfde0..01ad5258545e 100644
>> > --- a/include/linux/huge_mm.h
>> > +++ b/include/linux/huge_mm.h
>> > @@ -53,6 +53,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_area_struct =
*vma, unsigned long addr,
>> >                         pud_t *pud, pfn_t pfn, bool write);
>> >  enum transparent_hugepage_flag {
>> >         TRANSPARENT_HUGEPAGE_FLAG,
>> > +       TRANSPARENT_HUGEPAGE_DAX_FLAG,
>> >         TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>> >         TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
>> >         TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
>> > @@ -111,7 +112,8 @@ static inline bool __transparent_hugepage_enabled(=
struct vm_area_struct *vma)
>> >         if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FL=
AG))
>> >                 return true;
>> >
>> > -       if (vma_is_dax(vma))
>> > +       if (vma_is_dax(vma) &&
>> > +           (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_D=
AX_FLAG)))
>> >                 return true;
>>
>> Forcing PTE sized faults should be fine for fsdax, but it'll break
>> devdax. The devdax driver requires the fault size be >=3D the namespace
>> alignment since devdax tries to guarantee hugepage mappings will be
>> used and PMD alignment is the default. We can probably have devdax
>> fall back to the largest size the hypervisor has made available, but
>> it does run contrary to the design. Ah well, I suppose it's better off
>> being degraded rather than unusable.
>
> Given this is an explicit setting I think device-dax should explicitly
> fail to enable in the presence of this flag to preserve the
> application visible behavior.
>
> I.e. if device-dax was enabled after this setting was made then I
> think future faults should fail as well.

Not sure I understood that. Now we are disabling the ability to map
pages as huge pages. I am now considering that this should not be
user configurable. Ie, this is something that platform can use to avoid
dax forcing huge page mapping, but if the architecture can enable huge
dax mapping, we should always default to using that.

Now w.r.t to failures, can device-dax do an opportunistic huge page
usage? I haven't looked at the device-dax details fully yet. Do we make the
assumption of the mapping page size as a format w.r.t device-dax? Is that
derived from nd_pfn->align value?

Here is what I am working on:
1) If the platform doesn't support huge page=C2=A0and if the device superbl=
ock
indicated that it was created with huge page support, we fail the device
init.

2) Now if we are creating a new namespace without huge page support in
the platform, then we force the align details to PAGE_SIZE. In such a
configuration when handling dax fault even with THP enabled during
the build, we should not try to use hugepage. This I think we can
achieve by using TRANSPARENT_HUGEPAEG_DAX_FLAG.

Also even if the user decided to not use THP, by
echo "never" > transparent_hugepage/enabled , we should continue to map
dax fault using huge page on platforms that can support huge pages.

This still doesn't cover the details of a device-dax created with
PAGE_SIZE align later booted with a kernel that can do hugepage dax.How
should we handle that? That makes me think, this should be a VMA flag
which got derived from device config? May be use VM_HUGEPAGE to indicate
if device should use a hugepage mapping or not?

-aneesh

