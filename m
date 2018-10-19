Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163A0ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 20:37:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC1020869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 20:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC1020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42cHm73znbzF3bF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 07:37:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42cHjx2ZmMzF3Tc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 07:35:49 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9JKYMYF122528
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 16:35:47 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n7nq39qh5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 16:35:46 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 19 Oct 2018 14:35:45 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 19 Oct 2018 14:35:40 -0600
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9JKZdIE41681078
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Oct 2018 13:35:39 -0700
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A31A136055;
 Fri, 19 Oct 2018 20:35:39 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA33B136059;
 Fri, 19 Oct 2018 20:35:36 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.80.206.97])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 19 Oct 2018 20:35:36 +0000 (GMT)
Subject: Re: [PATCH v2] idle/x86: remove the call to boot_init_stack_canary()
 from cpu_startup_entry()
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
References: <285fcf8852b5924cb01de00be1152ea617527c52.1539944940.git.christophe.leroy@c-s.fr>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 19 Oct 2018 13:35:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <285fcf8852b5924cb01de00be1152ea617527c52.1539944940.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101920-0020-0000-0000-00000E7C9FD8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009902; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105085; UDB=6.00572143; IPR=6.00885136; 
 MB=3.00023828; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 20:35:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101920-0021-0000-0000-0000636F395D
Message-Id: <34e3d329-86bb-2194-0c8f-f2795aafd116@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-19_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190183
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
Cc: xen-devel@lists.xenproject.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/19/2018 03:31 AM, Christophe Leroy wrote:
> commit d7880812b359 ("idle: Add the stack canary init to
> cpu_startup_entry()") added the call to boot_init_stack_canary()
> in cpu_startup_entry() in an #ifdef CONFIG_X86 statement, with
> the intention to remove that #ifdef later.
> 
> While implementing stack protector for powerpc, it has been
> observed that calling boot_init_stack_canary() is also needed
> for powerpc which uses per task (TLS) stack canary like the X86.
> 
> However, calling boot_init_stack_canary() would break arches
> using global stack canary (ARM, SH, MIPS and XTENSA).
> 
> Instead of modifying the #ifdef CONFIG_X86 in an
>  #if defined(CONFIG_X86) || defined(CONFIG_PPC), powerpc
> implemented the call to boot_init_stack_canary() in the function
> calling cpu_startup_entry()
> 
> On x86, we have two functions calling cpu_startup_entry():
> - start_secondary()
> - cpu_bringup_and_idle()
> 
> start_secondary() already calls boot_init_stack_canary().
> 
> This patch adds the call to boot_init_stack_canary() in
> cpu_bringup_and_idle() and removes it from cpu_startup_entry()
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Revised commit log (#if defined  had been droped by 'git commit')
> 
>  arch/x86/xen/smp_pv.c |  1 +
>  kernel/sched/idle.c   | 15 ---------------
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
> index e3b18ad49889..0e05e8e23998 100644
> --- a/arch/x86/xen/smp_pv.c
> +++ b/arch/x86/xen/smp_pv.c
> @@ -88,6 +88,7 @@ static void cpu_bringup(void)
>  asmlinkage __visible void cpu_bringup_and_idle(void)
>  {
>  	cpu_bringup();
> +	boot_init_stack_canary();

I think I saw from the kbuild test robot in your first pass that this is an implicit declaration. Quick look at my local git tree and I don't see an include for stackprotector.h in this file.

-Tyrel

>  	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
>  }
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 16f84142f2f4..f5516bae0c1b 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -347,21 +347,6 @@ EXPORT_SYMBOL_GPL(play_idle);
> 
>  void cpu_startup_entry(enum cpuhp_state state)
>  {
> -	/*
> -	 * This #ifdef needs to die, but it's too late in the cycle to
> -	 * make this generic (ARM and SH have never invoked the canary
> -	 * init for the non boot CPUs!). Will be fixed in 3.11
> -	 */
> -#ifdef CONFIG_X86
> -	/*
> -	 * If we're the non-boot CPU, nothing set the stack canary up
> -	 * for us. The boot CPU already has it initialized but no harm
> -	 * in doing it again. This is a good place for updating it, as
> -	 * we wont ever return from this function (so the invalid
> -	 * canaries already on the stack wont ever trigger).
> -	 */
> -	boot_init_stack_canary();
> -#endif
>  	arch_cpu_idle_prepare();
>  	cpuhp_online_idle(state);
>  	while (1)
> 

