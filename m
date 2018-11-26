Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4309EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:04:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B45B2084E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGdnJZ1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B45B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4339Fj3Tk2zDqP1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 13:04:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="uGdnJZ1a";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uGdnJZ1a"; 
 dkim-atps=neutral
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4339BX1h0kzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 13:01:24 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id i12so5765883pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 18:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3mcHGeUjzPT6A3eGA/6hj3m5fliJC5MSPuTQ0JbvFRk=;
 b=uGdnJZ1aDlS5+ihhOJDg2zxgng3sG6TshwbBqSeArPCF70/U91cHhHdfF7QO0X8bPU
 5ahIekq+IrwGIN/36NvV4F5CbK1jcTm3sCn2BUZH3HvaorPaoy6XGlPtvnxIDGbeA3G5
 0K63Y3746jvQyCJjXl1qGIqgEYuxXvm4ZDMyDwsoIZj7Ims95xMOIPvQjk40uTz4vAuf
 SMOf9TyLVBf3P3j0kXfZJlEtRKBQfrP+ugWX9qvXbP+NUGTXIk+qUUMsGT6JOf0+s0ZC
 EgDSS11ZeNPblSoSY5FfN9fbTIULHg0dwtz3jsGvWFX9YO+Z68SeKvd2ZE9DiPkDFdNJ
 af+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3mcHGeUjzPT6A3eGA/6hj3m5fliJC5MSPuTQ0JbvFRk=;
 b=iivq6lwQEJSltudFyCLx/QsiVA9oiF5zOHiVFrYM55Bq8+o52KaojsrWRxmuiJkKuJ
 m0TXTP3TdaiUxYwObuvBSNUEAOKs0SWLsjoDCb+epW73p/tK+gyJ46OHVAJryHfRVTNE
 tO7BAQUfhYsEtfMuHs9Zl02eswdFYAfPFTK1i+Xl75ZmREDSHU8u90XwMbG8mElplipw
 7yplx4o/dBq5DxAvctyf8MEqPOb6D+b4TNavi94+/EuwSzLOYAS9bpp8GEvyV71DsGR4
 GRScWCFPco7dhHVoE76NGqF7e3VUZBK5efQoqhhRM2xhm1V6sE81zzEDJp55vKcwqyMo
 w6pA==
X-Gm-Message-State: AGRZ1gK1pWjqCeW4QiUr489CwlyqrpDBJIaaMaMUH12l8G4fmAD8yTjZ
 GJ4GXj8KT2ZNF1ySiZNrnMJ/8rq6jwc=
X-Google-Smtp-Source: AJdET5fR6GOVAgTLQ8WHPKyFmI1NTgXfTL0oej0ialNrPKni3cRhiN84uK4NAJ1F8OywQVOEmANtwg==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr26202765pfn.125.1543197681908; 
 Sun, 25 Nov 2018 18:01:21 -0800 (PST)
Received: from bobo.local0.net (203-221-165-244.tpgi.com.au. [203.221.165.244])
 by smtp.gmail.com with ESMTPSA id b5sm76675525pfc.150.2018.11.25.18.01.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Nov 2018 18:01:21 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] Fix NMI IPI timeouts
Date: Mon, 26 Nov 2018 12:01:04 +1000
Message-Id: <20181126020107.17250-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.19.2
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The first two patches fix timeouts and deadlocks using NMI IPIs.
The xmon deadlock fails with a timeout so it wasn't really noticed.
The infinite timeout only hits when the system is in really bad shape
or the sreset handler is broken somehow (e.g., running a guest and no
KVM test in the handler).

Patch 1 is a necessary fix. Patch 2 is a bigger change, we could live
without it because the sender will eventually time out and break the
deadlock.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/smp: Fix NMI IPI timeout
  powerpc/smp: Fix NMI IPI xmon timeout
  powerpc/smp: __smp_send_nmi_ipi static

 arch/powerpc/kernel/smp.c | 93 +++++++++++++--------------------------
 1 file changed, 30 insertions(+), 63 deletions(-)

-- 
2.19.2

