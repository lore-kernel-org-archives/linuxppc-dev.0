Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D72606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=6NY4mqyB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTdCF6LXyz2xPb;
	Wed, 18 Nov 2026 08:28:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794950937;
	cv=none; b=Lo0va2pgaApfluJClCfgoAQKGtKsDkwLxsDsPVyOowCKYkqiW9P4odFKOW1uc5EPOw8bg96cxKBovYvYVFxHXdDmtPso57At+fP807Loxr8UTKFxPwJCwDsWewgR934SZA83p9k+qED2hMw0HRGm6r9w5aLEI5KQDDnbEPEZ6sqJ/Awavld1l3HBQeT3h2jHhqR++F0Pb66m24ufp+NECRfVii59kSWU3CE8dRxzJ5r6cZNIWlJP5UyCenRzrKRNB0bZu0sFQSyFxL974owpqKhoD86iK3fSrXYsN7/HSpwHVNBT391Uu5freOLLQQgcvM4SWoxtayCDGbuoW+vNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794950937; c=relaxed/relaxed;
	bh=sok0CZwhI2weCSlua0qRcUV8buOFqxhZJVGyaUoPWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=err41mTV9cNBnfsxUyPeVt72TXT0PkzyXbxRcOSMdc5xcamBIgJMfiV6+ztQ0f/IEq+nukHDQRX0IfBXSrNttp6WjyNBy6L5lsH9mqXa1UNPGP84cUkA3eJh+XZ1GdVjv0JDctnrI2zDentQ6olq6bhPe9EpeD22vPiKBzUCZ49NfBbAZLAYy92Vc6cKZlPqqFltxzt3H9FW/qkJCJUYTst0RNAdgm+4N4XgHeJg9KotTlIXrEB901oZ7F64y2wrekTi90F1WH003rdaq6DYU2o9af9Yhhh5rG7y01zMv3PSTk8ge4tP9Ag7f6Sw6DCPGnwiBN99tAvAh8oxmXcMPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=6NY4mqyB; dkim-atps=neutral; spf=pass (client-ip=216.40.44.11; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=6NY4mqyB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.11; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTdCC3QmJz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:28:53 +1100 (AEDT)
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D36801A0111;
	Tue, 17 Nov 2026 21:28:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id E66A620016;
	Tue, 17 Nov 2026 21:28:43 +0000 (UTC)
Date: Tue, 17 Nov 2026 16:28:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Michal
 =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Vincent Donnefort
 <vdonnefort@google.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] ring-buffer: Do not check si_mem_available() before
 deferred init completes
Message-ID: <20261117162842.5cb22a24@gandalf.local.home>
In-Reply-To: <20261023145459.47516-1-amachhiw@linux.ibm.com>
References: <20261023145459.47516-1-amachhiw@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E66A620016
X-Stat-Signature: uz8ogb9bkninkia665f611tquq67ja7g
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=4.0.1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX190KJG1wKB8oxY9DNW4n/cv2wpWFqeVib0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=sok0CZwhI2weCSlua0qRcUV8buOFqxhZJVGyaUoPWW0=; b=6NY4mqyBcayAanYhwB+wNF/in+n88tz9eyhYjV72C6mrOo0rDCkGNm9lwoP28b9HPboSljBmkbq7sabRjxB7cmjP2fROJvcXxmqc2IIh4dhzKNj5kgOOL3JEXtJ7UdvlZDVxTGclJimb/4Dxg8GxIYKqV0yOzUoKO9f+fE5P2dE=
X-HE-Tag: 1794950923-547338
X-HE-Meta: U2FsdGVkX1+Z5NwWaYluQ9w9kbQeNNX0/mM6ywfmctuDnyU8UOryCSi/o8bflukrGTiphEoKPXquJwzKpxGaVbi/ueAKRt0q0jyMohX4lDs2W9rHzBhi/Qs8q0GavF+APZk0mhjCuIB/iGmeoA3XUlDuxv2Gnuibso7fzOKt3/Ru7EqIiWYCs+mNgGJfgTZz36Yb12+1Ns3EtKmP9slGRb13kuDByCIIzG9XSLGMbGSapgmvTpDZalhs8oK1hUgWSn7a3BDQkOTA1Qjw64zVwIio1SdGXnUSmw4tRtuQF9QyhpOy6dEZPAF+ddh73T6opH0kSWMStb6pKPBa1SUR4cF2qz55HMXM2DrkVOIlD1QXeH4NURO9Dw==
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 20:24:59 +0530
Amit Machhiwal <amachhiw@linux.ibm.com> wrote:

