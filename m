Return-Path: <SRS0=hK36=HL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F95C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 02:38:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6126C64DE8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 02:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6126C64DE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DZRsY0d9yzDvXp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Feb 2021 13:38:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530;
 helo=mail-pg1-x530.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TibI077w; dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DZRq40qdczDsY8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2021 13:36:30 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id c132so11527828pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Feb 2021 18:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=3QXGdYBY4GlaQjWRP3AW5oVocz08MQfpEQJa46lCHW4=;
 b=TibI077wK5BoFL+D16v0ATZT2K15vnWdkA7lAPagP9SvPLXshPfC8RfEfTQEshqj26
 MjWiqpkoaiRkz/RG2GZ/R19LJ1rS+KzYf5UFwmZ/r3eUgYlJRB1+LysTYC2/Msk08tkE
 TaJ5U5riA8qILa/prHnY2a765knNriZA7zZ4vYTu98cL7L7eZ1OnIOIS3TSMCTJOTBRx
 PEbPXjOBhcHuXIue0yq8RjEtZTC1QE2eRuzBWlXRtc7jRnki+WZ/0DBplRshX3IqgoTi
 D09T9UiuK+iSfq7FhOdISj+tMfEPoqcY4VVaEwdlx7f3wcbl18mS+ehf9ebS14uK+ROc
 mbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=3QXGdYBY4GlaQjWRP3AW5oVocz08MQfpEQJa46lCHW4=;
 b=fNsy9uzEHUws1aOL0BzJ+8ZT/4ptRWgLd9xf/8F2OoTyMfeLA+W4h9RQxPGgBXL/Ic
 tsknFRKdZ27PVZPLiA3T6k6e8gxTGAg/eiPc4AOtZZz1vMlQqZGxuumzddu0fgpGt6qG
 yjW6Q17Hbg4QUui55thVWroFpyv6Oic+bTEQOZ1h103fjhitQgeiqvEMViRF0+UyuvJw
 3UVWUzLlkuMT8KgywMwlCbWpxSpOdc+6aT2uSch9BOLwknNEI1gG6fCB9TLqzY4B+3qa
 2XEISbBuKBnvbXRifa+l/BoJWrsO7fUMdfDO59csTm45kg5ct/3PEKxNxeZ2TG4QENzE
 Tl5A==
X-Gm-Message-State: AOAM5327LOVMVVqXkCgvnkD9jrYyl4IpwpFMV3/BXT6Sm3GZPgvHjTnV
 YHxtggR6mV265Q2bXDNW0WY=
X-Google-Smtp-Source: ABdhPJzPMPSomATF2ZyD4YSYOSlDzTQHBwvjPuxeoN6W3R/OWYq87nM9LvDS8uYPAZg7XCUdbR0vMQ==
X-Received: by 2002:a62:cd:0:b029:1d5:da40:abf8 with SMTP id
 196-20020a6200cd0000b02901d5da40abf8mr20272668pfa.60.1612838187168; 
 Mon, 08 Feb 2021 18:36:27 -0800 (PST)
Received: from localhost ([220.240.226.199])
 by smtp.gmail.com with ESMTPSA id 71sm6599001pgh.55.2021.02.08.18.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 18:36:26 -0800 (PST)
Date: Tue, 09 Feb 2021 12:36:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v5 20/22] powerpc/syscall: Avoid storing 'current' in
 another pointer
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 msuchanek@suse.de, Paul Mackerras <paulus@samba.org>
References: <cover.1612796617.git.christophe.leroy@csgroup.eu>
 <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
In-Reply-To: <24804747098369ebcdac38970b8f7a1260bdd248.1612796617.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1612838134.rvncv9kzls.astroid@bobo.none>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of February 9, 2021 1:10 am:
> By saving the pointer pointing to thread_info.flags, gcc copies r2
> in a non-volatile register.
>=20
> We know 'current' doesn't change, so avoid that intermediaite pointer.
>=20
> Reduces null_syscall benchmark by 2 cycles (322 =3D> 320 cycles)
>=20
> On PPC64, gcc seems to know that 'current' is not changing, and it keeps
> it in a non volatile register to avoid multiple read of 'current' in paca=
.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

What if you did this?

---
 arch/powerpc/include/asm/current.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/current.h b/arch/powerpc/include/asm/=
current.h
index bbfb94800415..59ab327972a5 100644
--- a/arch/powerpc/include/asm/current.h
+++ b/arch/powerpc/include/asm/current.h
@@ -23,16 +23,19 @@ static inline struct task_struct *get_current(void)
=20
 	return task;
 }
-#define current	get_current()
=20
 #else
=20
-/*
- * We keep `current' in r2 for speed.
- */
-register struct task_struct *current asm ("r2");
+static inline struct task_struct *get_current(void)
+{
+	register struct task_struct *task asm ("r2");
+
+	return task;
+}
=20
 #endif
=20
+#define current	get_current()
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CURRENT_H */
--=20
