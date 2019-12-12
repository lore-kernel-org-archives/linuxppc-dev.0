Return-Path: <SRS0=eY2C=2C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB1C00454
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 13:12:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BCA206DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Dec 2019 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S0PeetXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BCA206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47YZ2z65RNzDr4d
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Dec 2019 00:12:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+27c5b7719eecc710bb1c+5954+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="S0PeetXC"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47YYxx1t55zDqf9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2019 00:08:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ORI9YzHhjLGPyL+QwYOIMHaGuxuP1MjIHAOeHK8vqaA=; b=S0PeetXCRwOI5pLW6hTeqrqQ5
 E1uU6CBXvw4L4mPJ187UgHLfD6MzG68+Xw3/1ACuIPlrfxM9ReOyjowx7/EDtEkgTH3M6ZFsVVf6w
 zpvO3nABtwiJ4rV37PlEkkStmRWVcJENFMu03YSgn1lXaoOvWtWHPs6aFK52UnPUBaNYM569wKXhW
 dG+1K5KNb3PHYV9bvxStOtyZnUIlBeQSjyv803p5sxXhkRZO5hWJ/LA5rlB0H2vCv4aGgPuzbGv5K
 3qnvaUrpHT6HXHpzwQnf+bZk+FbRhHHxUQ5b7Yfw5O2tTSHa0SqM8kniEs4mMaqWKorlTtrZquxcl
 IVbTi9kbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ifOCD-0001II-Cl; Thu, 12 Dec 2019 13:07:57 +0000
Date: Thu, 12 Dec 2019 05:07:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Haren Myneni <haren@linux.ibm.com>
Subject: Re: [PATCH V2 08/13] powerpc/vas: Update CSB and notify process for
 fault CRBs
Message-ID: <20191212130757.GF3381@infradead.org>
References: <1575861522.16318.9.camel@hbabu-laptop>
 <1575862417.16318.25.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575862417.16318.25.camel@hbabu-laptop>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: devicetree@vger.kernel.org, mikey@neuling.org, herbert@gondor.apana.org.au,
 npiggin@gmail.com, hch@infradead.org, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 08, 2019 at 07:33:37PM -0800, Haren Myneni wrote:
> +static void notify_process(pid_t pid, u64 fault_addr)
> +{
> +	int rc;
> +	struct kernel_siginfo info;
> +
> +	memset(&info, 0, sizeof(info));
> +
> +	info.si_signo = SIGSEGV;
> +	info.si_errno = EFAULT;
> +	info.si_code = SEGV_MAPERR;
> +	info.si_addr = (void *)fault_addr;
> +	/*
> +	 * process will be polling on csb.flags after request is sent to
> +	 * NX. So generally CSB update should not fail except when an
> +	 * application does not follow the process properly. So an error
> +	 * message will be displayed and leave it to user space whether
> +	 * to ignore or handle this signal.
> +	 */
> +	rcu_read_lock();
> +	rc = kill_pid_info(SIGSEGV, &info, find_vpid(pid));
> +	rcu_read_unlock();
> +
> +	pr_devel("%s(): pid %d kill_proc_info() rc %d\n", __func__, pid, rc);
> +}

I think you want to pass in the struct pid * here instead of looking
up again, given that..

> +	if (tsk) {
> +		if (tsk->flags & PF_EXITING)
> +			task_exit = 1;
> +		put_task_struct(tsk);
> +		pid = vas_window_pid(window);

We already have the struct pid in the window structure here.

> +	} else {
> +		pid = window->tgid;
> +
> +		rcu_read_lock();
> +		tsk = find_task_by_vpid(pid);
> +		if (!tsk) {

.. and could have easily stored on here.  Or at least only do the
look up once, given that already looks it up.

> +	/* Do not notify if the task is exiting. */
> +	if (!task_exit) {
> +		pr_err("Invalid CSB address 0x%p signalling pid(%d)\n",
> +				csb_addr, pid);
> +		notify_process(pid, (u64)csb_addr);
> +	}

I suspect inlining notify_process and just existing early for the
task_exit case also makes the code a bit easier to follow.
