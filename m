Return-Path: <linuxppc-dev+bounces-27556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE3C982D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 09:10:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlqhw4Lgbz2xfP;
	Thu, 17 Sep 2026 19:10:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789636208;
	cv=none; b=TdDM+Phx4EhMrh2qov51LCUKGIaIqnVjuV/dxX0EvzlqbdURUPkJOeKKdbtjWiheExsh54tcuSpmephdZCRSkjTNB+mmvtBDfwQJvyGNgj8l5tF4ITpYM9Eg80xRsBm9PzW74TQo+QCMVkiMA91yMg3l89qjOunvRiVN4/mdazwiIsi3ztyiudCOq9XZAhD45rkLnKyDGLKBBZ3wxMlq9Sdp1gv2hWmbTloItF59XYhVYgcdjtlVxzjFHdAsODfCNwmhiQVqTLtTu+418s1AddbkfeY4HgRgjTWmAn3BlKpKBBNANfABfcBodxGd4U472x08ZJwSwWyHC/HgfTvFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789636208; c=relaxed/relaxed;
	bh=6dWahTpadJ8SVAXJFFy0YTTM47N8xZaWr7TRB490RZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fgc1GCYrxbWe7gaQP+zgZuGvkT2aq9hxQIrq+X3D3T65JvsW+BQkuZDlnhYuBEVO87Hqr9XhBGEcCBDTm834H2vrx/SVvrhM8GYs2rnWYRZE0B9CSRw11MiCNnKMzdHSapbGnm6mb6RBKI7T8207LCawjaEEqb7SOXId3U1B2l6gZKUY20SPIu39NGBuWaX7oYXw2Un1+I2sVCXVOtJpvdGG/GEL7/nPcxidmwQ2MhRIJMeOydDlV6rliyHei0RyMO1NksUjIxreRwH0pi4LSvew+0kX/3+1BEZcDJiQWD97lpCwE7lEdCCrCTst47Ktpg4FAwwJ6QPxC7kqXrrsKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gB/wFH2C; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gB/wFH2C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlqhw0GGrz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 19:10:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1876360231;
	Thu, 17 Sep 2026 09:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D271F00893;
	Thu, 17 Sep 2026 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636205;
	bh=6dWahTpadJ8SVAXJFFy0YTTM47N8xZaWr7TRB490RZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gB/wFH2CZNIyTyzKz6rMZb09+PgNTjUmU9H+6Eu6QBXgv+KymxIPpgYbmkzflAQrU
	 333+7mJ3A2kMGLT23ZySfOlzw7hqX2G8T9dO6f/Qu32WgqkH066+pbE6q3csCBOJhn
	 hVwJvSqenhZsWVto4JK5LUDNWiDFgSRr4SPiFoiBdYSNOulqmHCvK17qzpVrUB9knh
	 DwxjmfSuTDS9Rvyi1IKr+fRBTuThlHhHi2c3yTEEnl8wU779+BxDljLnOBC063luH/
	 Qeu0whojY0FqyPpX+sBJ7x4WXtUCJ8RhJj4+xD+LK3aPYwpIvuZYf2EKHwPsuXaN/1
	 6baEMzbhlX7jA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:09:44 +0200
Subject: [PATCH 3/4] cleanup: remove CLASS_INIT()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-file-fd_prepare-v1-3-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
In-Reply-To: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, 
 wine-devel@list.winehq.org, linux-xfs@vger.kernel.org, 
 io-uring@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gePQjgNJP3rZLgjxZMbNcyCVB0rhSfWKtw7rWIMHsCU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWStXhcptiHRLFxir8hFQ7cX4T8XKIlF/9FhyhR+65ynl
 qu6Wcqno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJzVzD8lWq5Gco9c839ZU7p
 jdrmawS83i4NPfWqOvxHVrbIx6usagz/LFur6m/9XDa34GfizllL3I9kJfeIcS3yyg6IPH70c+Z
 CfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

CLASS_INIT() was added for FD_PREPARE() in commit 011703a9acd7 ("file:
add FD_{ADD,PREPARE}()") and never got another user. FD_PREPARE() now
declares its variable with __cleanup() directly. Remove CLASS_INIT().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/cleanup.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index b1b5698cbf1b..1fb8058b897d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -261,10 +261,6 @@ const volatile void * __must_check_fn(const volatile void *val)
  * CLASS(name, var)(args...):
  *	declare the variable @var as an instance of the named class
  *
- * CLASS_INIT(name, var, init_expr):
- *	declare the variable @var as an instance of the named class with
- *	custom initialization expression.
- *
  * Ex.
  *
  * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
@@ -302,9 +298,6 @@ static __always_inline class_##_name##_t class_##_name##ext##_constructor(_init_
 	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
 		class_##_name##_constructor
 
-#define CLASS_INIT(_name, _var, _init_expr)                             \
-        class_##_name##_t _var __cleanup(class_##_name##_destructor) = (_init_expr)
-
 #define __scoped_class(_name, var, _label, args...)        \
 	for (CLASS(_name, var)(args); ; ({ goto _label; })) \
 		if (0) {                                   \

-- 
2.53.0


