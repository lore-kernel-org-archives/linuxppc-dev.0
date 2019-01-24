Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4703CC282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 17:50:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBC9218A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 17:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBC9218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lqSm4N6zzDqHj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 04:50:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=embeddedor.com
 (client-ip=192.185.145.3; helo=gateway30.websitewelcome.com;
 envelope-from=gustavo@embeddedor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=embeddedor.com
X-Greylist: delayed 1427 seconds by postgrey-1.36 at bilbo;
 Fri, 25 Jan 2019 04:49:20 AEDT
Received: from gateway30.websitewelcome.com (gateway30.websitewelcome.com
 [192.185.145.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lqR41dtCzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 04:49:20 +1100 (AEDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id A400A3AE8A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 11:25:28 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id mikqgbb5m90onmikqg2hhB; Thu, 24 Jan 2019 11:25:28 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41838 helo=[192.168.1.76])
 by gator4166.hostgator.com with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gmikq-000089-4h; Thu, 24 Jan 2019 11:25:28 -0600
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
References: <1548338509-628-1-git-send-email-leitao@debian.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Subject: Re: [PATCH] powerpc/ptrace: Mitigate potential Spectre v1
Message-ID: <43b1ccd5-ec7f-32de-4f30-d67dbea02d9e@embeddedor.com>
Date: Thu, 24 Jan 2019 11:25:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548338509-628-1-git-send-email-leitao@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmikq-000089-4h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:41838
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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



On 1/24/19 8:01 AM, Breno Leitao wrote:
> 'regno' is directly controlled by user space, hence leading to a potential
> exploitation of the Spectre variant 1 vulnerability.
> 
> On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
> register number that would be read or written. This register number is
> called 'regno' which is part of the 'addr' syscall parameter.
> 
> This 'regno' value is checked against the maximum pt_regs structure size,
> and then used to dereference it, which matches the initial part of a
> Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
> is returned to userspace in the GETREGS case.
> 

Was this reported by any tool?

If so, it might be worth mentioning it.

> This patch sanitizes 'regno' before using it to dereference pt_reg.
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/ptrace.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index cdd5d1d3ae41..3eac38a29863 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -33,6 +33,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/perf_event.h>
>  #include <linux/context_tracking.h>
> +#include <linux/nospec.h>
>  
>  #include <linux/uaccess.h>
>  #include <linux/pkeys.h>
> @@ -298,6 +299,9 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
>  #endif
>  
>  	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {

I would use a variable to store sizeof(struct user_pt_regs) / sizeof(unsigned long).

> +		regno = array_index_nospec(regno,
> +				(sizeof(struct user_pt_regs) /
> +				 sizeof(unsigned long)));

See the rest of my comments below.

>  		*data = ((unsigned long *)task->thread.regs)[regno];
>  		return 0;
>  	}
> @@ -321,6 +325,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
>  		return set_user_dscr(task, data);
>  
>  	if (regno <= PT_MAX_PUT_REG) {
> +		regno = array_index_nospec(regno, PT_MAX_PUT_REG);

This is wrong.  array_index_nospec() will return PT_MAX_PUT_REG - 1 in case regno is equal to
PT_MAX_PUT_REG, and this is not what you want.

Similar reasoning applies to the case above.

>  		((unsigned long *)task->thread.regs)[regno] = data;
>  		return 0;
>  	}
> 

Thanks
--
Gustavo
