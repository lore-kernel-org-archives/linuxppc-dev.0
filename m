Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF3C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 03:24:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3E82081B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 03:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swKk85D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3E82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434Qws1JyGzDqnn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 14:23:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="swKk85D/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=radu.rendec@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="swKk85D/"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434Qt2655czDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 14:21:27 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id f6so18831332iob.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=yuiuzUQZJJzdQCN81LL4oR1IBglKaKSKJBR+JpDtjH0=;
 b=swKk85D/vuT2waND0dNxTnO7c3vqwH7M0ziCPicH+msjBmyuRLtfONeIy7ISFbb3d+
 8EwCd1AgzQCL6rneocS3XHnqF9A7AUDB1i0COi1mZ5C8X2aLT7JNqLmLTjK2wrOhkJc3
 0adWyHEZ63P/2ONdvra5U2lnt1FXDZGAfsGONIz0aYgwDt1xOUDaCOC/pcFw/fmpQ/Pj
 dlfeQV/ANGVI9AeNdXDQudoc46qDBi0AD2OJfrHPIPQMZfmsdszSkum/m8ECy75tjTFX
 7TcXaGCji1e2Rrw/8XUSiFZqCKZdVYU1CWjjIy5rcRQOlM8pFS9a4AaHaGVg5kyGNsos
 hHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yuiuzUQZJJzdQCN81LL4oR1IBglKaKSKJBR+JpDtjH0=;
 b=HjAWEuHJGGQqlvJT4A4UTK6IjHlA78FsAfJHK49N0L2BH/ryml53jwhLwr359cpVKL
 q8/PZhbGm9bF1GKseSPGgFBj5j4OgQbyj8NXtn00eFERoslPt+GInAexYXB1sjboB+5D
 2hfAGRTXZpFaLmJF/sjlVDCFr6RfF3A/YCa+S8Gh9a47xY3ZjMof1e95b1Pb/igB+gst
 VpO2GBdlDAcBZ0Rq42UnfPAqpWVfhFFOsnSUfHk9gOb/PHsUip04chPhQzbloj0JS4Wl
 k/CU/y1Sqm12DKLKIt0fIYDZFhoKNepXJ1i+2zpg3W+cd1WeFWXTG9SOB8eGZ3amlAZg
 eKxg==
X-Gm-Message-State: AA+aEWYc0aHAsAc1+W3jOOe5xnlSxKlL50Xr7L0lm8D2iuTahD+Oa3Fj
 b3UGKmBOTtuinXVx4Yk3A4fWd0VHdoA=
X-Google-Smtp-Source: AFSGD/U29g65WhwpKwbxFyuZ9xx6oQtBReGICkXH9/OZEF3nQB6D02xbMh/3bQKYvd6fjmAIw3IgGQ==
X-Received: by 2002:a5d:8b8d:: with SMTP id p13mr19483585iol.223.1543375285205; 
 Tue, 27 Nov 2018 19:21:25 -0800 (PST)
Received: from bat.mindbit.ro (CPE00fc8d79db03-CM00fc8d79db00.cpe.net.fido.ca.
 [72.140.67.131])
 by smtp.gmail.com with ESMTPSA id n129sm563927itb.20.2018.11.27.19.21.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 27 Nov 2018 19:21:24 -0800 (PST)
From: Radu Rendec <radu.rendec@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] Fix NULL pointer access in PowerPC MSI teardown code
Date: Tue, 27 Nov 2018 22:20:47 -0500
Message-Id: <20181128032048.11665-1-radu.rendec@gmail.com>
X-Mailer: git-send-email 2.17.2
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
Cc: Radu Rendec <radu.rendec@gmail.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi everyone,

It seems there's an unchecked access to a NULL pointer (to a function)
in the PowerPC MSI teardown code. I found this on kernel 4.9, but the
code looks identical in the latest 4.20-rc. I don't see any reason why
this wouldn't happen on recent kernels too.

The PowerPC architecture specific MSI setup and teardown functions are
in arch/powerpc/kernel/msi.c:

  * arch_setup_msi_irqs() checks pointers for both the setup_msi_irqs
    and teardown_msi_irqs ops and returns -ENOSYS if either one is NULL.

  * arch_teardown_msi_irqs() calls on the teardown_msi_irqs op pointer
    without checking it and assumes the function is never called unless
    arch_setup_msi_irqs() returns successfully.

The assumption in arch_teardown_msi_irqs() is wrong and results in a
function call on a NULL pointer. An example of how this can happen is
included in the actual patch header. In my case, it happens when the PCI
hardware is configured during kernel start-up, because my controller
doesn't support MSI and the ops are NULL.

I'm proposing the attached patch to fix the problem. It basically just
checks the pointer before the function call.

The patch is against v4.20-rc4, but I only actually tested it on
v4.9.115. On the other hand, the patch is trivial and I did check that
the NULL pointer dereference scenario is still valid on v4.20-rc4.

Best regards,
Radu Rendec


Radu Rendec (1):
  Fix NULL pointer access in PowerPC MSI teardown code

 arch/powerpc/kernel/msi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.2

