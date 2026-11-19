Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BD60A2603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMyYpvmv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVPPW4xnyz2yR1;
	Thu, 19 Nov 2026 14:40:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795059631;
	cv=none; b=NWA3JVO66gNwErG2C2fvQnk6jMaw9CZB7wCmaTYnCTG+G2F6x/PDWad02Spp0w0bapwhQErf2HMg3MchgPn1QnAaexw8DzUtkb6GuIxzLhD0sn7835jzs4FeO2YQmfUiM4mqCI8eZJqOLf3XMm78zND8QvWplUi4Ex3guYkM34y5jThl0+wprE9iWpQX9lnPXFuVCGvAmHeqHhOecHcqdWU7Y+7xCZ9q8Z6T77+tq5q1sfYakN91/r5FhnDRt5DiuPwlpw4UnNWFketOQdmmV/Td5txWbnGx6r1Fm5GBPX79R+EghwfHGmQDAbp4YHNr9YjIlvHX+hxEacXdvbgfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795059631; c=relaxed/relaxed;
	bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3nNRVJ4LxJWfst8oPxmuB6MWpNSp63+Wwz5O5JwMOOj0g7xYez3lIfzElGv1M90CeyxFaGmik/Uk4EMizdFNKZlBpKkG/3Xjj2nSuPdcHd5hWDYhrSU6inBJVfPySC5l0Sa2Le2IpNdWWZBddN2+VJi4IojmA0lQ/yN7YYJFpmfOquBQdrCo00qJ6OpBmoIDlnWTQbEoNnztaoUmnmmKSZOM4EIpRrswLSRnBKq5E7n/TKB23qEFYuCuJbbmZoazhHlSStd3OhAGTg00HGgGP64PWxqYHTQ4QGypo+z2gFhqn3PM4svbxy2rsQbSEcFE12MQDsFzQ00/XN+DL20sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMyYpvmv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMyYpvmv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVPPW0wnpz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:40:31 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso4099714eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 19:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795059629; x=1795664429; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
        b=TMyYpvmv/CeLbQ3yCy56YxyO+29AbpNyiWxzEQHQpCtW7fKF3RjwpTPb981ipEc164
         sFfRUZ/Hk02QNBQPIGzZ6Zxda2Y+oaZt7l1DU8sSGqvob/Q8fcnkWHYmTH4OzNWrazj+
         JrP1GLV87RNVAnrOWovCqs+K/WxYKf27e19z5RJ1FORgrR6p2b2sKzwKlH3G23aFCZBi
         aWlYgRbqjsQCs4SA5PYLEFiouJYVKcGZ99nyUtfT3AsBgfmo5UvzvH7WEfc0iCjFI6En
         YVQoZWNuCTuuTv5/TbbeRdh7xHZmP0xOYTZzxd40Miv1b6M4Yr5IbwWjZ9xG8oISSgLm
         3n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795059629; x=1795664429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OEeeKd8/7R6Ji2+yPy0bODVrPI/c25RCAh5o8xRTnOk=;
        b=Sue13Eq/xzxLIuZlKZEwQN89b5BvN+x4g+atDCWxLJA0f3diaj8VUzglx+/ZiyCduQ
         lsWTh3guKVyjsr4Q442TM+oPeQBOMqsRt+U/k7aZCJA37AekuaQh2XcW55R+iAn5/Mhj
         KyurFuRT//NBkBUPXEtd+5dbGL4t7+I4S6pB+4yXc49VeV944/dRP3GKOc2Y+TWe8by3
         z3oKro56khG1XX/wN2R285NlATVM5qz3PT2xfwBKPKz8E5tvdl5cLypcQi5b6tyuCsB3
         MU+CKdvu7bbjmI8P7rCPbY27yt3WSQ1WKG4Cj6DnBU2Fo4UfV2qNfbwHsRlele0oiTg4
         qcnQ==
X-Gm-Message-State: APuU4Z8ObKdn2yWWGcz983KvTW9GuEDKCKGJiS/Hf81DZFiKSksB7zwp
	tSMeH5EAFIZFM18/6PDZivJ7S1l/mw34UDwbSZDZZo6RUkXjq5Cfu+r9A6jA3Q==
X-Gm-Gg: AZFdTZdLjrLDA47XpycEB7islmSlSWbnVxpGXxXZNAwrtFYjCrxFDoH2bzZYfxP7/0I
	Nyh3khBHICpyb2I0dC3pEDVa6rfgKANUNq0CJS6StBDmXMoQWM7IX00b34yTPvP+zdm34xPkNbb
	fk11BBha+Om1q1U3Z2jWqdes9fJ5JLx/b7l2ws/o82LHzXyrqnYQ6ayOipXKSLIHx9A0R1r7u26
	xZVS0i8AH9BQ4LpgFwQhzYYr8LYXyfSyWqfGKRreqX/Of1kIm0G5NTIeCp3pPfiXpoWKN58rEXS
	pFJESaeP8Et8gOoACal7zlZZNOcNeT/zgYHzFtrB00X2iQ+ZsNNUU4N7RF6E7FKZ5B8I3H/mzu2
	lHagcirjRABXBw6NZdOsIMabmMRL4Qqfla/c3EXMT+ev6GS7A25cTBJNd6+6tzl3BXKWgb1Gu1/
	mCLmZFsi6unoY3lyGaDIvkNnvWQs7vuJLDe4JbgBN/5j/y4CYXVqV1GXcccxWNd1bU84K3OjeaK
	HsqubGtRWEyO2Vh3koWcJuwzQieFMXqm2p3pnAW6hIE/bXSIjZvkC/QKZLd6TjXoLqqwvaTMvV6
	uPmm3oAMBCMowwvvs9ps+Iiyq+0b3f0/CQ==
X-Received: by 2002:a05:7300:6da2:b0:380:d99d:ce1d with SMTP id 5a478bee46e88-3828016fed0mr5984047eec.15.1795059629049;
        Wed, 18 Nov 2026 19:40:29 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a4522829sm12699465eec.1.2026.11.18.19.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:40:28 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 15/18] powerpc/pseries: Disable context analysis for the CMM hotplug notifier
Date: Thu, 19 Nov 2026 09:09:10 +0530
Message-Id: <3a50c40b9f72c5e67f06e48d1db1359f3fdf3a73.1795058683.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795058683.git.ritesh.list@gmail.com>
References: <cover.1795058683.git.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clang's context analysis reports:
  cmm.c: error: mutex 'hotplug_mutex' is still held at the end of function [-Werror,-Wthread-safety-analysis]
  cmm.c: error: releasing mutex 'hotplug_mutex' that was not held [-Werror,-Wthread-safety-analysis]

cmm_memory_cb() takes hotplug_mutex on MEM_GOING_OFFLINE and drops it
on a later MEM_OFFLINE or MEM_CANCEL_OFFLINE call.

Add __context_unsafe() annotation for cmm_memory_cb() callback to avoid
the reported build error in order to enable Clang context analysis.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/cmm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index 38e22125b96f..159efe734785 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -470,6 +470,7 @@ static struct notifier_block cmm_reboot_nb = {
  **/
 static int cmm_memory_cb(struct notifier_block *self,
 			unsigned long action, void *arg)
+		__context_unsafe(/* Conditional locking */)
 {
 	switch (action) {
 	case MEM_GOING_OFFLINE:
-- 
2.39.5


