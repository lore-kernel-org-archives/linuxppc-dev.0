Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F29C432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 04:59:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A384222318
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 04:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTlGheLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A384222318
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HDBN3k3kzDqdl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 15:59:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::244;
 helo=mail-oi1-x244.google.com; envelope-from=natechancellor@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qTlGheLn"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HD8G3hdqzDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 15:57:18 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id n14so17664400oie.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 20:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UvkLGHgSvEIQI2WG9EBqccOe+HOcwjAc1fTcAv9zhAk=;
 b=qTlGheLnk9j7Jtg8ORqOUUIUR9icg7OH37dIf6wW26OuEIa2BvnW7Qixap4O6khJBB
 mzeeiJv3z0sBntejsJJdYWUtaAK7gdMOZa5Fw7mLD1GDqwuNEDkuJIBP3EM/If2IVR3x
 Uh1VgCUydqjmRxpiSgvXmvLINdknZxrBD8/oFnD2kabg3bZfTcruNljyySuA4qFfaaLO
 GzQgLSwfhQbRVcNuuRy7D6AKOEmq0LFOqGDXWB1/lQROrMVdchsUy1jwDLuPhD/lHK7n
 FdMA1fJciqh+4VSgU7pdZ1yZocH5vt5WOQGvQc0s7RA9X7tU+8btrMcMDRctleGTEF+p
 4AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UvkLGHgSvEIQI2WG9EBqccOe+HOcwjAc1fTcAv9zhAk=;
 b=LZMVl1Vq+W3NG4FR8J6WIFHnv4B7xuh4WDj+4hm9DaWQzwwiPVejLoY1O9b3Ly8Iae
 22eiiiiUNpEQxk4BxmbUku/DkRXmVh8z8YYce79xf3emrju2lGUclTimtxwts8lQgB0o
 avsHJzFWAyTLHGM8NTgpS1L1H3Re9pie0SLSkDs9rO3MMPNXsjFdHIXqPKLJuqv+DnG2
 0Yi4/yeYLLo/tqwww5WHpgXk+mgxDdK2JAC6nF2gAjaPhi7dZDJhpPMhCCX1H1Q5OvSX
 gHUOm9kfxWArn8G4C6nkTS4RkOb/mw9dBOzCwz0wNAS4usmH7QtNmpcEM5zLUvOMgQWN
 wRDA==
X-Gm-Message-State: APjAAAVnr3Rh/DnXTDuOIigSuFKbBBlSFyjPG0agB9hjqhKDbxMta6eN
 oJsS/jHskZO7UHjOmSur4ro=
X-Google-Smtp-Source: APXvYqzELbV9nrbsgdQ8mJAxGjlH53lHYWG1QkQvToy+qIRFXnecB49sDO1vLwH1WO/+7GLO/h0pow==
X-Received: by 2002:aca:4c14:: with SMTP id z20mr2385666oia.76.1574139434761; 
 Mon, 18 Nov 2019 20:57:14 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::7])
 by smtp.gmail.com with ESMTPSA id e88sm7019765ote.39.2019.11.18.20.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 20:57:14 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 0/3] LLVM/Clang fixes for a few defconfigs
Date: Mon, 18 Nov 2019 21:57:09 -0700
Message-Id: <20191119045712.39633-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191014025101.18567-1-natechancellor@gmail.com>
References: <20191014025101.18567-1-natechancellor@gmail.com>
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
Cc: clang-built-linux@googlegroups.com,
 Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

This series includes a set of fixes for LLVM/Clang when building
a few defconfigs (powernv, ppc44x, and pseries are the ones that our
CI configuration tests [1]). The first patch fixes pseries_defconfig,
which has never worked in mainline. The second and third patches fixes
issues with all of these configs due to internal changes to LLVM, which
point out issues with the kernel.

These have been broken since July/August, it would be nice to get these
reviewed and applied. Please let me know what I can do to get these
applied soon so we can stop applying them out of tree.

[1]: https://github.com/ClangBuiltLinux/continuous-integration

Previous versions:

v3: https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/

v4: https://lore.kernel.org/lkml/20191014025101.18567-1-natechancellor@gmail.com/

Cheers,
Nathan


