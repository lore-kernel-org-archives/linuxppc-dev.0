Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEFC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 06:00:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678DC20811
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 06:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko9TC5vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678DC20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T0q33924zDqHX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 17:00:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ko9TC5vv"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T0nD0jL3zDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 16:58:53 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id m10so1115484plt.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 22:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=CbYmRGUZEd1iQvum1IXYqF42ybOYTBKz3+p6mg+oYlo=;
 b=Ko9TC5vvEKuLwoXWFWzSAreUCqwrexYQMDa9zIoj6ql1FmP/l//6Ugs9azCRPyRu6J
 3rB852ZUpel8SIRAf1eA0VXvpeRr6gGfASPseK4uV3ZnuBZcy1lEUTLBEsSL7Db9ANKd
 8o8kh2cMlQR9PXoKKK3OkAnDekzGyhdfTLjBPSQi4IrHKdu48rwSnrWUESCOgx7OmYLe
 NuJ8h6kSYMSPTd/YeqYCrrD9iqEV3RYTRXzclPfWx8vYe19Z6xcDINB/jVaeOe8lzh2j
 eXmjJGFYw0Du/D5AhoU+ln+15kZ6rEM59plczL2dYyrQq/tDxtpP5uY7calONo898Fl/
 5htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=CbYmRGUZEd1iQvum1IXYqF42ybOYTBKz3+p6mg+oYlo=;
 b=qobcR0lLUxDXRfqd1vqmCAepVZL0tTD6B/v8BCOO1shaAAt3SYy9VcaSCjl1tyTfTt
 Od2z1MXEqSRIpM5+4e7Q0VYR8KSC07KlP2nZ7MUjNhP8C83RkRs/sKC50Al5Q5b9ioOI
 pNb+VZRHve55up56nlNi/qzTTYkRkI8B0BNQwHEQitZ7iYnTpSFjPkDfUsR76MgkViHP
 LBWZwTMxMSPzwyUiRp6oKEgo9OpbYszHQBHh6YP3ggFHeE8qdX20lbrKvLoMEg53H3mL
 tVMW/huNmMKPt895scF+uXMVNhLVoBUwjWDCQiPzA5bV59aW18a+T0vphGXLyupLEJ+k
 KTew==
X-Gm-Message-State: APjAAAVHKU2Zdj3jz9IU6wG1DIQUBoBHXIUha7Q0oin3TNx1ldwppAY1
 epvD0iVPywhCukNb1un2v+g=
X-Google-Smtp-Source: APXvYqwYpL9AXMOqLKcqIJyllvGM0xwvhgBITtdXdHbwwCZFAwPbb753YOq1ogdG3ANmWqO5UHFx5Q==
X-Received: by 2002:a17:902:1008:: with SMTP id
 b8mr28480020pla.120.1553579930670; 
 Mon, 25 Mar 2019 22:58:50 -0700 (PDT)
Received: from localhost ([193.114.107.176])
 by smtp.gmail.com with ESMTPSA id 25sm22419793pfo.96.2019.03.25.22.58.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Mar 2019 22:58:49 -0700 (PDT)
Date: Tue, 26 Mar 2019 15:58:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] arch/powerpc: Rework local_paca to avoid LTO warnings
To: Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20190313034208.13134-1-alastair@au1.ibm.com>
 <20190314023125.10076-1-alastair@au1.ibm.com>
In-Reply-To: <20190314023125.10076-1-alastair@au1.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553579424.0r39b9otz6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alastair D'Silva's on March 14, 2019 12:31 pm:
> From: Alastair D'Silva <alastair@d-silva.org>
>=20
> When building an LTO kernel, the existing code generates warnings:
>     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>         =E2=80=98local_paca=E2=80=99 used for multiple global register va=
riables
>      register struct paca_struct *local_paca asm("r13");
>                                   ^
>     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>         =E2=80=98local_paca=E2=80=99

Isn't this a bogus warning? It doesn't look like there's a way to=20
define it any other way.

>=20
> This patch reworks local_paca into an inline getter & setter function,
> which addresses the warning.
>=20
> Changelog:
> V2
>   - Address whitespace issues
>   - keep new implementation close to where the old implementation was
>=20
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/include/asm/paca.h | 37 +++++++++++++++++++++++++--------
>  arch/powerpc/kernel/paca.c      |  2 +-
>  2 files changed, 29 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.h
> index e843bc5d1a0f..2fa0b43357c9 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -34,19 +34,38 @@
>  #include <asm/cpuidle.h>
>  #include <asm/atomic.h>
> =20
> -register struct paca_struct *local_paca asm("r13");
> -
>  #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
>  extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
> -/*
> - * Add standard checks that preemption cannot occur when using get_paca(=
):
> - * otherwise the paca_struct it points to may be the wrong one just afte=
r.
> - */
> -#define get_paca()	((void) debug_smp_processor_id(), local_paca)
> -#else
> -#define get_paca()	local_paca
>  #endif
> =20
> +static inline struct paca_struct *get_paca_no_preempt_check(void)
> +{
> +	register struct paca_struct *paca asm("r13");
> +
> +	return paca;
> +}

Problem is it now changes the global register variable to a local=20
register variable. The compiler would presumably be within its rights
to "cache" that return value or use another register for it, which
is not really what we want.

Thanks,
Nick

=
