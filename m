Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE23C10F05
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 08:15:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265842184D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265842184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PN553tpszDqHq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 19:15:05 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PN1T2YnvzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 19:11:56 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K86mSo143819
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 04:11:54 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rbet9fvyr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 04:11:54 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 20 Mar 2019 08:06:46 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 08:06:41 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K86k5o26214620
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2019 08:06:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C298C4C046;
 Wed, 20 Mar 2019 08:06:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1503C4C040;
 Wed, 20 Mar 2019 08:06:45 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.31.96])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Mar 2019 08:06:44 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
In-Reply-To: <CAPcyv4i0SahDP=_ZQV3RG_b5pMkjn-9Cjy7OpY2sm1PxLdO8jA@mail.gmail.com>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
 <CAPcyv4ir4irASBQrZD_a6kMkEUt=XPUCuKajF75O7wDCgeG=7Q@mail.gmail.com>
 <871s3aqfup.fsf@linux.ibm.com>
 <CAPcyv4i0SahDP=_ZQV3RG_b5pMkjn-9Cjy7OpY2sm1PxLdO8jA@mail.gmail.com>
Date: Wed, 20 Mar 2019 13:36:43 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19032008-0020-0000-0000-000003257506
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032008-0021-0000-0000-00002177926D
Message-Id: <87bm267ywc.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200068
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Ross Zwisler <zwisler@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dan Williams <dan.j.williams@intel.com> writes:

>
>> Now what will be page size used for mapping vmemmap?
>
> That's up to the architecture's vmemmap_populate() implementation.
>
>> Architectures
>> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
>> device-dax with struct page in the device will have pfn reserve area aligned
>> to PAGE_SIZE with the above example? We can't map that using
>> PMD_SIZE page size?
>
> IIUC, that's a different alignment. Currently that's handled by
> padding the reservation area up to a section (128MB on x86) boundary,
> but I'm working on patches to allow sub-section sized ranges to be
> mapped.

I am missing something w.r.t code. The below code align that using nd_pfn->align

	if (nd_pfn->mode == PFN_MODE_PMEM) {
		unsigned long memmap_size;

		/*
		 * vmemmap_populate_hugepages() allocates the memmap array in
		 * HPAGE_SIZE chunks.
		 */
		memmap_size = ALIGN(64 * npfns, HPAGE_SIZE);
		offset = ALIGN(start + SZ_8K + memmap_size + dax_label_reserve,
				nd_pfn->align) - start;
      }

IIUC that is finding the offset where to put vmemmap start. And that has
to be aligned to the page size with which we may end up mapping vmemmap
area right?

Yes we find the npfns by aligning up using PAGES_PER_SECTION. But that
is to compute howmany pfns we should map for this pfn dev right?
	
-aneesh

