Return-Path: <SRS0=XY74=AY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D479AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 17:06:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8689620663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2020 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJH7yZNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8689620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B596l545ZzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2020 03:06:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VJH7yZNs; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B58xf67DqzDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2020 02:59:02 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id t6so2609663plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2020 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=ORIM/ZNEBl74OqQM8L2yYxI+Et9/wiuEeRnDUO3EsAQ=;
 b=VJH7yZNscwaYbqE/omlmt9Ksyur+12V/TuE/UzLDXZk/SEEj0A641Rrw9RCiT75aVt
 c/cWhEOhvn7WEAaw428XyuGfpY8+riam1LEjec4bzRUGLaXawH/7y7eVgkty0X8/OFOD
 5Bs6J+bA6AWv9xdq7GQtl2DfW8yf4wP3HlRvlnGpvHLd+gL2Ps+l1HfFk27Qza1vmgqI
 +oAKrctQtMbvS27Hts2r7k6nfJjisE/B8j3gfbNY7Ktm04fS+UpEsQCeGqNZfow5hWf5
 Hi3yVTrCbJWqlfa4SumRjH/GNjpEMx7RW9wmECansF4SxxF84A/18y0h5buEW5r5f4EP
 dWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=ORIM/ZNEBl74OqQM8L2yYxI+Et9/wiuEeRnDUO3EsAQ=;
 b=oHtKlwXjfyABjwy2WJQ92y89fv92Ne1ULEfmtlmVaIqXTZsgMrKaWNy5iApl3h/yLf
 Om3KkZlNxa7sFJNbpq7vITRIydU9IRepffgyZkPDQ6BkwySfeWFcJXMz8QpuvtczhMTW
 KEmjub2DBM3QRygCkeH+d3DfYt0XaFbhlkfp9B4Cdnjuukw/kz2c70mi5DGFcOjothzz
 lJ/pHgnlDXXuYwse5rcUG8T5gWaBb9Dtuzgz/5Ii2FifPNh9YsZjREwQoDe+HUz1aO8Q
 oI5Kxc7JlmhFT8aQGEhnusqoRL2f/nxnvi9mUhbeGeq7pAxFi3paJ5YC4FzoixP32sho
 6GKQ==
X-Gm-Message-State: AOAM532XKvh+qKbfo3BacfcXTkgChuMvp6hrMleYnJogX6XYdJIac09D
 sLPMcEFaaavFEcTBeNJ9KDo=
X-Google-Smtp-Source: ABdhPJxL5V5S/nPc/nFeHkLhW85eHEO6Lep2VyhUBbnbRUMZvQGVbz0NRkKtExc0kLvNvW7ItibMHg==
X-Received: by 2002:a17:902:bd97:: with SMTP id
 q23mr479116pls.167.1594659539086; 
 Mon, 13 Jul 2020 09:58:59 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
 by smtp.gmail.com with ESMTPSA id 207sm15368027pfa.100.2020.07.13.09.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 09:58:58 -0700 (PDT)
Date: Tue, 14 Jul 2020 02:58:53 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/3] Power10 basic energy management
To: ego@linux.vnet.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
 <1594617564.57k8bsyfd0.astroid@bobo.none>
 <20200713104837.GG24866@in.ibm.com>
In-Reply-To: <20200713104837.GG24866@in.ibm.com>
MIME-Version: 1.0
Message-Id: <1594659004.tvqngaepru.astroid@bobo.none>
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
Cc: ravi.bangoria@linux.ibm.com, mikey@neuling.org, pratik.r.sampat@gmail.com,
 linux-kernel@vger.kernel.org, Pratik Rajesh Sampat <psampat@linux.ibm.com>,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Gautham R Shenoy's message of July 13, 2020 8:48 pm:
> On Mon, Jul 13, 2020 at 03:23:21PM +1000, Nicholas Piggin wrote:
>> Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
>> > Changelog v1 --> v2:
>> > 1. Save-restore DAWR and DAWRX unconditionally as they are lost in
>> > shallow idle states too
>> > 2. Rename pnv_first_spr_loss_level to pnv_first_fullstate_loss_level t=
o
>> > correct naming terminology
>> >=20
>> > Pratik Rajesh Sampat (3):
>> >   powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on P9 and above
>> >   powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
>> >   powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
>> >=20
>> >  arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++---------=
-
>> >  1 file changed, 22 insertions(+), 12 deletions(-)
>>=20
>> These look okay to me, but the CPU_FTR_ARCH_300 test for=20
>> pnv_power9_idle_init() is actually wrong, it should be a PVR test=20
>> because idle is not completely architected (not even shallow stop=20
>> states, unfortunately).
>>=20
>> It doesn't look like we support POWER10 idle correctly yet, and on older
>> kernels it wouldn't work even if we fixed newer, so ideally the PVR=20
>> check would be backported as a fix in the front of the series.
>>=20
>> Sadly, we have no OPAL idle driver yet. Hopefully we will before the
>> next processor shows up :P
>=20
> Abhishek posted a version recently :
> https://patchwork.ozlabs.org/project/skiboot/patch/20200706043533.76539-1=
-huntbag@linux.vnet.ibm.com/

Yep, I saw that. Still keen to get it working, just had other priorities=20
in the short term. We'll need to do this OPAL v4 thing for it.

Thanks,
Nick

