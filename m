Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDB0C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 10:09:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC570216FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 10:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC570216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tmgb71lMzF38H
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 21:08:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tmdb3wkmzF3G3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 21:07:15 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wACA4NI8129153
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 05:07:13 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nq51neamt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 05:07:12 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 12 Nov 2018 10:07:10 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Nov 2018 10:07:07 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wACA76RF7733512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Nov 2018 10:07:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0704811C04C;
 Mon, 12 Nov 2018 10:07:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E4B211C054;
 Mon, 12 Nov 2018 10:07:04 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.50.113])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Nov 2018 10:07:04 +0000 (GMT)
Date: Mon, 12 Nov 2018 15:37:02 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC PATCH v1 2/4] kvmppc: Add support for shared pages in HMM
 driver
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-3-bharata@linux.ibm.com>
 <20181101104552.GE16399@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101104552.GE16399@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111210-4275-0000-0000-000002DF9483
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111210-4276-0000-0000-000037EC9EEF
Message-Id: <20181112100702.GF17399@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-12_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120093
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

On Thu, Nov 01, 2018 at 09:45:52PM +1100, Balbir Singh wrote:
> On Mon, Oct 22, 2018 at 10:48:35AM +0530, Bharata B Rao wrote:
> > A secure guest will share some of its pages with hypervisor (Eg. virtio
> > bounce buffers etc). Support shared pages in HMM driver.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
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
> 
> So this is a special flag passed via the hypercall to say
> this page can be skipped from page_out from secure memory?
> Who has the master copy of the page at this point?
> 
> In which case the question is
> 
> Why did we get a fault on the page which resulted in the
> fault migration ops being called?
> What category of pages are considered shared?

When UV/guest asks for sharing a page, there can be two cases:

- If the page is already secure, then provision a new page and share
- If the page is a normal page, share the existing page

In the former case, we touch the page via get_user_pages() and re-use the
HMM fault handler to release the HMM page. We use skip_page_out to mark
that this page is meant to be released w/o doing a page-out which otherwise
would be done if HV touches a secure page.

When a page is shared, both HV and UV have mappings to the same physical
page that resides in the non-secure memory.

Regards,
Bharata.

