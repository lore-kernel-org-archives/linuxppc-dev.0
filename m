Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFB7C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:03:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F6AE21780
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 04:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDaf5uxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F6AE21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vrSX2vkhzF3Gq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 15:03:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDaf5uxP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=amodra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QDaf5uxP"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vrPx2GcjzF3HS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 15:00:52 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id x21-v6so4378252pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 20:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hbCj58wDGJYVgLcMa3ZJ2tA031059oP2ukMWxYoZNWg=;
 b=QDaf5uxPPtuSiyA7UQcUgO7S8kXrjkpPkUp9Jl1ZeDPQkwCOU550XB8J6/JCCMMknA
 8EWRxMlalxiv6Yktx83clp/3/aBviP72J439Z++wLjhpXjFBHZLQMS0Hoy6g6M5t6RBf
 Fm4sMUZYyaoHk0vPokdJM3EIGxulm74PDxNq6AnxYH/z3P6Cl9kBundR9QJV6BzECKu1
 araJGLsPIDoYstadvCz56zZ7k91xypBteEWMunLPneJm01MspgFT8o7BJH2PpvnxoGUD
 iLD/dcaxfkvynHepdxU59BQ0rpzB5+BaSyUje64kEf4NzejBcSSagr90XBH/uSINEBxc
 aajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hbCj58wDGJYVgLcMa3ZJ2tA031059oP2ukMWxYoZNWg=;
 b=j1PCuf1YmBG2munZOEu2AW4O5bKsNRRyspEhJoKaWOFF8FnKTSk5dp3yG/EyaV+EUt
 03UHtVnehTAJDYssCvaMvERtKOVVce1+lqaEktk/DRHhi2PbAk1MSHsslCLYX+9Tdy9D
 ezRv7K0+Do6RvT2hBLVacHjSQSkqXEYz3pc9LhLkgvvotQclxDnYbaTWaUVidjOgtbwg
 8YnfQQfIEl1hh+gQNawEc+hx9CLS2CrI3FrCu0Q7svnde11UHym7mXsHXSjKUoY3sc6f
 /iRzmI2PLjcTs6vefGaS1wUujmCjyqQKnt5xXLm/K6tLWNKl/sOXuyFT7YyncqIFKrq1
 HXYA==
X-Gm-Message-State: AGRZ1gJANucRfm/shYBrzpYT7OG97L+0mGIxIrDbNwOwA+ezSLvMA5fE
 7ZVhRbfZ3/y1LVFdzUznhnA=
X-Google-Smtp-Source: AJdET5fpQzMxaoglFU0YbCyresK6eTM6o+iM2q9pxb+Hezl8Vo9yOJg/K9FH03UDpyS2Bg4lgUvJgA==
X-Received: by 2002:a17:902:5e4:: with SMTP id
 f91-v6mr312076plf.75.1542168050324; 
 Tue, 13 Nov 2018 20:00:50 -0800 (PST)
Received: from bubble.grove.modra.org ([58.175.241.133])
 by smtp.gmail.com with ESMTPSA id s186-v6sm50444343pfs.164.2018.11.13.20.00.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 13 Nov 2018 20:00:49 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
 id 1E0EC80869; Wed, 14 Nov 2018 14:30:46 +1030 (ACDT)
Date: Wed, 14 Nov 2018 14:30:46 +1030
From: Alan Modra <amodra@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc/32: Include .branch_lt in data section
Message-ID: <20181114040045.GX29784@bubble.grove.modra.org>
References: <20181114030218.25508-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114030218.25508-1-joel@jms.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 14, 2018 at 01:32:18PM +1030, Joel Stanley wrote:
> When building a 32 bit powerpc kernel with Binutils 2.31.1 this warning
> is emitted:
> 
>  powerpc-linux-gnu-ld: warning: orphan section `.branch_lt' from
>  `arch/powerpc/kernel/head_44x.o' being placed in section `.branch_lt'
> 
> As of binutils commit 2d7ad24e8726 ("Support PLT16 relocs against local
> symbols")[1], 32 bit targets can produce .branch_lt sections in their
> output.
> 
> Include these symbols in the .data section as the ppc64 kernel does.
> 
> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commitdiff;h=2d7ad24e8726ba4c45c9e67be08223a146a837ce
> Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alan Modra <amodra@gmail.com>

Looks fine to me.

> ---
> I wasn't sure where this should go or if the ordering matters.

The usual answer is: "Look at where the section goes in the standard
linker scripts."   But that doesn't apply here.  The section will be
empty for a kernel build so it doesn't matter where it goes.

> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index 434581bcd5b4..6d5fd1b95311 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -313,6 +313,7 @@ SECTIONS
>  		*(.sdata2)
>  		*(.got.plt) *(.got)
>  		*(.plt)
> +		*(.branch_lt)
>  	}
>  #else
>  	.data : AT(ADDR(.data) - LOAD_OFFSET) {
> -- 
> 2.19.1

-- 
Alan Modra
Australia Development Lab, IBM
