Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E21ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:53:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5A320664
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2b5VPEDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5A320664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lVCc5NmkzF3GS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 00:53:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="2b5VPEDS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lV8c1PkLzF2Dw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 00:50:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B29CGHTcZSRPozCawRO0XQWdzdy7ZVHP04YQm6az4Fg=; b=2b5VPEDS93iezL40hzfFNdB2Q
 Q2oa5emouDWxBDM7YjtCvq3RBkzYU9UIAhg4JYT01GQFj0M0iqYO6+dBiwEGq2gzVWqL4Z17nzAIt
 /B6Mw8Pfum22SIv40RbXUlPzRuOIwFss6fTghn7UuDUfNBHGP4GEMz19SdWzpCc+WDfIaRdUB3sZG
 8GRBWpBKrxDu+ziq0SVvPyqxxbDYcWxfT0Xhih5/K0Vaud120bGBsU6fMFbNhViPxD4EkUUuEv0o8
 CiOgYuuGdLGodb+aXmisTm5i694FBlKVCPEwsGRkq6o6x7rywLw/sbA47HHO8UScG/QrmYyAFJMes
 335WGiv3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHqsD-0003jt-9j; Wed, 31 Oct 2018 13:49:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 528272029F885; Wed, 31 Oct 2018 14:49:26 +0100 (CET)
Date: Wed, 31 Oct 2018 14:49:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
Message-ID: <20181031134926.GB13237@hirez.programming.kicks-ass.net>
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030221843.121254-3-dianders@chromium.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kgdb-bugreport@lists.sourceforge.net,
 James Hogan <jhogan@kernel.org>, linux-snps-arc@lists.infradead.org,
 Jason Wessel <jason.wessel@windriver.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> Looking closely at it, it seems like a really bad idea to be calling
> local_irq_enable() in kgdb_roundup_cpus().  If nothing else that seems
> like it could violate spinlock semantics and cause a deadlock.
> 
> Instead, let's use a private csd alongside
> smp_call_function_single_async() to round up the other CPUs.  Using
> smp_call_function_single_async() doesn't require interrupts to be
> enabled so we can remove the offending bit of code.

You might want to mention that the only reason this isn't a deadlock
itself is because there is a timeout on waiting for the slaves to
check-in.

> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -55,6 +55,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmacache.h>
>  #include <linux/rcupdate.h>
> +#include <linux/irq.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/byteorder.h>
> @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +/*
> + * Default (weak) implementation for kgdb_roundup_cpus
> + */
> +
> +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> +
> +void __weak kgdb_call_nmi_hook(void *ignored)
> +{
> +	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> +}
> +
> +void __weak kgdb_roundup_cpus(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_cpu(cpu, cpu_online_mask) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		smp_call_function_single_async(cpu, csd);
> +	}
> +}
> +
> +static void kgdb_generic_roundup_init(void)
> +{
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		csd = &per_cpu(kgdb_roundup_csd, cpu);
> +		csd->func = kgdb_call_nmi_hook;
> +	}
> +}
> +
>  /*
>   * Some architectures need cache flushes when we set/clear a
>   * breakpoint:
> @@ -993,6 +1027,8 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  		return -EBUSY;
>  	}
>  
> +	kgdb_generic_roundup_init();
> +
>  	if (new_dbg_io_ops->init) {
>  		err = new_dbg_io_ops->init();
>  		if (err) {

That's a little bit of overhead for those architectures not using that
generic code; but I suppose we can live with that.
