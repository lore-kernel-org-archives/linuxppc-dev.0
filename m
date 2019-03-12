Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC23C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 20:20:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1285F2171F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 20:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIXRUEdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1285F2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JmYl2cDHzDqCs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 07:20:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RIXRUEdj"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JmWl0dCPzDqCs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 07:18:40 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id a188so3961464wmf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 13:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NRhLG9kD6ihow+ahvLjtKp4GeQpYxn43CZtd+gLsH6U=;
 b=RIXRUEdjPhbE/WvsJoiw3+oGVuS2o/VuI6LtlNbxpWnbZhGtfosJxck2cTRXjAqcDn
 XA+HtzDTrvH11USp7MteV5JTfboJf8knzCdxIBXjCl7qQxYWh+xOXo+TedkyXQdYB293
 g0cQgIKxhWREI9kpORg7L2jaaU8vkoZujQKtD7FdlmAoM5cWxeqiPGEsD+zLABUzmSjn
 jgbkzhoPiqxENW+pXrhPLZFKIW2vrVs6IbI4/dWGpmyWw+/7Uk2AbABXhUQf4nHhsu4i
 d47yTpb6o9yAOPc4DeJ3/R+aOwGvifijAeW5Cb4pjztVB47IZijTQgUHMtVTCZzU6Xy8
 4D9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=NRhLG9kD6ihow+ahvLjtKp4GeQpYxn43CZtd+gLsH6U=;
 b=CUCKK14iBEGbFzCeLn35McZfOgHRChPVAQH2vrIUNlDyImX5wfJwvslZ0gqZUcPVal
 t+lANXbYTuegPc1K4VuyzliOfz0qQjVe/feLX9tTXKHbK9WSWNbbXuptuowF2bFizb0w
 9LEcg0quwBBbND6hl2DajCUHccg9RxrReOENLnwND4fl8UQHUH+ptofxtVx7OLWT7Q89
 iGA9Wqb9I2oM8AGeSp2vDSXjy8EhoX+f8kvEmmuoOz4br39HXpbvZRGeCYf9O9n5tUJv
 M3QR0taZBb5hyo3JPsWnLW/+AgGG+khZgI73ih4VkdzFLlSPQ7qivFGylf2TcEmuZCMm
 YHTw==
X-Gm-Message-State: APjAAAXhyOx1MQFVwyQSEVvymjwbqolQyIJFiwpOJHDllnJ9gIZ9UJhU
 ciRT+uLcvb2+9dbDDMSAwdI=
X-Google-Smtp-Source: APXvYqx96DiGXjumB1OWz2N30REZQpqUqbZ+wkVG4Rnxt+rF5+di4QS4fKygcOYXpZo+5D6uRuKRZA==
X-Received: by 2002:a1c:2283:: with SMTP id i125mr3601107wmi.24.1552421913609; 
 Tue, 12 Mar 2019 13:18:33 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id u17sm31080380wrg.71.2019.03.12.13.18.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Mar 2019 13:18:32 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id 0A3E4114655E; Tue, 12 Mar 2019 21:18:31 +0100 (CET)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/64s: Include <asm/nmi.h> header file to fix a warning
Date: Tue, 12 Mar 2019 21:18:23 +0100
Message-Id: <20190312201823.29371-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Make sure to include <asm/nmi.h> to provide the following prototype:
hv_nmi_check_nonrecoverable.

Remove the following warning treated as error (W=1):

  arch/powerpc/kernel/traps.c:393:6: error: no previous prototype for 'hv_nmi_check_nonrecoverable' [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/traps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a21200c6aaea..1fd45a8650e1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -71,6 +71,7 @@
 #include <sysdev/fsl_pci.h>
 #include <asm/kprobes.h>
 #include <asm/stacktrace.h>
+#include <asm/nmi.h>
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
 int (*__debugger)(struct pt_regs *regs) __read_mostly;
-- 
2.20.1

