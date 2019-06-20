Return-Path: <SRS0=+cnT=UT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05898C43613
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 01:48:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC5C214AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 01:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtIMmeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC5C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Tl7y6hgGzDqrn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2019 11:47:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=sjitindarsingh@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iwtIMmeI"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Tl525MfDzDqrV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2019 11:45:25 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 19so680871pfa.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2019 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3rH4Li7iQpV2NhLM6R10n6Rmb0Kzzsbup8BQ7TSxMNU=;
 b=iwtIMmeIJr/cVxE3WxYjZrIBVtItI9+cJkvTm/V2qUz+gSDLgMDlsFlakN/liAj6UP
 vTnVse3C+Zb6iPCkWTFoUZ/vRV7GfEd8BBSZQnyekicM0Bo0Iepkg6Cb9bdZjXDYlMcS
 K2U0CNMUdr+8X1DG2Zw2z1Y568j7zu4EgtRmW/zH3k3KORFFMDPL3a1Cp6/8yppUkC7S
 J3rc6HgY6mhVZa3t8SFDIVXsqDiUQ7cvClS0d43HDUt5L28IHFmqBedo/3qLZkDzoOSl
 JGbm6mvKONrTtgqxwLC1WCMFjYQEnjrIL9XyfAgA9mXCeKD3/DWczpPrJFCPh0+g42i/
 CkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3rH4Li7iQpV2NhLM6R10n6Rmb0Kzzsbup8BQ7TSxMNU=;
 b=ouDJ2OUupKZauel/XErZS8nb7HIexRVwlLMUpRN8GT4YPtc4TwxyPIB204tUTOumXT
 6gst3ehw/BBs1fu6HxHwF5qF1llEBB6JAJCh21VdjsmIb/eeHf1PM+ylMy7emHI2S4CY
 uML21TXnNYelA4alIYRhDTn3KG9TBEm/n/DIdpvsyVhpPWtunepiA+e7YWjGWq9NMVTQ
 dybaInx2Vvg3N+xzOhYmDZNuaEohR9ttXkqK7ipRs4QDs02mOwQXQu/PvfxAl4FCk+OO
 8WQLSpR/ye30KhqGG3PlQvqsGSA1HIvbVYpoZNsw58AbGev3aCGtacbhYB38Uftonelo
 uKCA==
X-Gm-Message-State: APjAAAUcf83X8Piu7MQDmh0CqpEZlgxJn6F/Ylnds2gqYRICCIdW/Bon
 W5MEx64TXiOQidqzs+cmuZU=
X-Google-Smtp-Source: APXvYqy304rXbVDnxHEwwjd5Cdhw7PS0colGaO5tqp7nM5MG7oxwiK0IgzAtTMcf04uXEMXJRDke3Q==
X-Received: by 2002:a65:5c88:: with SMTP id a8mr10317050pgt.388.1560995122055; 
 Wed, 19 Jun 2019 18:45:22 -0700 (PDT)
Received: from surajjs2.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id y22sm39926754pgj.38.2019.06.19.18.45.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 19 Jun 2019 18:45:21 -0700 (PDT)
Message-ID: <1560995116.4771.1.camel@gmail.com>
Subject: Re: [PATCH 0/2] Fix handling of h_set_dawr
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, 
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 20 Jun 2019 11:45:16 +1000
In-Reply-To: <87e219c8-1db7-9976-03ce-5a566a8df7ab@kaod.org>
References: <20190617071619.19360-1-sjitindarsingh@gmail.com>
 <87e219c8-1db7-9976-03ce-5a566a8df7ab@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: mikey@neuling.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-06-17 at 11:06 +0200, Cédric Le Goater wrote:
> On 17/06/2019 09:16, Suraj Jitindar Singh wrote:
> > Series contains 2 patches to fix the host in kernel handling of the
> > hcall
> > h_set_dawr.
> > 
> > First patch from Michael Neuling is just a resend added here for
> > clarity.
> > 
> > Michael Neuling (1):
> >   KVM: PPC: Book3S HV: Fix r3 corruption in h_set_dabr()
> > 
> > Suraj Jitindar Singh (1):
> >   KVM: PPC: Book3S HV: Only write DAWR[X] when handling h_set_dawr
> > in
> >     real mode
> 
> 
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> and 
> 
> Tested-by: Cédric Le Goater <clg@kaod.org>
> 
> 
> but I see slowdowns in nested as if the IPIs were not delivered. Have
> we
> touch this part in 5.2 ? 

Hi,

I've seen the same and tracked it down to decrementer exceptions not
being delivered when the guest is using large decrementer. I've got a
patch I'm about to send so I'll CC you.

Another option is to disable the large decrementer with:
-machine pseries,cap-large-decr=false

Thanks,
Suraj

> 
> Thanks,
> 
> C.
> 
