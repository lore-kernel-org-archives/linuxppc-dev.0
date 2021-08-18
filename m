Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C6C4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 03:33:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BF060FD7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 03:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99BF060FD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqD5C1v8dz30Hh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:33:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=f5QVtgRN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=f5QVtgRN; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqD4N5fPyz303t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 13:32:50 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id q2so823473pgt.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 20:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=JVWM1e48keuxJEZyPP2QSd2itI/kmHuk3JHjusMRB3Y=;
 b=f5QVtgRN/qQ8FRYVFoZwMFtXsA3QJioXXHGLyaapm7AYSJeP/YIXdzI3BHSxU/y/gY
 ASRo/SBMqVA2BNWF95fRBWuyREnofh6y/OLunUB6gsUXUSCxJAXtnxHFqyQ0dd/mVO7L
 I886hJpCoAm9B7UaWYBoyG+H6ISSNuZCchDIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=JVWM1e48keuxJEZyPP2QSd2itI/kmHuk3JHjusMRB3Y=;
 b=XJ8eOGh2/2uXFEdKrn1ZwJ643ekWE9QcfBNUcM0ZQ170+ksqbh6P1uM1zY2fFTNM3J
 ccDM+NPC2bxr+eQJJyFUSDrEM+u1Svy47HHaeihHXDhhfEJTK9gSKzxftbsTus8U+PKo
 AE4DUry03hLgz/uXsXhmUYmDyAqjJmHglb1PHFqGYjevV6zVMCNgUd+6yjDn4FPh1O2N
 LIjqtGcTlLh/C7Lpzc9ydQb5CCmcvtgIN5fYLh0mZpT1f0yBWW9Ep2mqmx57wGRMR0pX
 5kVWelGjnQyeQbEq/kl6IfRpVGMLdKnVx8vrEep7m2VgFEDOcj6cUvoKVJkT/HOL4eKr
 aLYA==
X-Gm-Message-State: AOAM531bxs+lCoB1ebDITVICOLTz3rvIlUf5oxfZtJS4ywt3wB36J6ik
 hGuMovSTPWnY3PDPE92+0t8/bg==
X-Google-Smtp-Source: ABdhPJwWhyoAOgoayOIjXjOosORW76E6dR6lxM5gqxM+kdBP2Aigtgkr96w1mxbR3nPsawKqh7JNYg==
X-Received: by 2002:aa7:8bdd:0:b0:3e2:13fc:dd2f with SMTP id
 s29-20020aa78bdd000000b003e213fcdd2fmr7077243pfd.53.1629257567442; 
 Tue, 17 Aug 2021 20:32:47 -0700 (PDT)
Received: from localhost ([2001:4479:e000:e400:bb2:9104:6a48:5aa6])
 by smtp.gmail.com with ESMTPSA id r16sm3499715pje.10.2021.08.17.20.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Aug 2021 20:32:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Jan Stancek <jstancek@redhat.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, christophe.leroy@csgroup.eu,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH/RFC] powerpc/module_64: allow .init_array constructors
 to run
In-Reply-To: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
References: <920acea9aa18e4f2956581a8e158bdaa376fdf63.1629203945.git.jstancek@redhat.com>
Date: Wed, 18 Aug 2021 13:32:43 +1000
Message-ID: <877dgjbf6s.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jan Stancek <jstancek@redhat.com> writes:

> gcov and kasan rely on compiler generated constructor code.
> For modules, gcc-8 with gcov enabled generates .init_array section,
> but on ppc64le it doesn't get executed. find_module_sections() never
> finds .init_array section, because module_frob_arch_sections() renames
> it to _init_array.
>
> Avoid renaming .init_array section, so do_mod_ctors() can use it.

This (the existing renaming) breaks a KASAN test too, so I'd love to see
this fixed.

However, I don't know that renaming the section is a complete fix: from
memory it is still be possible to get relocations that are too far away
and require separate trampolines. But I wasn't able to construct a
module that exhibited this behaviour and test a fix before I got pulled
away to other things.

Kind regards,
Daniel

>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> I wasn't able to trace the comment:
>   "We don't handle .init for the moment: rename to _init"
> to original patch (it pre-dates .git). I'm not sure if it
> still applies today, so I limited patch to .init_array. This
> fixes gcov for modules for me on ppc64le 5.14.0-rc6.
>
> Renaming issue is also mentioned in kasan patches here:
>   https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20210319144058.772525-1-dja@axtens
>
>  arch/powerpc/kernel/module_64.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 6baa676e7cb6..c604b13ea6bf 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -299,8 +299,16 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
>  					  sechdrs[i].sh_size);
>  
>  		/* We don't handle .init for the moment: rename to _init */
> -		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
> +		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init"))) {
> +#ifdef CONFIG_CONSTRUCTORS
> +			/* find_module_sections() needs .init_array intact */
> +			if (strstr(secstrings + sechdrs[i].sh_name,
> +				".init_array")) {
> +				break;
> +			}
> +#endif
>  			p[0] = '_';
> +		}
>  
>  		if (sechdrs[i].sh_type == SHT_SYMTAB)
>  			dedotify((void *)hdr + sechdrs[i].sh_offset,
> -- 
> 2.27.0
