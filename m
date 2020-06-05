Return-Path: <SRS0=3D1i=7S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BAC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 20:48:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB5A206E6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 20:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dADgwH7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB5A206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49dvqw57FyzDr2k
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2020 06:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::641;
 helo=mail-ej1-x641.google.com; envelope-from=torvalds@linuxfoundation.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.a=rsa-sha256 header.s=google header.b=dADgwH7H; 
 dkim-atps=neutral
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49dvnB2TdpzDqr6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2020 06:46:05 +1000 (AEST)
Received: by mail-ej1-x641.google.com with SMTP id gl26so11504073ejb.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2020 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8qMV9KxwdmsZX+Eg7b8uIKpKh+L6ERIeG0MgUjSlWGY=;
 b=dADgwH7HLX3Ef50nfWyXB0qJfBAkA4toklDET3r14dvzwUvOOHWJPSPxqvIAj8Hnqz
 uAo/tEBpNiuHuvb7vCyFfELFzlsPN7GC2kh35ivVAaWd4qFpAcUGYcwhiMkU/id7MW/n
 UEzobQLweBKm1LElBmSjOoiSVbWI/e7jjz2WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8qMV9KxwdmsZX+Eg7b8uIKpKh+L6ERIeG0MgUjSlWGY=;
 b=iUAlCAJ6mQVRwsMfizw8JpCRbFYhA4ZBLrXXbuCHwgG+O8X5N4/gUrX5h79I1pZBn/
 +IAE2XrgD/mJUIS6n9r6d/7SCA18AuEgLleUluEBTd7RtuwQl7UXWtY113esi+xKoiUh
 xBUA8nsbTq5aBjh7yOJJ4aelPP8pWckl4YCxevbSWBgbSf+3RrYASHd1KGSjiNxXt3bl
 +7/OJyNgV7OtfgvBnv4SpQgQWoEZiBuBP0Z515fD0vIXLR7U9lH2lcjYXHfWr1Hl+T7a
 WhDRg2esIpQWL0LMj2lmLGZNJGgCq3HTRPW/5L8dfm9GZf8yk2Oa8Ruu9Wc/9subfi9z
 /vEw==
X-Gm-Message-State: AOAM533FiDuZjNJqrPkqEcvOF9BPE4+TV3dz+D2rt7ZXbYCGHJXgCvbX
 KS4pfAVl+srfA0t9v9grV2EvE8xzCwc=
X-Google-Smtp-Source: ABdhPJzS3crmmYBPLZKna9jckzSaSOernkXmA2WugcbL22ZVS1YCYsnDbk/9utLbk+yBYuDp1g1/Hw==
X-Received: by 2002:a17:906:edd8:: with SMTP id
 sb24mr10186898ejb.25.1591389962672; 
 Fri, 05 Jun 2020 13:46:02 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49])
 by smtp.gmail.com with ESMTPSA id p13sm5765715edx.69.2020.06.05.13.46.02
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 13:46:02 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id l10so11006250wrr.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2020 13:46:02 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr5213330ljn.70.1591389567802; 
 Fri, 05 Jun 2020 13:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <87eeqth3hi.fsf@mpe.ellerman.id.au>
 <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
In-Reply-To: <CAHk-=wh5vSwYqF=YiKOOGBHE=hCwnes_ndbP4QOyjPK_Xocz7w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2020 13:39:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg33hLZHjqcMhvWzmgNrE6Gv+xpEcFXUx7iUHS2t5QtdQ@mail.gmail.com>
Message-ID: <CAHk-=wg33hLZHjqcMhvWzmgNrE6Gv+xpEcFXUx7iUHS2t5QtdQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-1 tag
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: ego@linux.vnet.ibm.com, emmanuel.nicolet@gmail.com, chenzhou10@huawei.com,
 jniethe5@gmail.com, linuxram@us.ibm.com, kernelfans@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, st5pub@yandex.ru,
 Oliver O'Halloran <oohall@gmail.com>, huhai@tj.kylinos.cn,
 Markus Elfring <elfring@users.sourceforge.net>, rzinsly@linux.ibm.com,
 leobras.c@gmail.com, mikey@neuling.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, haren@linux.ibm.com,
 michal.simek@xilinx.com, mahesh@linux.ibm.com, Takashi Iwai <tiwai@suse.de>,
 kjain@linux.ibm.com, leonardo@linux.ibm.com,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, ajd@linux.ibm.com,
 Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
 alistair@popple.id.au, Nick Piggin <npiggin@gmail.com>,
 wangxiongfeng2@huawei.com, Qian Cai <cai@lca.pw>, clg@kaod.org,
 Nathan Chancellor <natechancellor@gmail.com>, hbathini@linux.ibm.com,
 Christophe Leroy <christophe.leroy@c-s.fr>, geoff@infradead.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, wsa@kernel.org,
 sbobroff@linux.ibm.com, fbarrat@linux.ibm.com,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 5, 2020 at 12:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ..and then when I actually compared whether I otherwise got the same
> result as you, I realized that this all depends on the module tree.
>
> I'll go merge that first, and then re-do this all. Oh well.

Ok, redone and pushed out. Can you check that the end result makes sense?

              Linus
