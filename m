Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5483EC10F01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:25:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39052086C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39052086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Byf5wq8zDq5W
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:24:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Bv31P0zzDqDh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:21:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444Bv26WJ1z8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:21:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444Bv2682Fz9s70; Wed, 20 Feb 2019 20:21:50 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aravinda@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444Bv226cyz9s5R
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 20:21:50 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K9AQDQ012108
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:21:48 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qs1ecy44b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:21:42 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 20 Feb 2019 09:21:21 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 09:21:17 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K9LG2l15728882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 09:21:16 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17E27BE04F;
 Wed, 20 Feb 2019 09:21:16 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B671FBE054;
 Wed, 20 Feb 2019 09:21:14 +0000 (GMT)
Received: from [9.124.31.45] (unknown [9.124.31.45])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 20 Feb 2019 09:21:14 +0000 (GMT)
Subject: Re: [PATCH 2/2] powerpc/64s: Better printing of machine check info
 for guest MCEs
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20190220010550.GD5353@blackberry>
 <20190220010623.GE5353@blackberry>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 20 Feb 2019 14:51:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190220010623.GE5353@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022009-8235-0000-0000-00000E6267B8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010630; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163706; UDB=6.00607639; IPR=6.00944291; 
 MB=3.00025666; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-20 09:21:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022009-8236-0000-0000-0000448A384C
Message-Id: <c836c1f1-8119-41d1-b67c-ba4d37b8554a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200067
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Wednesday 20 February 2019 06:36 AM, Paul Mackerras wrote:
> This adds an "in_guest" parameter to machine_check_print_event_info()
> so that we can avoid trying to translate guest NIP values into
> symbolic form using the host kernel's symbol table.

Reviewed-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Regards,
Aravinda

> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/mce.h        | 2 +-
>  arch/powerpc/kernel/mce.c             | 8 +++++---
>  arch/powerpc/kvm/book3s_hv.c          | 4 ++--
>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>  4 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
> index a8b8903..17996bc 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -209,7 +209,7 @@ extern int get_mce_event(struct machine_check_event *mce, bool release);
>  extern void release_mce_event(void);
>  extern void machine_check_queue_event(void);
>  extern void machine_check_print_event_info(struct machine_check_event *evt,
> -					   bool user_mode);
> +					   bool user_mode, bool in_guest);
>  #ifdef CONFIG_PPC_BOOK3S_64
>  void flush_and_reload_slb(void);
>  #endif /* CONFIG_PPC_BOOK3S_64 */
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index bd933a7..d01b690 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -301,13 +301,13 @@ static void machine_check_process_queued_event(struct irq_work *work)
>  	while (__this_cpu_read(mce_queue_count) > 0) {
>  		index = __this_cpu_read(mce_queue_count) - 1;
>  		evt = this_cpu_ptr(&mce_event_queue[index]);
> -		machine_check_print_event_info(evt, false);
> +		machine_check_print_event_info(evt, false, false);
>  		__this_cpu_dec(mce_queue_count);
>  	}
>  }
> 
>  void machine_check_print_event_info(struct machine_check_event *evt,
> -				    bool user_mode)
> +				    bool user_mode, bool in_guest)
>  {
>  	const char *level, *sevstr, *subtype;
>  	static const char *mc_ue_types[] = {
> @@ -387,7 +387,9 @@ void machine_check_print_event_info(struct machine_check_event *evt,
>  	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
>  	       "Recovered" : "Not recovered");
> 
> -	if (user_mode) {
> +	if (in_guest) {
> +		printk("%s  Guest NIP: %016llx\n", evt->srr0);
> +	} else if (user_mode) {
>  		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
>  			evt->srr0, current->pid, current->comm);
>  	} else {
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index d8bf05a..81cba4b 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1216,7 +1216,7 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		break;
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
>  		/* Print the MCE event to host console. */
> -		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
> +		machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
> 
>  		/*
>  		 * If the guest can do FWNMI, exit to userspace so it can
> @@ -1406,7 +1406,7 @@ static int kvmppc_handle_nested_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
>  		/* Pass the machine check to the L1 guest */
>  		r = RESUME_HOST;
>  		/* Print the MCE event to host console. */
> -		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
> +		machine_check_print_event_info(&vcpu->arch.mce_evt, false, true);
>  		break;
>  	/*
>  	 * We get these next two if the guest accesses a page which it thinks
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 79586f1..05c85be 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -587,7 +587,7 @@ int opal_machine_check(struct pt_regs *regs)
>  		       evt.version);
>  		return 0;
>  	}
> -	machine_check_print_event_info(&evt, user_mode(regs));
> +	machine_check_print_event_info(&evt, user_mode(regs), false);
> 
>  	if (opal_recover_mce(regs, &evt))
>  		return 1;
> 

-- 
Regards,
Aravinda

