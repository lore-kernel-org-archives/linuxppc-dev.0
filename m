Return-Path: <linuxppc-dev+bounces-29333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C981CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:39:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3Tq239RDz30RN;
	Tue, 13 Oct 2026 07:39:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791823135;
	cv=none; b=fZhG5KgubpleN/gcgWeBLlFaFmNN0Dg+qUdsg1jdD14Jj1GBQrRuPumHHfhmP/6qM1VejBcNFKHC9a1uD4y3K4UDWiHJJBwoveoYODyw16ND+JpqZXti00hhJaRKXgyzbor1KRXRFhV1vlihUckpKVpNDAGSGy2FEAuV9kEBpckbQnHEIjGPE4jrR1l70Tt8sVoSH4st14MIBU/0xF8lFoS0g9lmbmNws60QDjSXi5ktf+Kj13Er+RnFGrkeHv4S/k5JXONQ6PRqAeOQxoNq1YErHtsRcD+2wP0GBu0KUz8dp6+CZS3aR5/3no6mRrT5XexCdfRhOvLXm4Is6Qzh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791823135; c=relaxed/relaxed;
	bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp0sSdT2Nqu4Kefr4mGXoXhAoihdDGfhBreNOC6cU/KOaJXM3aE1axHOm8Pu8/VB5wXg5KpxHZskrl1Ju4Rwk0gOZKiFSawpcRA7ntYf9WAYxRLBGKrRLsd5wltGtxo0A2IAFwTSgjOYdVSJ8CymZxe9hboO9HMETnWrRgZhJDDKHE0QQFebnqukyedG4VWdJ52uIU7a27HfhAT6pJH+kLWWv350ZKl1cgJylXud+BbMEKh38kyOlYscqZ2g9j0mLblKQBbsplGwnD1l0D/q0r2bjD9B7eyu2KqNxqAHmqUPs2Khz0Mtlb1V9/YIYJ+x4YaXEq0+h25ZM2N51TMU+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o8m/jSda; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=o8m/jSda;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3NTB097nz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 03:38:53 +1100 (AEDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-48c02782159so1280274f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791823128; x=1792427928; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
        b=o8m/jSdav+qV9sUwEahmdTBBouzSR9qc6cFpNWqZJeTgTAeDxcS9Eyaa0shHoYiuI7
         9qigoNGLizgxAG4YmSbZrIh6/9ekfhKwKyEj/oSWkSq4adbuZyBatd9SQO0G5bLY0hDd
         Jk++rhZzoZJ0d0HfgbP+PsMEzE2Zcyej0mA2jHgSnOFsfd5YS17Ft9KRFUMzLF+lLRlu
         re8HB2xuS+WhF0HRveSLAfABnSXJ4wWN7crFjTQHP64kWMEbJtr/zSt3sQS+7ih1By+R
         440vyBZ61hOfhGsroFTHMSfAMeITgT2gxzFFuXDxrxxa1Bal8nv7iJ/i2zr67IZXrNSi
         fVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823128; x=1792427928;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HuWCbCHALjFKQvI6kk2Kyts8iE/+EiR+kuOdFcAFHro=;
        b=ODaM9cwp5qS1w8af8fhmk2mISBHZUOkcus6vLvogyNfeJ3Td5qkL12oIR3Y8CYh53C
         S/Xm4eF0YcevggsqBr8FDU0s35BX7jBVwx7ulWOmzofP8Kly0zvRAR6+ESIi4UbpiO8Z
         hAiORDdAYHEIlNjdbfn1LL3gkSME1oTJy4RTugFvdX9bC/cjP46CnixBCeUAhoicaerS
         1XB0wFAmojj9GYcln0S4dQVTbRDsOz6fORl05Z2o1juMz0QkAGsHt9wX114TDnT7l0UK
         45sa6C/iLNihWouCdYmwR6VN6hZ9ZXO6131JZ6gMiMikajn3BiQPvKF7rY1so6bTLRDp
         nR/w==
X-Forwarded-Encrypted: i=1; AKwUvByyK9ndX7HcWtpkfqUdkhz/exzv+QHq7004u+WcU1TtoqRvqw6kGZIcanIv17NxPDXQFkyGk8i/4mXUXPk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKdUYPn1RM7uDpLN2r+gm1ylyjEgrld5l6ckpVxiU5OiiBIEmv5
	4XsPmGPqOzz/g54GOXFNuzQ5fVKGSkBd3v+O2oQFfm7l6SP5nyLB3P8/bDQW6FQ40w==
X-Gm-Gg: AYBFou3DESo0QtVEpmqdARq5zbq1ojqf5nRlZoLLMt2UEWOutEp/58L6fK0vToQuOZI
	/47xNJxZ2r46cB5oBTZcJ8S7J8i4TwHDAlfPa5QN+rrxy0NxYQFGjFwRMyzLoTTTqv/lSh6wBJt
	RqAd6MBGjFGeVVa39Tb8g912HQMwl8MHcWbA6kPQabiZdOqvJL3KrVO/FXXsDdZ+V1VfO3GvTHC
	pTGGQgP+coc/N4RUTUYOZ9+NlzvDqG+RrYrQXxsXNm4smvBvq5Meu30cWmlDxgTkV9tCuWrWMmd
	vE84OKJC1fzt9qmCfunZup1LzcYJLCDHbdq3gUz8sDo2aeUSP7XlXRQQQCcz0JDD9mfJ+9ohhhJ
	KZl8pn+9e5AlURQQNvhEfhCsmWi3BWjHA69ctyL0uaFLg+Z/dq8qJ1jVGxqxhM2nEhh8oC6OP5w
	/tgKyEyxm9jtyvJZcpUOM3RCNGtmo85CUwceYZDVbWFqA3h1kJ7WDyFVjqmzfFueYpmJLoqDKWD
	r5svOUKhyLUcHo9A36woWePrdE3yS6LCDOKMdD7x2U=
X-Received: by 2002:a05:6000:4a0b:b0:48b:11e1:8bc8 with SMTP id ffacd0b85a97d-48dbace678emr18199465f8f.39.1791823126911;
        Mon, 12 Oct 2026 09:38:46 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc91e2sm297646f8f.55.2026.10.12.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:38:44 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:38:39 +0100
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
	kvm-ppc@vger.kernel.org, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ring-buffer: Do not check si_mem_available() during
 SYSTEM_BOOTING
Message-ID: <as0NDyaXsfQnWPQ4@google.com>
References: <20261009163557.88467-1-amachhiw@linux.ibm.com>
 <20261009163557.88467-3-amachhiw@linux.ibm.com>
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
In-Reply-To: <20261009163557.88467-3-amachhiw@linux.ibm.com>

On Fri, Oct 09, 2026 at 10:05:57PM +0530, Amit Machhiwal wrote:
> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.
> 
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
> 
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> defer_init() leaves only a single section per node (e.g.  16 MiB with 64
> KB pages) initialized up-front.  On kernels with large static binary
> footprints (such as debug configurations enabling PAGE_OWNER,
> DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG), the static kernel image and
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this initial pool.
> 
> At T=0.000000, watermarks have not yet been established
> (totalreserve_pages = 0), so si_mem_available() returns the raw free
> page count (often 0-1 pages).  When the snapshot buffer or global trace
> buffer attempts to allocate 2 sub-pages, si_mem_available() returns <
> nr_pages and prematurely aborts with -ENOMEM.
> 
> This failure is false: if the page allocation were actually attempted
> via alloc_pages_node(), the page allocator would trigger
> deferred_grow_zone() on demand to initialise additional deferred memory
> sections.  Checking si_mem_available() before attempting the allocation
> short-circuits this on-demand growth.
> 
> Skip the si_mem_available() check when system_state == SYSTEM_BOOTING.
> Once the system transitions past early boot and page_alloc_init_late()
> initialises all deferred memory, si_mem_available() accurately reflects
> system-wide free memory and the check operates as intended for runtime
> allocations.
> 
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Suchánek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  kernel/trace/ring_buffer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 04bb94c29f58..a9f82e2f8fad 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2452,9 +2452,15 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  	 * memory. It may not be accurate. But we don't care, we just want
>  	 * to prevent doing any allocation when it is obvious that it is
>  	 * not going to succeed.
> +	 *
> +	 * Skip this check during early boot: with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
> +	 * NR_FREE_PAGES only reflects the initial non-deferred pool at this
> +	 * stage. si_mem_available() returns a false negative while actual
> +	 * allocations succeed by growing the zone on demand via
> +	 * deferred_grow_zone().

As Sashiko pointed-out, if si_mem_available() is only ready after
page_alloc_init_late() when CONFIG_DEFERRED_STRUCT_PAGE_INIT, then checking for
system_state >= SYSTEM_FREEING_INITMEM might be more correct.

Also I wonder if we don't want to guard with CONFIG_DEFERRED_STRUCT_PAGE_INIT,
to keep the verification when CONFIG_DEFERRED_STRUCT_PAGE_INIT is unset.

>  	 */
>  	i = si_mem_available();
> -	if (i < nr_pages)
> +	if (system_state != SYSTEM_BOOTING && i < nr_pages)
>  		return -ENOMEM;
>  
>  	/*
> -- 
> 2.54.0 (Apple Git-157)
> 
> 

-- 
Vincent

