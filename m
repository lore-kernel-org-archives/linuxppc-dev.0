Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADE606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BH8YLCDn
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9wrf62snz2ySl;
	Fri, 23 Oct 2026 19:18:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792743506;
	cv=none; b=cJsscTKcQCknBi4hpzmo6q4/LGYuVaHn4q2cp8eevgZ15F6u36kZG8vjJtaeT+B5yTilV6cGbV0TtbRMO1+tHVTpg5ska/QMjSW14Gsqs+CXXzkaw15pAKseBLv9jrMYydnUQBmZoWemaiQvaODKaf+ZAXXfpe0es3cmOKdMn1OtCD8G+EonoqnLSMyb0LOMVwTZ+IEEmoZVnk1eal0zLuYRBz6PlvisuBWft4oLRVwKiXTtHNpQUQytoaCeNy0jUW2FFSNYs5m1hmJ+ZyKEDKrzYcPoS22pTgVUN1+9/L3pl5KhEQtdTxu9VGd7QmRmfs0gLit5qDJR2Vex9D/OmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792743506; c=relaxed/relaxed;
	bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EExcyipa27plP4tzKZpHYyA2bAJVTPsnrahxlt36L5YMXKTyaUWg4YhIJw9bidGnd0NzxK8PJtwbFcQSCV+YT/lxmxbnQw7m40HWh+DiwoUfas3SimRATTtaxWLlkhHIsek8UaNsII8xjhX5lWb/ESSQPg08O1K+n2SSFird+/zToTbfZdmlwmdca0UCuEh2OXT+/QCRCl32bVJVymoYMQUJaBfMOxxis5ByMUQ0CxGDhr0234hV9x9i8QMrb9vA8k6GLpR6olfdfTHwyFNraauEwt0AkoXweU6Ta1Q66v1YW0fjsmXcDpbcg16xBnXZwzkM1tnxaSOgFXN6fBS7Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BH8YLCDn; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BH8YLCDn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9wrc3HWRz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 19:18:24 +1100 (AEDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso6463555e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792743496; x=1793348296; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
        b=BH8YLCDn5s5o9H6jE2kPgNpWl4SkcwyOZdfV5pHtm7mgWVB565xuXjRveKS6EyvYPa
         kBBsffCQn2/QD5Ehiu62E4goV37qBN/1GsIo9oYBFFes/BlrzPAVCj6ICqMNtpWmbJjl
         DWebJSCfmHyh1d60GN+vN5OOedhCkIWESROrjh2veBwfWf4Z8NNjjn/LUmxBPzkMs+x1
         Q11bmqmVhlzn83giPZL6qbhPk6UuxyjHe0Ehh86iL63ij5lFwflyeOr2mYH8VEdS1snY
         gu3GBmWO0/ZEfZsH9nXkBJ8mld6FaN6vfjnXtpAlnoKChNk68xzQMCaiR6olV8UYAFBi
         KUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743496; x=1793348296;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5oVeJI18w0YWnW1MyEvLa+/8268RVOyYzuorpmt19/c=;
        b=GuHm073A0bWCa+elvJ/GR/XR1N0km4zNbwyum+91eQEir3LSXptAbzoj9eD1XDJt9y
         7X9qO8Qg6LXvGKa1mq1Si7TPy1aAlTMLAuVHSbvxVGTSgSjqQIyDg03lETEH54G7xgQC
         P/bOrbqS+p7G6wg4zeLq7OhGDSRqzmYs8zEi0mt0R9Fs5JiH7yqpuI/3cKgoiDZEyEZY
         4Smv2Uk0feA7gimUaaHJ0KBe+8EbNvlptI6QeeDHQMeP6BRNOYjosscEMzyeoz2LayJR
         fE/S9qa9j8eUIv9GBNe8gFXRgj1H5XUTmFhCjm6JnFBXEiOxukjwFlceIYv84B90Bn2M
         c9TA==
X-Forwarded-Encrypted: i=1; AKwUvBwHr+7r+zBL/uhsK3one7MqkyR6A7CYpt0wxZ0zoq+J9ASLPuCJraXDnEC/jXxM7skQgrMYQyeYztL+4Pk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI2LS5i31mvocidz68XuCM7qfglzlqqRS7Vj9hFfOxq2b1jvHJM
	N9bsaHrXNUXBeWvr1lcN6Opt/G4FAUuNKzvPUkL0LXIwEQ5r+KtBpZ48NwCvRYlJFQ==
X-Gm-Gg: AYBFou1YrvIAB59iS3symZSFR3/GnXl3sESmebZ8BAOGVo02vov6/bipB39uqK38Y8h
	VaTwwAfAK5qVAdyRa/QVgCU8Sm9Qxx4LtTHo1g9Fr6v9riKWttrycfUWKwSvEm4mX9LxTVd8kiA
	VMvcRW3dA6fkDKAJF24WQ2UvipjRUCkZaOMGDL/Tya/OjV2uUqGTcTlUnBSqlldgG3QgDIeonbg
	YzudoInB0tY57/5mr3C1n1wRKjs0QEeVEwcbd0LmIAa1JPSj/j5flTUUTLtLgVr6ND7EjdXJu7T
	sZQXbhShrisCeNtnRoCKtG+lSoGuS3EKPc0nBRbH2BdvqB81/aeHpE5zDRiNnX66UwFJdgiB3fb
	rB2G7tx/ibBGdUCrOmQa/xbahZUWXynIX1LqBUx5H2jWtAZuO2mtmH5dmf0TMsMz4XZL3FqMqdE
	jCw7t/mk7bI5wa9fdmn4FhleO5Qat2TeZuwtSIVof0jHN2L9XdAD0uICSMwA5SE6yEYuC90o26G
	f897eWwCerB45mWTT4fWP7ltpKB/winLrFWtJc3Ac4qePZrnA33+Z5BjFFyjgYc+noKaHX/UQ7z
	JJ4lk9FJJu3kJnEL8RNjUWrH
X-Received: by 2002:a05:600c:524b:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4a211ed3f5emr23048395e9.24.1792743494996;
        Fri, 23 Oct 2026 01:18:14 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm68556225e9.8.2026.10.23.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:18:14 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:18:10 +0100
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
Subject: Re: [PATCH v3] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <atsYQtXHRH_cCQ5A@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <20261022181817.49717-1-amachhiw@linux.ibm.com>
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
In-Reply-To: <20261022181817.49717-1-amachhiw@linux.ibm.com>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 11:48:17PM +0530, Amit Machhiwal wrote:
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
> Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
> without deferred init the original check is preserved unchanged.
> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

It is usually good practice to not use in-reply-to to link the series between
each other.

> ---
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
>  kernel/trace/ring_buffer.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..8e5a59a7b69b 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
> +		 * reflects the initial non-deferred pool during early boot and
> +		 * throughout SMP bring-up (smp_init() runs before
> +		 * page_alloc_init_late() completes deferred initialization).
> +		 * si_mem_available() returns a false negative across this
> +		 * entire window while actual allocations succeed by growing the
> +		 * zone on demand via deferred_grow_zone(). Only re-enable the
> +		 * check from SYSTEM_FREEING_INITMEM onward, after
> +		 * page_alloc_init_late() has finished and si_mem_available() is
> +		 * accurate.

This is quite a massive comment for something simple: When
CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available() will reflect the actual
available memory only after SYSTEM_FREEING_INITMEM.

>  		 */
>  		i = si_mem_available();
> +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> +		if (system_state >= SYSTEM_FREEING_INITMEM &&
> +		    i < (nr_pages << subbuf_order))
> +			return -ENOMEM;
> +#else
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
> +#endif

Could we avoid the double i < (nr_pages << subbuf_order) with something like

if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
    system_state < SYSTEM_FREEING_INITMEM)
       i = LONG_MAX;

>  
>  		user_thread = current->mm != NULL;
>  	}
> 
> base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
> -- 
> 2.54.0 (Apple Git-157)
> 

-- 
Vincent

