Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC511C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 10:02:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117B860E93
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 10:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 117B860E93
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hnmqj2wVKz30Hj
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 21:02:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=D3eL8POb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=pmladek@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=susede1 header.b=D3eL8POb; dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hnmq51qMpz2xsT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Nov 2021 21:01:36 +1100 (AEDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 33A1E21AFC;
 Mon,  8 Nov 2021 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1636365693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5UZuKAmHIrwVcGr41lKYOAKA0vOHUe0ZexZ00mvExQU=;
 b=D3eL8PObhxrU8IE4pU3nDbNQgS4xDX279ndrDe7NVbcOlV4CWeQKYLEcilP1qhzGBDs3uI
 HmnxAMflpuaiiXUcslsjCPMak5CL4TWeHpLVKyz19GO9CWWroehg4VuHCTyaaSS/gDVgxR
 wrpGSrPqJ5HNIFgpWfuGeQ6v/SzYcyk=
Received: from suse.cz (unknown [10.100.224.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 11789A3B8B;
 Mon,  8 Nov 2021 10:01:33 +0000 (UTC)
Date: Mon, 8 Nov 2021 11:01:32 +0100
From: Petr Mladek <pmladek@suse.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 5/5] powerpc/ftrace: Add support for livepatch to PPC32
Message-ID: <YYj1fNkYAqr/H/I2@alley>
References: <cover.1635423081.git.christophe.leroy@csgroup.eu>
 <b73d053c145245499511c4827890c9411c8b3a5a.1635423081.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b73d053c145245499511c4827890c9411c8b3a5a.1635423081.git.christophe.leroy@csgroup.eu>
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
Cc: Joe Lawrence <joe.lawrence@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 live-patching@vger.kernel.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Miroslav Benes <mbenes@suse.cz>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 2021-10-28 14:24:05, Christophe Leroy wrote:
> This is heavily copied from PPC64. Not much to say about it.
> 
> Livepatch sample modules all work.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> index 4fe018cc207b..daf24d837241 100644
> --- a/arch/powerpc/include/asm/livepatch.h
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -23,8 +23,8 @@ static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
>  static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
>  {
>  	/*
> -	 * Live patch works only with -mprofile-kernel on PPC. In this case,
> -	 * the ftrace location is always within the first 16 bytes.
> +	 * Live patch works on PPC32 and only with -mprofile-kernel on PPC64. In
> +	 * both cases, the ftrace location is always within the first 16 bytes.

Nit: I had some problems to parse it. I wonder if the following is
better:

	 * Live patch works on PPC32 out of box and on PPC64 only with
	 * -mprofile-kernel. In both cases, the ftrace location is always
	 * within the first 16 bytes.


>  	 */
>  	return ftrace_location_range(faddr, faddr + 16);
>  }

Best Regards,
Petr
