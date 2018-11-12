Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3951C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 09:41:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B0E223C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 09:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B0E223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tm3T26vTzF3VC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 20:41:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bharata@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tm1D1VFTzF3Sd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 20:39:11 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAC9d7Rw084503
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 04:39:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nq4j4egvw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 04:39:08 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 12 Nov 2018 09:39:03 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Nov 2018 09:39:01 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAC9cxUh53542944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Nov 2018 09:38:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A69924C04A;
 Mon, 12 Nov 2018 09:38:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A6304C04E;
 Mon, 12 Nov 2018 09:38:58 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.50.113])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Nov 2018 09:38:57 +0000 (GMT)
Date: Mon, 12 Nov 2018 15:08:55 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [RFC PATCH v1 2/4] kvmppc: Add support for shared pages in HMM
 driver
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-3-bharata@linux.ibm.com>
 <20181030052646.GB11072@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030052646.GB11072@blackberry>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111209-4275-0000-0000-000002DF91DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111209-4276-0000-0000-000037EC9C35
Message-Id: <20181112093855.GC17399@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-12_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=515 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120088
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

On Tue, Oct 30, 2018 at 04:26:46PM +1100, Paul Mackerras wrote:
> On Mon, Oct 22, 2018 at 10:48:35AM +0530, Bharata B Rao wrote:
> > A secure guest will share some of its pages with hypervisor (Eg. virtio
> > bounce buffers etc). Support shared pages in HMM driver.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> 
> Comments below...
> 
> > ---
> >  arch/powerpc/kvm/book3s_hv_hmm.c | 69 ++++++++++++++++++++++++++++++--
> >  1 file changed, 65 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
> > index a2ee3163a312..09b8e19b7605 100644
> > --- a/arch/powerpc/kvm/book3s_hv_hmm.c
> > +++ b/arch/powerpc/kvm/book3s_hv_hmm.c
> > @@ -50,6 +50,7 @@ struct kvmppc_hmm_page_pvt {
> >  	struct hlist_head *hmm_hash;
> >  	unsigned int lpid;
> >  	unsigned long gpa;
> > +	bool skip_page_out;
> >  };
> >  
> >  struct kvmppc_hmm_migrate_args {
> > @@ -278,6 +279,65 @@ static unsigned long kvmppc_gpa_to_hva(struct kvm *kvm, unsigned long gpa,
> >  	return hva;
> >  }
> >  
> > +/*
> > + * Shares the page with HV, thus making it a normal page.
> > + *
> > + * - If the page is already secure, then provision a new page and share
> > + * - If the page is a normal page, share the existing page
> > + *
> > + * In the former case, uses the HMM fault handler to release the HMM page.
> > + */
> > +static unsigned long
> > +kvmppc_share_page(struct kvm *kvm, unsigned long gpa,
> > +		  unsigned long addr, unsigned long page_shift)
> > +{
> > +
> > +	int ret;
> > +	struct hlist_head *list, *hmm_hash;
> > +	unsigned int lpid = kvm->arch.lpid;
> > +	unsigned long flags;
> > +	struct kvmppc_hmm_pfn_entry *p;
> > +	struct page *hmm_page, *page;
> > +	struct kvmppc_hmm_page_pvt *pvt;
> > +	unsigned long pfn;
> > +
> > +	/*
> > +	 * First check if the requested page has already been given to
> > +	 * UV as a secure page. If so, ensure that we don't issue a
> > +	 * UV_PAGE_OUT but instead directly send the page
> > +	 */
> > +	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
> > +	hmm_hash = kvm->arch.hmm_hash;
> > +	list = &hmm_hash[kvmppc_hmm_pfn_hash_fn(gpa)];
> > +	hlist_for_each_entry(p, list, hlist) {
> > +		if (p->addr == gpa) {
> > +			hmm_page = pfn_to_page(p->hmm_pfn);
> > +			get_page(hmm_page); /* TODO: Necessary ? */
> > +			pvt = (struct kvmppc_hmm_page_pvt *)
> > +				hmm_devmem_page_get_drvdata(hmm_page);
> > +			pvt->skip_page_out = true;
> > +			put_page(hmm_page);
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
> > +
> > +	ret = get_user_pages_fast(addr, 1, 0, &page);
> 
> Why are we calling this with write==0?  Surely in general the secure
> guest will expect to be able to write to the shared page?
> 
> Also, in general get_user_pages_fast isn't sufficient to translate a
> host virtual address (derived from a guest real address) into a pfn.
> See for example hva_to_pfn() in virt/kvm/kvm_main.c and the things it
> does to cope with the various cases that one can hit.  I can imagine
> in future that the secure guest might want to establish a shared
> mapping to a PCI device, for instance.

I switched to using gfn_to_pfn() which should cover all the cases.

> 
> > +	if (ret != 1)
> > +		return H_PARAMETER;
> > +
> > +	pfn = page_to_pfn(page);
> > +	if (is_zero_pfn(pfn)) {
> > +		put_page(page);
> > +		return H_SUCCESS;
> > +	}
> 
> The ultravisor still needs a page to map into the guest in this case,
> doesn't it?  What's the point of returning without giving the
> ultravisor a page to use?

Yes, missed it.

Regards,
Bharata.

