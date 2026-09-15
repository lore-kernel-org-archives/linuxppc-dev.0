Return-Path: <linuxppc-dev+bounces-27397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487AAC88E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 12:54:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkhmy5g7Zz2yFW;
	Tue, 15 Sep 2026 22:54:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789473776;
	cv=none; b=Ncwc1rytRTcd/uL5cjcgcCC5dPLGhvfHH2YvJPiu5lA+jnSVkcTDJAfexHtK5Il+Eh3v59rv539WpPcMeQfyzxk203M1jjnp6WFW2teoicvGcq9Lg0wCtsRMEnwMuur4dovWSeuHB4TD21Jq3fB4kVWShLx4FQTooBRfEajWMGm8E6T9IgrXar7sZGTIegNpW4cFfJevQ1geUmR76Pv2Z/hqB8eQCkyjWANdA5x35ltyodTC5osqhaXai5XYym+C0YDZkhzGd19BXcyk9qxZ0vnN+VsYa00Z1YOHx/+Fghd7ddt9Z8YPYnO+2f9tGyisn9b6IatlVtdAApxJjg+AqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789473776; c=relaxed/relaxed;
	bh=DKmKc8nUgnveY4UghGsysLXcnr7yvrf1lajtZ4j0caE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXpOZMbgar7CtWR5OMESppyGpUZPZQeCODnccpuXdyS3iemGdY7sAPH0Fpi+xzmBpp3/o1Fb3aGzPxnf9Ic8GmFpzRyT2/ZFXBG7zf6gKv67yIcv0ZAiSLeTNkVk8GXrIypAAN7+MmO0qI78GtcSj/UXy0BuBvE/B5ikcvCdptlFWN76FDhQInJBzzWxD1pq6Fbqrczii8fzaiYM7lvppWgwAPZOzc8gbceM13sx0ltNBVsAUTNsJFmkSaRTEeURPCcYaSjC2kUWm7A0JI4nF2xeDCedPGFTcZtLDt9OO51NlyRKwPEPnE1+u9whR8NpLyWk8Gl3myy+cPre2nCrQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfQU5nin; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfQU5nin;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkgdC6SPVz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 22:02:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B76E41687;
	Tue, 15 Sep 2026 12:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A091F000FF;
	Tue, 15 Sep 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473774;
	bh=DKmKc8nUgnveY4UghGsysLXcnr7yvrf1lajtZ4j0caE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DfQU5ninsS1IF1iFmSCoi9zf6HJdPuTsj7XVVosHw24AZzhEXM7lUTSHKfoNPHRdo
	 ftBPV2UxXZ2x35Xuh5jkFihXtOZzfFYSs5oMx5CREjLOMipaTe8AZXg3ZWUkHTE9VL
	 3gNhL/WjsyOkNox97h2tfNc5eOHIstmUUtbf7Kt7QK0dzF9fCvXokT4Z7qzy3LnalW
	 L8pIgSgRVoLl7LNk9qv23YKEL97Hvnx60zhcjswEXimdWiH3nyH090Y8Tjh1FGnAql
	 aHkyZipO2f+jnmDQAYZHAx+8OnX8dq3pE0GKnLcYYqt6qe+Wm21ZPjEtaRgeSDex2F
	 1fIq73PDJ4NnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 13/50] openrisc: commit fds on syscall exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-csky@vger.kernel.org, io-uring@vger.kernel.org, "Peter Zijlstra" <peterz@infradead.org>, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-mips@vger.kernel.org, "David Airlie" <airlied@redhat.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Ingo Molnar" <mingo@redhat.com>, linux-hyperv@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Jann
 Horn" <jannh@google.com>, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-arm-msm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org, kexec@lists.infradead.org, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, sparclinux@vger.kernel.org, linux-gpio@vger.kernel.org, linux-um@lists.infradead.org, virtualization@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Oleg
 Nesterov" <oleg@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-13-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-13-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:02:52 +0000
Message-Id: <20260915120252.89A091F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it together with TIF_SYSCALL_TRACE on the
> way out of a system call. The check used to rely on the flags r30 had
> been loaded with before the call. Reload them. The syscall may have set
> the new bit. A task that reserved descriptors calls
> do_syscall_trace_leave() which commits them before audit and the ptrace
> exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D13


