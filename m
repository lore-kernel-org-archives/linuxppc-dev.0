Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8AFC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 09:30:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19B3223B0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 09:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19B3223B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tlq95d14zF3Vh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 20:30:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bharata@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tlmy6khPzF3S0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 20:28:34 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAC9JR26146054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 04:28:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nq4xyn2e0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 04:28:31 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 12 Nov 2018 09:28:29 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Nov 2018 09:28:26 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAC9SO3E63307906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Nov 2018 09:28:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCECA11C050;
 Mon, 12 Nov 2018 09:28:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17C1411C04A;
 Mon, 12 Nov 2018 09:28:23 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.50.113])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Nov 2018 09:28:22 +0000 (GMT)
Date: Mon, 12 Nov 2018 14:58:20 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [RFC PATCH v1 1/4] kvmppc: HMM backend driver to manage pages of
 secure guest
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-2-bharata@linux.ibm.com>
 <20181030050300.GA11072@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181030050300.GA11072@blackberry>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111209-0012-0000-0000-000002C9136B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111209-0013-0000-0000-000020FE1B28
Message-Id: <20181112092820.GB17399@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-12_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120086
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
Reply-To: bharata@linux.ibm.com
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org, benh@linux.ibm.com,
 linux-mm@kvack.org, jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 paulus@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 04:03:00PM +1100, Paul Mackerras wrote:
> On Mon, Oct 22, 2018 at 10:48:34AM +0530, Bharata B Rao wrote:
> > HMM driver for KVM PPC to manage page transitions of
> > secure guest via H_SVM_PAGE_IN and H_SVM_PAGE_OUT hcalls.
> > 
> > H_SVM_PAGE_IN: Move the content of a normal page to secure page
> > H_SVM_PAGE_OUT: Move the content of a secure page to normal page
> 
> Comments below...

Thanks for your comments, I have addressed all of your comments in the
next version I am about to post out soon. I will reply only to the
questions here:

> > diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
> > new file mode 100644
> > index 000000000000..a2ee3163a312
> > --- /dev/null
> > +++ b/arch/powerpc/kvm/book3s_hv_hmm.c
> > @@ -0,0 +1,514 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * HMM driver to manage page migration between normal and secure
> > + * memory.
> > + *
> > + * Based on Jérôme Glisse's HMM dummy driver.
> > + *
> > + * Copyright 2018 Bharata B Rao, IBM Corp. <bharata@linux.ibm.com>
> > + */
> > +
> > +/*
> > + * A pseries guest can be run as a secure guest on Ultravisor-enabled
> > + * POWER platforms. On such platforms, this driver will be used to manage
> > + * the movement of guest pages between the normal memory managed by
> > + * hypervisor (HV) and secure memory managed by Ultravisor (UV).
> > + *
> > + * Private ZONE_DEVICE memory equal to the amount of secure memory
> > + * available in the platform for running secure guests is created
> > + * via a HMM device. The movement of pages between normal and secure
> > + * memory is done by ->alloc_and_copy() callback routine of migrate_vma().
> > + *
> > + * The page-in or page-out requests from UV will come to HV as hcalls and
> > + * HV will call back into UV via uvcalls to satisfy these page requests.
> > + *
> > + * For each page that gets moved into secure memory, a HMM PFN is used
> > + * on the HV side and HMM migration PTE corresponding to that PFN would be
> > + * populated in the QEMU page tables. A per-guest hash table is created to
> > + * manage the pool of HMM PFNs. Guest real address is used as key to index
> > + * into the hash table and choose a free HMM PFN.
> > + */
> > +
> > +#include <linux/hmm.h>
> > +#include <linux/kvm_host.h>
> > +#include <linux/sched/mm.h>
> > +#include <asm/ucall-api.h>
> > +
> > +static struct kvmppc_hmm_device *kvmppc_hmm;
> > +spinlock_t kvmppc_hmm_lock;
> > +
> > +#define KVMPPC_HMM_HASH_BITS    10
> > +#define KVMPPC_HMM_HASH_SIZE   (1 << KVMPPC_HMM_HASH_BITS)
> > +
> > +struct kvmppc_hmm_pfn_entry {
> > +	struct hlist_node hlist;
> > +	unsigned long addr;
> > +	unsigned long hmm_pfn;
> > +};
> > +
> > +struct kvmppc_hmm_page_pvt {
> > +	struct hlist_head *hmm_hash;
> > +	unsigned int lpid;
> > +	unsigned long gpa;
> > +};
> > +
> > +struct kvmppc_hmm_migrate_args {
> > +	struct hlist_head *hmm_hash;
> > +	unsigned int lpid;
> > +	unsigned long gpa;
> > +	unsigned long page_shift;
> > +};
> > +
> > +int kvmppc_hmm_hash_create(struct kvm *kvm)
> > +{
> > +	int i;
> > +
> > +	kvm->arch.hmm_hash = kzalloc(KVMPPC_HMM_HASH_SIZE *
> > +				     sizeof(struct hlist_head), GFP_KERNEL);
> > +	if (!kvm->arch.hmm_hash)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < KVMPPC_HMM_HASH_SIZE; i++)
> > +		INIT_HLIST_HEAD(&kvm->arch.hmm_hash[i]);
> > +	return 0;
> > +}
> 
> I gather that this hash table maps a guest real address (or pfn) to a
> hmm_pfn, is that right?  I think that mapping could be stored in the
> rmap arrays attached to the memslots, since there won't be any
> hypervisor-side mappings of the page while it is over in the secure
> space.  But maybe that could be a future optimization.

