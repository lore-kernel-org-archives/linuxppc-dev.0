Return-Path: <linuxppc-dev+bounces-17986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88999FD88D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 00:56:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVsky2QSXz2yFY;
	Wed, 11 Mar 2026 11:56:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773149108;
	cv=none; b=NAJeazPksjuPG1TMlH3BuiasVEr8b33V6gx3AWXm4lMP52f7Rc//d1Y9zk15kcIXJSpL3xoSm+UVzT2qWtphCQNVg4ugByy/K6iIWMfUzDKU0IWpOZ0vswnvi4eA92/hUMwvUEHIVyu7NqbTs3Wh2PlTKzIPrqDiMLb7IubDfpcr4siIdmOiml2ok3EsrXoF0c2KluEG4xGcD/OPQX/GZ26yI7ckJMkm4g+H9P35QYcHILabuZQgEhTwpW/yDCohWEfP2PsE7LtyLMRgLS9V9KNy/NArjdxvCUIdxedjRtiljAh6jjIfmaAFBIOkopZXj9nKjDlODZXbVVgZllkgCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773149108; c=relaxed/relaxed;
	bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvE3n5UsSqJu8ZwFt19P/DHppK6n/RiqvhIqqiDmO+Qdkl6DDclg+7/aGjFkIa4XGWTNJrRr4znqGmC2vkfYyVXU1I0P3oI/N87qEZi2G63pzfTnivzc/DDSgBTVxcPRiYss3OgRi89AntQ/EuV/vJqxY4cCHUsnxRP5lNWUxnbhj39lUoqHgjUwibMTIts5Rp7InVMJkUsnfXkjQDb+XaltXC/bUVr1RAieP4ErgP/ulRxwIdJV3BvYkQKeWF/U0WZOWKqOim3OkVP0q58uXR6hSm21m9X3f+M17BSEgT9TgMbmZPKO3dhnDq9DSqZyM3HkKdLTrJhT4j0IkGDZdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rbrb7M3Q; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rbrb7M3Q; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=qzhao@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rbrb7M3Q;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rbrb7M3Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=qzhao@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVZPG3tzqz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 00:25:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773149102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
	b=Rbrb7M3Qt9WoZRx5L/JJuPnYTxOnPxdbv/KYDxPkU42E8wnHWz0ErFX85xwS/jMSgAuF/P
	lS3thVQG5d01WQzJpDQ3a8+Q38/NahV8xZhdvVQOpSO8h5CBjiLFR7l94YpKPkMpTbNsnx
	hWwLDrncBN4wttRO4FWgN6nffc/TFI0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773149102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
	b=Rbrb7M3Qt9WoZRx5L/JJuPnYTxOnPxdbv/KYDxPkU42E8wnHWz0ErFX85xwS/jMSgAuF/P
	lS3thVQG5d01WQzJpDQ3a8+Q38/NahV8xZhdvVQOpSO8h5CBjiLFR7l94YpKPkMpTbNsnx
	hWwLDrncBN4wttRO4FWgN6nffc/TFI0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-TRKrFlQNPjWbc6S0XVCj_g-1; Tue, 10 Mar 2026 09:25:00 -0400
X-MC-Unique: TRKrFlQNPjWbc6S0XVCj_g-1
X-Mimecast-MFC-AGG-ID: TRKrFlQNPjWbc6S0XVCj_g_1773149100
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67bb47e67f4so29240610eaf.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 06:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149099; x=1773753899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+mRiZHd3hjy9wYbcMzg1z2YcvSrUrPgvmFfUtqm16Gs=;
        b=K7Wanuhyt1KGLEBMSuigjLlaHCCL8/iG4wWvtDXZ1l6aaU1Q/PhFs2hUo50FzDXOeL
         1uI26/K/3SA1LmA9LoadympPDumpK5wphEtIUFC9GJCZok4RPFFM0ffbtI86q4l4PwQV
         PPyhfkdcJ3KlqwDGxILdmaM+7VsGGkx+uJNmpmlPhFoQc/F/9/w+DS5ZthbvFi8h3H1I
         QXUIFxpnQ0vHLrYg+NIjOvtylnucCS9LeVvJWx/HWBnZe1aCy1uGSkQg6jfAO4t2mrc8
         ekbVu5/f75TJdz+suT0YI2L5UACxy7lzu03FtT48B0C3qADLfMskgswEx33SOxu+QT2u
         nDcg==
X-Gm-Message-State: AOJu0YwsXqz83iLdJtTafaqPmQYSeb4F0vE8j2QMsRppBt7iNcbOVXq/
	grwklA0f4zY7f2I9EBKoUfWjcbi38JeZXhnmjKoYMAAimVlKRcLuI5E21kKhS3Bbrn5JM9Rl4FG
	Z5R+DhGUCQo6v0DPQi+bsTVbCNgGebn6QEHoz8/R1/ecGQ8zfqx0nqGxYe+qHPUcBqBtlvm+SS6
	KQv+ACFZQnYFn5qkE2PQxylAfeKh9h95LlSRgt5STIuSfYEiuvMB9d
X-Gm-Gg: ATEYQzwrmabF8hZUbUc5AGSTda+tvCUNtV6UMLxH483ql0ogZo1WW0mZzNKUo04UfCS
	GmWON3nUG3iMYRYFuQadIlRzLPqHE0qQysQJuUX9H1GtjJT4Gz2cAEjEvdIgURE/0waejmnAlen
	OhfE5aXOhyL4WQGCw63voCcQf5iApKaYBcbbMBflOp4Gh24bQp6DJjvJGcfc2s/bIyonj3rudzx
	R4RywE=
