Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF5CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 08:25:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E2F20774
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 08:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlhfMQnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E2F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRN745qswzDqHr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 18:25:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=nlhfMQnM; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRMzL0nSpzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 18:18:37 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so734642pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=79f2Q6E1np8SG+am2XzUSjzcDBDgFqCYmgnZYDZDf0A=;
 b=nlhfMQnM79bkE++hU9UHzfAUO66rEjOEAxexFuScCLj0xVeTisj/51Sld5gT92RraL
 AIS1BNxrJdTMd/O/cmh0/IGywD8U+UHWRAWdJw4sn6pFNJ1aM+ZEFJykhekp8fyRlekv
 LNTPHdU9+KOMOqB4Be8S/E5WxkWJoog5eZn7ITX+DJUEKrw0BTVVaIMiHMlJ7VXRMMwo
 kiCYV0pib4I4ri3GTSoo9n57yoWVf8Vp7rHBmryszp5U/Rr18mZaWiOGWRmwA4iTrrCr
 KNrv3q9Zt3T+MKIrxclD6UrzJkuhy0i1V0g7GfQb/NXC/roh2pwnOrLc4NQSycPfN/Pr
 mMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=79f2Q6E1np8SG+am2XzUSjzcDBDgFqCYmgnZYDZDf0A=;
 b=hqJJlHpe7s9UQtRm+0ggmscyzHFaBPEWvcLWP3Hs+19TjCUQB8y8vbGru9q65F52ez
 cxagdDD6AJvd01/VyPsBMsld2CKQnl/8YK0s/EydCyv3A9ozLXMXN92vBrjQNH+Trjcn
 ts3yEfe1C3xtX3Q74+OQ2nhA2gJNKoq7DX/2B9cTs2173x1HsctkBSyiid//yvKEtJM7
 RXgGXtaLYaeGx0oteAyrkGOogJyFNauYpAdMWfDxZ6aMGRCrTNpxGUAYGCOLKv9q7NUh
 fJNduH2bq4gw1U9Btql3NtBFshCPMTKeDlTXDZJbSsh92ifmjPZoGkaGfoO3mdtENCrj
 pUfw==
X-Gm-Message-State: AOAM532QJKhW3M5W35duJlFIYR6fIfj3S0MS/HruQ1ecjJllPGUT+mQK
 d75wIP4+tKKg8kXcoxDjW28=
X-Google-Smtp-Source: ABdhPJxeeFrT8J1cTifNM8kGu2J2wqCIyrp58B7SlaMaeh8+s3Jr8gHNTZT1n1PHaZ/FvCH/wjcD2w==
X-Received: by 2002:a17:90b:f09:: with SMTP id
 br9mr5035461pjb.11.1597220314648; 
 Wed, 12 Aug 2020 01:18:34 -0700 (PDT)
Received: from localhost (193-116-193-175.tpgi.com.au. [193.116.193.175])
 by smtp.gmail.com with ESMTPSA id n15sm1501361pgs.25.2020.08.12.01.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 01:18:34 -0700 (PDT)
Date: Wed, 12 Aug 2020 18:18:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To: peterz@infradead.org
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200807111126.GI2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200807111126.GI2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1597220073.mbvcty6ghk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-arch@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from peterz@infradead.org's message of August 7, 2020 9:11 pm:
>=20
> What's wrong with something like this?
>=20
> AFAICT there's no reason to actually try and add IRQ tracing here, it's
> just a hand full of instructions at the most.

Because we may want to use that in other places as well, so it would
be nice to have tracing.

Hmm... also, I thought NMI context was free to call local_irq_save/restore
anyway so the bug would still be there in those cases?

Thanks,
Nick

