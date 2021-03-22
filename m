Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCE7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 04:06:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC9261878
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 04:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC9261878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F3gtL190wz2y68
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 15:06:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=CMuTQNMB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d;
 helo=mail-pj1-x102d.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=CMuTQNMB; dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3gss5nKSz2xfy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Mar 2021 15:06:24 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id
 ot17-20020a17090b3b51b0290109c9ac3c34so7458835pjb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Mar 2021 21:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=MgSbLNOjzWTK+0uwZ7SzymSxTsdNF7f6+E7B6gVkrKw=;
 b=CMuTQNMBjDdzZq3E/C4fKIQ1FL3HDQTbcx6uFdPs25M6zPucIcArgN1lq33B/dcBjO
 MrZ5X7RLSa/VUfh2PhJ8yD8KZPpE2adivWcjqaN4QugKLiBq+CkJGh3KeB9audmasXbO
 ysQ9Hc3itPhikB/FAA7Po90KKKpxadTRVc/9x5CXf+8Ravi1Zo8KS2gawU65S+KhcBkx
 u5u3UMMymNQ1gNCz6vCAv14JmwdmzexXmLAwebBkNkF5ztJvLXn7Q/1OCj5f14uCvw1p
 RgUST1CF7BgNS7yIK/5WuIGN9GZjrQSuQZYgvRL7uWwRbZ4DUyczLCbZ12QkRQ//V/p5
 JqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=MgSbLNOjzWTK+0uwZ7SzymSxTsdNF7f6+E7B6gVkrKw=;
 b=r8fL/gcniBkVgbRR5ilfiBGegQqeNkfUdVjEl1nHdsgq9mlEdMzpV9EQVAlntNpRCE
 36+2qSeUnNivbyto2dyF/W7mRVrgEODz1nS/kowthTkcMBj9BXufdocJMLesAkqvk+g1
 lu/2jKEPDcm8A3Pd3gFRbWr4ihnGTQzdH6D6VPgPzkoELE4VBpowvtE7psEfDUerDQDP
 rEM5DJ9KEP6a3ueeCkJiUZkyofzNG2gAslju1zQQFswwlDy+Qj5S6hIsyXmR8bubmTx+
 NV65ciCNkOtpwOZ0z9zwmFqjNThTC8gEtGA6df9h4deDqGJSpA1N3pc4iFQvc0Qlbacz
 BXpw==
X-Gm-Message-State: AOAM531t3eipy7bRLQglIXSQp0rH6fD+L3eq4+hm6JSiGC21X1LPG6nV
 AGBLyydJPGjSXxz02TLC5YzGZaPG/lI=
X-Google-Smtp-Source: ABdhPJyd4INNrI9YdT3vXBq+7ZOGEmGLoNYV+8CvpsMVx97Rklb8MehDcUmn9iEp7JJJEl7rRqdbsA==
X-Received: by 2002:a17:90a:a10c:: with SMTP id
 s12mr11000599pjp.166.1616385982755; 
 Sun, 21 Mar 2021 21:06:22 -0700 (PDT)
Received: from localhost ([58.84.78.96])
 by smtp.gmail.com with ESMTPSA id t6sm11971114pjs.26.2021.03.21.21.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 21:06:22 -0700 (PDT)
Date: Mon, 22 Mar 2021 14:06:16 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 15/41] KVM: PPC: Book3S 64: Minimise hcall handler
 calling convention differences
To: kvm-ppc@vger.kernel.org
References: <20210305150638.2675513-1-npiggin@gmail.com>
 <20210305150638.2675513-16-npiggin@gmail.com>
In-Reply-To: <20210305150638.2675513-16-npiggin@gmail.com>
MIME-Version: 1.0
Message-Id: <1616385477.zdncmgsbmf.astroid@bobo.none>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Nicholas Piggin's message of March 6, 2021 1:06 am:
> This sets up the same calling convention from interrupt entry to
> KVM interrupt handler for system calls as exists for other interrupt
> types.
>=20
> This is a better API, it uses a save area rather than SPR, and it has
> more registers free to use. Using a single common API helps maintain
> it, and it becomes easier to use in C in a later patch.

On second look I'm happy enough with this.

It does add some hcall setup code back into exception-64s.S and removes
most of the "fixup" code that was previously moved into=20
book3s_64_entry.S in patch 12. But if you take patch 12 and 13 and other
earlier patches together they are moving most KVM interrupt knowledge
into KVM which is a good change.

Once that is done, this final one then gets hcall into better shape for
the C code. If anything this patch could go together with patch 12 but
I guess I ended up writing it for the C code whereas the previous ones
were cleanups so the ordering didn't come out that way. It won't be
trivial to move now so I don't think I'd bother.

Thanks,
Nick
