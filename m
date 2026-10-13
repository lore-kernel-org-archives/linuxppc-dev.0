Return-Path: <linuxppc-dev+bounces-29449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD2FCC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 23:31:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j49Zq1dGNz3btj;
	Wed, 14 Oct 2026 10:31:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791934291;
	cv=none; b=ociVJ/+i9HBArz4Mz7B09mDQyjvpTkVpAr7NY51cXkSwSOTomhCMam26iZpYmqIEbuW3K8RwCvLMogVB4dq8Dhp2lUYdxazHiZseUA2zfPnun3Pvc2dTFiYszZOZ7uuvpTZRlfsr8p8wKFCkQFLKJq0GUSTy6rlnAlOxfyeOFbBESvLqmX/yuSNUOEqRbytBiuqdQkFq2uU6lwnNjOIAN4uBQZ4F1OqXjlHSsVjKdJJ5+ojR/p4NNGaGe62pgBSkj/b4zJojc34O4aCmJv2gk7aFNDk4K5RrwmaoiEbw5TkzKq8fLWrpRaFUqiBwBVfyZF8igPj8qsEL68vuBP2miQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791934291; c=relaxed/relaxed;
	bh=APi2ZfgZmahKqfvONReNmB6QiAyaVs+ZKVZwZPGqYh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=ERTxbrNI9Bt++1hzmKisxDSjiW/pSyZDiDQaCj1l0Gq2gUsukf0GgtaPqgo6HOkVkw6UqrHhJFy2mroFICfzNF1CxJ6Bzw8DEm0h14jE/xXNn9EPBm+8Jzb0NFPFc18LkexUKMTgPzXTow2xQKTwwrNMf1yUF7KeS78C6INVnLFdwPzJ21RIYilxNpCiged59uib80rd23trccZyINIlPup0Z4e1C/abqPwNCFrnDf+IKWYyN/E8LD3Bimr8a9mhEg1wK6exbwL9mPra6D4FwM0OOLJLxKkkUayRxQJjqrNYTIwWYuVFXscH4Bj39c9j2Lu/e6N8JUzJZ08RIcU5tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXSJPJb3; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mhiramat@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXSJPJb3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mhiramat@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j49Zp0GJlz3btZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 10:31:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AF74C600CB;
	Tue, 13 Oct 2026 23:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF091F000FF;
	Tue, 13 Oct 2026 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791934286;
	bh=APi2ZfgZmahKqfvONReNmB6QiAyaVs+ZKVZwZPGqYh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXSJPJb3ZwyaTyYxBAjLq6sUf5snAqcUWFn5362P9BKVrs69z5jtuKBXOK7MgZFhj
	 vaIbebRCBcIe3qo7EX2QIue+IYOQk85QSc1HSf9sog366F2tvfexS+4+S0Srs9rlY3
	 tu9PBp5qMgAgFN+zmTzdwu2xBFeDEkwqgrWouzNrV28buHFQbMQrXeYfcVVIMxZgcq
	 hjnr/maN5XTmY681pZxlgFkAb9xYESxFz0fnpityZ/sHYBe/AIEYgBNRv806/E/nBk
	 hSVqJ0W5gFuHRjiF+QaIJcH/1crTop/LBq9EC2QpYdFjbiODK4riQu7gxG9kWuUbrU
	 C3mBPZ7oZAHDw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: amachhiw@linux.ibm.com
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Michal =?utf-8?q?Such=C3=A1nek?= <msuchanek@suse.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Mark-PK Tsai <mark-pk.tsai@mediatek.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Do not initialize tracefs work if tracing is
 disabled
Date: Wed, 14 Oct 2026 08:31:21 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261009163557.88467-2-amachhiw@linux.ibm.com>
References: 20261009163557.88467-1-amachhiw@linux.ibm.com
 <20261009163557.88467-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Message-Id: <20261013233123.5FF091F000FF@smtp.kernel.org>

On Fri, 09 Oct 2026 22:05:56 +0530, Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
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
>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

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

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

