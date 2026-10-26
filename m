Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917C606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRMTuMlw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jD05s6P6Zz2yGT;
	Tue, 27 Oct 2026 03:52:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793033521;
	cv=none; b=ACOR4Y4K9djA+mo8l3+gIKsOS0Hb1fk6BYYtI5DBI9dbsnraKqSa4W4LOlzxpn4Rtqat48q/ZtGzOUGwdWoxzvqlsfmPq2rajayTCquQ0WLmWGTA+rk+/c1IWAud2KHFc9OMFZ3sT02e4omLM6gPjU+yW9pSRjTY70TSZ6QT5thHgucVHw6ZXoCUemuxxzH2X5eu7oLs3oekowFj3+aN4iwLMEENdyKVo2T1Kg1rr8yfrAn9iVVJRHzG6JJiD2MRpmxJThxng/Yf+O4oWC/+SqSY3O2/vjXVHBg+k9zdgPVJzttmXwT2azImjGtYdUlNgsxX9BanyNg1D4ZkjptAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793033521; c=relaxed/relaxed;
	bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlP6wc57oPYH9OlrBv3jpeXaw+e0mUlSQMNdviunkS1ONNd02JSdLpVxWTjiZmZphQMq7FLR8LxjKvJ3Jo3RBevBeImLfFCboANyRxot1VcWj5BKGpNY/6p7F4p6QlaktZrB61490hzu1SrMrH8lqOD1ODLI8yGwxd+IO6K6FQ+pQEvHT7VUdl1Pha1qjzUHSw6eK1fNMGq22FhAeKkJWgI05wCurT/KvUvI2NFizMQYeKgix2Tn2COCdTYM8qU4ijp7PwVkktv8TQDfc0A+PVOG0KjbEZw3uwLjekeFUnX/j89hO/U21P20PyK4AyhJ34PZqGy7Cx+OY2XHxYwwVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRMTuMlw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=dRMTuMlw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jD05r3vgmz2xbN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 03:52:00 +1100 (AEDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so11886545e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793033516; x=1793638316; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=dRMTuMlwMZpsImSPpTdmPBQeuv6DqWGhVhYXQP8NLzdWX4FoNsNpAIzjZspm3R/3NX
         d64+TJb4vPFQ/FUHEKnNPKsYRLliFDmZGuqlEIRp7HTCuVLrAiWWqzN8u8GWvLuuURbm
         B5GlkbvCk5S9WAQMrqgm4yRD1d7QQOdQ07g7eb6W61XRZNZ1DLJ6TE/cst1U6sfu4tDk
         nR1BkG4T3OEV8fcs6aoYyAb38iH6YBfcoHdojCpTuKszugEr0tgINwzB+OAzU6c/sW+W
         WSoxH9JeW04ZWjV7CftKIyBLGMTk16bXLxJ4SWB2AuEpZBziFrL2tzCCRbSq9Mam9gSP
         384g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033516; x=1793638316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2/2qQgHjg7B4L90wJY7NcYQb/sw77pDt+0YufHxfkwg=;
        b=Zg1QWhm5wsBUG0tSMEZiLNiLFfGEGTuOAD3QVEpsJHzBiDnt11vcS64EkMD2wVmrEX
         LYR+rRQ6YU+Q3xam1snTcimKkCyflqPNue5cc8YgEpIOQ+eDv4PwhC1RbCFmWMYuyNEN
         qSK2lr0aXY827bB/fQ+MFsG2UFqAJnJ8s4cyoQgmHuyo9aMoZvogIpBeJayFFKANlygF
         tYORyHiA9N0KZkJzcCOGSQAlUydR8tFNIc8UIsIfuKgFs+iNb+aKIYOZcVssHkS207Ou
         qubHmBZ1UIccDkbvYDVIx27pANlHRigyX9A6Khb2FbZf7QU+pli2DAiE4R79zfRilR4i
         KSPw==
X-Forwarded-Encrypted: i=1; AKwUvBxxNoXx9gnqJn/W3YooTDsQXB00vxLROIMmq5qrhEKGPoVWL8153duqSVzWVY8p6pG9q/5klrPFYqWaRW0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKwsj7D4aYcII5BX9o5MbiZLuPBxJ/Q/GtxTuUPhz2juNK6BxlK
	bP92He2UQTPHScadkEx8LJUXGwGlwqCkOd/ln8gHxuk3LnWf4FLteVnmSHS7jY3euw==
X-Gm-Gg: AYBFou3FWwm2uAzs/cvsmz+RhtE8XYUQQfRwgDKR3SRf6cbcrMpeVIi0T/01mWuohBO
	UxtovCO4cD+TzAWlE/UmMp+PAE93uD1zRvyN8vjQT7742AcMgpZZCmv2DpGZScOCVXx7fQqbhxI
	OBTKsShaWlexs1z+D+azqBPDChQhI9/NWJRI5FTx1GeSbmQsTfJr2ruNCyNiOuebegxb3LxfcRn
	jsiWfGnAAG3jCtoQ24WVSCFkdTDUtzkoATwjyU72cOQe9Ry58YTQT3yIvOXC9eD0rucuJ4lQ1mk
	6e5CLT3V6pl1wSVE42ON0eHl7MzQVOnCTWwQS99zPDu/XFFzFGy06XR3rc80khbtcayAV8RIC+d
	zgY88QIcJxDgmCNeOf8i5ilrB6BKNaQRmhqSA9J9RdQ9UeLZDNT4lKlEbS+2oSlJNAwA1RtIzKv
	DKabKC3CFlf5itPU1CHZTz/hTu63vx/+hoRO+Ma0tkr7GkYeU4A24GhY02rmjE8g4/njkys6S3b
	YJtLBsa5WzZZ8K2EiY4xktc/eF9iACJrGvn7FunOSARwOakV6Fbx5NS/8lUDww1cxBwkHaOSI00
	tihxTXHdOP4mmP0XgZaYKXpv
X-Received: by 2002:a05:600c:46c5:b0:4a2:1364:252b with SMTP id 5b1f17b1804b1-4a35acba20dmr143926245e9.35.1793033515974;
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a58a293sm204540985e9.12.2026.10.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:51:55 -0700 (PDT)
Date: Mon, 26 Oct 2026 16:51:52 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <at-FKOk_-OrKTP8H@google.com>
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 08:24:59PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> period from early_trace_init() through smp_init().  defer_init() leaves
> only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> up-front, and on kernels with large static binary footprints (debug
> configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this pool.
> 
> si_mem_available() therefore returns a false negative (often 0-1 pages)
> across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> 
> This failure is false: the buddy allocator is designed to replenish
> ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> short-circuits this on-demand growth entirely.
> 
> deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> completes (it spawns per-node kthreads and blocks until done), which happens
> inside kernel_init_freeable() — before system_state is set to
> SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> and si_mem_available() is accurate.
> 
> Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i = LONG_MAX during
> this window, unconditionally bypassing the threshold check.  On kernels
> without deferred init IS_ENABLED() compiles the branch away and the original
> check is preserved unchanged.

Commit messages are not LLMs' strong suit.

Otherwise.

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>

> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changes since v3:
>  - Replace #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT / #else / #endif with
>    IS_ENABLED() + i = LONG_MAX to avoid duplicating the threshold check.
>    (Vincent Donnefort)
>  - Trim the in-code comment to one sentence. (Vincent Donnefort)
> 
> Changes since v2:
>  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
>    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> 
> Changes since v1:
>  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
>    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
>    completes, so the false negative window spans both SYSTEM_BOOTING and
>    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
>    boundary.  (Sashiko, Vincent Donnefort)
>  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
>    check unchanged on non-deferred kernels. (Vincent Donnefort)
>  - Drop Tested-by: guard condition changed, requesting fresh test.
> 
>  kernel/trace/ring_buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..09c02e838c4d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,8 +2463,16 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
> +		 * will reflect the actual available memory only after
> +		 * SYSTEM_FREEING_INITMEM.
>  		 */
>  		i = si_mem_available();
> +		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> +		    system_state < SYSTEM_FREEING_INITMEM)
> +			i = LONG_MAX;
> +
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
>  
> 
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> -- 
> 2.54.0 (Apple Git-157)
> 

