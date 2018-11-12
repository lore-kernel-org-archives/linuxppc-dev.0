Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177FEC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 10:10:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939D9216FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 10:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939D9216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tmjc2wg8zF3Pm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 21:10:44 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tmgS0HfXzF3C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 21:08:51 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wACA4MEV135075
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 05:08:49 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nq4xypq22-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 05:08:49 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 12 Nov 2018 10:08:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 12 Nov 2018 10:08:43 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wACA8g4n55050354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Nov 2018 10:08:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C59AA404D;
 Mon, 12 Nov 2018 10:08:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F3E9A4055;
 Mon, 12 Nov 2018 10:08:40 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.50.113])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 12 Nov 2018 10:08:40 +0000 (GMT)
Date: Mon, 12 Nov 2018 15:38:38 +0530
From: Bharata B Rao <bharata@linux.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [RFC PATCH v1 3/4] kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE
 hcalls
References: <20181022051837.1165-1-bharata@linux.ibm.com>
 <20181022051837.1165-4-bharata@linux.ibm.com>
 <20181101104926.GF16399@350D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181101104926.GF16399@350D>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111210-0012-0000-0000-000002C917A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111210-0013-0000-0000-000020FE1F8A
Message-Id: <20181112100838.GG17399@in.ibm.com>
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

On Thu, Nov 01, 2018 at 09:49:26PM +1100, Balbir Singh wrote:
> On Mon, Oct 22, 2018 at 10:48:36AM +0530, Bharata B Rao wrote:
> > H_SVM_INIT_START: Initiate securing a VM
> > H_SVM_INIT_DONE: Conclude securing a VM
> > 
> > During early guest init, these hcalls will be issued by UV.
> > As part of these hcalls, [un]register memslots with UV.
> > 
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/hvcall.h    |  4 ++-
> >  arch/powerpc/include/asm/kvm_host.h  |  1 +
> >  arch/powerpc/include/asm/ucall-api.h |  6 ++++
> >  arch/powerpc/kvm/book3s_hv.c         | 54 ++++++++++++++++++++++++++++
> >  4 files changed, 64 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
> > index 89e6b70c1857..6091276fef07 100644
> > --- a/arch/powerpc/include/asm/hvcall.h
> > +++ b/arch/powerpc/include/asm/hvcall.h
> > @@ -300,7 +300,9 @@
> >  #define H_INT_RESET             0x3D0
> >  #define H_SVM_PAGE_IN		0x3D4
> >  #define H_SVM_PAGE_OUT		0x3D8
> > -#define MAX_HCALL_OPCODE	H_SVM_PAGE_OUT
> > +#define H_SVM_INIT_START	0x3DC
> > +#define H_SVM_INIT_DONE		0x3E0
> > +#define MAX_HCALL_OPCODE	H_SVM_INIT_DONE
> >  
> >  /* H_VIOCTL functions */
> >  #define H_GET_VIOA_DUMP_SIZE	0x01
> > diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> > index 194e6e0ff239..267f8c568bc3 100644
> > --- a/arch/powerpc/include/asm/kvm_host.h
> > +++ b/arch/powerpc/include/asm/kvm_host.h
> > @@ -292,6 +292,7 @@ struct kvm_arch {
> >  	struct dentry *debugfs_dir;
> >  	struct dentry *htab_dentry;
> >  	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
> > +	bool svm_init_start; /* Indicates H_SVM_INIT_START has been called */
> >  #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> >  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
> >  	struct mutex hpt_mutex;
> > diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
> > index 2c12f514f8ab..9ddfcf541211 100644
> > --- a/arch/powerpc/include/asm/ucall-api.h
> > +++ b/arch/powerpc/include/asm/ucall-api.h
> > @@ -17,4 +17,10 @@ static inline int uv_page_out(u64 lpid, u64 dw0, u64 dw1, u64 dw2, u64 dw3)
> >  	return U_SUCCESS;
> >  }
> >  
> > +static inline int uv_register_mem_slot(u64 lpid, u64 dw0, u64 dw1, u64 dw2,
> > +				       u64 dw3)
> > +{
> > +	return 0;
> > +}
> > +
> >  #endif	/* _ASM_POWERPC_UCALL_API_H */
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 05084eb8aadd..47f366f634fd 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -819,6 +819,50 @@ static int kvmppc_get_yield_count(struct kvm_vcpu *vcpu)
> >  	return yield_count;
> >  }
> >  
> > +#ifdef CONFIG_PPC_SVM
> > +#include <asm/ucall-api.h>
> > +/*
> > + * TODO: Check if memslots related calls here need to be called
> > + * under any lock.
> > + */
> > +static unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
> > +{
> > +	struct kvm_memslots *slots;
> > +	struct kvm_memory_slot *memslot;
> > +	int ret;
> > +
> > +	slots = kvm_memslots(kvm);
> > +	kvm_for_each_memslot(memslot, slots) {
> > +		ret = uv_register_mem_slot(kvm->arch.lpid,
> > +					   memslot->base_gfn << PAGE_SHIFT,
> > +					   memslot->npages * PAGE_SIZE,
> > +					   0, memslot->id);
> 
> For every memslot their is a corresponding registration in the ultravisor?
> Is there a corresponding teardown?

Yes, uv_unregister_mem_slot(), called during memory unplug time.

Regards,
Bharata.