> During early boot (early_trace_init() called from start_kernel()),
> tracing allocates initial ring buffers (temp_buffer, array_buffer, and
> snapshot_buffer) for CPU 0.  Later, as secondary CPUs come online during
> smp_init(), each CPU's ring buffer is allocated via trace_rb_cpu_prepare(=
).
>=20
> Before attempting page allocation, __rb_allocate_pages() performs a
> heuristic check using si_mem_available() to return early with -ENOMEM if
> memory appears insufficient.
>=20
> However, on kernels built with CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy,
> NR_FREE_PAGES only reflects the initial non-deferred pool across the enti=
re
> period from early_trace_init() through smp_init().  defer_init() leaves
> only a single section per node (e.g.  16 MiB with 64 KB pages) initialized
> up-front, and on kernels with large static binary footprints (debug
> configurations enabling PAGE_OWNER, DEBUG_PAGEALLOC, KFENCE, or SLUB_DEBU=
G),
> early core initialisations (SLUB caches, vmalloc, static ftrace records)
> consume virtually all managed pages in this pool.
>=20
> si_mem_available() therefore returns a false negative (often 0-1 pages)
> across both SYSTEM_BOOTING (for the initial CPU 0 buffers) and
> SYSTEM_SCHEDULING (for secondary CPU buffers via trace_rb_cpu_prepare()),
> causing __rb_allocate_pages() to prematurely abort with -ENOMEM.
>=20
> This failure is false: the buddy allocator is designed to replenish
> ZONE_NORMAL on demand via deferred_grow_zone() when an actual allocation
> is attempted.  Checking si_mem_available() before calling alloc_pages_nod=
e()
> short-circuits this on-demand growth entirely.
>=20
> deferred_grow_zone() is only permanently disabled after page_alloc_init_l=
ate()
> completes (it spawns per-node kthreads and blocks until done), which happ=
ens
> inside kernel_init_freeable() =E2=80=94 before system_state is set to
> SYSTEM_FREEING_INITMEM.  Skip the si_mem_available() check until
> SYSTEM_FREEING_INITMEM, at which point all deferred pages are initialized
> and si_mem_available() is accurate.
>=20
> Use IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) to set i =3D LONG_MAX du=
ring
> this window, unconditionally bypassing the threshold check.  On kernels
> without deferred init IS_ENABLED() compiles the branch away and the origi=
nal
> check is preserved unchanged.

As Vincent mentioned, the above is just word salad. Please make it human
readable. That is, state what the actual issue is and how it's fixed and
remove all the AI fluff.

Also note, just because we no longer require an "Assisted-by" tag, it
should still be mentioned how the patch was created. I want to know.

>=20
> Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before al=
location")
> Cc: stable@vger.kernel.org
> Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Link: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c4e40847e43..09c02e838c4d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2463,8 +2463,16 @@ static int __rb_allocate_pages(struct ring_buffer_=
per_cpu *cpu_buffer,
>  		 * memory. It may not be accurate. But we don't care, we just want
>  		 * to prevent doing any allocation when it is obvious that it is
>  		 * not going to succeed.
> +		 *
> +		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
> +		 * will reflect the actual available memory only after
> +		 * SYSTEM_FREEING_INITMEM.
>  		 */
>  		i =3D si_mem_available();
> +		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
> +		    system_state < SYSTEM_FREEING_INITMEM)
> +			i =3D LONG_MAX;

Make the above an if/else statement.

		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
		    unlikely(system_state < SYSTEM_FREEING_INITMEM))
			i =3D LONG_MAX;
		else
	  		i =3D si_mem_available();

-- Steve


> +
>  		if (i < (nr_pages << subbuf_order))
>  			return -ENOMEM;
> =20
>=20
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b


