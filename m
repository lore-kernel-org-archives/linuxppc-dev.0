Return-Path: <linuxppc-dev+bounces-24612-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A8C4451C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 15:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4MQd3dZ5z2yR5;
	Wed, 22 Jul 2026 01:54:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784649289;
	cv=none; b=FSjvAOiAiWolwgGJV+/Yd56mDHTbkpx/glFzFqsdB23M0QHufxPxFhB9LWdnaOH2vfG5cc1QFlbHbFhZ6bxxkf33BWSXdAQHxfq4ZIkRNaSfxoJQdEWmohvrD1LyrE4iQlteH+UlwyU3Z0DvQ7teag2K+X9jw1P0Jhd+AEqhSCVvr2ksGYuy81xYTSgFn9EC2qkcEu8q4ZObznBovZWh4CvQEBvayCvyqkHZOAfDCZPIw5+btEH3wLdtpcy8Iy9Yavm77sSyFd3SZy0YjtEbb238m4pNTK8uUxbkmOLxz0QLwSdE293n6L10RkvvBG0TMioaymEokF3j2S/126nnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784649289; c=relaxed/relaxed;
	bh=VzIcHGjxX1dcSz7+14+ettkC++8S0LxutXTYkBjO25k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlV+zxV4YuHhQ4/2gQS15GkLLOeawFElR3rWeRuGx29dhj4C74Les8UqD9jVtyP/dVowRmQkj7o9HTP9IVYC+llOMzkBHTgNc1rUGOGfwlpKztslff0CQ1RAMMBLelhRI9QNZASB2FTzl1iKsEHg7ixis1e81PdgdhttbyN3oMb2VFfxE23iXDVp81rEYETgB/adg7TSqZh6YRbUEvAsgFB+HDHJuwItdLyR+q66WTObSZ2AG2mDPeMWk2S0c95xDUGrKzgMNiseWziFfGn58K6UKeuUY6VHw/B/oJExg79tunjvDkn4xAef3oti7yZ3jlCwuks2v39IMN4hO+ISBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A+r3IduV; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A+r3IduV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=thorsten.blum@linux.dev; receiver=lists.ozlabs.org)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4MQZ4kXRz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 01:54:46 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784649266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VzIcHGjxX1dcSz7+14+ettkC++8S0LxutXTYkBjO25k=;
	b=A+r3IduVgZBI+mzurlk1ToEay9DLcu22/XqjU/lVT3HfeuI3S2UOcU+SBGDB3kusfHjxrF
	BJfNmxcz/yGCaOB7KNyPpTsVhQYgp2jksqynj+faUwWj8p+vA+njE4F+0jekBkw8VqJVhn
	9fZJjDEJgJ59jeSbsSsXBX7V0910U6A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/pseries: Avoid strlen() in do_{remove,update}_property()
Date: Tue, 21 Jul 2026 17:53:46 +0200
Message-ID: <20260721155346.121975-4-thorsten.blum@linux.dev>
In-Reply-To: <20260721155346.121975-3-thorsten.blum@linux.dev>
References: <20260721155346.121975-3-thorsten.blum@linux.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=thorsten.blum@linux.dev; h=from:subject; bh=zRRNcErEeZUzqUVDgfD4he8/ABa1ClK+vt73aKmxWDM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnx06R9WOqmbz76eqVjw4Tc9XOfam7Yn2TXdqxNoFbir 3FZweLMjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjImQsM/5MLGee93JzTcWIG x9YFzFPeWekqNO92YTXdwqm8XvrL42cM/6t7o5Jsff6y1V5k2DuBy3iFpaOKBsvaJ3sUHjJ8/Ln RjQEA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Check only the first byte instead of scanning the entire string with
strlen().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/platforms/pseries/reconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 7faebcffc9df..18e3f1a036e3 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -307,7 +307,7 @@ static int do_remove_property(char *buf, size_t bufsize)
 	if (tmp)
 		*tmp = '\0';
 
-	if (strlen(buf) == 0)
+	if (*buf == '\0')
 		return -EINVAL;
 
 	return of_remove_property(np, of_find_property(np, buf, NULL));
@@ -330,7 +330,7 @@ static int do_update_property(char *buf, size_t bufsize)
 	if (!next_prop)
 		return -EINVAL;
 
-	if (!strlen(name))
+	if (*name == '\0')
 		return -ENODEV;
 
 	newprop = new_property(name, length, value, NULL);

