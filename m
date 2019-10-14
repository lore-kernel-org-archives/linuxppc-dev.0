Return-Path: <SRS0=PY1v=YH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F363DC4360C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 02:55:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06332067B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 02:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlO+lnqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06332067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46s38427wlzDqS7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 13:55:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=natechancellor@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlO+lnqn"; 
 dkim-atps=neutral
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46s33c2xnjzDqS6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2019 13:51:23 +1100 (AEDT)
Received: by mail-oi1-x22a.google.com with SMTP id w144so12548605oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Oct 2019 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OqhQeSDaocWWcugyUoJesGShn68jf9JC9j/MN8cXVt0=;
 b=nlO+lnqnRRJzINk7eKGzEsDVXRZKpRSDO9Hw8IOhKcAQWKb+dFKNUYDEXriwt3z4Vu
 r+BclH3Hc8umblXdehMtmxJsdedztKAG5pG5XV1Ec55lq52KZORXcDxvHUxm0ND9LFnr
 3GE7z2smPWBODGpLEM6FFlNq1c/2MKGrllXL2lgkxE9p7Mfx3t3VofJHUMAd4sUfPdce
 ng84xxa7grVNrKJ3FKTjyB8RFZFP3hqLg1ykKT4e3zFelu9AbVk6196besuw0r66IbFH
 8MP2+EOfKnTn2Xq7K6jsXZF3l905QzZXAhd25u1hzvr2MEjfPd0DeDodB5NZVaLGQgHr
 1u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OqhQeSDaocWWcugyUoJesGShn68jf9JC9j/MN8cXVt0=;
 b=hVR5SGCNAAYEkwD2nx6OK1H++cUl2tl4mmnlSx5GTA4lJfrGj0iLywZvWat3MKKB4A
 t2Wi5BFFuS90hvrzZxnf3Ri7jKXYRmHrdaudOjs0tZsdt0O2DOoPKfFjvbRQJvgZzbBH
 O6fWUGrWlzfOA813GcDfUaEYhJ+ifPiM7HOm495dkO9z3jL9Aew/1EZVR8I1Qyk9xsX+
 agpH/J4aS86tEXWrPyCU7fovbLPChZy+OxwwbkgV3QCaDeLOZr0lo3nL4irf+Aos7gic
 Kl/8r4Fi3wjG+U74z8OAOumUqZE0CL8uPevFVusS4MER2P7l8ZZXpCEvv6+dhhlqiIbA
 vM8w==
X-Gm-Message-State: APjAAAWz17oQu9Eqt+9nm3jZVxDzGYtQmgeuj/bRag5a0dy1RoZxqko9
 DIn6DUxXsQZhLvglNmqtbS4=
X-Google-Smtp-Source: APXvYqz6GBZsxgq+giKH9Jhhxhcf62juaeQg2FtUlBjagl8SKfDNfbLYziCdQj01o/ohEIMWPEkiPQ==
X-Received: by 2002:aca:cd0c:: with SMTP id d12mr22781772oig.25.1571021480513; 
 Sun, 13 Oct 2019 19:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id 11sm5612491otg.62.2019.10.13.19.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 19:51:19 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v4 0/3] LLVM/Clang fixes for pseries_defconfig
Date: Sun, 13 Oct 2019 19:50:58 -0700
Message-Id: <20191014025101.18567-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190911182049.77853-1-natechancellor@gmail.com>
References: <20190911182049.77853-1-natechancellor@gmail.com>
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
pseries_defconfig. These have been floating around as standalone
patches so I decided to gather them up as a series so it was easier
to review/apply them.

This has been broken for a bit now, it would be nice to get these
reviewed and applied. Please let me know if I need to do anything
to move these along.

Previous versions:

https://lore.kernel.org/lkml/20190911182049.77853-1-natechancellor@gmail.com/

Cheers,
Nathan


