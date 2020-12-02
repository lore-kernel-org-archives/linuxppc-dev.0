Return-Path: <SRS0=PqhP=FG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21E0C64E7C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 15:14:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F7820656
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F7820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmMv52Qg2zDqcv
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 02:14:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=andreyknvl@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=KQx3tJgz; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmMrP0RXFzDr0D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2020 02:11:41 +1100 (AEDT)
Received: by mail-pj1-x1041.google.com with SMTP id hk16so1133047pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Dec 2020 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2HsmIMcZJpe7tYpMj4NnnC0QPe3wNYiaDnh9WVgHhJ4=;
 b=KQx3tJgz/INomXf3rio23NSDcD9wW4IAJav9Y9BJw53GdaN2o6fOGhlX8MBRbVEX/z
 GJnxX1SOpLw3TBSSXOyjEAGBMPEOzouTPbcvhMI11uEaxagjIn9JnLaNnxPM0y7ywI7W
 QyRN7MldGkgFmPigqQvsujyTvwSL/ZHKPFZbcRmkSH4l6Ffh9hFQWjY9Cuji5JSur0+X
 ghBUvBOcEkEyT+gIijLWQAdyC2cpWZ+DqUClF+JBkuzKgpn/U/kFgHckDgYHw8Gy8AAZ
 rY0WN/jM5PDSXnBHyekvdPvFYlBbw30fsPk/7X9X7VH+CC2mwj44NQzN7se3/lnMuMyV
 SatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2HsmIMcZJpe7tYpMj4NnnC0QPe3wNYiaDnh9WVgHhJ4=;
 b=VXuBueaH76KVfcvy8SGZesuLwoFok9UGgpGHryK1fMjxoA/5lX4VssdtutvMqqnPdh
 yDbRN1u0EjJrb3qxjvlg5T8n00D2PIkH1HokTWUTR7dRi/1kbdDH+7aWLzqDVZxStmhi
 VzHfAfEYNmNTNyBFgi22COXkGe7NpQemImJOveuS+t0iacpRKPiT6lwcr8mprECfQiCj
 FzyhPynQVNzSb8Od7o/IyGtbveIMloAvJ4HT0jTB7pstaMUlcVP14fREww4anYRR+nAF
 DZ/VlBxr4kV6HYBFgcTnroLQ+xsbbPAP6LIAlCsiNDLgP3OdZpk4Yp2QKHm7C7xN4Rhz
 IgJA==
X-Gm-Message-State: AOAM531L6Mp8vTpkfXlJmaNMMKwb4GnwGtlD2tFe4AhFHZCxv2slSVIO
 fQioX3YXxawjMkE1E8vHMhS/kKrWlwdXpCV9mf7geQ==
X-Google-Smtp-Source: ABdhPJzfWUqM7uNDjSRCST7XbyM6pfI51u3tJv0DhofJxxJmpsNwCOQzSTp65YnSwldtwCV6tKI7oV/ks90wuIfKTgE=
X-Received: by 2002:a17:90a:6bc1:: with SMTP id
 w59mr319106pjj.136.1606921896689; 
 Wed, 02 Dec 2020 07:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20201201161632.1234753-1-dja@axtens.net>
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 2 Dec 2020 16:11:25 +0100
Message-ID: <CAAeHK+znbFs6PRQNg0TVAB=diqnzo=uRg8-dFKcKuNUgJ_T2uw@mail.gmail.com>
Subject: Re: [PATCH v9 0/6] KASAN for powerpc64 radix
To: Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 1, 2020 at 5:16 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Building on the work of Christophe, Aneesh and Balbir, I've ported
> KASAN to 64-bit Book3S kernels running on the Radix MMU.
>
> This is a significant reworking of the previous versions. Instead of
> the previous approach which supported inline instrumentation, this
> series provides only outline instrumentation.
>
> To get around the problem of accessing the shadow region inside code we run
> with translations off (in 'real mode'), we we restrict checking to when
> translations are enabled. This is done via a new hook in the kasan core and
> by excluding larger quantites of arch code from instrumentation. The upside
> is that we no longer require that you be able to specify the amount of
> physically contiguous memory on the system at compile time. Hopefully this
> is a better trade-off. More details in patch 6.
>
> kexec works. Both 64k and 4k pages work. Running as a KVM host works, but
> nothing in arch/powerpc/kvm is instrumented. It's also potentially a bit
> fragile - if any real mode code paths call out to instrumented code, things
> will go boom.
>
> There are 4 failing KUnit tests:
>
> kasan_stack_oob, kasan_alloca_oob_left & kasan_alloca_oob_right - these are
> due to not supporting inline instrumentation.
>
> kasan_global_oob - gcc puts the ASAN init code in a section called
> '.init_array'. Powerpc64 module loading code goes through and _renames_ any
> section beginning with '.init' to begin with '_init' in order to avoid some
> complexities around our 24-bit indirect jumps. This means it renames
> '.init_array' to '_init_array', and the generic module loading code then
> fails to recognise the section as a constructor and thus doesn't run
> it. This hack dates back to 2003 and so I'm not going to try to unpick it
> in this series. (I suspect this may have previously worked if the code
> ended up in .ctors rather than .init_array but I don't keep my old binaries
> around so I have no real way of checking.)

Hi Daniel,

Just FYI: there's a number of KASAN-related patches in the mm tree
right now, so this series will need to be rebased. Onto mm or onto
5.11-rc1 one it's been released.

Thanks!
