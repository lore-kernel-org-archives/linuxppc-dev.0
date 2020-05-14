Return-Path: <SRS0=AY7V=64=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C78C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 01:44:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA44A2054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 01:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh37iuu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA44A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49MvVW3JQHzDqkf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2020 11:44:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::342;
 helo=mail-ot1-x342.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Kh37iuu1; dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49MvSj18y9zDqdq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2020 11:43:17 +1000 (AEST)
Received: by mail-ot1-x342.google.com with SMTP id 72so1139264otu.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2020 18:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zVUkgSM73lmqJbHczRsbUUg5ns/nYOpsW20Qn/wMO0I=;
 b=Kh37iuu13AG+SpyK0iKTyFGQ4bQ8GpFlm3I6PdJX9RuMLZz/RZq/EhXHDDsmkr/tq6
 YUGZaNPxV/pwKYLKxZwXfoc5xT9Dg0XZVlkIFU9Q3PBXpoGj2rd5XwTNKPPkLo3Gsbk9
 oG6AlGkbzNfMT/L/GML5IbAjhjZmw4StmG7dxuVfNT8tLeXB8FVVUn61QNtq8tDsxVfP
 B4P4BQrZSoAJB6z7hex8MY+uxST2mx99r+BU/KiRM+S13o1RvRGQ1scGIQN9xWB8vB4Z
 6NiD0Gfxq2okWCLBFIhSi6noE3Jhk3443PnBpq7Vwd7wMqyh8H86qsSvJ7D2qJMlpojW
 ng/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zVUkgSM73lmqJbHczRsbUUg5ns/nYOpsW20Qn/wMO0I=;
 b=Wz66hwXXov0ladDT5+xKjKG1CzDenq/8q/48PSuHLE/svZt4ypvSVrh3otmPgWQGDJ
 wtRgtYtwFzpY2esC0Gway5SYuU0NwLo9sag8lvLrR/xsFZ4cgsgcgBNigMrB7roTAuQw
 XFaziej8ERrrjp0EHLrdlXlw9dgx0yB1F9lv9/BHxg2XTUUu6xecEgztkiJDwuZ8ommO
 o4d8nMwfxFBd2Nn+2zvDeR2Y/5lg2C9F/RgJJ4wTs7XF0NH15GOpyjwJDfu1IT/T/ul4
 Jo/TfBf5S/9xGjkb5L/z/lNeUD0JDcTeRyk5tStgjItDcDKt/s3q2ZS/9O4Pl8jXFQog
 xGZw==
X-Gm-Message-State: AOAM532TCOvrg/Pc9uDryy5pB7uDsNZ+Z74gkrpTu3fNoOGrd4GUXRBj
 /7nweSG7r7tniyaJPZ18lvc3xggLQhmDIHuxXYM=
X-Google-Smtp-Source: ABdhPJw9JQt1zr75S9s0QnxUSiBL92gmiFqp8oLIqO+IjBpfEyMAoSQlA4ZuTY8Swc5iikttJn6JGX7qz0RSIs7wN4k=
X-Received: by 2002:a9d:784b:: with SMTP id c11mr1922905otm.28.1589420593840; 
 Wed, 13 May 2020 18:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-17-jniethe5@gmail.com>
 <878shvc40x.fsf@mpe.ellerman.id.au>
 <CACzsE9od2GFXBiy5imy_dGutx7POOnCx7+k-Ynx+UMcNzyTsTw@mail.gmail.com>
In-Reply-To: <CACzsE9od2GFXBiy5imy_dGutx7POOnCx7+k-Ynx+UMcNzyTsTw@mail.gmail.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Thu, 14 May 2020 11:43:02 +1000
Message-ID: <CACzsE9qLm47jufaVa9H553DhkNt6cTFYNRhijxD2UEn-_7Pyuw@mail.gmail.com>
Subject: Re: [PATCH v8 16/30] powerpc: Define and use __get_user_instr{,
 inatomic}()
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Alistair Popple <alistair@popple.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Balamuruhan S <bala24@linux.ibm.com>, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi mpe, could you please take this.

 arch/powerpc/include/asm/uaccess.h | 3 +++
 arch/powerpc/kernel/vecemu.c       | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h
b/arch/powerpc/include/asm/uaccess.h
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -105,6 +105,9 @@ static inline int __access_ok(unsigned long addr,
unsigned long size,
 #define __put_user_inatomic(x, ptr) \
     __put_user_nosleep((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))

+#define get_user_instr(x, ptr) \
+    get_user((x).val, (u32 *)(ptr))
+
 #define __get_user_instr(x, ptr) \
     __get_user_nocheck((x).val, (u32 *)(ptr), sizeof(u32), true)

diff --git a/arch/powerpc/kernel/vecemu.c b/arch/powerpc/kernel/vecemu.c
index 60ed5aea8d4e..ae632569446f 100644
--- a/arch/powerpc/kernel/vecemu.c
+++ b/arch/powerpc/kernel/vecemu.c
@@ -266,7 +266,7 @@ int emulate_altivec(struct pt_regs *regs)
     unsigned int va, vb, vc, vd;
     vector128 *vrs;

-    if (__get_user_instr(instr, (void __user *)regs->nip))
+    if (get_user_instr(instr, (void __user *)regs->nip))
         return -EFAULT;

     word = ppc_inst_val(instr);
