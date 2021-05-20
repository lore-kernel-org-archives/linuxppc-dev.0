Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A75C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 12:58:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B3161004
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 12:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B3161004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm8tY08JMz3bxj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 22:58:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.131; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fm8t80g4yz2yjK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 22:58:07 +1000 (AEST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MnaY1-1l13i343mP-00jcOW for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May
 2021 14:58:03 +0200
Received: by mail-wr1-f42.google.com with SMTP id j14so15834900wrq.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 05:58:02 -0700 (PDT)
X-Gm-Message-State: AOAM5325vF+kRfjime9Bq5lq1llROFLNvfQpLYTgE1IKFw46LGTAOVAZ
 RyPl5Pwxee71vIzVErbixMnIECMJCNq1lkCHB60=
X-Google-Smtp-Source: ABdhPJzjF6dsH5HoZqJvsW8Z8vuY/KQcYke0jL+BR2nKnLRzRk59Q8j7MY6u03gtUYt403a0Fz/TtBgmPs8YgE0TcrY=
X-Received: by 2002:a05:6000:18a:: with SMTP id
 p10mr4175890wrx.99.1621515471669; 
 Thu, 20 May 2021 05:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210520121347.3467794-1-lee.jones@linaro.org>
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 20 May 2021 14:56:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
Message-ID: <CAK8P3a0VujuG8eU_CEVSvzbk4nAJz8fStedM5eMUrLAr9EJxDQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] Rid W=1 warnings from Char
To: Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:20c6Xf9KOtvhlAGgThCMfcb6P7Y2Oiw+2Gc60CYM3h0/OnQKa5C
 1y4/r9N2J6Y89TwF97+H2Z4ERSgZ6KoYaQg/tNQfEToxMs5UIDS5PqEpcCLtTQstq1ewGVC
 wDV+1zzsOBCIZLgjaPrTu9HKOrBhDjF+6sPjI3a+rtiwMQxzQe7TJulDD+v4bzGjNlxbX90
 gqwxRwqU7FVsihSBd3nmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IBE8t81oDrY=:YxP1bUg3rkKVieCw4+QCt7
 FWTnjMjGOkl13bZnvDNAhmqwQ1T+UqaBjd3JiXJWGlP6eZHYeNIHPTMcqUgBL3mm1GY5kvjTl
 qyEfKH7UVEAaL/XYipr0OGzzPu50UKTC+ApdqKcDxGU7a1N6jtL4yxOQjXtJravKE8q2iJdMN
 thd6sAi1kfgDB0P8wjTDRD+2zbYJXNK6qakyAsheQ6RTTztYit6uCnqPuKiU5JuiIXKfD1Vwc
 qQgmK+OUOYQF44j8k8wl6gDIq0ocLC9MCEkLHVDTq/Za39ybX2Yh3NDbVj5THuOyjFbm8Zl6v
 AnR1qULO5hKgUjm50+7IqGBw/vO9+5LGnlnushSWpuFQrYPNVuQU8o4o4EHk39bMlF/zq+oB2
 Ss2v0soKbtks2neg7KRGfWWs6R327eFtC0mWEO4HBzPcyjeIRTEZcVowNGifegHGrydlRJxOu
 rktWmBxnxbBjYNm9YE1pR0dkha/KsLyezDUyDdBJKWMWLv++i5oJkik+POeXTxmHghOqmsLED
 +6oPrpNYvin2PGSZp4OjXplIhRRfI1XsrM2o+043/o3mMjb+QJPNfGOykOLW0RL3gcNhQCy07
 eW0dfQgV2EY6C3cTJC4rm7F8+ZVmNAJ4By+HT/wkD2Ha8Ppnc9/Hypf0l3GzYx5vE2SvyctxP
 WaYA=
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
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, David Airlie <airlied@linux.ie>,
 Clemens Ladisch <clemens@ladisch.de>,
 "C. Scott Ananian" <cananian@alumni.princeton.edu>,
 Paul Mackerras <paulus@samba.org>, Kylene Hall <kjhall@us.ibm.com>,
 Jerome Glisse <j.glisse@gmail.com>, Peter Huewe <peterhuewe@gmx.de>,
 Michael Neuling <mikey@neuling.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Dave Safford <safford@watson.ibm.com>, Harald Welte <laforge@gnumonks.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kanoj Sarcar <kanoj@sgi.com>,
 David Woodhouse <dwmw2@infradead.org>, Bob Picco <robert.picco@hp.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
 Thirupathaiah Annapureddy <thiruan@microsoft.com>,
 "cs.c" <support.linux@omnikey.com>, Lijun Pan <ljp@linux.ibm.com>,
 Reiner Sailer <sailer@watson.ibm.com>, Matt Mackall <mpm@selenic.com>,
 van Doorn <leendert@watson.ibm.com>, Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Fulghum <paulkf@microgate.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, linux-integrity@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 20, 2021 at 2:13 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
>
> Lee Jones (16):
>   char: pcmcia: cm4000_cs: Remove unused variable 'tmp'
>   char: pcmcia: cm4040_cs: Remove unused variable 'uc'
>   char: random: Include header containing our prototypes
>   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
>   char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
>   char: applicom: Remove 3 unused variables 'ret' and 2 instances of
>     'byte_reset_it'
>   char: tpm: tpm1-cmd: Fix a couple of misnamed functions
>   char: tpm: tpm_ftpm_tee: Fix a couple of kernel-doc misdemeanours
>   char: agp: backend: Demote some non-conformant kernel-doc headers
>   char: agp: frontend: Include header file containing our prototypes
>   char: agp: via-agp: Remove unused variable 'current_size'
>   char: hpet: Remove unused variable 'm'
>   char: agp: generic: Place braces around optimised out function in if()
>   char: agp: uninorth-agp: Remove unused variable 'size'
>   char: hw_random: pseries-rng: Demote non-conformant kernel-doc header
>   char: mem: Provide local prototype for non-static function

Thanks a lot!

I've looked all the patches now and commented on patches 6 and 16.
With my comments addressed

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

       Arnd
