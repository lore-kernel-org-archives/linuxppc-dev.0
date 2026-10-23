Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00841606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JFRjDIAk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9wvT2gCcz2xdX;
	Fri, 23 Oct 2026 19:20:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792743653;
	cv=none; b=fwoCNmGMujHvLKFJ7QAwGhkaSSHL9VSeCnwa5tyiB7AxBUHuCP9x0RpIhcAR4D9tKWG6EHjxpmYjq6B9f2cO8wMMAaQwwtXvjjcXEFS+rwrx218I5cGIK2JZ5AZkb2ybvs9V+sorkmTe1EB2SbSg8rYngaOhVAxbfi6ly3ESmsyLHoBipNd3LqhHLNT8cw3vn/N7/iYYu+b8lIXxrHt8SNpWpmzqzzQzX3TIHYsq3jULv54do261x8y3iwaYvjqwUrC0SeeOg53Y3e3U9yBnVZ+kNJroQ5gGty4jK3xxYroqNKwL8Qc60VSzChG20+bUcqG7fOTkApRfyhQA4W0Ijw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792743653; c=relaxed/relaxed;
	bh=SXFzVxbt3rTWSbyQVYsDzyVGHc2RBqghX5A01kRz5f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HODEpcUcXJ7rhDIB1oXMQ01XpawggSGoHKG1LYmbuoJ0LmwadrLuYYleYlIl+qZOT2+Kq7zoMdaMy8Ids5T3WzFaBSl10YQD+vYmGOTmrqbbyqqqe9IRodHzXh61+XvfJWJE2qDmAUQR0faO5ZRPICW1J2/ZGGVVPZjgP/pf5kP6sqpVcuKPfGNyRaaawt5av095Om/wb+TGTFhqNnxk3U6nmZ4EOyVzzdkjtL5F+ccgiKXqjmrMXQ4nb6tWiHbAdhWn2lFr2Vm1lw/C9vdj1+Zh4jB3y6hoN9DDTPZRKfhAGhj5WWoVSlcgqpcpaRzIT+nKlDYOkeQS9YyfSt1DHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JFRjDIAk; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JFRjDIAk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=vdonnefort@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9wvS28M4z2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 19:20:52 +1100 (AEDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso5773685e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792743649; x=1793348449; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXFzVxbt3rTWSbyQVYsDzyVGHc2RBqghX5A01kRz5f8=;
        b=JFRjDIAkF3iY6owct/Q/K+wYjBW9eGCRmiYhZ6/8oAI3FOLfwqtxEBnq6QoJA10Q6n
         CXLazdoJpYM9XuYKlWTYOxl5mtyhFJoL0g4l//z8M73KzaJstJS3pkW51mDRbtfGc5ix
         O3K4s6J++ebcgoWZQor3JWvKSd/thsFKVPj2AbeQYViGzTZt4Tu9La6gEdNAfr1WqflX
         OUexVtUZOTNmlILVIbFJc4gyKaBpFwj1iQckrT1U8vYoRVamT82DvYk96zRUdka8n42+
         8eZpocNssriPdwGu+Xo57kqmstgAfjTOe89ZVAE2jNJHLv63MXrfcmREPW/lA1E7dBKP
         kVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743649; x=1793348449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SXFzVxbt3rTWSbyQVYsDzyVGHc2RBqghX5A01kRz5f8=;
        b=iqhOjhtBO/SJi9W6jcGC+r/usiSCTP6iSTwcPHG4xx5yNm0GH7Ig91DWIn9dE0JYLu
         2z3ZTBeoNOIgwVOS6iyW4RZYGtJWxDy8JtfUJJ92D2AcetrCYcqFnAOUlG9nYBMzXLTe
         g9AeVwSkgxmqm167rCOvURM+HXp28PbqMWGVcxX5LPQSdFtFe0MtGWHtBIVndBH9snRU
         ER5S7+eXiWelVKSzk1G58C5sSKs55n9Vw3IkdpZFhcBayYxaFgiHeLs/yR6ojgGTjCOQ
         BAylFVsR8SlFcQnHp84Zg9Y9INr8o4+VhEXxcbk2JbClyJnWwCUSoQ2zD2UVBc+Jj5Fo
         8T0g==
X-Forwarded-Encrypted: i=1; AKwUvBwDZ8aleX9nYegQEREV2XaAOdSLGN9idtrhTzEiHzZaGJgSe4yipqxSBdcjoEoKFQX4SNAPQlms3JNa8yc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIZYJ5dcKn0DxS7dJDIvd8ZCHQzF0WUAByO4tfRa1wsgBgzmrrw
	eymM5ZYJlt0+6+th2WIYw8mt2+et+75goT5Aft7E0Ha59pz9+0ULplxRjhpjLklSoA==
X-Gm-Gg: AYBFou3RL/ccQr/rHywZkdm7xPu+WlPv7CGEFXfsOiJ2ZKF5s5EN/BWQh9I5yQu/wM9
	hJQHwCTUidPK/wSGq6yJpl5FlJM3txrYnpJ6TpZdyWPyNO8Y0t+Xqo8PTAvDD73qeBftRclyhrP
	sOdweXECaASPa2L7N5TnxuuiBxSDJCgO4lQyvnKN3cv/hXeEvn6/P6y3IUQ2tyIaccdh5OyqGd1
	KU830+e6z6gC835AOtm1bcdLkwGRWTWm0WIy41rbl45RSXfmqpILw4TMy7lVQWPmqG8tKzOtuUF
	k8MxEVUxZEfoYYnCxSczn5u8B8TpkKXv+2TVVDvH6xfxNbvBH+mi6qyjgLGE/mdg+Par2DJL5EY
	EWfqfitCdPfSbhlNvEdsvNUEfWG0JJAA/xmzJSrdYxXd12cwzcv9BuY1Es7zewUlLsPLeCmd0tv
	RPQ2/6BXQ1HAhLt9WGH/siLLArVCOrN+GEM/ZB9HL4dU8Z8byjLjp0YScC3DFh6v8nfxNlldAa+
	mGtIskVNak61OYzcVNU6UzWeuc3UXD2zGwmW7Yy5UCQWZCDPGEbmmp0DdIjB5/OWlGl0vPS5Aqm
	ZRuERVvmCQCqG1qVWRTQEFGdeA==
X-Received: by 2002:a05:600c:1c05:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a211c45f89mr27907715e9.1.1792743648308;
        Fri, 23 Oct 2026 01:20:48 -0700 (PDT)
Received: from google.com (197.183.140.34.bc.googleusercontent.com. [34.140.183.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38031488sm3623513f8f.24.2026.10.23.01.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:20:47 -0700 (PDT)
Date: Fri, 23 Oct 2026 09:20:44 +0100
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
Message-ID: <atsY3MXXEUe2YopQ@google.com>
References: <20261016134247.70722-1-amachhiw@linux.ibm.com>
 <20261022181817.49717-1-amachhiw@linux.ibm.com>
 <atsYQtXHRH_cCQ5A@google.com>
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
In-Reply-To: <atsYQtXHRH_cCQ5A@google.com>
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 09:18:10AM +0100, Vincent Donnefort wrote:
> On Thu, Oct 22, 2026 at 11:48:17PM +0530, Amit Machhiwal wrote:
> > During early boot (early_trace_init() called from start_kernel()),
> > tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> > snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> > smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare().
> > 
> > Before attempting page allocation, __rb_allocate_pages() performs a
> > heuristic check using si_mem_available() to return early with -ENOMEM if
> > memory appears insufficient.
> > 
> > However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=y,
> > NR_FREE_PAGES only reflects the initial non-deferred pool across the entire
> > period from early_trace_init() through smp_init().  defer_init() leaves
> > only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> > up-front, and on kernels with large static binary footprints (debug
> > configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBUG),
> > early core initialisations (SLUB caches, vmalloc, static ftrace records)
> > consume virtually all managed pages in this pool.
> > 
> > si_mem_available() therefore returns a false negative (often 0-1 pages)
> > across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> > SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> > causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
> > 
> > This failure is false: the buddy allocator is designed to replenish
> > ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> > is attempted.  Checking si_mem_available() before calling alloc_pages_node()
> > short-circuits this on-demand growth entirely.
> > 
> > deferred_grow_zone() is only permanently disabled after page_alloc_init_late()
> > completes (it spawns per-node kthreads and blocks until done), which happens
> > inside kernel_init_freeable() — before system_state is set to
> > SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> > SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> > and si_mem_available() is accurate.
> > 
> > Wrap the guard in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT so that on kernels
> > without deferred init the original check is preserved unchanged.
> > 
> > Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
> > Cc: stable@vger.kernel.org
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> It is usually good practice to not use in-reply-to to link the series between
> each other.
> 
> > ---
> > Changes since v2:
> >  - Rebase on top of upstream ring_buffer.c changes from Vincent Donnefort;
> >    update threshold to i < (nr_pages << subbuf_order). (Michal Suchánek)
> > 
> > Changes since v1:
> >  - Extend the guard to cover SYSTEM_SCHEDULING as well: smp_init() calls
> >    trace_rb_cpu_prepare() -> __rb_allocate_pages() before page_alloc_init_late()
> >    completes, so the false negative window spans both SYSTEM_BOOTING and
> >    SYSTEM_SCHEDULING. Use system_state >= SYSTEM_FREEING_INITMEM as the correct
> >    boundary.  (Sashiko, Vincent Donnefort)
> >  - Wrap in #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT to preserve the original
> >    check unchanged on non-deferred kernels. (Vincent Donnefort)
> >  - Drop Tested-by: guard condition changed, requesting fresh test.
> > 
> >  kernel/trace/ring_buffer.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 9c4e40847e43..8e5a59a7b69b 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2463,10 +2463,27 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> >  		 * memory. It may not be accurate. But we don't care, we just want
> >  		 * to prevent doing any allocation when it is obvious that it is
> >  		 * not going to succeed.
> > +		 *
> > +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, NR_FREE_PAGES only
> > +		 * reflects the initial non-deferred pool during early boot and
> > +		 * throughout SMP bring-up (smp_init() runs before
> > +		 * page_alloc_init_late() completes deferred initialization).
> > +		 * si_mem_available() returns a false negative across this
> > +		 * entire window while actual allocations succeed by growing the
> > +		 * zone on demand via deferred_grow_zone(). Only re-enable the
> > +		 * check from SYSTEM_FREEING_INITMEM onward, after
> > +		 * page_alloc_init_late() has finished and si_mem_available() is
> > +		 * accurate.
> 
> This is quite a massive comment for something simple: When
> CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available() will reflect the actual
> available memory only after SYSTEM_FREEING_INITMEM.
> 
> >  		 */
> >  		i = si_mem_available();
> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > +		if (system_state >= SYSTEM_FREEING_INITMEM &&
> > +		    i < (nr_pages << subbuf_order))
> > +			return -ENOMEM;
> > +#else
> >  		if (i < (nr_pages << subbuf_order))
> >  			return -ENOMEM;
> > +#endif
> 
> Could we avoid the double i < (nr_pages << subbuf_order) with something like
> 
> if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
>     system_state < SYSTEM_FREEING_INITMEM)
>        i = LONG_MAX;
> 

or even i = totalram_pages()? 

> >  
> >  		user_thread = current->mm != NULL;
> >  	}
> > 
> > base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
> > -- 
> > 2.54.0 (Apple Git-157)
> > 
> 
> -- 
> Vincent

-- 
Vincent

