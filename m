Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2DCC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:56:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1683F20835
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQEC6duc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1683F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4yg1B1GzDqNF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:56:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQEC6duc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="fQEC6duc"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q4tW25mJzF3Dy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:52:51 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id 30-v6so2888033plb.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8SQvWieqe/Eb6yw/WYj1GWGB7oORzXy2L84m4cX0Ejw=;
 b=fQEC6ducxFixdTINpUkC7qCYU4/LJQScxyxoeHW3Kyjs6CM0yxdk9DPS3jiFoxaTM8
 kEnYVS4ba7iHqIEp8aJH5RTLAJBN4mRDZN7fY5bBcZFR9y3/HqKgg2PrGrx5wd8uGfhB
 juGglZIDge7qzMoOINT58yAwjmOY9fMH3pK6cr/0ecqHDACGIW+vou+tr5CDDPkpKs6l
 KWwxq00BKgdbHm1eLhyMoSixxPdMZvd57WkFtqxdiywG+SXV2nNRJEnmZ/xn5gMbpzQx
 6++Ef5GEPFzASdVJ/V7drqxx1gmepSya5lMqgu9UtmLjcyRSwP+BzUhZA75WC2uCm/Ux
 b4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8SQvWieqe/Eb6yw/WYj1GWGB7oORzXy2L84m4cX0Ejw=;
 b=lUDNhJhSvi1GsBdbY7jStdc7cYukLjzygOFXrL/6kPN4XQ5d1CkM0wVSHGZ27zvQQP
 oXx0PWGkoziFH+MffRo0zuCk8koCsX/eCs1SNniKQoaCTnXMLNitqYWbtphTIkGUS5fn
 jvKhnLaP3+nkpQ5q5v4vuS7US4x3uDxGMSle6hlYUKGdnqpoG3p/4HPJwWvAX48RnSk0
 dnB5X+lG7+z6FzQmFMqFNM78tuJyJRbHO+QDDXJ2kvoogYJs/eZVjdIPrSlbd78k2N/S
 WFBI916pm+N55B+nZGC7y13ri5UNzFXYjzit4AbWELIC0RRq8+BeThwisqqgZ1+nmVGf
 4iqA==
X-Gm-Message-State: ABuFfogrAyVwwEoaVH/s76TOpVEgTnPYZx4BbXca39+MHd9R9FANW65U
 h7ZP8sJ8KMaqxe5B1PhzodI=
X-Google-Smtp-Source: ACcGV60Rh9LSr/fS1ZQ7e5A2gmGGQFErtSjK6ZfOzCxOUkMMU3VJyt+kA/MN6E9YQKcs3jYgsj+GVA==
X-Received: by 2002:a17:902:2e83:: with SMTP id
 r3-v6mr20175150plb.80.1538545969279; 
 Tue, 02 Oct 2018 22:52:49 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id t22-v6sm652470pfk.141.2018.10.02.22.52.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 22:52:48 -0700 (PDT)
Date: Wed, 3 Oct 2018 15:52:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 3/7] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181003155243.70806497@roar.ozlabs.ibm.com>
In-Reply-To: <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
 <20181003153025.35b2dd5e@roar.ozlabs.ibm.com>
 <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Oct 2018 07:47:05 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:30, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon,  1 Oct 2018 12:30:23 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> >> moves the thread_info into task_struct.
> >>
> >> Moving thread_info into task_struct has the following advantages:
> >> - It protects thread_info from corruption in the case of stack
> >> overflows.
> >> - Its address is harder to determine if stack addresses are
> >> leaked, making a number of attacks more difficult.
> >>
> >> This has the following consequences:
> >> - thread_info is now located at the top of task_struct. =20
> >=20
> > "top"... I got confused for a minute thinking high address and
> > wondering how you can change CURRENT_THREAD_INFO just to point
> > to current :) =20
>=20
> Would 'beginning' be less confusing ?

Yes, good idea.

> >> @@ -83,7 +83,13 @@ int is_cpu_dead(unsigned int cpu);
> >>   /* 32-bit */
> >>   extern int smp_hw_index[];
> >>  =20
> >> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
> >> +/*
> >> + * This is particularly ugly: it appears we can't actually get the de=
finition
> >> + * of task_struct here, but we need access to the CPU this task is ru=
nning on.
> >> + * Instead of using task_struct we're using _TASK_CPU which is extrac=
ted from
> >> + * asm-offsets.h by kbuild to get the current processor ID.
> >> + */
> >> +#define raw_smp_processor_id()		(*(unsigned int*)((void*)current + _T=
ASK_CPU)) =20
> >=20
> > This is clever but yes ugly. Can't you include asm-offsets.h? riscv
> > seems to. =20
>=20
> riscv has a clean asm-offsets.h . Our's defines constant with the same=20
> name as those defined in other headers which are included in C files. So=
=20
> including asm-offsets in C files does create conflicts like:
>=20
> ./include/generated/asm-offsets.h:71:0: warning: "TASK_SIZE" redefined
>   #define TASK_SIZE -2147483648 /* TASK_SIZE */
> ./arch/powerpc/include/asm/processor.h:95:0: note: this is the location=20
> of the previous definition
>   #define TASK_SIZE (CONFIG_TASK_SIZE)
>=20
> ./include/generated/asm-offsets.h:98:0: warning: "NSEC_PER_SEC" redefined
>   #define NSEC_PER_SEC 1000000000 /* NSEC_PER_SEC */
> ./include/linux/time64.h:36:0: note: this is the location of the=20
> previous definition
>   #define NSEC_PER_SEC 1000000000L
>=20
> ./arch/powerpc/include/asm/nohash/32/pgtable.h:34:0: warning:=20
> "PGD_TABLE_SIZE" redefined
>   #define PGD_TABLE_SIZE (sizeof(pgd_t) << PGD_INDEX_SIZE)
> ./include/generated/asm-offsets.h:101:0: note: this is the location of=20
> the previous definition
>   #define PGD_TABLE_SIZE 256 /* PGD_TABLE_SIZE */
>=20
> ...

Okay.

>=20
> In v2, I had a patch to fix those redundancies=20
> (https://patchwork.ozlabs.org/patch/974363/) but I found it unconvenient.

Because of merge conflicts, or you did not like the new names?

Thanks,
Nick
