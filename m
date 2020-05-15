Return-Path: <SRS0=TkHQ=65=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A5CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 07:49:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0462206F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 07:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaAqnnL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0462206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49NgYC5lRkzDr1D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2020 17:49:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::344;
 helo=mail-ot1-x344.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vaAqnnL6; dkim-atps=neutral
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49NgWN0KmSzDqvp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 17:48:15 +1000 (AEST)
Received: by mail-ot1-x344.google.com with SMTP id z17so1219361oto.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2020 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uOqXP70KUX5ATxXM5WrDTw/0ik/z8y8XvdLCYLjUIis=;
 b=vaAqnnL67qaI1oZWR4mWHpPf1DFxNqQdGxyTeJrPAgVJxMDBPxwOH0BltCunuYdX1Y
 beigLWvTZYBCqyO1ZgB4MJ3sV6alA+YVmsDMGsIwqRWkxydCV3VfEG2YwyqWdVuxp6aq
 SV7U2NDyU9IMEwDrWVyEE8aDvp5ctEobfGt/tIDG5QppYPT28M00oY1q35xtI0PLLB55
 akbkCXMXexiKaWutkRIMVM0/aIRJFq6ZZmdvsd8ZbTTULtVJ1r5hAYzhrMQEMbiGxl+t
 AMPAw0U/ez3lxBEzjURJ3RNV9XS6modXLt0uWf6jnTQOZU44f2BecjH2gQFS9QHI+2hj
 7QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uOqXP70KUX5ATxXM5WrDTw/0ik/z8y8XvdLCYLjUIis=;
 b=sY7r0kIuiV2ZI4RYr/gjXUILpRz90P5t0viwgwWTlHNV3udqRotcO84AusZrKgll7e
 ypN72cMj5FL6v2ER36VKWip+GUFDDy+3Mu6S8FHpKQ5HGUiJjRXC7MISPzRqtLJYWJYP
 olo5HnwYi0ulLdvrGs/bjWkT4Iop05gnv4JFcGz8qdHk4wDLbyE7OZfrt0arSJLqEcdc
 fMy9mJ20wm9voeAZgamhZv1/DZyDcaAXwMjcKjDsVO549OUL4h+DjGIZREO4P1KCOnBe
 T/PcWhhG1U3PUdBDzkvc0pTM48e54m78WgUmyMOEAmAIE1cOQVru0uitw0wDYzxk3DdV
 gRqA==
X-Gm-Message-State: AOAM531yb6nqqFmpXm5ymZMzGJRpRuMzX+vRWkzcn/wWzQCWNXxtlUjj
 e+Q9T/0yvod7xQJXvo9vwESDI3YQcpb2eWgMUZO50jbEEEM=
X-Google-Smtp-Source: ABdhPJxHylj7KiLPlLODb0raDWnVFJN7JEatqc7/KQWmYGw2hDm4KGTOtoEuzbRk8IDFhCbvBA8LImiEEKueUuQrjVw=
X-Received: by 2002:a9d:784b:: with SMTP id c11mr1426721otm.28.1589528892383; 
 Fri, 15 May 2020 00:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200506034050.24806-1-jniethe5@gmail.com>
 <20200506034050.24806-9-jniethe5@gmail.com>
In-Reply-To: <20200506034050.24806-9-jniethe5@gmail.com>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Fri, 15 May 2020 17:48:00 +1000
Message-ID: <CACzsE9o0DNZ+fwO4Zh-oUp8B+zMukXAr_bicCi0V5PYcnJO7_A@mail.gmail.com>
Subject: Re: [PATCH v8 08/30] powerpc: Use a function for getting the
 instruction op code
To: linuxppc-dev@lists.ozlabs.org
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
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

mpe, as suggested by Christophe could you please add this.
diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_INST_H
 #define _ASM_INST_H

+#include <asm/disassemble.h>
+
 /*
  * Instruction data type for POWER
  */
@@ -15,7 +17,7 @@ static inline u32 ppc_inst_val(u32 x)

 static inline int ppc_inst_primary_opcode(u32 x)
 {
-    return ppc_inst_val(x) >> 26;
+    return get_op(ppc_inst_val(x));
 }

 #endif /* _ASM_INST_H */
-- 
2.17.1
