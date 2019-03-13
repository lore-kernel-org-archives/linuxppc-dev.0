Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF486C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 23:56:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0595F21019
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 23:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="q4tx4eEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0595F21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KTJk2h96zDqMk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 10:56:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="q4tx4eEs"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KTGc2G3MzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 10:54:47 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id e17so2664770pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 16:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4r1t1dMqNtFks28Rn2JjRV6yw+6RsCTbtKIKKd7oQmA=;
 b=q4tx4eEsEbYudnlQn7kAa8a/5AEE/S3NHEv3hQ0QWs0lqGoycQ1lImoPF4WG8bskUM
 pDAjHTnDcv/Xc8GPNvHCU2V1zNhuroC6V39bEPgM0EWPMPsG3Vlj/Ha9VKqy6J7dQCkO
 /xLGd7dVxzBER1NQ73UK+aBfy7qNwnjJ+xvAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=4r1t1dMqNtFks28Rn2JjRV6yw+6RsCTbtKIKKd7oQmA=;
 b=nrfsMoxF8yz3EMiXAMoDsHqwoUxY7DJo9Ms0qmvtAAEyxEjjVrUazOvDR6jYYQXeum
 ouI3OF00rifXKy4MDQiLtBPbm8uXrqVpJJB0tZSRGK/2e+5zwhIRfv2qve+xt60BtQMr
 FimAyE19D5FNE8PJgAdv+87q6EioDr6ZweRwb811xsRd1joggAKihTHlPtzUi+FucWhQ
 dSwYAdJTQ8d7glh4PhgDnvPUu+DlzdME+BCmYQTCstpMsYGx2mBGRZkkZikCteBEc8gK
 Skub4EaNSt98VqZI8MoEVda8T9+c4DP1y+hjUPwCMo2Lf09ZmfhMib/oQ2CIj/lFFD4o
 CAjw==
X-Gm-Message-State: APjAAAW7UYs74NtcG1IzmpVQOOYW/8Ewf0rKmnLwPR1levVH9mjAz4jB
 5hfRWAYbbucmwRXs4A6SQ/2YgA==
X-Google-Smtp-Source: APXvYqxYcxkGiP+q+kR2RNQ4sqFTC6V+SP1sQIio44bFpazQ8jfIUI+3D/TjuMQs2LtEgSIjEaPTVw==
X-Received: by 2002:a63:1602:: with SMTP id w2mr13338023pgl.406.1552521283908; 
 Wed, 13 Mar 2019 16:54:43 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
 by smtp.gmail.com with ESMTPSA id l184sm19982642pfc.41.2019.03.13.16.54.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Mar 2019 16:54:42 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH 1/1] arch/powerpc: Rework local_paca to avoid LTO warnings
In-Reply-To: <20190313034208.13134-1-alastair@au1.ibm.com>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
Date: Thu, 14 Mar 2019 10:54:39 +1100
Message-ID: <87ef7atjnk.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
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
Cc: Michal Hocko <mhocko@suse.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> From: Alastair D'Silva <alastair@d-silva.org>
>
> When building an LTO kernel, the existing code generates warnings:
>     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>         =E2=80=98local_paca=E2=80=99 used for multiple global register va=
riables
>      register struct paca_struct *local_paca asm("r13");
>                               ^
>     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>         =E2=80=98local_paca=E2=80=99
>
> This patch reworks local_paca into an inline getter & setter function,
> which addresses the warning.
>
> Generated ASM from this patch is broadly similar (addresses have
> changed and the compiler uses different GPRs in some places).

Ditto to Christophe's comment; I'd love to know how to build this so I
can actually see the differences. Perhaps you could bundle up all the
required changes and send it as a patch series with a cover letter
explaining this?

> +static inline struct paca_struct *get_paca_no_preempt_check(void)
> +{
> +	register struct paca_struct *paca asm("r13");
> +	return paca;
> +}

Isn't the convention to have the { on the same line as the function, or
am I horrible mis-remembering things?

Should these functions be __always_inline?

Regards,
Daniel

> +
> +static inline struct paca_struct *get_paca(void)
> +{
> +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> +	/*
> +	 * Add standard checks that preemption cannot occur when using get_paca=
():
> +	 * otherwise the paca_struct it points to may be the wrong one just aft=
er.
> +	 */
> +	debug_smp_processor_id();
> +#endif
> +	return get_paca_no_preempt_check();
> +}
> +
> +#define local_paca	get_paca_no_preempt_check()
> +
> +static inline void set_paca(struct paca_struct *new)
> +{
> +	register struct paca_struct *paca asm("r13");
> +	paca =3D new;
> +}
> +
> +
>  extern void copy_mm_to_paca(struct mm_struct *mm);
>  extern struct paca_struct **paca_ptrs;
>  extern void initialise_paca(struct paca_struct *new_paca, int cpu);
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 913bfca09c4f..ae5c243f9d5a 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct *new_p=
aca, int cpu)
>  void setup_paca(struct paca_struct *new_paca)
>  {
>  	/* Setup r13 */
> -	local_paca =3D new_paca;
> +	set_paca(new_paca);
>=20=20
>  #ifdef CONFIG_PPC_BOOK3E
>  	/* On Book3E, initialize the TLB miss exception frames */
> --=20
> 2.20.1
