Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DFFC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 08:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E3420897
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 08:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F0HxDleJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3420897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49YHXq4jRfzDqdP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 18:19:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=chromium.org (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=keescook@chromium.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=F0HxDleJ; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49YHS269P1zDqcv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 18:15:14 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id f21so1056009pgg.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vO7oMyHAmtFgCk2sYz6KxFOeu6MNzidQmmJ2G/1pEM0=;
 b=F0HxDleJOoUvcttpU1UIgZwwGo1qsAu0SBmow0w21SBCMiqJuBybCtCeetr2YSSb4u
 +fkjyKNAyrdR6LI67eZ9RazJfkaoRWRSfWH45gbXJFqdNmob97+GWbiwux22WJi7UR4k
 7hajvHhSt2gRzwMsACsyTc1hVkQyehLvyrnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vO7oMyHAmtFgCk2sYz6KxFOeu6MNzidQmmJ2G/1pEM0=;
 b=Kedu2zApDUrnFJHydKAKD3ocSVDTEHf0Wyus7RAn6/4KS8InQ5z3A41RJxC2gQbQ8m
 Air5E+4rBLFJ7geUX6mnf7w3uBJCF6GzadHqwRISQJ9zFlT4j2tvrZ81WpDcvCbqb/LI
 84Fo3RMzHaz85gde6q5ZGDFDJXv5mZTfi+UoAkvZzJ0Hw8xfchiQLVc62Se6F9YGQMm0
 vvgDgaj76kP67DndvtyWTH+1FSy5so77zVAw+VFFSEH8Yh/HhvwU/H3rjS9/o65csI6D
 z88t5puVg/dmIFPCzgxWnlHTPKfujnsJcTzaasj0zBLNpcXbpP8pefUUZGFN3CquW5PY
 Ccwg==
X-Gm-Message-State: AOAM533a6bi/Sd4YEpvtPxAz1J7kuZlL0v29AuDuFTA0iNTKKv331g6U
 KnfXZHCXeMsSZyirixGMlxwseg==
X-Google-Smtp-Source: ABdhPJyNTEBK6lvlRch0b3eSKkfLXX3ub632bw+/rFINA2CK9LgJdaFmN+AJlEWxtJSWAZIJVMFXUQ==
X-Received: by 2002:a62:1e84:: with SMTP id e126mr7611560pfe.67.1590740111285; 
 Fri, 29 May 2020 01:15:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id k194sm253258pfd.26.2020.05.29.01.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 01:15:10 -0700 (PDT)
Date: Fri, 29 May 2020 01:15:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 12/13] sysctl: add helper to register empty subdir
Message-ID: <202005290115.487C95B@keescook>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-13-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074108.16928-13-mcgrof@kernel.org>
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
Cc: jack@suse.cz, rafael@kernel.org, airlied@linux.ie, amir73il@gmail.com,
 clemens@ladisch.de, dri-devel@lists.freedesktop.org,
 joseph.qi@linux.alibaba.com, sfr@canb.auug.org.au, mark@fasheh.com,
 rdna@fb.com, yzaikin@google.com, joonas.lahtinen@linux.intel.com,
 arnd@arndb.de, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 julia.lawall@lip6.fr, jlbec@evilplan.org, rodrigo.vivi@intel.com,
 nixiaoming@huawei.com, vbabka@suse.cz, axboe@kernel.dk, tytso@mit.edu,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ebiederm@xmission.com, daniel@ffwll.ch, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 viro@zeniv.linux.org.uk
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 29, 2020 at 07:41:07AM +0000, Luis Chamberlain wrote:
> The way to create a subdirectory from the base set of directories
> is a bit obscure, so provide a helper which makes this clear, and
> also helps remove boiler plate code required to do this work.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
