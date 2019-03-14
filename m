Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F18C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 00:55:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE31A2085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 00:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="TIiuGPRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE31A2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KVcb10SyzDqLf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 11:55:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="TIiuGPRf"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KVZT3ThBzDqL7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 11:53:34 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id u9so2738371pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 17:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=K11thIZxmNt9fMugDgK3Awc8dl/lwXPNdW2lxXs/fLY=;
 b=TIiuGPRfDG9rYm5tL5wIv67p4cfPfVcaHJZReBlFxT4ogfaYTOehaod0TFWrP3U86f
 wlltIVZs4dFr9cT9kG14l30/JZi2KPbGcR4iYXR32dOd/35Fv3dV4U64MFNqUKUVbBDf
 /KhtFrCOqNrLNnJvAplu1hi9YVhaQeobzkszA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=K11thIZxmNt9fMugDgK3Awc8dl/lwXPNdW2lxXs/fLY=;
 b=Tlk8TPESLe3XwuA+ThcnhAC47YBnF8P5Fq1J1vF7Fonbu0SJ4aUakg3qeiIZ5PLA5U
 05di4ab/v3bTbBHcOFs9FgwYELwu2xT4d0L3kqEjB2Uh3E3EL27LzztGecZvle/U7kmo
 sk71WjVJnEt/l6/HbUjhkieeC+UMlA4W03+2iRrJlb7hr1wbTlfUiApZ5OIDdlUwppvX
 UaMMrwc/agKkJudK8I0Xa/GhodIjywG2oWYe15jmyCZygNqXUArgoxFtjbjZRv3dXk8D
 BP/Cya7hVh/5LPupFpPQEcnCX2uixW+WeoqegUkI+UjWoEzwdc/Q5LZiwzTsKayjICLT
 WngA==
X-Gm-Message-State: APjAAAU+ouQr64qICKtlmU5SlLCSlhEJzhiFQbkmPuug1XWUuCjIf1Ti
 f6QfoNM5nUiRqRz1h4LMEAGUVQ==
X-Google-Smtp-Source: APXvYqyc834u9MoIPvajZWU3C2E+ZTOCEpZr59tseUn6RqTKV+XioMWD4Y8ln5KSGbBeCMtefiN1NA==
X-Received: by 2002:a17:902:e192:: with SMTP id
 cd18mr49544659plb.309.1552524811482; 
 Wed, 13 Mar 2019 17:53:31 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
 by smtp.gmail.com with ESMTPSA id p187sm8701035pfg.64.2019.03.13.17.53.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Mar 2019 17:53:30 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: BUG: p8_aes_ctr randomly returns wrong results
In-Reply-To: <CAAUqJDuegy=zw3SwQ1UsV881DjLSvZ9X3joFt89HkBy7y9=7pg@mail.gmail.com>
References: <CAAUqJDtsx6Sdv=6xAb1VWWjDF08y8wh2nsAypR8_x_e99a1Uwg@mail.gmail.com>
 <CAAUqJDuegy=zw3SwQ1UsV881DjLSvZ9X3joFt89HkBy7y9=7pg@mail.gmail.com>
Date: Thu, 14 Mar 2019 11:53:27 +1100
Message-ID: <87bm2etgxk.fsf@dja-thinkpad.axtens.net>
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
Cc: leo.barbosa@canonical.com, Stephan Mueller <smueller@chronox.de>,
 nayna@linux.ibm.com, leitao@debian.org, pfsmorigo@gmail.com,
 marcelo.cerri@canonical.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Ondrej,

I can confirm this on a ppc64le VM, at least as far back as 4.18, and am
investigating. Thanks for the reproducer.

Regards,
Daniel
