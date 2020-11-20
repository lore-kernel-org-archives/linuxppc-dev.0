Return-Path: <SRS0=wfc/=E2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B4DC5519F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 07:52:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77333222BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 07:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1mwo+EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77333222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CcpfY2cmdzDqxj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 18:52:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::341;
 helo=mail-wm1-x341.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=e1mwo+EC; dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CcpcL4p6KzDqQv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 18:50:10 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id a65so8946476wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2020 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ebx5P9t5H+MiQQTlLfM0hkZw/MTzmtdqFls14AM1z/M=;
 b=e1mwo+ECalTd3S98s5Ektjznx93/PmbMRwHlKHMiD8na32C42TLPqJljO3cb1++GrV
 XbnjjRsDxXrnJuu//pgdIiiKhC0vACcmUHFq7Fg2IkM453kGb9jhMeVMJV1hOQWPb7XG
 X2z+sg0YTSqBEmNQ5Q+SMQ2VqUq66zaSsoKEo7Yx6iSIIHR8ou3N2cOeU0luTK4Pq0A4
 TekOE63Co03VRv5c6F18ey/D3z7/3oWE5A5odAixoxpsHpkwQ3hnFwWoH4cTKZKibOqS
 g1wyVQpH2YqyNL0PovbKe9CQeiFXsekdAFfP9bdfOMeA88XQ0weuxDMsnPoctKGeX2QA
 gG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ebx5P9t5H+MiQQTlLfM0hkZw/MTzmtdqFls14AM1z/M=;
 b=reZijKn8mHG+22dGWati2V3L/kG2/omhfbtoH3pVAktXRA8xxz1B5YIte18X3p+MWm
 qz0WBXCaWTSj1afhjbX/hYvoKoGIrN/Lua6YmztbFmu/ANh4HTV0pDofNC/zJJGvMuwi
 ne76ZImGEh+ToXYmEo+svooHvN4S1qR+EZkUrM6Vsjex7w1GJBJnZyKZzjNjuYz2MlNG
 1+zNPnUjudamNwNruw2pJfPOVuqHkhcmkclZqWQw538FtlRTdL/g3UJb0OQ6gViWsJEQ
 MyiV7YXUz0Ytx+J1++YVy7QSLk8ba+JlffIjnKgLNhL3kMK/WbGZQqrc8rF7Mfgw3EGd
 gHjA==
X-Gm-Message-State: AOAM533kZwivcwTOWhoNnWoFwcHwuoXdzb7RmJfQpwAFvISGGWnC0w3G
 DCC6Xx/lOJUtYRN4ERGmS0uysg==
X-Google-Smtp-Source: ABdhPJx4fGTY2rHUzVNZxl2TJRKDria44u2mMJodTpI8NFP2+B0rLTwEJhgPV9+TxdAoNSy5h1Qd8A==
X-Received: by 2002:a1c:1bcb:: with SMTP id b194mr8420302wmb.139.1605858603401; 
 Thu, 19 Nov 2020 23:50:03 -0800 (PST)
Received: from dell ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id u23sm3555393wmc.32.2020.11.19.23.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2020 23:50:02 -0800 (PST)
Date: Fri, 20 Nov 2020 07:50:00 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 23/23] mtd: devices: powernv_flash: Add function names
 to headers and fix 'dev'
Message-ID: <20201120075000.GA1869941@dell>
References: <20201109182206.3037326-24-lee.jones@linaro.org>
 <20201119210716.25046-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201119210716.25046-1-miquel.raynal@bootlin.com>
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Paul Mackerras <paulus@samba.org>,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 19 Nov 2020, Miquel Raynal wrote:

> On Mon, 2020-11-09 at 18:22:06 UTC, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
> >  drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
> >  drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
> >  drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'
> > 
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Richard Weinberger <richard@nod.at>
> > Cc: Vignesh Raghavendra <vigneshr@ti.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: linux-mtd@lists.infradead.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Superstar.  Thanks for your help Miquel.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
