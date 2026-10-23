Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36137606A321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zUOHQ6XH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB8dx2YWQz2yDc;
	Sat, 24 Oct 2026 04:09:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792775397;
	cv=none; b=eaCljJ0LCdp3hguPtFjFp89AulbMWU8PRCkyBP+d95XLQ37zrzX1ymSZDlYN3/bycjaBwp4ejwqkK8PTEuthOhIZDLE3CVK0rUz+whI0N0+uTvDlmHZmu1mL9TEpreQFc8m7+ZbIzQE5h2/aFOH0cOcdz4briztsrMiQsWL/AWt3GZVQG/ZsYvACiPTzTKLeysWCZ4B2gvThO9Lsld0j2mokeS+crdsh2RNYUy5S3FixKE80/DN3FHeEC2Z+Goq1rvsxeunk7osFpBUueoSHmQa1I7Ee4r/Oj6JLCxh1qvwencV6jrf+UOGYSuqvebaybETokIdZdim9dv5QUsAOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792775397; c=relaxed/relaxed;
	bh=8m4RKkMiiU8bh0E91081ZTnsfbzeWqjKyYPrm7qreTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8aHlRLU3rr2BHH4zfHHtTdLfsOMZdyn4EbnsFdH0o3rLZQa+aj6sO054/5ptiWLrKfnABVSbE4XQuE8N9p3jmA/jA0daBokmYg6e8EzD7wF3s/QeIzHNhcUY1l/ejKxtFTRuMNtTimOkrW5mwSBX84tQFtBh9/VgFOJxS9goVOTUrHGDwllG1im97VB+IjXUBfihcMQcry7PllqJsqN8EYlQ3VZqwCFrbFHKBsq4TJc1OmPnWH1hsT7JXfMv2cNH8+lbqLfu1cZHxnL1M3pTl5dn1Gfca9Jou3d8riN7Rv/eLfxpmEM4tv8mq/eafFO8AvmQh7XOhy9+/r4oOEXAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zUOHQ6XH; dkim-atps=neutral; spf=pass (client-ip=216.40.44.10; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=zUOHQ6XH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.10; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB8dt2p3lz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 04:09:53 +1100 (AEDT)
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A2E79C0180;
	Fri, 23 Oct 2026 17:09:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 45F2E30;
	Fri, 23 Oct 2026 17:09:46 +0000 (UTC)
Date: Fri, 23 Oct 2026 13:09:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani
 <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Madhavan
 Srinivasan <maddy@linux.vnet.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Use raw_local_irq_pmu_save/restore() in
 local_t functions
Message-ID: <20261023130943.775b2b65@gandalf.local.home>
In-Reply-To: <20261023155529.3895393-1-jmarchan@redhat.com>
References: <20261023155529.3895393-1-jmarchan@redhat.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=4.0.1
X-Rspamd-Server: rspamout06
X-Stat-Signature: dkd49bp7ie9q1ukpuri763w5nzcejt5a
X-Rspamd-Queue-Id: 45F2E30
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/0wX9pO02ZWtXsM9Kya2cXD7k+9fbyk8Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=8m4RKkMiiU8bh0E91081ZTnsfbzeWqjKyYPrm7qreTc=; b=zUOHQ6XHb8k5FmnnTjDdDC3cfTDXs9E6/Ow/oHOFpxNl40ZCyaAIvD9/OHZjWt99Kx13XgneXmdpyWmrYgdTjUHs7WZtaQkuCTpNi/RVnOwc4FsxqNcY8MsBG2NsCzVkzTY2n3KlyjMw9M4K0i+K5cqtZ6s1TbOyNfqfCuAA7NM=
X-HE-Tag: 1792775386-597871
X-HE-Meta: U2FsdGVkX1+KkNW6m+t9S1AvyAQdJ3NdBfSGduko+1ErfnQswKcHgIVurgl/PvL/JYZgmf8Laz9ai/H6APmL94CktNTyzCU4ziuSsE4AoJtKtJPT4o0JpbpQEStgwHWCrfyGHnarg8cpyisnWtMBAXRqYn3ZyHabCoTE6Rg836tC7TeBqxr0c01+lPEdvifHiZoAPB+Pf3gLBa6vsEP6ChfI3/V2TDMZj1k26tGTn+Eerebs0H1aZRWvGy5HjxkDOiFjHmSMkLPoRvR2PRFnJqRpxh0pnWcheDzpmwrgSyHxgD7W2N8g+GWJ+9hX8JzVYqfzayAVNDxQgBEYztu1Yex11WY9JnC1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 17:55:29 +0200
Jerome Marchand <jmarchan@redhat.com> wrote:

> On ppc64 with CONFIG_TRACE_IRQFLAGS enabled, the ring buffer code can
> enter in an infinite recursion loop.
> 
> The problem occurs because some PowerPC's local_t operations
> (local_inc/dec in particular) use powerpc_local_irq_pmu_save/restore()
> which call trace_hardirqs_on/off() to generate trace events. This
> creates a recursion loop:
> 
>   ring_buffer_unlock_commit()
>     rb_commit()
>       local_inc(&cpu_buffer->entries)
>         powerpc_local_irq_pmu_save()
>           trace_hardirqs_off()
>             trace event => ring_buffer_unlock_commit()
>               [INFINITE RECURSION]

Hmm, the ring buffer has recursion protection that should prevent this. My
question is, why didn't that work? Yes, I agree with the patch to not have
local_inc/dec() call anything that can be traced, but if this caused an
infinite recursion, there's a bug in the ring buffer code I want fixed too.

The ring buffer has a trace_recursive_lock() that will allow one level of
recursion and then prevents new commits from happening. The
trace_recursive_unlock() is called after the rb_commit(). Why did the
rb_commit() allow an infinite recursion?

-- Steve

