Return-Path: <SRS0=SG0q=ZT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4F7C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 08:48:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9663204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 08:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FlP8wRbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9663204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47NDvS4kYbzDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 19:48:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+230b1395c146a7dc824f+5939+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="FlP8wRbW"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47NDrg4dNhzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2019 19:46:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wXWwhpdRgill+QTPv3BKJAOvN43996rdTBF/4swV0U8=; b=FlP8wRbWl0zj7De91vYcG2C79
 PtfKLaPfuDNa6KpnRDxy0fS5CW1/WBC2QkzQdd3uwh00blaoP5j6+Gl3q+8O5JAk1I6ZbMUw/6A9o
 nYbRLjeK55ePNl8E4uj7o/U6veOHatkgw21qb4KqNQ4LrWUEc7m9JskRcraUsIIN+tpBmLSCvBlDK
 VwFAaFCzk91GCmZy3kLOJE+KapzZfmNa5Po0POQ8t/IXUMaARP96Hb+bhdUFoS7Elk2eV0FvaeYMC
 IEUnpzVwhlU5PX93IiFvjMUpHXzTxc+v+I/7xQ4KoeAK9WPm/QVieEpBXdbv2bG9/FBJ4Q4ssTccI
 4ON2vYmfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iZsxd-0003st-AT; Wed, 27 Nov 2019 08:46:09 +0000
Date: Wed, 27 Nov 2019 00:46:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/14] powerpc/vas: Update CSB and notify process for
 fault CRBs
Message-ID: <20191127084609.GF17097@infradead.org>
References: <1574817074.13250.16.camel@hbabu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574817074.13250.16.camel@hbabu-laptop>
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
 npiggin@gmail.com, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>  
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
> +
> +	info.si_addr = (void *)fault_addr;
> +	rcu_read_lock();
> +	rc = kill_pid_info(SIGSEGV, &info, find_vpid(pid));
> +	rcu_read_unlock();
> +
> +	pr_devel("%s(): pid %d kill_proc_info() rc %d\n", __func__, pid, rc);
> +}

Shouldn't this use force_sig_fault_to_task instead?

> +	/*
> +	 * User space passed invalid CSB address, Notify process with
> +	 * SEGV signal.
> +	 */
> +	tsk = get_pid_task(window->pid, PIDTYPE_PID);
> +	/*
> +	 * Send window will be closed after processing all NX requests
> +	 * and process exits after closing all windows. In multi-thread
> +	 * applications, thread may not exists, but does not close FD
> +	 * (means send window) upon exit. Parent thread (tgid) can use
> +	 * and close the window later.
> +	 */
> +	if (tsk) {
> +		if (tsk->flags & PF_EXITING)
> +			task_exit = 1;
> +		put_task_struct(tsk);
> +		pid = vas_window_pid(window);

The pid is later used for sending the signal again, why not keep the
reference?

> +	} else {
> +		pid = vas_window_tgid(window);
> +
> +		rcu_read_lock();
> +		tsk = find_task_by_vpid(pid);
> +		if (!tsk) {
> +			rcu_read_unlock();
> +			return;
> +		}
> +		if (tsk->flags & PF_EXITING)
> +			task_exit = 1;
> +		rcu_read_unlock();

Why does this not need a reference to the task, but the other one does?
