Return-Path: <SRS0=DFH+=DY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC6DC433E7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 00:52:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AD821D81
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 00:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RWzY/piC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AD821D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCkyV6fvnzDqxb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 11:52:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=flex--morbo.bounces.google.com
 (client-ip=2607:f8b0:4864:20::549; helo=mail-pg1-x549.google.com;
 envelope-from=3pz-kxwukdogwyblyqyyqvo.mywvsxehzzm-nofvscdc.yjvklc.ybq@flex--morbo.bounces.google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=RWzY/piC; dkim-atps=neutral
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCks76Bp7zDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 11:48:02 +1100 (AEDT)
Received: by mail-pg1-x549.google.com with SMTP id x77so2127360pgx.23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 17:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=ixiZWMbrWnfJCj6w4pIymadOOWlYaZoKWVAlr1IE7kQ=;
 b=RWzY/piC3N7Z1yWtztVs2nhn7mXzIFA5DDcYEGfhwiA+BrNACR+YZ65BwqWy6CvDYh
 eMz8/vWD4agcss+wdB2ycSe1bHDjuo9BwqtVpiWTKvlaIoO8YtSA5boxMcYNNhJG/4Im
 NFMmwYXJSWz9r5aGJxbmrrkZ2C+HHcZDkxRq53cOZv2qNVIcAxzANNXRctsA9iRoDStq
 /2ISY78lkzY6FSFcViQATsMoCCQ9z5lOywsyF1tjWyQP+FkQsfTYOB6gOZt/VrSxd2w6
 1QPGBpnwKCHxR99XNAukSloeuXMzefTTnhW9WPd6atOIsItFp7YybbyMx86QtOuhcf8c
 +zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=ixiZWMbrWnfJCj6w4pIymadOOWlYaZoKWVAlr1IE7kQ=;
 b=oxSu4t+/GaPGktSG+YAy+GEa1bs6NblVmlFnsluHcKyqmwy0WUtt9HlTdv9WAna+Go
 H/YqAFYsNVkwQDRVd32d0Zx9AF2g4RinqE2LELuNyb5byYzBderHemfL3XKZue9Eu7la
 rzwHoz0m3e1P0VaSmIIYEcIiK0rxdZz44YRo1dpsOomQLNAWPPBYIRGLsiBoZMuGrCXp
 zQZGw2Ic3rCuC2zRa5b4K88SPh/lrNfsIy4QB8C05CaM80f5JVmS6Kzr2zJzpxabXBF8
 mr35giz6TvPr35zZL17NxovH5K+XT/sS1UjXpnHHoLr/y2QYHX/dfiYcIwQHpWztQ5nI
 jdrQ==
X-Gm-Message-State: AOAM530tlHs4uYra2lKNt09799tcdMo/FpjkKsQNZP96P/M3Qw2R0fco
 B5c9/IYHRaU9sGMP4TyMECQZXdQWggixm3AEri8kuAy//CVhh1kBa0G8onscXlCpp7r0JDUU1A9
 p76qypxTjdxv+OqSrcEMTzklKfgs71WU/+0DWhCMSXtqUbTby9qFIvpxNGLSYakQcfds=
X-Google-Smtp-Source: ABdhPJySW6wBRdxaVkG4yxL2O5dnmJXGKj6Eq3dD2TTn8yMq4EcC2qJsEpmcNQKIRQFDN0JauuEX+3yQmA==
X-Received: from fawn.svl.corp.google.com
 ([2620:15c:2cd:202:7220:84ff:fe0f:9f6a])
 (user=morbo job=sendgmr) by 2002:a17:902:b414:b029:d5:cfb6:e44 with SMTP id
 x20-20020a170902b414b02900d5cfb60e44mr2504168plr.28.1602895679003; Fri, 16
 Oct 2020 17:47:59 -0700 (PDT)
Date: Fri, 16 Oct 2020 17:47:50 -0700
Message-Id: <20201017004752.415054-1-morbo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH 0/2] Fixes for clang/lld
From: Bill Wendling <morbo@google.com>
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
Cc: Paul Mackerras <paulus@samba.org>, Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These patches fix some compilation / linking issues with clang & lld.

Bill Wendling (2):
  powerpc/wrapper: Add "-z notext" flag to disable diagnostic
  powerpc/boot: Use clang when CC is clang

 arch/powerpc/boot/Makefile | 4 ++++
 arch/powerpc/boot/wrapper  | 6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