Hash table exists for two reasons:

- When guest/UV requests for a shared page-in, we need to quickly lookup
  if HV has ever given that page to UV as secure page and hence maintains
  only HMM PFN for it. We can walk the linux page table to figure this
  out and since only a small fraction of guest's pages are shared, the
  cost of lookup shouldn't cause much overhead.
- When the guest is destroyed, we need release all HMM pages that HV
  is using to keep track of secure pages. So it becomes easier if there
  is one centralized place (hash table in this case) where we can release
  all pages. I think using rmap arrays as you suggest should cover this
  case.

> 
> > +/*
> > + * Cleanup the HMM pages hash table when guest terminates
> > + *
> > + * Iterate over all the HMM pages hash list entries and release
> > + * reference on them. The actual freeing of the entry happens
> > + * via hmm_devmem_ops.free path.
> > + */
> > +void kvmppc_hmm_hash_destroy(struct kvm *kvm)
> > +{
> > +	int i;
> > +	struct kvmppc_hmm_pfn_entry *p;
> > +	struct page *hmm_page;
> > +
> > +	for (i = 0; i < KVMPPC_HMM_HASH_SIZE; i++) {
> > +		while (!hlist_empty(&kvm->arch.hmm_hash[i])) {
> > +			p = hlist_entry(kvm->arch.hmm_hash[i].first,
> > +					struct kvmppc_hmm_pfn_entry,
> > +					hlist);
> > +			hmm_page = pfn_to_page(p->hmm_pfn);
> > +			put_page(hmm_page);
> > +		}
> > +	}
> > +	kfree(kvm->arch.hmm_hash);
> > +}
> > +
> > +static u64 kvmppc_hmm_pfn_hash_fn(u64 addr)
> > +{
> > +	return hash_64(addr, KVMPPC_HMM_HASH_BITS);
> > +}
> > +
> > +static void
> > +kvmppc_hmm_hash_free_pfn(struct hlist_head *hmm_hash, unsigned long gpa)
> > +{
> > +	struct kvmppc_hmm_pfn_entry *p;
> > +	struct hlist_head *list;
> > +
> > +	list = &hmm_hash[kvmppc_hmm_pfn_hash_fn(gpa)];
> > +	hlist_for_each_entry(p, list, hlist) {
> > +		if (p->addr == gpa) {
> > +			hlist_del(&p->hlist);
> > +			kfree(p);
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> > +/*
> > + * Get a free HMM PFN from the pool
> > + *
> > + * Called when a normal page is moved to secure memory (UV_PAGE_IN). HMM
> > + * PFN will be used to keep track of the secure page on HV side.
> > + */
> > +static struct page *kvmppc_hmm_get_page(struct hlist_head *hmm_hash,
> > +					unsigned long gpa, unsigned int lpid)
> > +{
> > +	struct page *dpage = NULL;
> > +	unsigned long bit;
> > +	unsigned long nr_pfns = kvmppc_hmm->devmem->pfn_last -
> > +				kvmppc_hmm->devmem->pfn_first;
> > +	struct hlist_head *list;
> > +	struct kvmppc_hmm_pfn_entry *p;
> > +	bool found = false;
> > +	unsigned long flags;
> > +	struct kvmppc_hmm_page_pvt *pvt;
> > +
> > +	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
> > +	list = &hmm_hash[kvmppc_hmm_pfn_hash_fn(gpa)];
> > +	hlist_for_each_entry(p, list, hlist) {
> > +		if (p->addr == gpa) {
> > +			found = true;
> > +			break;
> > +		}
> > +	}
> > +	if (!found) {
> > +		p = kzalloc(sizeof(struct kvmppc_hmm_pfn_entry), GFP_ATOMIC);
> > +		if (!p) {
> > +			spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
> > +			return NULL;
> > +		}
> > +		p->addr = gpa;
> > +		bit = find_first_zero_bit(kvmppc_hmm->pfn_bitmap, nr_pfns);
> > +		if (bit >= nr_pfns) {
> > +			kfree(p);
> > +			spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
> > +			return NULL;
> > +		}
> > +		bitmap_set(kvmppc_hmm->pfn_bitmap, bit, 1);
> > +		p->hmm_pfn = bit + kvmppc_hmm->devmem->pfn_first;
> > +		INIT_HLIST_NODE(&p->hlist);
> > +		hlist_add_head(&p->hlist, list);
> > +	} else {
> > +		spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
> > +		return NULL;
> > +	}
> 
> I suggest you redo that if statement as:
> 
> 	if (found) {
> 		spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
> 		return NULL;
> 	}
> 
> and then have the main path (the code starting with p = kzalloc...) at
> a single level of indentation, so the normal/successful path is more
> obvious.
> 
> > +	dpage = pfn_to_page(p->hmm_pfn);
> > +
> > +	if (!trylock_page(dpage)) {
> 
> Where does this page get unlocked?

At the end of migrate_vma() in whose alloc_and_copy() callback this
lock_page() is done.

Regards,
Bharata.

