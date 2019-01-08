Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FF7C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:25:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4172087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 05:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkFuu65N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4172087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YghQ1w3gzDqNK
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 16:25:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=deepa.kernel@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YkFuu65N"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ygdp2MrrzDqNK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 16:23:23 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id i12so1331624pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 21:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=C/PZBrvynKthJJ/lsF1pt+JT3JSAbBllFgTcfNdsDto=;
 b=YkFuu65N+ngxVlHyeP0s/V9Iod2E+T5hUPbkRPQCh2yKnlCzkVVWq6aCB1rO18RPVv
 Va6IUWqSuQBNmsTUmS2Ki064WizCMs9ehC3oa4wamc+2WANf8A0xJMwdQEmoLt9FMTLc
 TLnwCCGiNtpbKSmbSwS3ncUx1s7rJG3/ZZEkIFSmAsznHR9MwqdRz0l/uEmgwqDSxgIC
 Hnu3c+5wyfrwxSJareRyEVjwA2869fv5iJ4XmW+f5X8SqBGZoQYb/cpb9L/QdDGZCzzi
 l5W+q8/iqpilkwwb8mIBYxWNRrcv01JVjwQr073PF8KMF4Z4JN3BjUhSQcUCUyL9kSxG
 JZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=C/PZBrvynKthJJ/lsF1pt+JT3JSAbBllFgTcfNdsDto=;
 b=pZOUZaIWe9zlIwZPbrQU7UxiMAnG4QQajlbDN+KMruWoXix4sODUx8IHwZvcILX3k5
 RZaOdDPMcALlrD/Lpd0+Fdh/n3OTy0Mg9pG36/2LapFnpM+3XM/ONzXibbuqdqCzrg7p
 pTBrLdMGQYZLYYE/5Mh/w3t3REEzs2bilRjq9YMHySXDLsA4UD288mdGjEEqwFffKYpa
 l9AASHXU2PfggBV04BM1ev2JywEN55a1fICXj2SgedsadDdrdYzjOBcCEqzXf02gFHPb
 THeM1L8SnW6gdYugLq4LlW1Jg4dDs/NL6dSLJi+YWGucE0R/ceJjVya4ls+I3vWF85yY
 iZKA==
X-Gm-Message-State: AJcUukc7iKJIGl/yhhRHyUpMwNwJ7ymN5oiIa/A9CayMtIaoqOv+nM/e
 92t+STQ4zAZcBiZEK16OU7U=
X-Google-Smtp-Source: ALg8bN7ghZyE1I0wD5gN5PUQnaYnkYOy9P+PydTedV977KUL90hHzyPMg9r/c9JBoF+NRNuGobCIpQ==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr400161pfd.56.1546925001107;
 Mon, 07 Jan 2019 21:23:21 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net.
 [98.234.52.230])
 by smtp.gmail.com with ESMTPSA id x127sm102710626pfd.156.2019.01.07.21.23.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 21:23:20 -0800 (PST)
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] net: y2038-safe socket timeout options
Date: Mon,  7 Jan 2019 21:22:52 -0800
Message-Id: <20190108052255.10699-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de,
 y2038@lists.linaro.org, netdev@vger.kernel.org, deller@gmx.de,
 linux-mips@vger.kernel.org, ralf@linux-mips.org, cluster-devel@redhat.com,
 ccaulfie@redhat.com, paulus@samba.org, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, rth@twiddle.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The series is aimed at adding y2038-safe timeout options:
SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW.

This is similar to the previous series adding y2038-safe
SO_TIMESTAMP* options.

The series needs to be applied after the socket timestamp series:
https://lore.kernel.org/lkml/20190108032657.8331-1-deepa.kernel@gmail.com

Deepa Dinamani (3):
  socket: Use old_timeval types for socket timeouts
  socket: Rename SO_RCVTIMEO/ SO_SNDTIMEO with _OLD suffixes
  sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW

 arch/alpha/include/uapi/asm/socket.h   | 13 ++++-
 arch/mips/include/uapi/asm/socket.h    | 13 ++++-
 arch/parisc/include/uapi/asm/socket.h  | 13 ++++-
 arch/powerpc/include/uapi/asm/socket.h |  4 +-
 arch/sparc/include/uapi/asm/socket.h   | 13 ++++-
 fs/dlm/lowcomms.c                      |  4 +-
 include/uapi/asm-generic/socket.h      | 13 ++++-
 net/compat.c                           | 14 ++---
 net/core/sock.c                        | 78 +++++++++++++++++++-------
 net/vmw_vsock/af_vsock.c               |  4 +-
 10 files changed, 126 insertions(+), 43 deletions(-)


base-commit: a4983672f9ca4c8393f26b6b80710e6c78886b8c
prerequisite-patch-id: a03ec6afbdd328cd90557f7ee6675016a5f5c653
prerequisite-patch-id: 724d26c3036e6f3a38f810c2f10db3f7ddbf843b
prerequisite-patch-id: 14017867b6eb4d5231eec1b563edcd840a1be26e
prerequisite-patch-id: 8df0edfd9b973ff5aae91c7709c8223be096a5bc
prerequisite-patch-id: 9850ad48d41bf068f074c0dd3c7610fb7177c89f
prerequisite-patch-id: bd31f35bba11902d1cc3e8726492b54df34b5c59
prerequisite-patch-id: ea4b005c5ad188a4e0899d728357c114710a3a8e
prerequisite-patch-id: cc3ee912c1ee1ea502ca079de81236a467950501
-- 
2.17.1

Cc: ccaulfie@redhat.com
Cc: cluster-devel@redhat.com
Cc: davem@davemloft.net
Cc: deller@gmx.de
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: sparclinux@vger.kernel.org
