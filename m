Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6589C282C2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 02:03:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D1B2146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 02:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3SKHIz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D1B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wdkv50KdzDqV6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:03:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wdhm32tJzDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 13:01:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="t3SKHIz8"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43wdhm1jmfz8t1F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 13:01:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43wdhm0wb2z9sMx; Fri,  8 Feb 2019 13:01:44 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=sergey.senozhatsky.work@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="t3SKHIz8"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43wdhl26f8z9sMl
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Feb 2019 13:01:42 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id s198so873723pgs.2
 for <linuxppc-dev@ozlabs.org>; Thu, 07 Feb 2019 18:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rCXYuL2yAB+lK2US45/0mGxsgwjtq+ulyYDwTWv61C0=;
 b=t3SKHIz8BoD7qGbeZngs12TnU5mv/oLSbdc3Aa4Sy5LggK3MnB3vo20Wgn/o/cg98k
 60NDhIa35S38Duzo9bU4OjSFSG7A8G3CtfRtFlF3MtpfteAtnbgENz0TZlv2GGP+pCJT
 LnA6Ne57lzA8S7HJpc83udB2BNF/emDruyTW31yikjUkh+/ITkE7c8cpFNmFoJiJBuFl
 Pwe8PtHUg6XbGhqTolyhZO6vEn7EZhkMYRI9xUQc3CFbbZPfwFZECmeiPDGsjtYd8+xa
 wgYmeyFW/5NonKtjaLD0dyUp/BslcoGtsrUAsxWRNOkhl9w/0T9mbuwDy+q2Tqh37YhW
 Xtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rCXYuL2yAB+lK2US45/0mGxsgwjtq+ulyYDwTWv61C0=;
 b=qGY0EvjIRaCZmvObuJqPzkn1U7SqUuVFSyVpmfCSskU7+QaLSIP0ED2mwdXSEEZ9Z1
 wuQ3cRVMRibyGFC7u3x84FZDD7elwCohQZXWu9rtjx2cDIyaMWxhZ0K6sTXj02WhIlHC
 T9gj9eMU8FvIw51pk5+OAvO0dbPHXACRm2zRYQvjh1k0IwwqdFdW8lB+yl5DKftRQJ1C
 quUm9fpDaaBnsywB33VAmQz+dTOPR/VILprxN7xw6PtieLklrOWsstbdxN43mQpsaIxu
 sn2uNVNYkpcFuUX4vunEOu/aLQ5eEPS8WFmB+X2/KkyFCqEZcW7xxqKPsMvRJGKTD/I3
 zVBQ==
X-Gm-Message-State: AHQUAuajE5PyLo0qXqK/XEURycmf2jotQs/usT2gvYNjvMrlSr+1+iNt
 uW6KrZyoFXiIE5QK2fhrKiY=
X-Google-Smtp-Source: AHgI3Ia3XMfxae7D9RdSp4kC4yA9+lfsmjUeA4uj2E54LxMcvUG1ISZrl0dFGrEqvsX9Bjqbzxa4Og==
X-Received: by 2002:a63:ce08:: with SMTP id y8mr13032128pgf.388.1549591301268; 
 Thu, 07 Feb 2019 18:01:41 -0800 (PST)
Received: from localhost ([110.70.55.31])
 by smtp.gmail.com with ESMTPSA id q5sm588767pfi.165.2019.02.07.18.01.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 18:01:40 -0800 (PST)
Date: Fri, 8 Feb 2019 11:01:37 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190208020137.GA22600@jagdpanzerIV>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207124635.3885-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linux-arch@vger.kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@ozlabs.org, tj@kernel.org, akpm@linux-foundation.org,
 dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Cc-ing Steven

  https://lore.kernel.org/lkml/20190207124635.3885-1-mpe@ellerman.id.au/T/#u

On (02/07/19 23:46), Michael Ellerman wrote:
> Arch code can set a "dump stack arch description string" which is
> displayed with oops output to describe the hardware platform.
> 
> It is useful to initialise this as early as possible, so that an early
> oops will have the hardware description.
> 
> However in practice we discover the hardware platform in stages, so it
> would be useful to be able to incrementally fill in the hardware
> description as we discover it.
> 
> This patch adds that ability, by creating dump_stack_add_arch_desc().
> 
> If there is no existing string it behaves exactly like
> dump_stack_set_arch_desc(). However if there is an existing string it
> appends to it, with a leading space.
> 
> This makes it easy to call it multiple times from different parts of the
> code and get a reasonable looking result.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

You probably can have a __init buffer somewhere in ppc code, append
data to it, step by step, and call dump_stack_set_arch_desc() all
the time.

But no real objections; dump_stack_add_arch_desc() can do.

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
