Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01637C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:24:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA9A218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA9A218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LMCC2xZzzDqYW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:24:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLhs5G1mzDqxg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:49 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIwpax047335
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 14:01:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pgdrfr9yb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 14:01:47 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 20 Dec 2018 19:01:44 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:01:40 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ1d2B60489916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:01:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA13852051;
 Thu, 20 Dec 2018 19:01:39 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.187.27])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id DBE5952052;
 Thu, 20 Dec 2018 19:01:36 +0000 (GMT)
Date: Thu, 20 Dec 2018 11:01:33 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pkeys: copy pkey-tracking-information at fork()
References: <1543869802-15372-1-git-send-email-linuxram@us.ibm.com>
 <8736qsqqsu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
In-Reply-To: <8736qsqqsu.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18122019-4275-0000-0000-000002F37583
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-4276-0000-0000-000038018151
Message-Id: <20181220190133.GA5373@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200154
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
Reply-To: Ram Pai <linuxram@us.ibm.com>
Cc: fweimer@redhat.com, Ulrich.Weigand@de.ibm.com, dave.hansen@linux.intel.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 21, 2018 at 12:19:13AM +1100, Michael Ellerman wrote:
> Hi Ram,
> 
> Thanks for fixing this.
> 
> Ram Pai <linuxram@us.ibm.com> writes:
> > diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> > index b271b28..5d65c47 100644
> > --- a/arch/powerpc/mm/pkeys.c
> > +++ b/arch/powerpc/mm/pkeys.c
> > @@ -414,3 +414,10 @@ bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
> >  
> >  	return pkey_access_permitted(vma_pkey(vma), write, execute);
> >  }
> > +
> > +void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
> > +{
> > +	/* Duplicate the oldmm pkey state in mm: */
> > +	mm_pkey_allocation_map(mm) = mm_pkey_allocation_map(oldmm);
> > +	mm->context.execute_only_pkey = oldmm->context.execute_only_pkey;
> > +}
> 
> Shouldn't this check if pkeys are actually in use?

Yes. That will make it better. However not checking it, will not hurt. Just that
it will do some unnecessary copying.

Will spin out a new patch with the fix, and send it your way.
RP


> 
> eg:
> 
> diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
> index cf87dddefbdc..587807763737 100644
> --- a/arch/powerpc/mm/pkeys.c
> +++ b/arch/powerpc/mm/pkeys.c
> @@ -418,6 +418,9 @@ bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
> 
>  void arch_dup_pkeys(struct mm_struct *oldmm, struct mm_struct *mm)
>  {
> +	if (static_branch_likely(&pkey_disabled))
> +		return;
> +
>  	/* Duplicate the oldmm pkey state in mm: */
>  	mm_pkey_allocation_map(mm) = mm_pkey_allocation_map(oldmm);
>  	mm->context.execute_only_pkey = oldmm->context.execute_only_pkey;
> 
> 
> Ideally we'd actually do it in the inline so that the function call to
> arch_dup_pkeys() can be avoided. But it looks like header dependencies
> might make that hard.
> 
> cheers

-- 
Ram Pai

