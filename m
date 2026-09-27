Return-Path: <linuxppc-dev+bounces-28321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E86EC9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:36:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6Rk2647z3bqZ;
	Mon, 28 Sep 2026 00:35:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519730;
	cv=none; b=F6GrLHj0wwM2U6l2QFaIL456ZLylnuytTF1CFj5iBb387PKJJWEIjYlEvNPpBaa5MWH7aw4jb59asJCiyO26pi36wC+IFJ4qNnp8jP8HiTQSaqjqZkFCLUDYgogcjt0GP+0jOi6HY6G3C76vI+4cYqfhDyggPC+svSio9BhimTOMNArmCQwyvMo0znaJNvLNXbpy5sBLLAEdb3Vb6T/pOq89VsErUCpa6MtD7+BaE6/UbzpI768EdekHPn8FWo6ytiglq0jtt70PVYlR/xab4sPLztfUqAF92Q1Q6nssMEr2h+g3KinQqf4cCAdyZ5xGnlvekFjwH0WSJpStyFmbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519730; c=relaxed/relaxed;
	bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTymlhEywG4nZGjqX4O0ZcMp1xc7GK5I4YtUcYAgtoeBkUlGG2KyTXC95B8wO1RNRR5v5zBQNT0Nj0GdYCP7hMQOFRel6tyBWoxthVZTr89nnEdEXsKTto8BaBedC6kZ66hRAg4Be5XGHUgaN+6IJkRS0YtC6uDC7H/HPptL3IjMBnUpk+RY04acXuXer+YpEJNenpItmRH3drN8EJjFFIP9u3vEptOtNF4lpPKAqT1uNv76bOebgKbO2jKta+6IyVq4BWPrODS6s8iFyZcq7EF30p/iKiE4cZmicJzj0vVvpwSM/Hw7QM0G9KsfjjwQLx9KXVyIW7bgssEe9IY5Og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h6jLDYh+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h6jLDYh+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6Rj3nzwz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:29 +1000 (AEST)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-3425f2b24a4so899800eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519727; x=1791124527; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
        b=h6jLDYh+8+af110C2YNlkZ7xg9/GHuIgNqVDdaB7jEbliGLpjR9JZyOfvLTialjkYY
         uO8kaT/dEW71vha0LXNd0Hnun6QC3FVY7PAKes/9JaSiB/h+rm/won2E3nQmgPPAufVz
         ASuI0613VMGpLdk561KT0qPQsXCngoVNUXMMtqDIRYXAzFJK56Q8UjqYVHZLA6QhXtqO
         G6GoWwxJZfLEnAJbBT6nRPN12xP/QZvzIcPdztWGkvDrJu0kOTDTLsh/B24mMawAqMkE
         d1wyoDzA7Pac2bjstY3Q5AOxSfRICLcuGb2jaegrghx1em1RnamMRqP1tPBu5ZVdui5o
         Axdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519727; x=1791124527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zLySA6vQdM6/Jc0fF+x2gAStuP7aq2CXmHJfOM+evZA=;
        b=V0P6exHaREkMGS/ZiZHbzcd6Dy9D+efPyqEynd6UyyBbhsNs2/bza0rMUV+esJvMna
         jxEiqD7X812dsjjBhAN2TLTw58vGzkNuke9mC0UqId+1J4/F98vY1ZDTRs/GtdOvdhRz
         SwDGLZ116Uu17t+DezblYNc0QrdPlEIfnTxNOvhLHBkwoNzgKjc/8ECwphHzhUbnRqXp
         D3y0rILg13xzT9aYmjGInvWh8ILZqHusESC3jYOHcxYc3KgMYm2VmdK+PpcBWq6bKTkH
         wG96UKFMCpxquCWmXX2qLiTPPIUJRk/S6BJKtXrivGQtYt7zffLL+cdkh4rY7UmtuhNS
         l54A==
X-Gm-Message-State: AFq9FYJ9w24j7Y9ENgfX6NOcBZ4RZtvc9wc0MqBzseL4+AzxoMmYLxVI
	Y7Q9arVNsFqI9D2VT+EexYyrUoubtntn33sAFUhK0byYx8/uLlAv5iNzRKf7Qw==
X-Gm-Gg: AYBFou3QRqkYWnsaU9DusJB1ZvZsEFVNiCIdakFdFigrvtPdzSSjkAOrtg3XATYDdoM
	+ysY8e4Q0tsZgKQlksZaIGggABXFh9q9G/QOqRogYW3th8nmDFOJhvbXzWzCDLP632i+emlOUlh
	X5C8WrI3lZSmj7tKZ/fb37x3C0egFemL2v4231IBslbNnyT3BSznytYQPDz/ugxZ0ro8tAUFRnZ
	OEOVMeaYnZGg0KQwy8QbYPzOXeZojB2a5l4O/rVe91Fu07WXeBB8W/gBvrU6da4BagXPaUhbXwF
	tcKBDcFKfiF/otaPuK4IpHCoQpTh4y4gu7K6EN7kFZOo7wZ3QXDVyfxGOnXB9wu2z3jZg9hh755
	ZepFAAUnj+gRptABAryDGd6jOzOUkdF6Nf4/z2Q3zW2Vg4abQhNPsrnOHqNhzwdjdDVWchDOExj
	UGlyZekWR11VO6xx5/Q4vqTGeEpTa9SvGPHLUQaHKLOMqijXZ3lDzTSxVPmAeBA+TIeL6aFvgoh
	OqcPyvl8OKuENlUtuXZ7DBMlMEa+akNrXaYxzJgO9/XwmPa+pqK+atzhwax
X-Received: by 2002:a05:7301:1a8a:b0:342:890a:4088 with SMTP id 5a478bee46e88-342890a4424mr6023547eec.2.1790519726936;
        Sun, 27 Sep 2026 07:35:26 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:35:26 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 12/12] powerpc/powernv: Enable context analysis
Date: Sun, 27 Sep 2026 20:03:53 +0530
Message-Id: <f33a461307440c78ab8abd136529d167ee716164.1790517984.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790517984.git.ritesh.list@gmail.com>
References: <cover.1790517984.git.ritesh.list@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

powernv objects now build with Clang context analysis enabled.
Turn it on for the directory.

This checks that each lock taken in this code is dropped on every path.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/powernv/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 9e5d0c847ee2..834a56122aaa 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CONTEXT_ANALYSIS	:= y
+
 # nothing that deals with real mode is safe to KASAN
 # in particular, idle code runs a bunch of things in real mode
 KASAN_SANITIZE_idle.o := n
-- 
2.39.5


