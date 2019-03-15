Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D286C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 01:29:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEAA21872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 01:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="F+732QtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEAA21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44L7Jz0SPbzDqRW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:29:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="F+732QtM"; 
 dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L7Gh1DbgzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 12:27:06 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id a3so5073121pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 18:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=0Wlef7QlJVRBWt94bY3O0T0yq0oH1GDzoCO3EpkQNTQ=;
 b=F+732QtMoBzCT63zkmlyoqY9YGDTFXA/U8bWwR3haWtl5BaqGeEO/a/sw2BvAp2Hwp
 DBMHb/W4SQ/6Ykg6/DBbfp6PiGfbgZpU0O3t3lWZJAgzdvgRtdfQtIGw+hqoTyIkzQsq
 n7wJnYbtUmTHxgtGycZIK3BUd5mcjCofK/Wdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=0Wlef7QlJVRBWt94bY3O0T0yq0oH1GDzoCO3EpkQNTQ=;
 b=qowvuYirBRfH6y+y/I7IEOChmYwvLNNQCclGmTNy6JcoTJiNX8p9UeB2brZoMfFi3C
 zwjhhOUPVbiu2j2lA7VuiUfYJDCel8p6tdIWPs8PTUCrbwHam199T+iFz0QTlSRPZG5c
 wcgqJX7JmfM2jAAG9S8mA6JZzRSSJMSPUJxPKnlrU7LkYAeCzp0cCIYitQyOzLC9EcIU
 yyZbKVtnXZpbRm9F9FjuezIcu372jtg+rYqxJlgNsINdXOsWBEVoNxJgOpr4afIhxKnX
 55+43n3M6DvA1trMvRS4f3FIqHE3M5A6rg+GJeuXdeaY6dgZ8VaGYx/D8nb7UVd3LwDY
 sr3Q==
X-Gm-Message-State: APjAAAX3+Tk/fr1QNrzoeAlc8gSgz7IFSCu3jhb6mY00Z9F0DB6jxYp+
 NYVgr27/Rm/8/2xREUjhMOYOTw==
X-Google-Smtp-Source: APXvYqwZY3/PkTVn1luNO/pBnSC/DG7EX+foGnzMJsvwOjZca2d88oNOrgHhxkB76IW3GbmUGhVxJw==
X-Received: by 2002:a62:54c5:: with SMTP id i188mr1292962pfb.188.1552613223946; 
 Thu, 14 Mar 2019 18:27:03 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
 by smtp.gmail.com with ESMTPSA id v9sm440373pfg.130.2019.03.14.18.27.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 14 Mar 2019 18:27:02 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: BUG: p8_aes_ctr randomly returns wrong results
In-Reply-To: <CAAUqJDtsx6Sdv=6xAb1VWWjDF08y8wh2nsAypR8_x_e99a1Uwg@mail.gmail.com>
References: <CAAUqJDtsx6Sdv=6xAb1VWWjDF08y8wh2nsAypR8_x_e99a1Uwg@mail.gmail.com>
Date: Fri, 15 Mar 2019 12:26:59 +1100
Message-ID: <878sxhsza4.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: marcelo.cerri@canonical.com, Stephan Mueller <smueller@chronox.de>,
 leo.barbosa@canonical.com, linuxppc-dev@lists.ozlabs.org,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ondrej,

> When I run 'rmmod vmx_crypto' before running the reproducer, I get
> only one (correct) checksum, so this is definitely a bug in the
> driver. Other ciphers (cbc(aes), xts(aes)) are not affected, even
> though the glue code is very similar. That leads me to believe the
> problem is somewhere in the assembly code.

It appears that under certain circumstances, aes_p8_ctr32_encrypt_blocks
changes walk.iv. If this is done when
  while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
is not in its final iteration, it will corrupt the future blocks.

I am not yet sure why this is. Clearly it's pretty late in the assembly
because it doesn't seem to affect the blocks being processed in that
call, only future calls.

Saving and restoring the IV makes the test case pass.

I'll have a look at the asm.

Regards,
Daniel


>
> [1] http://github.com/smuellerDD/libkcapi
>
> Cheers,
> Ondrej
