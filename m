Return-Path: <linuxppc-dev+bounces-29252-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9FCA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 10:04:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CkK5Yqvz3bSw;
	Mon, 12 Oct 2026 21:04:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791799481;
	cv=none; b=MaKhxjrFet3ILiYmtkVy5wyTIlRBuUObBL8+y98CyNKNL56nzXme5VmhOVIQ9aORNKOHMDvWxpR5EsilvGp7BnkW3B++JnaqpQmjaBzys5USJX/DIhyCAdIQT4gkz/lmK/Ev9fYeqb2g+sHIpdw5oM4EWDawMrDSjQlapl1QppxP0AWobIgxL+XoFgwa2KfuSKaM/yXDtCzVY4huxPDIFJiduC6Do0s4ABjdEWoWWA/tyQNI9tzUEJ3m3QMHdrwnWHkVGrAQnj92Fnv82urEwS/aCNxrAk5JjYkPFcVXroFoqcydoiFdYSEeefJwfrulHgy4FC9pGvL+XtZ/UL5CVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791799481; c=relaxed/relaxed;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7ONqM8YNgcna5h2k51VzvMA6pQYDf8JzoKfqNIjQxJoOtWNfMrMrYwmKbWHhNWDEiyp79DptW1QUhiHPXSxKNITumonkI528VyUJdzeuUjlQbFxqvHQrDz/IbyGaCxUVDq4DxJtMy37qOc0BJV9PGu+aEvDXQY8X9KhBD2/+petdGXeg0Voxm6qDEs8sJY86i7rXYZNKaVTJgOMhUrNsPIWRYxNNavVHJ3UOcgTjflJF0HefPzcCpkLBvLodrs3ZSuaad16ipc/s0bLRZKbirL8pin7KD+WFAehH32yiCo7Spi9euhwj/E26LglKRQ4AWSZo58TEYfwC2e6Ht7P2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ObvDo3gn; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QmfbedIY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ObvDo3gn; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QmfbedIY; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ObvDo3gn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QmfbedIY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ObvDo3gn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QmfbedIY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CkJ2fMPz30hC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:04:40 +1100 (AEDT)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9ABD31F76C;
	Mon, 12 Oct 2026 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791799476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=ObvDo3gnEPoN+VUfHnzb0zfbkhh8LRHVzgywDABcSgf4o/28kL5BF+OzqFBJ7KxrndM8xb
	kQE5RGqqOlzgupcdLJPSWMx8wR6KmxsiJyCQ2X38ctOCqm1yhQSlijtYL7eT3fTAn5wYsy
	kSLsadb+VxyXS4NyCQVwrclCvoo8Ta4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791799476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=QmfbedIYDfCznU/qAZcKnNcBZ+C19RNjPp1M0SggWKes4puqwQGJeIjd3n3RtwXc2aNdrt
	WMYTXHCNIy/XcUCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ObvDo3gn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QmfbedIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791799476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=ObvDo3gnEPoN+VUfHnzb0zfbkhh8LRHVzgywDABcSgf4o/28kL5BF+OzqFBJ7KxrndM8xb
	kQE5RGqqOlzgupcdLJPSWMx8wR6KmxsiJyCQ2X38ctOCqm1yhQSlijtYL7eT3fTAn5wYsy
	kSLsadb+VxyXS4NyCQVwrclCvoo8Ta4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791799476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV/uchDiV6BTnoljBvD8VleslGZ6Gbxx1QPYEt6Kc7A=;
	b=QmfbedIYDfCznU/qAZcKnNcBZ+C19RNjPp1M0SggWKes4puqwQGJeIjd3n3RtwXc2aNdrt
	WMYTXHCNIy/XcUCA==
Date: Mon, 12 Oct 2026 12:04:35 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Do not initialize tracefs work if tracing
 is disabled
Message-ID: <asywswm6JClQDcOg@kunlun.suse.cz>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-2-amachhiw@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009163557.88467-2-amachhiw@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.977];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,kernel.org,vger.kernel.org,lists.ozlabs.org,efficios.com,linux.ibm.com,gmail.com,mediatek.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 9ABD31F76C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri, Oct 09, 2026 at 10:05:56PM +0530, Amit Machhiwal wrote:
> If trace buffer allocation fails during early boot (e.g.  in
> early_trace_init() -> allocate_trace_buffers()), tracing_disabled is
> left set to 1 and the global trace array events list remains
> uninitialized.
> 
> Later during boot, tracer_init_tracefs() (invoked via fs_initcall)
> queues tracerfs_init_work asynchronously without checking if tracing was
> disabled.  When tracer_init_tracefs_work_func() runs, it calls
> event_trace_init() and init_tracer_tracefs(&global_trace, NULL)
> unconditionally.  This leads to __find_event_file() dereferencing an
> uninitialized tr->events list, causing an early boot NULL pointer
> dereference Oops:
> 
>   BUG: Kernel NULL pointer dereference on read at 0x00000010
>   Faulting instruction address: 0xc000000000485be0
>   Oops: Kernel access of bad area, sig: 7 [#1]
>   ...
>   NIP [c000000000485be0] __find_event_file+0x70/0x3c0
>   LR  [c000000000448874] init_tracer_tracefs+0x274/0xc80
>   Call Trace:
>    init_tracer_tracefs+0x274/0xc80
>    tracer_init_tracefs_work_func+0x50/0x320
>    process_one_work+0x1e8/0x5c0
>    worker_thread+0x1dc/0x3d0
>    kthread+0x194/0x1b0
>    start_kernel_thread+0x14/0x18
> 
> Check tracing_disabled at the beginning of tracer_init_tracefs_work_func()
> and return immediately if tracing is disabled or failed to initialize,
> preventing the crash.

Thanks for the patch

Tested-by: Michal Suchánek <msuchanek@suse.de>

> 
> Fixes: 6621a7004684 ("tracing: make tracer_init_tracefs initcall asynchronous")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/trace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c..7ac9e1c92702 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9287,6 +9287,12 @@ static struct notifier_block trace_module_nb = {
>  
>  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
>  {
> +	/*
> +	 * Do not attempt to initialize tracefs if tracing was disabled or
> +	 * failed to allocate
> +	 */
> +	if (tracing_disabled)
> +		return;
>  
>  	event_trace_init();
>  
> -- 
> 2.54.0 (Apple Git-157)
> 

