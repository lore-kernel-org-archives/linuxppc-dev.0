Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465BDC7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:42:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559CE2064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559CE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYPS5JCpzF3Hh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:42:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YYCb0BPwzF39m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:33:30 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9F9JANE013471
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 05:33:29 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n4p7sdr9j-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 05:33:28 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 15 Oct 2018 03:33:27 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 15 Oct 2018 03:33:25 -0600
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9F9XO3G25690154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Oct 2018 02:33:24 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C20166E04E;
 Mon, 15 Oct 2018 03:33:24 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCD6D6E04C;
 Mon, 15 Oct 2018 03:33:22 -0600 (MDT)
Received: from [9.124.35.84] (unknown [9.124.35.84])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 15 Oct 2018 03:33:22 -0600 (MDT)
Subject: Re: [PATCH] powerpc/64: properly initialise the stackprotector
 canary on SMP.
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Mon, 15 Oct 2018 15:03:21 +0530
In-Reply-To: <a2694b8ffeb6c52d1c755d8a7bfaac689c4e1c6d.1539423893.git.christophe.leroy@c-s.fr>
References: <a2694b8ffeb6c52d1c755d8a7bfaac689c4e1c6d.1539423893.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101509-0012-0000-0000-000016C8A148
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009879; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102946; UDB=6.00570861; IPR=6.00882998; 
 MB=3.00023760; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-15 09:33:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101509-0013-0000-0000-000054C321CA
Message-Id: <1539596001.28358.1.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-15_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810150088
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2018-10-13 at 09:45 +0000, Christophe Leroy wrote:
> commit 06ec27aea9fc ("powerpc/64: add stack protector support")
> doesn't initialise the stack canary on SMP secondary CPU's paca,
> leading to the following false positive report from the
> stack protector.
> 
> smp: Bringing up secondary CPUs ...
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __schedule+0x978/0xa80
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.0-rc7-next-20181010-autotest-autotest #1
> Call Trace:
> [c000001fed5b3bf0] [c000000000a0ef3c] dump_stack+0xb0/0xf4 (unreliable)
> [c000001fed5b3c30] [c0000000000f9d68] panic+0x140/0x308
> [c000001fed5b3cc0] [c0000000000f9844] __stack_chk_fail+0x24/0x30
> [c000001fed5b3d20] [c000000000a2c3a8] __schedule+0x978/0xa80
> [c000001fed5b3e00] [c000000000a2c9b4] schedule_idle+0x34/0x60
> [c000001fed5b3e30] [c00000000013d344] do_idle+0x224/0x3d0
> [c000001fed5b3ec0] [c00000000013d6e0] cpu_startup_entry+0x30/0x50
> [c000001fed5b3ef0] [c000000000047f34] start_secondary+0x4d4/0x520
> [c000001fed5b3f90] [c00000000000b370] start_secondary_prolog+0x10/0x14
> 
> This patch properly initialises the stack_canary of the secondary
> idle tasks.
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Fixes: 06ec27aea9fc ("powerpc/64: add stack protector support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 61c1fadbc644..e774d3bf3a03 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -34,6 +34,7 @@
>  #include <linux/topology.h>
>  #include <linux/profile.h>
>  #include <linux/processor.h>
> +#include <linux/random.h>
> 
>  #include <asm/ptrace.h>
>  #include <linux/atomic.h>
> @@ -810,9 +811,16 @@ static void cpu_idle_thread_init(unsigned int cpu, struct task_struct *idle)
>  {
>  	struct thread_info *ti = task_thread_info(idle);
> 
> +#ifdef CONFIG_STACKPROTECTOR
> +	idle->stack_canary = get_random_canary();
> +#endif
> +
>  #ifdef CONFIG_PPC64
>  	paca_ptrs[cpu]->__current = idle;
>  	paca_ptrs[cpu]->kstack = (unsigned long)ti + THREAD_SIZE - STACK_FRAME_OVERHEAD;
> +#ifdef CONFIG_STACKPROTECTOR
> +	paca_ptrs[cpu]->canary = idle->stack_canary;
> +#endif
>  #endif
>  	ti->cpu = cpu;
>  	secondary_ti = current_set[cpu] = ti;

Thank you Christophe for the fix, Machine boots fine with above patch.

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



