Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF074C76186
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 20:51:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BE1206A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 20:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqYg2vf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BE1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45yBg14VDHzDq96
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 06:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqYg2vf6"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yBbQ3vBvzDqMt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 06:48:02 +1000 (AEST)
Received: by mail-wr1-x443.google.com with SMTP id z1so63285703wru.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RDzvvOLuO0FrlKWxE2OmL3qzW6ImORMj+8bQNrB211w=;
 b=bqYg2vf6S77RfIIDwmBpPvt98JMouraDjU/7gkOw4RUdkILM9kHRrxPCO1GPEiAfrB
 8k7HgMX7cALTWMIvmrVFh6Z7j8UypTjrSThLnoXQzgJQEUXYLwVrpd/FYWZ3uJol2rHH
 Kl+IJS7l+LdQCn41iD/kRCqtErAV//frDl3lYXeMfyWBR94TF9FzeDw0owWo+OEEHPSG
 8uwvF5QvbEjNHE17mrI6MRB4xoeMNHwwsqAISapLtlap5lQkdueROuTAewOxp+Z9mS11
 6fPixvDgOIu7s/zq1LWwASsumNqNj8nmbp+waUiGMVX33yO5DWFgPQnkrzaBnVoeHVTY
 E4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RDzvvOLuO0FrlKWxE2OmL3qzW6ImORMj+8bQNrB211w=;
 b=Xpzdf8u6Imx43ap9oBdRKZRmS8f0zxsWec/rASHclBEkwG2h9rocGmyPBU8tEtmR5w
 5ByTats+0R6aY9eYUfjbGvWbYRBTd1aLxponHIruCwPyFiJfdIYadZyvKrciG4VfLKxr
 JvuzsgF8PArXXA6q5fIhwaXYFsKD3oOoeeAaKcWb+hmSgs9gjljFmP9eq0WJb9Xb6HTN
 cG2Cf5iIhytjg7uINNzkt7mUlNo0xivfW4Qu6qCOU+/FoY1v9j1oxSoJtu4+oNMph0On
 a1qiEeVVyCjuRJ3rZMo8ePjIWTtn3WBkpgbrcDshOnVJMNCjO3D7hF/kdI0Ig3bjJgoV
 EK7Q==
X-Gm-Message-State: APjAAAUpk8BbHXUpLsxhXcSu4rRMzuJe9JYpjvsnjQgX70vj2nhxGZ0v
 ffB9AUATmN0mE+tUFq3mA80=
X-Google-Smtp-Source: APXvYqz0cYI4K316CGTDakDGyEqSptDOdhcM8y/dijSRlDVX+fk7T3qYCFFRPauHBHOlOJ6IkHwRUg==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr20910659wrw.178.1564433277503; 
 Mon, 29 Jul 2019 13:47:57 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
 by smtp.gmail.com with ESMTPSA id s188sm51874539wmf.40.2019.07.29.13.47.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 13:47:57 -0700 (PDT)
Date: Mon, 29 Jul 2019 13:47:55 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
Message-ID: <20190729204755.GA118622@archlinux-threadripper>
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper>
 <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kbuild test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 29, 2019 at 01:45:35PM -0700, Nick Desaulniers wrote:
> On Mon, Jul 29, 2019 at 1:32 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
> > > But I'm not sure how the inlined code generated would be affected.
> >
> > For the record:
> >
> > https://godbolt.org/z/z57VU7
> >
> > This seems consistent with what Michael found so I don't think a revert
> > is entirely unreasonable.
> 
> Thanks for debugging/reporting/testing and the Godbolt link which
> clearly shows that the codegen for out of line versions is no
> different.  The case I can't comment on is what happens when those
> `static inline` functions get inlined (maybe the original patch
> improves those cases?).
> -- 
> Thanks,
> ~Nick Desaulniers

I'll try to build with various versions of GCC and compare the
disassembly of the one problematic location that I found and see
what it looks like.

Cheers,
Nathan
