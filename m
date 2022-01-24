Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DC9C43217
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jan 2022 10:25:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jj5hd1ZhNz3cCr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jan 2022 21:25:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=aYhTEZmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c;
 helo=mail-pj1-x102c.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=aYhTEZmz; dkim-atps=neutral
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jj5gw30tyz2xF0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jan 2022 21:24:27 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id
 g9-20020a17090a67c900b001b4f1d71e4fso16368905pjm.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jan 2022 02:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1eKmqFP+6EXhwXfWNc2+n11iTSyDt9/Aii7+uGw93YU=;
 b=aYhTEZmzJu5ttIHxpF7Nc2HGl4r6D0Jq47+iiH0bLyOBGbnqWFRj1WWcni7IHJwFBn
 ogn8bZY6CN6k3U73fzUWnl3CZyRhFY7ZSMoIoy0zZ7iNSe3OnDQENcRcfr8fvmbhMwy4
 3rpYS9eLJXfQI32LOOwM9kynRLDv81l5v76kAmwgv5kUqHtzG48bMWL9cTIvswB8mlWx
 wkyiPPARlRJ/GgGrDQS9m0JMisQUX+2R/n5dUdOWBHngaDzkKvub/gCQiFXDXQQ7yA0J
 cb8RdkHwUPGLt3GCLsZnTMNUu1AxHHgBeXJf347SJbKZkhOgTu3UXO51yUqt7mleV940
 +qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1eKmqFP+6EXhwXfWNc2+n11iTSyDt9/Aii7+uGw93YU=;
 b=0LmS01cGniG2Wdo2fz68j6gX/twxwgfkE1rS5G3ojv5hts4LjjuvPaZWBIAGeAC1SN
 JniCXMW5i5Qx1uymUOXummCPaal1CkAlfzKBmwG3zKx/U6uo1yxvGULJmd5A8cLiuI7v
 n5iOxfZ+Q4DVG75XmQo7LQb3PDf63ZfZBADXFBSB6y6iMP7YPJEAAvcCjndOZx4D7He3
 bGw+INQaMczmA7arV/luU2htGFY2uZhDrDBPQUhjhgueLH0YryYVqt1c6FPoDRowVWO+
 C+G+VJn5Ncp3CEcLY1zymPPBqmAVMTpZDc9q7XQfBzXTzp0E/P6Doy6f7yVOsFJrrnLi
 Ni0w==
X-Gm-Message-State: AOAM530n0CjK+axxP5Bbn3kS/HxZUDrmyqz/+WOgZhJajVgO7WyBQt2L
 dnVk4DA3GbhrY0WTMDOZuX4BY4XBBwo=
X-Google-Smtp-Source: ABdhPJx5sfpIrdtzfQx8pGaOcikyx0E78e2yxamNaDV5cmynM9dcB+pI+r2UPOVezFVACWQe9TBArQ==
X-Received: by 2002:a17:90b:3a87:: with SMTP id
 om7mr1268331pjb.16.1643019865255; 
 Mon, 24 Jan 2022 02:24:25 -0800 (PST)
Received: from bobo.ibm.com (193-116-82-75.tpgi.com.au. [193.116.82.75])
 by smtp.gmail.com with ESMTPSA id z14sm11724081pgr.34.2022.01.24.02.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 02:24:24 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] KVM: PPC: Book3S PR: SCV fixes
Date: Mon, 24 Jan 2022 20:24:15 +1000
Message-Id: <20220124102417.3741427-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These patches seem to be the quickest and easiest way to avoid the
host crash and to get recent Linux images (that use scv) to run under
PR.

These are independent of the syscall emulation series. Those just came
about when looking at ways to fix the host problem and seeing emulation
was broken.

Thanks,
Nick

Nicholas Piggin (2):
  KVM: PPC: Book3S PR: Disable SCV when running AIL is disabled
  KVM: PPC: Book3S PR: Disallow AIL != 0

 arch/powerpc/kernel/exceptions-64s.S |  4 ++++
 arch/powerpc/kernel/setup_64.c       | 15 +++++++++++++++
 arch/powerpc/kvm/book3s_pr.c         | 20 ++++++++++++++------
 arch/powerpc/kvm/book3s_pr_papr.c    | 20 ++++++++++++++++++++
 4 files changed, 53 insertions(+), 6 deletions(-)

-- 
2.23.0

