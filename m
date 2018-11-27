Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2151C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69F1E20659
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F1E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4349dB3m4qzDqKQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:24:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.195; helo=mail-qk1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4349Zs6ZyRzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 04:22:29 +1100 (AEDT)
Received: by mail-qk1-f195.google.com with SMTP id r71so15034359qkr.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:22:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zJM9cofLlUDQu4fU2mWtJh7DM/ZIyJdcM18tfHysqGY=;
 b=oRaWuQHAWs969V9QabT0V/7KFZduPPNZke0Kc3ZzTeGpqCQhKf68fcYRkm4FmYHb3U
 kBHRZUYDVnIH29MtNcfwX9gm+VUgZLloyVGe6AU2KuD6TNJrDr2OHzYWcatKXwWE8zXS
 BlfcighKKPsoZ/O96wY0KSNKDONIKBZ7Lfa2EDlOmDOZWR87CMSPAGc8UKTKt+v54Abb
 1g3OL5ALKUz3BX7pWmQAhap71tCUAijxoUNDbsuj1usOfGkMSvRxi7Y/SbAhEfw6Yeyy
 zDw1QQleKTzwH34GzT+lJDRlFdgxITalGMIEYSyvPY9K7540DvTER152pqkFXi0MzGvJ
 V+kA==
X-Gm-Message-State: AA+aEWZ4zr3QW5UEliH0ae6jLbEt2c3jt/J4T0bmR0ChXeylJe+Epzef
 fY9KK3wRCc7hKdwXzEVw5CAAq0akYuo=
X-Google-Smtp-Source: AFSGD/Vlk9X7VjWEgY9Hu6krkB0pQ0Yu5fqZ/vQmOq/url86/c3CfkNnM0SKYqPNNtQ4QcDWzt/qXQ==
X-Received: by 2002:a37:3753:: with SMTP id e80mr29792385qka.207.1543339347278; 
 Tue, 27 Nov 2018 09:22:27 -0800 (PST)
Received: from [10.0.0.8] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id p42sm2227554qte.8.2018.11.27.09.22.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Nov 2018 09:22:26 -0800 (PST)
Subject: Re: [PATCH] powerpc/mm/hash: Hand user access of kernel address
 gracefully
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
References: <20181126143504.30996-1-aneesh.kumar@linux.ibm.com>
From: Breno Leitao <leitao@debian.org>
Message-ID: <c6ef0f52-6cb9-d48c-c11e-51b7d5cf8a25@debian.org>
Date: Tue, 27 Nov 2018 15:22:32 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126143504.30996-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Aneesh,

On 11/26/18 12:35 PM, Aneesh Kumar K.V wrote:
> With commit 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
> we moved the protection fault access check before vma lookup. That means we
> hit that WARN_ON when user space access a kernel address.  Before the commit
> this was handled by find_vma() not finding vma for the kernel address and
> considering that access as bad area access.
> 
> Avoid the confusing WARN_ON and convert that to a ratelimited printk.
> With the patch we now get
> 
> for load:
> [  187.700294] a.out[5997]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
> [  187.700344] a.out[5997]: segfault (11) at c00000000000dea0 nip 1317c0798 lr 7fff80d6441c code 1 in a.out[1317c0000+10000]
> [  187.700429] a.out[5997]: code: 60000000 60420000 3c4c0002 38427790 4bffff20 3c4c0002 38427784 fbe1fff8
> [  187.700435] a.out[5997]: code: f821ffc1 7c3f0b78 60000000 e9228030 <89290000> 993f002f 60000000 383f0040
> 
> for exec:
> [  225.100903] a.out[6067]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
> [  225.100938] a.out[6067]: segfault (11) at c00000000000dea0 nip c00000000000dea0 lr 129d507b0 code 1
> [  225.100943] a.out[6067]: Bad NIP, not dumping instructions.
> 
> Fixes: 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Tested-by: Breno Leitao <leitao@debian.org>

> ---
>  arch/powerpc/mm/fault.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 1697e903bbf2..46f280068c45 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -342,8 +342,21 @@ static inline void cmo_account_page_fault(void) { }
>  #endif /* CONFIG_PPC_SMLPAR */
>  
>  #ifdef CONFIG_PPC_STD_MMU
> -static void sanity_check_fault(bool is_write, unsigned long error_code)
> +static void sanity_check_fault(bool is_write, bool is_user,
> +			       unsigned long error_code, unsigned long address)
>  {
> +	/*
> +	 * userspace trying to access kernel address, we get PROTFAULT for that.
> +	 */
> +	if (is_user && address >= TASK_SIZE) {
> +		printk_ratelimited(KERN_CRIT "%s[%d]: "
> +				   "User access of kernel address (%lx) - "
> +				   "exploit attempt? (uid: %d)\n",
> +				   current->comm, current->pid, address,
> +				   from_kuid(&init_user_ns, current_uid()));
> +		return;

Silly question: Is it OK to printk() and just return here? __do_page_fault
will continue to execute independently of this return, right?
