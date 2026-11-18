Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879A606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igeBfJaW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV0Nk299Bz2xdX;
	Wed, 18 Nov 2026 22:53:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795002806;
	cv=none; b=lC7BjP+F/gBglV/H6jHDImryMhRKU1WBh2Fir0ZKMwN4MPMqRSCBtAloOtYZ7aiUaPDSJlkTxoY2/pxj2xYT27qNfP9kjO9umw+QSiY8AY2E5yiIq15zy521MwTe+Vzkt9TJT7PTiYpM1dn4Ve4quO/mdphF4pRcnAEDA0J4PgvJwNgMZSxK6uAX6NIHX22ozyzVuHTdcy0xWU5iUKhB2BQjug4YIf/QQOejyH0xv9xkBa8LjbWmZ6sneBJWZCa1kUuxLv+gkz8Ys8whGliiiTyxfZtvdUOuvMuA+on3Bz8PGluOO1vrqwKWZmZcM0Oc9CuOPCixGVWZHKRJpUvvyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795002806; c=relaxed/relaxed;
	bh=8N9FZyOEbyiUWy2rIi8L5t2k68c/Uas6jnWB07vla6Q=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Ks7ZsfZaSXgMBWFwXJlU45taHdfSyQc7X+aNe38A5iBzQ5jmE1wFWLxxMveqNY9LzettksOYYDx2GAeYu2+2CVvCbQmWMgL5GAaD1Gz+4WC6tJgXR4tZY8s6bna6FzZ0oMZkSL+y2Va6718OuVNn2EWn89J0VU9nkkGQndSDGDp+LwkhYSwu1dbLzSXfIM1XgKQ0QoDJHRRKmg+OhLpVWQO6lSjigMEVz6Vdh50e2NTpVKFcoAFfc1O0/9d09/+SUpKBxxPOYytmivHa/9H1XDt1pxoZ24+wQk0o/vIO0fzz0YyKvbfPuSH95q4+vqHANs+0mpV+qvgOSTjkJc9xpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igeBfJaW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=igeBfJaW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV0Nj3795z2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 22:53:24 +1100 (AEDT)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso1152170c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795002803; x=1795607603; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8N9FZyOEbyiUWy2rIi8L5t2k68c/Uas6jnWB07vla6Q=;
        b=igeBfJaWn4y4kZh1zy2R45d+kBw+KVTowf3jvGx2iO0aAwlJpqtskDCOvyGw7EYYJ6
         3sbck/QoV8gEdkEiedGYVwHeTAqS6YpovWIfrpUBOw0QP0XFjh98rYEzy9exIh2nV7bc
         41G2Ke3ddmzdhGG/G8ntqwGeplE6aoGPEaIxyjKIN6wL/CfXobqCqlnmFXSBfe9f2qrK
         7yy0HP9sVWxqA7Q7eTLrEvFjWKlzVSNJv7icu7CbI0P68Nuu64ya4DjRvGBtH9rCK69/
         PtqlmwT6bKsJG86ncyvnELBxhhHj+6tU+ODbFPqZZpoCuGHNuJKVYPTYlalfn/ZxeIX1
         i/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795002803; x=1795607603;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8N9FZyOEbyiUWy2rIi8L5t2k68c/Uas6jnWB07vla6Q=;
        b=lmzQLpm3+23hD/vcCnRo+PKIdnMRftww9v//A5cjuDRT0NNl3BCGHI/UfVXl14XOFg
         BRke3yvAue0Dm/HhsbUne4W0ZZrgOaezRk/Xfs99X1vvKa3EW+vqRpaT7sU1zyu9uUxS
         Zlrmh4bj9VfA0MbO6p44OAQZ++vKadgAnzBo7bxzhrCMbHxsQfEYHs6uN+87XP+ovYaq
         RbI1+KlXP8uSPvwQab9O3WuH3J3LgoC00sS1Ng7VldCBB/NaCe8OarLqIDU6SevWNMkY
         OOdgDbv2mIqzW8Y1sMxoExOAxfVfTpyu1f42ArRX3tSnv1NpGHKBXlJYIJCjA6tl69N8
         82gw==
X-Forwarded-Encrypted: i=1; AL+hErEfAa7g7Lo3JoXYBaNpb1atCyp0qRve3SABI3Qhh+mnAxfva/WALOb8+tQU9RItAdZicJdPN4M6NZuPgvQ=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+2SCRX8MTBW0+Mr00lT4lgwK86Dn9/3Jro8lq6wfBU2BZmvWX3
	xJrE3kip5Dqbrqn82e2S9I7qkakd18S19Ib+aOKD9HUxVt2ua35r7TFs
