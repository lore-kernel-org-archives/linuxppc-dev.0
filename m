Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604EDC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 04:05:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FDA820881
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 04:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FDA820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437Wbz38CVzDqT4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 15:05:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=us.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=linuxram@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437WYh4RqYzDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 15:03:04 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB33xC94129674
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 2 Dec 2018 23:03:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p4sq7ey0v-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Dec 2018 23:03:01 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 3 Dec 2018 04:02:59 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 04:02:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB342tWX62521348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 04:02:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D083C4C046;
 Mon,  3 Dec 2018 04:02:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1D354C04E;
 Mon,  3 Dec 2018 04:02:53 +0000 (GMT)
Received: from ram.oc3035372033.ibm.com (unknown [9.85.171.204])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 04:02:53 +0000 (GMT)
Date: Sun, 2 Dec 2018 20:02:49 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: pkeys: Reserve PKEY_DISABLE_READ
References: <6f9c65fb-ea7e-8217-a4cc-f93e766ed9bb@intel.com>
 <87k1ln8o7u.fsf@oldenburg.str.redhat.com>
 <20181108201231.GE5481@ram.oc3035372033.ibm.com>
 <87bm6z71yw.fsf@oldenburg.str.redhat.com>
 <20181109180947.GF5481@ram.oc3035372033.ibm.com>
 <87efbqqze4.fsf@oldenburg.str.redhat.com>
 <20181127102350.GA5795@ram.oc3035372033.ibm.com>
 <87zhtuhgx0.fsf@oldenburg.str.redhat.com>
 <58e263a6-9a93-46d6-c5f9-59973064d55e@intel.com>
 <87va4g5d3o.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87va4g5d3o.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18120304-0028-0000-0000-000003251540
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120304-0029-0000-0000-000023E115EB
Message-Id: <20181203040249.GA11930@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=936 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030038
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
Cc: Dave Hansen <dave.hansen@intel.com>, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 29, 2018 at 12:37:15PM +0100, Florian Weimer wrote:
> * Dave Hansen:
> 
> > On 11/27/18 3:57 AM, Florian Weimer wrote:
> >> I would have expected something that translates PKEY_DISABLE_WRITE |
> >> PKEY_DISABLE_READ into PKEY_DISABLE_ACCESS, and also accepts
> >> PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ, for consistency with POWER.
> >> 
> >> (My understanding is that PKEY_DISABLE_ACCESS does not disable all
> >> access, but produces execute-only memory.)
> >
> > Correct, it disables all data access, but not execution.
> 
> So I would expect something like this (completely untested, I did not
> even compile this):


Ok. I re-read through the entire email thread to understand the problem and
the proposed solution. Let me summarize it below. Lets see if we are on the same
plate.

So the problem is as follows:

Currently the kernel supports  'disable-write'  and 'disable-access'.

On x86, cpu supports 'disable-write' and 'disable-access'. This
matches with what the kernel supports. All good.

However on power, cpu supports 'disable-read' too. Since userspace can
program the cpu directly, userspace has the ability to set
'disable-read' too.  This can lead to inconsistency between the kernel
and the userspace.

We want the kernel to match userspace on all architectures.

Proposed Solution:

Enhance the kernel to understand 'disable-read', and facilitate architectures
that understand 'disable-read' to allow it.

Also explicitly define the semantics of disable-access  as 
'disable-read and disable-write'

Did I get this right?  Assuming I did, the implementation has to do
the following --
  
	On power, sys_pkey_alloc() should succeed if the init_val
	is PKEY_DISABLE_READ, PKEY_DISABLE_WRITE, PKEY_DISABLE_ACCESS
	or any combination of the three.

	On x86, sys_pkey_alloc() should succeed if the init_val is
	PKEY_DISABLE_WRITE or PKEY_DISABLE_ACCESS or PKEY_DISABLE_READ
	or any combination of the three, except  PKEY_DISABLE_READ
      	specified all by itself.

	On all other arches, none of the flags are supported.


Are we on the same plate?
RP


> 
> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> index 20ebf153c871..bed23f9e8336 100644
> --- a/arch/powerpc/include/asm/pkeys.h
> +++ b/arch/powerpc/include/asm/pkeys.h
> @@ -199,6 +199,11 @@ static inline bool arch_pkeys_enabled(void)
>  	return !static_branch_likely(&pkey_disabled);
>  }
> 
> +static inline bool arch_pkey_access_rights_valid(unsigned long rights)
> +{
> +	return (rights & ~(unsigned long)PKEY_ACCESS_MASK) == 0;
> +}
> +
>  extern void pkey_mm_init(struct mm_struct *mm);
>  extern bool arch_supports_pkeys(int cap);
>  extern unsigned int arch_usable_pkeys(void);
> diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
> index 19b137f1b3be..e3e1d5a316e8 100644
> --- a/arch/x86/include/asm/pkeys.h
> +++ b/arch/x86/include/asm/pkeys.h
> @@ -14,6 +14,17 @@ static inline bool arch_pkeys_enabled(void)
>  	return boot_cpu_has(X86_FEATURE_OSPKE);
>  }
> 
> +static inline bool arch_pkey_access_rights_valid(unsigned long rights)
> +{
> +	if (rights & ~(unsigned long)PKEY_ACCESS_MASK)
> +		return false;
> +	if (rights & PKEY_DISABLE_READ) {
> +		/* x86 can only disable read access along with write access. */
> +		return rights & (PKEY_DISABLE_WRITE | PKEY_DISABLE_ACCESS);
> +	}
> +	return true;
> +}
> +
>  /*
>   * Try to dedicate one of the protection keys to be used as an
>   * execute-only protection key.
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 87a57b7642d3..b9b78145017f 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -928,7 +928,13 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
>  		return -EINVAL;
> 
>  	/* Set the bits we need in PKRU:  */
> -	if (init_val & PKEY_DISABLE_ACCESS)
> +	if (init_val & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_READ))
> +		/*
> +		 * arch_pkey_access_rights_valid checked that
> +		 * PKEY_DISABLE_READ is actually representable on x86
> +		 * (that is, it comes with PKEY_DISABLE_ACCESS or
> +		 * PKEY_DISABLE_WRITE).
> +		 */
>  		new_pkru_bits |= PKRU_AD_BIT;
>  	if (init_val & PKEY_DISABLE_WRITE)
>  		new_pkru_bits |= PKRU_WD_BIT;
> diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> index 2955ba976048..2c330fabbe55 100644
> --- a/include/linux/pkeys.h
> +++ b/include/linux/pkeys.h
> @@ -48,6 +48,11 @@ static inline void copy_init_pkru_to_fpregs(void)
>  {
>  }
> 
> +static inline bool arch_pkey_access_rights_valid(unsigned long rights)
> +{
> +	return false;
> +}
> +
>  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> 
>  #endif /* _LINUX_PKEYS_H */
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 6d331620b9e5..f4cefc3540df 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -597,7 +597,7 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
>  	if (flags)
>  		return -EINVAL;
>  	/* check for unsupported init values */
> -	if (init_val & ~PKEY_ACCESS_MASK)
> +	if (!arch_pkey_access_rights_valid(init_val))
>  		return -EINVAL;
> 
>  	down_write(&current->mm->mmap_sem);
> 
> Thanks,
> Florian

-- 
Ram Pai

