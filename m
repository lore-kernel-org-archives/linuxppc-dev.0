Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43A606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTVR16pC7z2xPb;
	Wed, 18 Nov 2026 03:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794932621;
	cv=none; b=KDhpoWChkglQR9DcGKZPhpPELGBipQnwsC8UlC+hKKPctEdmEz1EerGbAnNtf4+oKrmK9OxOfFGWBi8KkT7W21Fj8aNfdwYRY1n7/J0fHBv2CMes077MonbOzPSu4NSpHxWg5t+eR2iF4+zTFeg3oYjPjjPsoK+37TM8U5kK5E+mDqbniAKKE5BMgir1tswvmIHrS2kZTOh3cSat0iymVLE/MLxNYJsEfAoFt9lLa3fPyxmaNOSoo20kyFreLHNwnt0T69DVKsU17Bb6eGOia6XiTkWYKZAIyLklfqFyuPqzYP9ebZAfbaIVEhEemShsARIHnjNBFwhCCq/y20nv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794932621; c=relaxed/relaxed;
	bh=9bKC9y5sYZUFVKo3cJF968X4JmNJ/KKgeW9i3uCsAQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SdKoC4seof0vQqEuQ6pwAY/yy0dD9iUxFcYdbBp0/zixFBpfzxkvQxgyvjkMy46amoXvTyorzsKixzYFVZrLpgyGbdoIOZIGAwhAjr4UeixWCQkGRsc2uQel1A2TiFNc0SOLTLhjXhgWQfrZAizUdT4Fh8SJ9vLBmRlJxkGNeWqkicPKeR0bKxppC705HS5gIDwtaTyOtWNuEC65BgrMH0yw5REGQghCHoJ7aZVK6j3Kzj6/g8yOufmgLukbCsB0PPVlmJAq/zqi2R/dFouwAwy3z/yVC7ryeD43/gt8fJS3GXIGlj5e9WIXsNP2GykEunU8MbpAsH8UBGXN/hJ6Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A672g0X6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTVR01fJCz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:23:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794932615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKC9y5sYZUFVKo3cJF968X4JmNJ/KKgeW9i3uCsAQ4=;
	b=A672g0X6Nd0bvkqcf9/cMSE8K/y6lNmme/bxa4qT/ZCnrisU+xUwCI+O+3udz3wjDuCyMS
	F91nI9Wlf82UfUDMGLEK76cWMFpNGwzj+kEBl2ZQVXyxn60fN8exd9cSQCnKQvSmejyzJe
	ULuN2IhRy0OEHOQXD+j/uWuuJ8A/hDM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794932615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKC9y5sYZUFVKo3cJF968X4JmNJ/KKgeW9i3uCsAQ4=;
	b=A672g0X6Nd0bvkqcf9/cMSE8K/y6lNmme/bxa4qT/ZCnrisU+xUwCI+O+3udz3wjDuCyMS
	F91nI9Wlf82UfUDMGLEK76cWMFpNGwzj+kEBl2ZQVXyxn60fN8exd9cSQCnKQvSmejyzJe
	ULuN2IhRy0OEHOQXD+j/uWuuJ8A/hDM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794932615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bKC9y5sYZUFVKo3cJF968X4JmNJ/KKgeW9i3uCsAQ4=;
	b=A672g0X6Nd0bvkqcf9/cMSE8K/y6lNmme/bxa4qT/ZCnrisU+xUwCI+O+3udz3wjDuCyMS
	F91nI9Wlf82UfUDMGLEK76cWMFpNGwzj+kEBl2ZQVXyxn60fN8exd9cSQCnKQvSmejyzJe
	ULuN2IhRy0OEHOQXD+j/uWuuJ8A/hDM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-XavX1kWgOCO_-y1dC__RfQ-1; Tue,
 17 Nov 2026 11:23:30 -0500
X-MC-Unique: XavX1kWgOCO_-y1dC__RfQ-1
X-Mimecast-MFC-AGG-ID: XavX1kWgOCO_-y1dC__RfQ_1794932608
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D234E19560B5;
	Tue, 17 Nov 2026 16:23:26 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C0C371956054;
	Tue, 17 Nov 2026 16:23:20 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Tue, 17 Nov 2026 17:23:26 +0100 (CET)
Date: Tue, 17 Nov 2026 17:23:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 2/3] ptrace: add PTRACE_SET_SYSCALL_INFO syscall
 skipping support
Message-ID: <avx_d9SSnpwhSyqU@redhat.com>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <20261114181923.370930-3-renzo@cs.unibo.it>
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
In-Reply-To: <20261114181923.370930-3-renzo@cs.unibo.it>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: VsfivtZPvgcLJdS4HDuyTSeb6Ygf2-R5l022PcFOeK8_1794932608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14, Renzo Davoli wrote:
>
> Extend PTRACE_SET_SYSCALL_INFO to support skipping a system call
> triggered via seccomp.

...

> Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
> [v8: skip via seccomp_ptrace_skip_syscall() instead of syscall_set_nr(-1),
>  separate ptrace_set_syscall_info_seccomp_skip(), reject later
>  PTRACE_SYSCALL_INFO_SECCOMP updates during the same stop]
> [v11: report the stop as PTRACE_SYSCALL_INFO_EXIT once the syscall is
>  skipped, instead of rejecting PTRACE_SYSCALL_INFO_SECCOMP explicitly]
> Assisted-by: claude-opus-5-5
> ---
>  kernel/ptrace.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



Sashiko has some concerns
https://sashiko.dev/#/patchset/20261114181923.370930-1-renzo%40cs.unibo.it
but IIUC this is the "pre-existing" problem fixed by

	[PATCH v3 0/2] powerpc/syscall: Fix the return value of skipped syscalls
	https://lore.kernel.org/lkml/20261030084926.1068384-1-renzo@cs.unibo.it/

so this change do not need to depend on the powerpc-specific fix above.

Right? Just to be sure...

Oleg.


