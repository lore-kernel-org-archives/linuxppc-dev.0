Return-Path: <linuxppc-dev+bounces-23562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9656C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Jul 2026 12:14:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsqLj4Y0xz2xyh;
	Sat, 04 Jul 2026 22:14:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783167293;
	cv=none; b=eDAYEitnkSvEMO9PskIpHUMboqKrh7JOJaywfALnmMWRlLqo7oQ8cmYGe6T0cQZXvHpBGh1DDDR8vmKoQTzbwF2NJ6Y9YNMRUJ6oepsekz++kgQ1jPz8CbPe0NlzHrSrQN7hRw24rYio+nb/87QVV1CzhfJu/t/L61w9SEp+LVVk0CqaCkgAwDjN8WIePPcrUmJg67znUTXkxnS6KSN0L8iVBj4/9/G4w/cUfh/MTBAJgdlhum6Tl511KI4wB4fJYIUlaK+SpUjFxmbF9FIuUSNJooBvOkO+j4n4qw85DRpZtusAknflguqykWQef+EDXzl/Kxs3zMZ81ikAEabAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783167293; c=relaxed/relaxed;
	bh=AkRCfO1iVn/QHizYN/z5xeFRWe5Y2j6prWXL4nkHqdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKqB2SDJqSS3lF1/jR4hwKJiPjcH7LEa1nPJL+wm1BW9lxZwFwk5Samk5B5OHLjBb6zvH9kWl+PAeubxVwaGQmxXVF0Bv1tW3oBBrIGI19k5sY3gN4CV0Dju00aAVGLQsaSmYwLWIkgNvQSHSwgI1d8p9MWYIRKe2CmicbcqiyPRvoljgCAg5Mg8itPng2iSTAuK+/c5qg0ZyVJKVW4xMLfMvpi9YOj4VfYMDYqISIJOtDkQKEaCRGlyp/EbQ6V0NXvGqa4cwf7YQ1stueHrSTin2zAslcInzJrjHJpC+pWKJdhoP4Q4sjtLu4TUDPBmVZHTpXm2rXzCHYnD59kNGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QjDxQo8v; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b3; helo=out-179.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=QjDxQo8v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b3; helo=out-179.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsqLd2dxJz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 22:14:47 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783167262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AkRCfO1iVn/QHizYN/z5xeFRWe5Y2j6prWXL4nkHqdg=;
	b=QjDxQo8vPMgA7MrJ4wj1u1aU11TtIiT/LlRkdAPJ8hnzzkaVl5om7ZrvV6TTOF8+uBQlhY
	s6dJqzyOlCzmZCea7yEtSBkUFKRrbjIhAik8RITcq4aWudmD/uDSkanidbPa9ykITDlsvZ
	ebhGyu01+koW2fR2kW0vvTmCF5avOeE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Yury Norov <ynorov@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/perf: Use strstarts() to simplify is_thread_imc_pmu()
Date: Sat,  4 Jul 2026 14:13:54 +0200
Message-ID: <20260704121353.201583-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=806; i=thorsten.blum@linux.dev; h=from:subject; bh=UwrlOT9c1HuWdVl1Ql3XG6T9KxGSNS6xYqU+a7+eINQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkePxm1Fl8KcjnnKLXtq0NjesmzpfP6hFviRL7vWmv/s aKG88LejlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjI5oWMDM/m2Zb6m+5ZotB1 bKX5QVuhE9+EziYslbkTct+4LiA9v4yRYWe182+zZInwAxH5d8/9+b7umP6ZnU7f1km973xcz6z SwAIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the open-coded implementation with strstarts() to simplify
is_thread_imc_pmu().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/perf/imc-pmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index e3822f36c419..1d2db6d3e226 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1023,10 +1023,7 @@ static int thread_imc_event_init(struct perf_event *event)
 
 static bool is_thread_imc_pmu(struct perf_event *event)
 {
-	if (!strncmp(event->pmu->name, "thread_imc", strlen("thread_imc")))
-		return true;
-
-	return false;
+	return strstarts(event->pmu->name, "thread_imc");
 }
 
 static __be64 *get_event_base_addr(struct perf_event *event)

