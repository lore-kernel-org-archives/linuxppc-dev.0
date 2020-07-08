Return-Path: <SRS0=luaH=AT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B9C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 13:19:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1472067D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1ZIjk7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1472067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B20Jp4XXkzDqfG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 23:19:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::344;
 helo=mail-wm1-x344.google.com; envelope-from=daniel.thompson@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=A1ZIjk7Y; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B20C401Y5zDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 23:14:33 +1000 (AEST)
Received: by mail-wm1-x344.google.com with SMTP id g75so3037191wme.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2020 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=l8TXsMU8pcx7Tss0R/XmiW2rwe2Hix1sm/QIevQOb2M=;
 b=A1ZIjk7YGe2YSEoQCSRgqjmHR7oxja8buIPLjIhRTjdJVpAt9lG0gE7SFtVGHQLadT
 xVpcPloGsK2WSxEeeICvTCCQ1YYB1VSfUPjrX131Kkrf1ua0TB8eUFoz6BcB/ltMdxle
 g0CUQEDldKrVRBTAatDkSdjEu36OQGD68toOzC25aprt3rfyUr9rqTVrTmbAXsTUgf77
 9cR8rDocIEreQ2XYDW7IWJeD90ce47cu6PI8ZsNUWN9GnPzAGJerkmwY1TNG1BH5v+ah
 Y+0oSh28JHhB1q0lkYDfWGe+5f8BNO5h4B8RbndZgEm96Q69dP3WLG/nFIdlxkVQzXH+
 HYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l8TXsMU8pcx7Tss0R/XmiW2rwe2Hix1sm/QIevQOb2M=;
 b=FrRFglVITt3X2PdqCWRG7nwf1QNa2zPJuMTMJNc1dc0gCo7dt/H2FlMuFwmDzTRtAp
 0YggGeObOlOG2uOFwkrEnp9/58BXkyThfJbqq0i4VN/zkZ2pMc41xyd31nUOosB2Wyv4
 Et5+8xiVHyd/5DNuGDv0/TZQh7M6QK9iorlCRKm+b9jpKNzV8RCDzGS188U+50mgqCAH
 JeLXO6uMHzgy1rGO3TpMoWG9lF1by3fiwMjlskZo11OQvr67/FqWk3/CjypkOH7FJBK5
 +1XI/PSQ7LrIxcfbv7+IT3LHa3lPKnz1HcXxgKqGu/wU2in2QASoLejv2nodrfTF5r2z
 7lvg==
X-Gm-Message-State: AOAM533zadGJjBxczihnEXIyINeE+PgOP3JgVwfSzRan68flyxx3Zymr
 r3A6cPR1tkkBnOq/Be3LkW4uzw==
X-Google-Smtp-Source: ABdhPJwq0Oc6xY1jGe2yyxLQ3zEuUYKf/Jmuh4JKlNT9KiWq8rLJ6802Y6Ay8mTXZNr5ogQ7BAfKOg==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr9822665wmj.39.1594214068610;
 Wed, 08 Jul 2020 06:14:28 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net.
 [86.9.19.6])
 by smtp.gmail.com with ESMTPSA id n16sm5779824wra.19.2020.07.08.06.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 06:14:27 -0700 (PDT)
Date: Wed, 8 Jul 2020 14:14:25 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 04/20] Documentation: kgdb: eliminate duplicated word
Message-ID: <20200708131425.iesuqtfklrsn3kam@holly.lan>
References: <20200707180414.10467-1-rdunlap@infradead.org>
 <20200707180414.10467-5-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707180414.10467-5-rdunlap@infradead.org>
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
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, kgdb-bugreport@lists.sourceforge.net,
 linux-fpga@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
 dri-devel@lists.freedesktop.org, Douglas Anderson <dianders@chromium.org>,
 Paul Cercueil <paul@crapouillou.net>, keyrings@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-i2c@vger.kernel.org,
 Pavel Machek <pavel@ucw.cz>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, linux-leds@vger.kernel.org,
 linux-s390@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
 linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Masahiro Yamada <masahiroy@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 James Wang <james.qian.wang@arm.com>, linux-input@vger.kernel.org,
 Mali DP Maintainers <malidp@foss.arm.com>,
 Derek Kiernan <derek.kiernan@xilinx.com>, linux-mips@vger.kernel.org,
 Dragan Cvetic <dragan.cvetic@xilinx.com>, Wu Hao <hao.wu@intel.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, linux-kbuild@vger.kernel.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>, Jiri Kosina <jikos@kernel.org>,
 linux-block@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-mm@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Jens Axboe <axboe@kernel.dk>, Michal Marek <michal.lkml@markovi.net>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Jason Wessel <jason.wessel@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>, Dan Murphy <dmurphy@ti.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jul 07, 2020 at 11:03:58AM -0700, Randy Dunlap wrote:
> Drop the doubled word "driver".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: kgdb-bugreport@lists.sourceforge.net

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
