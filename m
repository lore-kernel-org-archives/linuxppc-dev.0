Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8398EC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:57:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0741820664
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Oct 2018 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hrjdgZYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0741820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42kx1w0yyBzF1RG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 02:57:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="hrjdgZYK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="hrjdgZYK"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42kwvw43RnzF35j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 02:52:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JrT+GY2FMwB2T1XAI7yMtLPtyidWS9RM37PHU0M8ADE=; b=hrjdgZYKhW66jsqwqYy7iBEqT
 aNllxbN4/e8ECyE0JYYVlRz4hYMQq+5XyXBhJug9T7NXVMGsZYNnB48zQ5AONXgGCCz5pSF7PKDGv
 pUVDc3Gfy6dNIDOhDp3hygtwI+6Ayy/kWZdsh+gXrZwiOSnojSmqIpKvUnWw65wIWG/RWwAdU+PXE
 ybavT2cUzBF09n3j7ot0t/xu+zRu2FHWKXET0xypzw3UeDhmVbOVREEUYAxmV9gYCr96vhkDYDukA
 /HU86umn8HQtqmSEHxnQN9yJjjim6IzloRma9Rh3rDily9mqzwc2/lKjda/4VtIWu1flnKNK/ibTj
 tmapDlxkw==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHPLh-000790-S1; Tue, 30 Oct 2018 08:26:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 47C7E202A40A3; Tue, 30 Oct 2018 09:25:25 +0100 (CET)
Date: Tue, 30 Oct 2018 09:25:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 6/7] smp: Don't yell about IRQs disabled in
 kgdb_roundup_cpus()
Message-ID: <20181030082525.GA13436@hirez.programming.kicks-ass.net>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-7-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029180707.207546-7-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-mips@linux-mips.org, Daniel Thompson <daniel.thompson@linaro.org>,
 linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, frederic@kernel.org,
 Jason Wessel <jason.wessel@windriver.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 luto@kernel.org, linux-arm-msm@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-hexagon@vger.kernel.org,
 tglx@linutronix.de, linux-snps-arc@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org, riel@surriel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 29, 2018 at 11:07:06AM -0700, Douglas Anderson wrote:
> In kgdb_roundup_cpus() we've got code that looks like:
>   local_irq_enable();
>   smp_call_function(kgdb_call_nmi_hook, NULL, 0);
>   local_irq_disable();

> Let's add kgdb to the list of reasons not to warn in
> smp_call_function_many().  That will allow us (in a future patch) to
> stop calling local_irq_enable() which will get rid of the original
> splat.
> 
> NOTE: with this change comes the obvious question: will we start
> deadlocking more often now when we drop into the debugger.  I can't
> say that for sure one way or the other, but the fact that we do the
> same logic for "oops_in_progress" makes me feel like it shouldn't
> happen too often.  Also note that the old logic of turning on
> interrupts temporarily wasn't exactly safe since (I presume) that
> could have violated spin_lock_irqsave() semantics and ended up with a
> deadlock of its own.

How is any of that not utterly and terminally broken?

> @@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
>  	 * can't happen.
>  	 */
>  	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
> -		     && !oops_in_progress && !early_boot_irqs_disabled);
> +		     && !oops_in_progress && !early_boot_irqs_disabled
> +		     && !in_dbg_master());
>  
>  	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
>  	cpu = cpumask_first_and(mask, cpu_online_mask);

Not a fan of this. There is a distinct difference between
oops_in_progress and dropping into kgdb in that you don't ever expect to
return/survive oopses, whereas we do expect to survive kgdb.

Also, how does kgdb work at all without actual NMIs ?

So no, NAK on this.
