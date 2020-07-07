Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE47C433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 18:48:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A41C8206E2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GtYcI34p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41C8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1Wfl68jkzDqwW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 04:48:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2a00:1450:4864:20::642;
 helo=mail-ej1-x642.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=GtYcI34p; dkim-atps=neutral
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1W0t002CzDqvp
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 04:19:08 +1000 (AEST)
Received: by mail-ej1-x642.google.com with SMTP id rk21so47629839ejb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2020 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IJcF3lAERNl2pHWGp39A9gwQbaEBKJzdpdY4Z29brno=;
 b=GtYcI34psfamNnVZB54EG+w1stxgeDLcIFiZaiUbR3trVD0lb2aYCNtXamoiJnBwny
 ythvCZsScIhskjQWMpoOh6ln/SwwcT/25kxyMFYQhWpC/rbTe/rrmyfSZLG/cuvsxnqa
 l7MA9Xw7s15QuDh1+Ak8iN66kQHRHsaM338N3pJNQ5oTuLMt83pouJw8vSOKh7ACtsYG
 Vnp8Z7N+H1jOCVpuFx5aa1ln4a2c3CUpVW1grf23B4jd719fP/7YFBdeotJEtj0VCWc2
 bpwjzv49FPEEfKnY9vtw0lDE7jzevmJbQL6im7meQiahBIfu4NZGoL5br4zYm9nbUAv7
 iRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IJcF3lAERNl2pHWGp39A9gwQbaEBKJzdpdY4Z29brno=;
 b=TeQ3QnV1PMukSYIkhYxaoV+IEeF4FZPZnhJpjDizyFfb+R5uNUKvRc1VSp68wS2T6N
 EPGPMuCIZubPi2tT7S3dr79IywLPimYESn2umHgIup1uFOeyTfNWoNGpbONtBFmce2Bc
 UWyGtI4YH1nrYa99OMHnla0q7mchU2eRFoY+3n9irPTnm+VgY8U0aoy8ehcQx9cVKIwt
 F7Foop0eYJsAXKDKFNvjR+HKDdyA2VO/99N2VhYH38SwposHCiBGk73dCmo5avCjQUhQ
 jD1tiktZciRaEaSc037D13sg2iv6Dz7ze3Uns9oVoJaZcdUpn97AGLxEMXRXlxY9QtR/
 keKg==
X-Gm-Message-State: AOAM530U7F+kZv8GMmWVIfzFfyv7E988deMrNMl7JP/bck8p1R9oPnO+
 B1g5TD5MC4HvEwo2n0uMnowFVL2qbTniK/uwfe5qlA==
X-Google-Smtp-Source: ABdhPJz/k1Lj7S8JXbw1qDGIHYzWAWL1RIZUAULeU0yGbiOgcHknNP96xoeVJ3D+eLW4C9y+LJcZZrAh7dTGJVMuYfE=
X-Received: by 2002:a17:907:20af:: with SMTP id
 pw15mr50524338ejb.204.1594145943817; 
 Tue, 07 Jul 2020 11:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180414.10467-1-rdunlap@infradead.org>
 <20200707180414.10467-13-rdunlap@infradead.org>
In-Reply-To: <20200707180414.10467-13-rdunlap@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jul 2020 11:18:52 -0700
Message-ID: <CAPcyv4hsu57988v7bZq9udTTan72NYDw8TrF46LC7bT_cqex2Q@mail.gmail.com>
Subject: Re: [PATCH 12/20] Documentation: maintainer-entry-profile: eliminate
 duplicated word
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: KVM list <kvm@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 David Airlie <airlied@linux.ie>, kgdb-bugreport@lists.sourceforge.net,
 linux-fpga@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Douglas Anderson <dianders@chromium.org>, Paul Cercueil <paul@crapouillou.net>,
 "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linux-i2c@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, linux-leds@vger.kernel.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 linux-scsi <linux-scsi@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 James Wang <james.qian.wang@arm.com>, linux-input@vger.kernel.org,
 Mali DP Maintainers <malidp@foss.arm.com>,
 Derek Kiernan <derek.kiernan@xilinx.com>, linux-mips@vger.kernel.org,
 Dragan Cvetic <dragan.cvetic@xilinx.com>, Wu Hao <hao.wu@intel.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jiri Kosina <jikos@kernel.org>,
 Hannes Reinecke <hare@suse.com>, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-mm@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Jens Axboe <axboe@kernel.dk>, Michal Marek <michal.lkml@markovi.net>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Pierre Morel <pmorel@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Wolfram Sang <wsa@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jason Wessel <jason.wessel@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Mike Rapoport <rppt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 7, 2020 at 11:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Drop the doubled word "have".
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/maintainer/maintainer-entry-profile.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-next-20200701.orig/Documentation/maintainer/maintainer-entry-profile.rst
> +++ linux-next-20200701/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -31,7 +31,7 @@ Example questions to consider:
>  - What branch should contributors submit against?
>  - Links to any other Maintainer Entry Profiles? For example a
>    device-driver may point to an entry for its parent subsystem. This makes
> -  the contributor aware of obligations a maintainer may have have for
> +  the contributor aware of obligations a maintainer may have for
>    other maintainers in the submission chain.

Acked-by Dan Williams <dan.j.williams@intel.com>
