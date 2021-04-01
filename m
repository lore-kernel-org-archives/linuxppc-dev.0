Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08233C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 09:49:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4113761057
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 09:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4113761057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9z1Z5s6Kz3bwG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 20:49:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=FIEsx+En;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=FIEsx+En; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9z174sjyz2yjc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 20:49:31 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id
 lr1-20020a17090b4b81b02900ea0a3f38c1so4471045pjb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=LWrLsc7U/Y59RvQVrIOPJZyoQyt2UXhRFGQ6YveYHww=;
 b=FIEsx+EncqLUUJj9AjtyYn3npxPJJollHq6dZ56xEFFvX53Z8iHWgUCb8JqqcgSUSs
 PjPzwePxZHLRi269igCb6iVW4e00T56HvL7cZdP+dIL+eU+funRd//JeHZQLTNmpAwzP
 mlwDeIiBq8qrjSVWYqa11U2dUH0jgISgxL7QcXYWJjF6FzZljBYMhb1myHJNzq7ZcnKe
 so3NBZpu26MkGF6tQXhuZk9qhXVcfS8GVr8z4FKEyGgyYchKWMlWCPcloOLC42HcDQK4
 kiPNIEHPZBClEcojcEw/KYOOiFYJ8bxEoxYxY4ekkgrgqcmKDIHBa7k1BOTHmHWM1SKZ
 z6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=LWrLsc7U/Y59RvQVrIOPJZyoQyt2UXhRFGQ6YveYHww=;
 b=tBJdWz7t0+Frq3koUmzZ3TEcjS87D4djuWntDWYKd1hwsITh+qeRBBae22+gQaqSUw
 6z3DQG9A0p8FnI74rUFBaZZCmG2n7EoNRsQfHkpmH9d1nMopsE3Xi8qdmbMHj7gyPgtY
 EyUS5DDga+f3Npv20UNZ79kxZJ9JHqqZD61wFsDkVObLp5SkM3Lk44lk75n4N33y6rOz
 1jachs/7+awQW79WYspJJLrrBBLs7r4/bOm+4kV/B7MQXzcaZSCkfbGKV0KSA/w9XAG0
 4gZXfFf6JUL06Rv61IcFljrAt0nltGzGoEUWfSOBpa0zjps6J1qNC98I4pM1eW0K+ffg
 Yr1w==
X-Gm-Message-State: AOAM532VMgpaRLKUUVy02kyjm57iufGxX3pj9q5efVfR4U1JQEoKDIY3
 uRU01nw86IgHoNcI7aP4LTg=
X-Google-Smtp-Source: ABdhPJyoham8uTT+KgHOmDWwfrW4nRhuzu5ssWNL2ldPpSoB4ofe5HKDsyD/SvBLKfDeqyditEt7aA==
X-Received: by 2002:a17:902:23:b029:e7:32b7:e760 with SMTP id
 32-20020a1709020023b02900e732b7e760mr7069600pla.55.1617270569806; 
 Thu, 01 Apr 2021 02:49:29 -0700 (PDT)
Received: from localhost ([1.128.219.229])
 by smtp.gmail.com with ESMTPSA id gz12sm5099146pjb.33.2021.04.01.02.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 02:49:29 -0700 (PDT)
Date: Thu, 01 Apr 2021 19:49:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 11/46] KVM: PPC: Book3S HV: Ensure MSR[HV] is always
 clear in guest MSR
To: Paul Mackerras <paulus@ozlabs.org>
References: <20210323010305.1045293-1-npiggin@gmail.com>
 <20210323010305.1045293-12-npiggin@gmail.com>
 <YGQBdVntWnG/ewtj@thinks.paulus.ozlabs.org>
In-Reply-To: <YGQBdVntWnG/ewtj@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Message-Id: <1617270525.5034ks2srs.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Paul Mackerras's message of March 31, 2021 2:58 pm:
> On Tue, Mar 23, 2021 at 11:02:30AM +1000, Nicholas Piggin wrote:
>> Rather than clear the HV bit from the MSR at guest entry, make it clear
>> that the hypervisor does not allow the guest to set the bit.
>>=20
>> The HV clear is kept in guest entry for now, but a future patch will
>> warn if it's not present.
>=20
> Will warn if it *is* present, surely?

Just making sure you were awake, definitely wasn't a copy-paste bug...

Thanks,
Nick

>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Acked-by: Paul Mackerras <paulus@ozlabs.org>
>=20
