Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94191C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 15:05:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB51C2063F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 15:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D58yz0fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB51C2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VDqj3mMzzDqKw
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 02:05:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D58yz0fe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="D58yz0fe"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VDmq0nn5zDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 02:02:34 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id c25so14703484pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jan 2019 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=7nqJrGCWoJ/xXa+0vawBxQXEAZNobDoLmrZscFMVjZY=;
 b=D58yz0feqYH8p3MlPzWJ5O4HNTeru3ubYuxTOOx+nCouyEc2r0hnaS1C8V5BQ7pGQg
 a3HQOzV5zGyVLLq1ybFKsEZHnnowIgRh/ji0d86VV8K2PRO8bJhgI66Zlf450SQXQRtL
 HD4ZiT+jnqnf3zdmSp+5fds0S0Kri2KexHxCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=7nqJrGCWoJ/xXa+0vawBxQXEAZNobDoLmrZscFMVjZY=;
 b=WMHiFzGvSMW5ckLWHhtw0aoWwwnegk3GCEwkeMVMQAjCPs3LS2RKhEpyyELMZfan6i
 Q8Y9XRl22pMGwDeIPs/oFMaGJUEn8uXf81WHgahLiyzd45rL7qnSjyVVtkoqxDK/pe/B
 SGTPprIuHb0kV5VrI447Nnt74FkkowW/g8hMhDdMxYb3+N0dBjrY8et/5pxElgEYx05A
 rZi4RN0WE4ZoB3IadDAvb1PlTBgUbpgjZdqaUREL4Y+RHW9rEOTNN/TwiUtR7OHrvZVR
 cFC3Fm43uVVSv0deu/ssMcqTVqe8w5UbBFJSay0P+Y5HLcFtrJWqKFGNrj5+o0bGk9yX
 XkAw==
X-Gm-Message-State: AJcUukcRAHp9NW08Z2BaBqVWGdC7Gd0hO+HCfDH8pLIZRnq8UwGN9z2L
 xEYuLDcTEKa8OeUKwFMkew73sw==
X-Google-Smtp-Source: ALg8bN4klezGJ0qRyQtepbOyLk5xRK2fQc0VFDcWdh/7XU4H1sqDnuGGKSe5lk39u0CFM5YuqhtlBA==
X-Received: by 2002:a63:4456:: with SMTP id t22mr14012658pgk.0.1546441352610; 
 Wed, 02 Jan 2019 07:02:32 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id z14sm66180213pgv.47.2019.01.02.07.02.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 02 Jan 2019 07:02:31 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 0/2] powerpc: Unify the system call scripts
Date: Wed,  2 Jan 2019 20:32:02 +0530
Message-Id: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
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
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

System call table generation support is provided for
alpha, ia64, m68k, microblaze, mips, parisc, powerpc,
sh, sparc and xtensa architectures. The implementat-
ions are almost similar across all the above archte-
ctures. In order to reduce the source code across all
the above architectures, create common ".sh" files and
keep it in the common directory, script/. This will 
be a generic scripts which can use for all the above
architectures.

This patch depends on;
 https://lore.kernel.org/lkml/1546439331-18646-1-git-send-email-firoz.khan@linaro.org/

Firoz Khan (2):
  powerpc: remove nargs from __SYSCALL
  powerpc: generate uapi header and system call table files

 arch/powerpc/kernel/syscalls/Makefile       | 11 +++++++--
 arch/powerpc/kernel/syscalls/syscallhdr.sh  | 37 -----------------------------
 arch/powerpc/kernel/syscalls/syscalltbl.sh  | 36 ----------------------------
 arch/powerpc/kernel/systbl.S                |  6 ++---
 arch/powerpc/platforms/cell/spu_callbacks.c |  2 +-
 5 files changed, 13 insertions(+), 79 deletions(-)
 delete mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh

-- 
1.9.1

