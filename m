Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C31C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:37:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864242089F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864242089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444CDt4PZZzDqBK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:37:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444CC46Jp4zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:35:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444CC44srXz8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:35:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444CC44BqTz9sB3; Wed, 20 Feb 2019 20:35:44 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mahesh@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444CC373wSz9s5R
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 20:35:43 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K9R8aV030423
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:35:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qs494rcxy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:35:41 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 20 Feb 2019 09:35:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 09:35:37 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K9ZaeX23986336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 09:35:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B36BA404D;
 Wed, 20 Feb 2019 09:35:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37875A4040;
 Wed, 20 Feb 2019 09:35:35 +0000 (GMT)
Received: from in.ibm.com (unknown [9.109.253.165])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Feb 2019 09:35:35 +0000 (GMT)
Date: Wed, 20 Feb 2019 15:05:29 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc/64s: Better printing of machine check info
 for guest MCEs
References: <20190220010550.GD5353@blackberry>
 <20190220010623.GE5353@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220010623.GE5353@blackberry>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
x-cbid: 19022009-0016-0000-0000-00000258A045
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022009-0017-0000-0000-000032B2E8DC
Message-Id: <20190220093529.uegsp5fuj6ozb2mq@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200068
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
Reply-To: mahesh@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2019-02-20 12:06:23 Wed, Paul Mackerras wrote:
> This adds an "in_guest" parameter to machine_check_print_event_info()
> so that we can avoid trying to translate guest NIP values into
> symbolic form using the host kernel's symbol table.
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

Missing 'level' argument. This should be:
		printk("%s  Guest NIP: %016llx\n", level, evt->srr0);

Rest looks fine to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.