X-Gm-Gg: AYBFou3w/w4Tb4AwmTKbCCUH85e2m5d5x2gBr5lmcgxBZl/YIsJIWDI4KmlkMO2LA5W
	I6t6PvCPsUrWRs9hsGA526Rtg0LPV5s3Su5fROmZHOfXHe86SRN1D5CDEVFWTr4YgooCfNQi75n
	W9SJyrxtwSM4/ecOs3zhElu8A58PnLJOFvTTOFgIGDkCwYTzdEg32hUmxjjJfsN2UfD9hjLABjR
	dHqL6rAT7FIlI+eCeSf3SWS4bOvxH32si2FnLAAPDSZo8epFtGbEBGvBzQnoC+wYX5AeYj+hOAV
	YFNok8YqhrJcaS1I80v3afpnp08/swTeY1yHZ6AiEDV5voqf0shXOY7+i8t/GjNy8JThDXnNWIW
	CjQNqLtZepTptqAMwX95RcFDtXwVcZnzhjJPiYOhO4rhErzfge51OKmugOBoJDDceQxd4Qg82WR
	qs8x0udujCLDShr6RqO82A1Cc8/+GJVruA7zRg8McL7PzMJiUbxEjBInDKpYAazrEl7Hpw0ap9e
	PSLZndaxABfn7Wy2K3sO2QC1PkEHgk0C6VCajp5gCX08sEOpiKok9Ei5+Fio0+KKjtLkOWLV3bZ
	H363N+Lzh8XtPdfpLmHJryNAlI6Sn9V9ArvBzCvmbqT8z8h0
X-Received: by 2002:a05:701b:2056:b0:144:eaa7:2763 with SMTP id a92af1059eb24-1b543cf2a7amr2077988c88.16.1795002802386;
        Wed, 18 Nov 2026 03:53:22 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447da7e0sm9120829c88.9.2026.11.18.03.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:53:20 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: mdshahid03@gmail.com, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Mohammad Shahid <mdshahid03@gmail.com>, Athira Rajeev <atrajeev@linux.ibm.com>, Tanushree Shah <tshah@linux.ibm.com>
Subject: Re: [PATCH] powerpc/perf: vpa-dtl: fix resource leak on allocation failure
In-Reply-To: <20261112134455.6880-1-mdshahid03@gmail.com>
Date: Wed, 18 Nov 2026 17:02:01 +0530
Message-ID: <ld6q74um.ritesh.list@gmail.com>
References: <20261112134455.6880-1-mdshahid03@gmail.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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


mdshahid03@gmail.com writes:

> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> vpa_dtl_event_init acquires dtl_access_lock when initializing the
> first vpa_dtl PMU event.
>
> If vpa_dtl_mem_alloc() fails,the function returns -ENOMEM without
> releasing the semaphore.
>
> Release the semaphore when buffer allocation fails and no other
> PMU events are active.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  arch/powerpc/perf/vpa-dtl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
> index 3e3d65b6c796..20eafeaffa6b 100644
> --- a/arch/powerpc/perf/vpa-dtl.c
> +++ b/arch/powerpc/perf/vpa-dtl.c
> @@ -396,6 +396,8 @@ static int vpa_dtl_event_init(struct perf_event *event)
>  
>  	/* Allocate dtl buffer memory */
>  	if (vpa_dtl_mem_alloc(event->cpu)) {
> +		if (dtl_global_refc == 0)
> +			up_write(&dtl_access_lock);
>  		spin_unlock(&dtl_global_lock);
>  		return -ENOMEM;
>  	}


I looked at this code and I am unable to wrap my head around it. We have
dtl_access_lock and dtl_global_lock. Then we have vpa_dtl, which is a
per-cpu variable anyway.

So I am not sure why we need both locks held while doing
vpa_dtl_mem_alloc(). What exactly are they protecting?  Can we move the
allocation out of the lock and just assign dtl->buf later within the
lock?  In one other place I see dtl->buf = NULL without any lock.  Also,
do we need a spinlock to protect dtl_global_refc? Would an atomic
variable not work here?

The above fix is not wrong per se, based on today's code, but it would
be better if someone who owns this code takes another look and fixes its
design while we are at it.

Another motivation for doing this work now is to bring in clang's
context analysis for arch/powerpc/perf/, which can statically check
that such locking rules are followed, provided there are proper
annotations for every lock and the data it protects.

-ritesh


