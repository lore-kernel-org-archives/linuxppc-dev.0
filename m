Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC4C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:46:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9089D20684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsf2p/Bl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9089D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q64C3nVXzF3JB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:46:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsf2p/Bl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nsf2p/Bl"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5ZQ1mh5zF3Hs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:23:58 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id s4-v6so2932523plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rAOevDPZe7dnbkiFavmd+0KLnTNthcuJvJUp0SfuH2Y=;
 b=nsf2p/BlhFFzRdFqVcLMk0Bl7JIUkBM/EYlFaviVuV3X8OYH0Ej9KxRtec8rHU2b31
 /a5/uyJaR9KM/Xi7e2Qy0w4CzUDkORWLtaR/go1D9CZ+7ew0Nn6x7J7cTfFDMtbnIP8q
 SO4kJEiaGcqxi08ldPUAOmf5cCc/7K/GMhT5gjO8uwdlgpe7KXJPQufZ7P8h/ORd1SKA
 WOO1/hyWWvy6FU2HKR8YE9lZtkBi3dS17I9+7DBF7sMUb1Lbau1YEkvyrZhBYdqyTpK0
 cWJXwuw8oUC6rFS5Epfcaprer3sfHa7HuyF8A5wViQonGmQ+G65GY5m0viUxu8KieE1A
 5X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rAOevDPZe7dnbkiFavmd+0KLnTNthcuJvJUp0SfuH2Y=;
 b=e7c87FdVWMLCxKocp4f1D5slQ0ox8H9LZpJKVe3YElonsZix7+a2qef1FLhV+Hiueh
 r4S7ZfDDiRYDdG7trK1+X61D5sPywzWf4BL1oGUmvX1IEQTN2FA34CIjI8Hqs5Hy4xMP
 8IPFTJK8mNXFRxYM9unFs9iiI2Z7e9mgo6N6iGka03J2mUtVQUz0D/TuzlrdntLTo39M
 w6IB+d26DB5ajiigT5gIAcHnbaldymA2q6sBr2XCaYnLR6Ey3qXI0Xosf2qughyx60Px
 Wi/jVKr3pW1m0h9+FI+08x5UD3EoZe34RtLqiNG3PKMo1LoEddMsDImcVQam1L5neyFN
 +8zg==
X-Gm-Message-State: ABuFfoiN8bNYhyd1z1+3X7Vq7ylF8YZljBjL6qGx0kkNAMjOAU5TMT1a
 0ffq0gfDzvm8Cb54sxqtQaM=
X-Google-Smtp-Source: ACcGV62WSMnq0atjDjUL5X/xXhhgCVLBqc+hIfyFi32tOWAeMQ5hWVtsZgSav+35Uttqb3/PMkzUFA==
X-Received: by 2002:a17:902:b784:: with SMTP id
 e4-v6mr11272pls.284.1538547836422; 
 Tue, 02 Oct 2018 23:23:56 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id 64-v6sm1360736pfq.10.2018.10.02.23.23.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 23:23:55 -0700 (PDT)
Date: Wed, 3 Oct 2018 16:23:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 3/7] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181003162350.408f7f84@roar.ozlabs.ibm.com>
In-Reply-To: <210d5ce2-1f62-2458-617b-fe604b95919e@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
 <20181003153025.35b2dd5e@roar.ozlabs.ibm.com>
 <c1b9f2db-ebca-4a2d-4f91-2dce84da31f2@c-s.fr>
 <20181003155243.70806497@roar.ozlabs.ibm.com>
 <210d5ce2-1f62-2458-617b-fe604b95919e@c-s.fr>
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

On Wed, 3 Oct 2018 08:04:49 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:52, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Wed, 3 Oct 2018 07:47:05 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Le 03/10/2018 =C3=A0 07:30, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>> On Mon,  1 Oct 2018 12:30:23 +0000 (UTC)
> >>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>>     =20
> >>>> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> >>>> moves the thread_info into task_struct.
> >>>>
> >>>> Moving thread_info into task_struct has the following advantages:
> >>>> - It protects thread_info from corruption in the case of stack
> >>>> overflows.
> >>>> - Its address is harder to determine if stack addresses are
> >>>> leaked, making a number of attacks more difficult.
> >>>>
> >>>> This has the following consequences:
> >>>> - thread_info is now located at the top of task_struct. =20
> >>>
> >>> "top"... I got confused for a minute thinking high address and
> >>> wondering how you can change CURRENT_THREAD_INFO just to point
> >>> to current :) =20
> >>
> >> Would 'beginning' be less confusing ? =20
> >=20
> > Yes, good idea.
> >  =20
> >>>> @@ -83,7 +83,13 @@ int is_cpu_dead(unsigned int cpu);
> >>>>    /* 32-bit */
> >>>>    extern int smp_hw_index[];
> >>>>   =20
> >>>> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
> >>>> +/*
> >>>> + * This is particularly ugly: it appears we can't actually get the =
definition
> >>>> + * of task_struct here, but we need access to the CPU this task is =
running on.
> >>>> + * Instead of using task_struct we're using _TASK_CPU which is extr=
acted from
> >>>> + * asm-offsets.h by kbuild to get the current processor ID.
> >>>> + */
> >>>> +#define raw_smp_processor_id()		(*(unsigned int*)((void*)current + =
_TASK_CPU)) =20
> >>>
> >>> This is clever but yes ugly. Can't you include asm-offsets.h? riscv
> >>> seems to. =20
> >>
> >> riscv has a clean asm-offsets.h . Our's defines constant with the same
> >> name as those defined in other headers which are included in C files. =
So
> >> including asm-offsets in C files does create conflicts like:
> >>
> >> ./include/generated/asm-offsets.h:71:0: warning: "TASK_SIZE" redefined
> >>    #define TASK_SIZE -2147483648 /* TASK_SIZE */
> >> ./arch/powerpc/include/asm/processor.h:95:0: note: this is the location
> >> of the previous definition
> >>    #define TASK_SIZE (CONFIG_TASK_SIZE)
> >>
> >> ./include/generated/asm-offsets.h:98:0: warning: "NSEC_PER_SEC" redefi=
ned
> >>    #define NSEC_PER_SEC 1000000000 /* NSEC_PER_SEC */
> >> ./include/linux/time64.h:36:0: note: this is the location of the
> >> previous definition
> >>    #define NSEC_PER_SEC 1000000000L
> >>
> >> ./arch/powerpc/include/asm/nohash/32/pgtable.h:34:0: warning:
> >> "PGD_TABLE_SIZE" redefined
> >>    #define PGD_TABLE_SIZE (sizeof(pgd_t) << PGD_INDEX_SIZE)
> >> ./include/generated/asm-offsets.h:101:0: note: this is the location of
> >> the previous definition
> >>    #define PGD_TABLE_SIZE 256 /* PGD_TABLE_SIZE */
> >>
> >> ... =20
> >=20
> > Okay.
> >  =20
> >>
> >> In v2, I had a patch to fix those redundancies
> >> (https://patchwork.ozlabs.org/patch/974363/) but I found it unconvenie=
nt. =20
> >=20
> > Because of merge conflicts, or you did not like the new names? =20
>=20
> Both, because of the amount of changes it implies, and also because of=20
> the new names. I find it quite convenient to be able to use same names=20
> both in C and ASM.

Yeah that's true. I guess this is okay for a one-off hack.

Thanks,
Nick
