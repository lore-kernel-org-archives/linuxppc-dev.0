Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B013CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 18:32:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E5F20856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 18:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="al5aEOhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E5F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473HB25WB2zF3RG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 05:32:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::441;
 helo=mail-pf1-x441.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="al5aEOhx";
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473H7d0WppzF4gg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 05:30:19 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id d13so2180791pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=qt1LJEyIRaEDllLVqLH7qbNDphlkjCZco3W19Gfwzcw=;
 b=al5aEOhxLiz0B1e3fwRa1JcU4iQZgmirA1Ct/lHAO/pQEfSBmkDnCWE6zt0ZZVm9yF
 iOnnQSg/OytlL7fwVY98bQg8i+gKIO84NlHty7mZoArixkMXetqSqD5uMYGcnlx1WNgE
 aqFVwy9/TbvwyeVX3hUWoFMEWmIklYjRnLhJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qt1LJEyIRaEDllLVqLH7qbNDphlkjCZco3W19Gfwzcw=;
 b=HzQS3vsEJhKQB6fli6O3F/XLaDOR/yley6+5Vy4XZNYBPfuxah4fn4IP9KW4DkGWGx
 n6LsR8ttYSCpY6PSehxml7+sBB9SlrufUcLcB3ffVdd/KHXRIF8QftebuKgrr7RP4erw
 jq/J+tip6f1YoGG2WC7bfSKHfd345chTI//YoXBkrjE0S2foMrN7Tg3TQIaDNqoUF8wt
 nrAlR/a/Lxa6gdG1W/hpUlRG4dt0WEyTBuDQX5Nj3np7d+d6yJXpJRJ4ca5j1Kyh7NeR
 742mao6UCmoXQoqCO0KZXzf4g7x+hlB2+KUgUisdlvYD47Z9s1u51AWl9/Mml0gKbWqW
 5t/A==
X-Gm-Message-State: APjAAAX46bP5dle944qx5ty2MJz5rxdwfh75x7riOV9NMbl2xmjoYivd
 BEFt/0/r34AV1X1Bim7h6JnfWQ==
X-Google-Smtp-Source: APXvYqz3dMewe2phjB2EOF2Jom8Z3MYTzZ3AjLUP+7e1uUyrqbjtg2J3m89Vu9V2Lh7PUAeTc3TSJw==
X-Received: by 2002:aa7:9a94:: with SMTP id w20mr772278pfi.256.1572460215124; 
 Wed, 30 Oct 2019 11:30:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id h189sm498618pge.88.2019.10.30.11.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 11:30:14 -0700 (PDT)
Date: Wed, 30 Oct 2019 11:30:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v5 0/5] Implement STRICT_MODULE_RWX for powerpc
Message-ID: <201910301128.E7552CDD@keescook>
References: <20191030073111.140493-1-ruscur@russell.cc>
 <53461d29-ec0c-4401-542e-6d575545da38@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53461d29-ec0c-4401-542e-6d575545da38@c-s.fr>
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
Cc: ajd@linux.ibm.com, kernel-hardening@lists.openwall.com, npiggin@gmail.com,
 joel@jms.id.au, linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 30, 2019 at 09:58:19AM +0100, Christophe Leroy wrote:
> 
> 
> Le 30/10/2019 à 08:31, Russell Currey a écrit :
> > v4 cover letter: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198268.html
> > v3 cover letter: https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-October/198023.html
> > 
> > Changes since v4:
> > 	[1/5]: Addressed review comments from Michael Ellerman (thanks!)
> > 	[4/5]: make ARCH_HAS_STRICT_MODULE_RWX depend on
> > 	       ARCH_HAS_STRICT_KERNEL_RWX to simplify things and avoid
> > 	       STRICT_MODULE_RWX being *on by default* in cases where
> > 	       STRICT_KERNEL_RWX is *unavailable*
> > 	[5/5]: split skiroot_defconfig changes out into its own patch
> > 
> > The whole Kconfig situation is really weird and confusing, I believe the
> > correct resolution is to change arch/Kconfig but the consequences are so
> > minor that I don't think it's worth it, especially given that I expect
> > powerpc to have mandatory strict RWX Soon(tm).
> 
> I'm not such strict RWX can be made mandatory due to the impact it has on
> some subarches:
> - On the 8xx, unless all areas are 8Mbytes aligned, there is a significant
> overhead on TLB misses. And Aligning everthing to 8M is a waste of RAM which
> is not acceptable on systems having very few RAM.
> - On hash book3s32, we are able to map the kernel BATs. With a few alignment
> constraints, we are able to provide STRICT_KERNEL_RWX. But we are unable to
> provide exec protection on page granularity. Only on 256Mbytes segments. So
> for modules, we have to have the vmspace X. It is also not possible to have
> a kernel area RO. Only user areas can be made RO.

As I understand it, the idea was for it to be mandatory (or at least
default-on) only for the subarches where it wasn't totally insane to
accomplish. :) (I'm not familiar with all the details on the subarchs,
but it sounded like the more modern systems would be the targets for
this?)

-- 
Kees Cook