>=20
> ---
>=20
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index 3a0db7b0b46e..6be22c1838e2 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -196,33 +196,6 @@ static inline bool arch_irqs_disabled(void)
>  		arch_local_irq_restore(flags);				\
>  	} while(0)
> =20
> -#ifdef CONFIG_TRACE_IRQFLAGS
> -#define powerpc_local_irq_pmu_save(flags)			\
> -	 do {							\
> -		raw_local_irq_pmu_save(flags);			\
> -		trace_hardirqs_off();				\
> -	} while(0)
> -#define powerpc_local_irq_pmu_restore(flags)			\
> -	do {							\
> -		if (raw_irqs_disabled_flags(flags)) {		\
> -			raw_local_irq_pmu_restore(flags);	\
> -			trace_hardirqs_off();			\
> -		} else {					\
> -			trace_hardirqs_on();			\
> -			raw_local_irq_pmu_restore(flags);	\
> -		}						\
> -	} while(0)
> -#else
> -#define powerpc_local_irq_pmu_save(flags)			\
> -	do {							\
> -		raw_local_irq_pmu_save(flags);			\
> -	} while(0)
> -#define powerpc_local_irq_pmu_restore(flags)			\
> -	do {							\
> -		raw_local_irq_pmu_restore(flags);		\
> -	} while (0)
> -#endif  /* CONFIG_TRACE_IRQFLAGS */
> -
>  #endif /* CONFIG_PPC_BOOK3S */
> =20
>  #ifdef CONFIG_PPC_BOOK3E
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/=
local.h
> index bc4bd19b7fc2..b357a35672b1 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -32,9 +32,9 @@ static __inline__ void local_##op(long i, local_t *l)		=
	\
>  {									\
>  	unsigned long flags;						\
>  									\
> -	powerpc_local_irq_pmu_save(flags);				\
> +	raw_powerpc_local_irq_pmu_save(flags);				\
>  	l->v c_op i;						\
> -	powerpc_local_irq_pmu_restore(flags);				\
> +	raw_powerpc_local_irq_pmu_restore(flags);				\
>  }
> =20
>  #define LOCAL_OP_RETURN(op, c_op)					\
> @@ -43,9 +43,9 @@ static __inline__ long local_##op##_return(long a, loca=
l_t *l)		\
>  	long t;								\
>  	unsigned long flags;						\
>  									\
> -	powerpc_local_irq_pmu_save(flags);				\
> +	raw_powerpc_local_irq_pmu_save(flags);				\
>  	t =3D (l->v c_op a);						\
> -	powerpc_local_irq_pmu_restore(flags);				\
> +	raw_powerpc_local_irq_pmu_restore(flags);				\
>  									\
>  	return t;							\
>  }
> @@ -81,11 +81,11 @@ static __inline__ long local_cmpxchg(local_t *l, long=
 o, long n)
>  	long t;
>  	unsigned long flags;
> =20
> -	powerpc_local_irq_pmu_save(flags);
> +	raw_powerpc_local_irq_pmu_save(flags);
>  	t =3D l->v;
>  	if (t =3D=3D o)
>  		l->v =3D n;
> -	powerpc_local_irq_pmu_restore(flags);
> +	raw_powerpc_local_irq_pmu_restore(flags);
> =20
>  	return t;
>  }
> @@ -95,10 +95,10 @@ static __inline__ long local_xchg(local_t *l, long n)
>  	long t;
>  	unsigned long flags;
> =20
> -	powerpc_local_irq_pmu_save(flags);
> +	raw_powerpc_local_irq_pmu_save(flags);
>  	t =3D l->v;
>  	l->v =3D n;
> -	powerpc_local_irq_pmu_restore(flags);
> +	raw_powerpc_local_irq_pmu_restore(flags);
> =20
>  	return t;
>  }
> @@ -117,12 +117,12 @@ static __inline__ int local_add_unless(local_t *l, =
long a, long u)
>  	unsigned long flags;
>  	int ret =3D 0;
> =20
> -	powerpc_local_irq_pmu_save(flags);
> +	raw_powerpc_local_irq_pmu_save(flags);
>  	if (l->v !=3D u) {
>  		l->v +=3D a;
>  		ret =3D 1;
>  	}
> -	powerpc_local_irq_pmu_restore(flags);
> +	raw_powerpc_local_irq_pmu_restore(flags);
> =20
>  	return ret;
>  }
>=20