X-Received: by 2002:a05:6820:2188:b0:67b:c08f:c646 with SMTP id 006d021491bc7-67bc08fc867mr800210eaf.45.1773149099377;
        Tue, 10 Mar 2026 06:24:59 -0700 (PDT)
X-Received: by 2002:a05:6820:2188:b0:67b:c08f:c646 with SMTP id
 006d021491bc7-67bc08fc867mr800178eaf.45.1773149098970; Tue, 10 Mar 2026
 06:24:58 -0700 (PDT)
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
References: <20260309144045.169427-1-vmalik@redhat.com>
In-Reply-To: <20260309144045.169427-1-vmalik@redhat.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Tue, 10 Mar 2026 21:24:47 +0800
X-Gm-Features: AaiRm52us4L_x-yzPwkJaPK73H8lBCzWxkyJHukmqBE4DeWQ1HyAoAtPgAw11Ks
Message-ID: <CAATMXfmc8VAGh3d1D2MYPvZQiUpwua8o7FyRngSw4CmyRPZkrQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc, perf: Check that current->mm is alive before
 getting user callchain
To: Viktor Malik <vmalik@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	Paul Mackerras <paulus@ozlabs.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3wLKIzhkqQ7v4dsbdQbXiUbMKARTDeAbRZrsayAPHtc_1773149100
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Run the BPF profiling program (profile.py from bcc-tools) on a ppc64le
machine and passed.

Tested-by: Qiao Zhao <qzhao@redhat.com>

Thanks,
Qiao

On Mon, Mar 9, 2026 at 10:43=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> It may happen that mm is already released, which leads to kernel panic.
> This adds the NULL check for current->mm, similarly to 20afc60f892d
> ("x86, perf: Check that current->mm is alive before getting user
> callchain").
>
> I was getting this panic when running a profiling BPF program
> (profile.py from bcc-tools):
>
>     [26215.051935] Kernel attempted to read user page (588) - exploit att=
empt? (uid: 0)
>     [26215.051950] BUG: Kernel NULL pointer dereference on read at 0x0000=
0588
>     [26215.051952] Faulting instruction address: 0xc00000000020fac0
>     [26215.051957] Oops: Kernel access of bad area, sig: 11 [#1]
>     [...]
>     [26215.052049] Call Trace:
>     [26215.052050] [c000000061da6d30] [c00000000020fc10] perf_callchain_u=
ser_64+0x2d0/0x490 (unreliable)
>     [26215.052054] [c000000061da6dc0] [c00000000020f92c] perf_callchain_u=
ser+0x1c/0x30
>     [26215.052057] [c000000061da6de0] [c0000000005ab2a0] get_perf_callcha=
in+0x100/0x360
>     [26215.052063] [c000000061da6e70] [c000000000573bc8] bpf_get_stackid+=
0x88/0xf0
>     [26215.052067] [c000000061da6ea0] [c008000000042258] bpf_prog_16d4ab9=
ab662f669_do_perf_event+0xf8/0x274
>     [...]
>
> In addition, move storing the top-level stack entry to generic
> perf_callchain_user to make sure the top-evel entry is always captured,
> even if current->mm is NULL.
>
> Fixes: 20002ded4d93 ("perf_counter: powerpc: Add callchain support")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
> Changes in v2:
> - Move call to perf_callchain_store() for the top-level stack entry to
>   common perf_callchain_user (Saket)
>
>  arch/powerpc/perf/callchain.c    | 5 +++++
>  arch/powerpc/perf/callchain_32.c | 1 -
>  arch/powerpc/perf/callchain_64.c | 1 -
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.=
c
> index 26aa26482c9a..992cc5c98214 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -103,6 +103,11 @@ perf_callchain_kernel(struct perf_callchain_entry_ct=
x *entry, struct pt_regs *re
>  void
>  perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_re=
gs *regs)
>  {
> +       perf_callchain_store(entry, perf_arch_instruction_pointer(regs));
> +
> +       if (!current->mm)
> +               return;
> +
>         if (!is_32bit_task())
>                 perf_callchain_user_64(entry, regs);
>         else
> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callcha=
in_32.c
> index ddcc2d8aa64a..0de21c5d272c 100644
> --- a/arch/powerpc/perf/callchain_32.c
> +++ b/arch/powerpc/perf/callchain_32.c
> @@ -142,7 +142,6 @@ void perf_callchain_user_32(struct perf_callchain_ent=
ry_ctx *entry,
>         next_ip =3D perf_arch_instruction_pointer(regs);
>         lr =3D regs->link;
>         sp =3D regs->gpr[1];
> -       perf_callchain_store(entry, next_ip);
>
>         while (entry->nr < entry->max_stack) {
>                 fp =3D (unsigned int __user *) (unsigned long) sp;
> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callcha=
in_64.c
> index 115d1c105e8a..30fb61c5f0cb 100644
> --- a/arch/powerpc/perf/callchain_64.c
> +++ b/arch/powerpc/perf/callchain_64.c
> @@ -77,7 +77,6 @@ void perf_callchain_user_64(struct perf_callchain_entry=
_ctx *entry,
>         next_ip =3D perf_arch_instruction_pointer(regs);
>         lr =3D regs->link;
>         sp =3D regs->gpr[1];
> -       perf_callchain_store(entry, next_ip);
>
>         while (entry->nr < entry->max_stack) {
>                 fp =3D (unsigned long __user *) sp;
> --
> 2.53.0
>
>


