Return-Path: <linuxppc-dev+bounces-28319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3DBC9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 14:35:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ht6RZ3qRjz30Vy;
	Mon, 28 Sep 2026 00:35:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.229.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790519722;
	cv=none; b=Krg67FQQFG9RtnNRT0u27TVZx0cP6Xr6Caex3yOX7fhX3ssryncnZqar07n4YoJU/LacOiOQC52xt0EoPaC3yaOH5QlmIpl/8kYClgc4zhR1c16cjPnn8ByCfIA+LzwHKmvSYJWPmYzByXxYmGf2cp9If+c0rVNJBBUixN5AYY+z0b5fh0ObjCCzGsq/x6u7U88dh/QFF1S/nSVMNjHbgcZTmr7IlLXzrlLre9TtUSGr7HiwSEC1k6oUzNokb1q4gUgp2s5zMUF/lk8AipIZW3E2jLGn9LTv02mnPBvOpC1f3Mu2vNYIo8xwsxGHFL0JQSIXrhQe272XjRcwoDV+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790519722; c=relaxed/relaxed;
	bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UTXVjD541RpwoBey5LnF/BCMLlMZrfeKdabBWLo335xqSaWFOrTgcFS68xYHxb6n2UFK2Q5sTNhztAESeIVN6mW/g9V7JDnvSBvlAJQXx4kcMtbSIVGTw1Mi7XvV82pm6NYdrFoiibHhA8zmHV+r1xw3qTJCreahmNGkjAVJxiY7iqo1z2P46dW5HoLri3CUx9iKJVtSHn9MoSMtQWZJBnWdO8ifmeKqz5Y8OBhzcY9y9wdRFv9v+rWQdknLvIpEAj4kvwFeCehzcfM0zqaB4R8UoduZyXpBA5s5Aq6MYgdg/pPe3/7r9N5aZTrPzgDsR+pJHNqirTFLl6lWBlyc8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P5R6dMIE; dkim-atps=neutral; spf=pass (client-ip=74.125.229.41; helo=mail-dy2-f41.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P5R6dMIE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.229.41; helo=mail-dy2-f41.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht6RY5csWz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 00:35:21 +1000 (AEST)
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-343c8177767so507762eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790519718; x=1791124518; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
        b=P5R6dMIEnYClY/q63ooyOUM7PhffgheMHFde5dvGAn8Kx+QLK+ui7sIMBR+1oaK54M
         OY3SfkFf9528N3VoxXNr+T3tfSj7oqCaVoRJrwtmDRNaZtEXuTi2doOMLGPUV9GBHUxg
         /rjhgn+KORxdnC2Ewtf9w/YaIBuJ8/A+yDNOwYttObNU+UvjCSPNoSC2WyNgoRIwR3Ze
         R+/XiSuhXz4C28F9AcjfwNd5zV1uwCBv/iIz5N2z04DhbK3oFxxVphmwKd/2YmPzs4CZ
         aHYhKerGZ5Li0aQPQ5dBy9zpUKxHWu2Q+rotdarJ+EWTQARjvIa9m4Ld/X5cTwHAJdyx
         fzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790519718; x=1791124518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMXueYzEMSkafhBw0cZtNBrJpZvkeyJZqfF9NmIV6eo=;
        b=PpAmrOhBnjFQ4ACws0y+OkFqcIl9wO6lwzEv30Wml6foQe0TvGNSwIU0uiJkvt+di0
         lmw/ymH6CxDWtNciR4MPZ9H6JmWGOaABtC2jXUp8oU6F5bARG4eVgnh1snUhHMziKzEK
         TvUN3BJef5L9K0sbd25pbqlkIkQlBJkrIOkWVUUbkEO1qDGQpFMn7xjz4psHr0adusVP
         91uf7ot3XwNJwu74OKfmDM8uPJRL7wGyUEA/julelYs3ohhQL9Jid/g8krnKvosluGyH
         m10fVNnS3qWnxqWmHnsyslW5zqTweKoDnyNCzG29CAsF1sqdeETWjDxvOxGq6W1qp8kj
         GC5Q==
X-Gm-Message-State: AFq9FYIcXlSo/ytRhRo7f/w4/GhckluMK829BvRngtaXTivg4w7i26VQ
	bMwe2xOH4Ga3IhjEIboecpphQ02caSmry55c0drHMV7u8rzsaqcPsJeVyQULyA==
X-Gm-Gg: AYBFou0qFiKkmrQCecYOlsziF9W/ImkK46CpcE2yOjafQHMsjRdNK8yuWlqT5rx6XEm
	Jd469pAYSGfIKG9nOAqxl6VIr/yBUiDrCij6mfCrOWF0L7sFQcjEBwnxWBvIWOBno4A38jIav5B
	tTi7+/6vj4GaFFc2TIYNE8HPwRiKXGgkmgfmoKJpYJkGb6UU8FrjFZdjeZ/XkNsepi7wjs5PFZI
	8n7VyNUS6Ucd0U72whT1B7/CRbnGP+qH5sXjbNYyqnl3DoZt+cDjI6t0KM5qeVD1CSMZKqmFVTu
	yozYKnfJpp3yzj5hZhTn9fxfy1NO/g6b/zUaYZ7F/809pgM4IEzzC2owYL0nnbRgjoTrnJ4CsUT
	DFx9EDIssEL1QNzfTk8S031MY7U8uaE+0GMWksy0T+Bg13pyNTYr5/z4hJRPukpxXVBiOJxt6yw
	BYSf/qMiJaCQoC/UwVPCX8KtH7GU1aWCEqYLyjrfoDpbLy7t2ElGTGJMmyOYKNlgUu6Byi5I9pJ
	qi2qET6rA5SOOBTL/wdx6ccxQ9YngIUSqGNlIsEgekn43iXIR2v4z+kVW99
X-Received: by 2002:a05:7301:2623:b0:33b:fae9:fc37 with SMTP id 5a478bee46e88-342711ab273mr5485491eec.5.1790519717835;
        Sun, 27 Sep 2026 07:35:17 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm21869436eec.17.2026.09.27.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 07:35:16 -0700 (PDT)
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
Subject: [RFC 10/12] powerpc/pseries: Enable context analysis
Date: Sun, 27 Sep 2026 20:03:51 +0530
Message-Id: <bc1d8d5a9227776a49b8f72f64d96f840b5658ed.1790517984.git.ritesh.list@gmail.com>
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

pseries objects now build with Clang context analysis enabled.
Turn it on for the directory.

This checks that each lock taken in this code is dropped on every path.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 3ced289a675b..d5f9beec33cc 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CONTEXT_ANALYSIS			:= y
+
 ccflags-$(CONFIG_PPC_PSERIES_DEBUG)	+= -DDEBUG
 
 obj-y			:= lpar.o hvCall.o nvram.o reconfig.o \
-- 
2.39.5


