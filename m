Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D26C54E94
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Jan 2023 23:37:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P2KyT4k35z3fF8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Jan 2023 10:37:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=O3Dw/3Yf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::b49; helo=mail-yb1-xb49.google.com; envelope-from=34lzrywykdmu352pymrzzrwp.nzxwty5800n-op6wt343.zawlm3.z2r@flex--surenb.bounces.google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=O3Dw/3Yf;
	dkim-atps=neutral
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P2KwM3KHMz3c65
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2023 10:36:03 +1100 (AEDT)
Received: by mail-yb1-xb49.google.com with SMTP id n8-20020a258d08000000b007facaf67acfso161700ybl.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2023 15:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu3p5HiJtTPZuGN+bqO+yFOC5Hz9ZieUjpaHjc/iiFw=;
        b=O3Dw/3Yf4QCHpXxfNvbShJeQEuFeZuaCO84YhsKbrfT9gihwXHPbAFRN/aHZ1lsYAC
         qgvLA/2wUiu0psYz4A7EZ32N7vcrezUtVg4gluDiovAd73nSCoLCjue3jqIRvyM8XHNi
         SclRHbL02JwJ/8QyQNyO8kpVKn5KS/kWq1y8oT8WTssLAAs6ZeUTA2CZ8CZH/ArlHruv
         /5QEuWLIWZWNh2Nma31HKz5RSg245aOjanktJB6bqUAOqyB+fKcWWKlMYW8vP7U0C0Fl
         poBIPYC0lSSLPSIW0BCqHBXJQ4Xga5iRXWZxkJmdRhnHZTAHGwylJAWWG4x9W7mFvX74
         pJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu3p5HiJtTPZuGN+bqO+yFOC5Hz9ZieUjpaHjc/iiFw=;
        b=HCs907k+n8bxXWsdD/TnE7QMAHfojhBh4pt6ovLaNjH/nRnPMNvsKQeUgoQPzp1HGL
         IzszseG65kFG5tTcxH036+mjGDktZ/1hwPiNFSKz6w1ukiUPV9p1o365wDFzD23dtbNj
         B43OOj7Qpmt0N6ZMYHeE9gA0NHU2SjrymYpukDoJbFzs5R2i2Zu2MiIqvkDALs0yi50V
         0eqB3/MsDxotuv8G1i87aU6mZ/oB8Um+fkuN485TR/ZUhptyJRpPlBaHP+4x1h/m984N
         iqIu6vV9BHqKr4g2Pf6a+sHEu5Agw9IiWiEF2VNkK2vktty+GLXXhPePJ7uZFwXSLf/h
         Amfw==
X-Gm-Message-State: AFqh2krCVbXdI8Ou0yA3b6pkfB7hKYWLKiVhUJRhpDeQWeLTp7grTE7K
	zL41hqG8lMQRTY+yTlOjjYS3nKgpoOE=
X-Google-Smtp-Source: AMrXdXtpp7+Hs4EoYFj7KklscrSLOU6ca9mI+eR4n2eaFqWbrWVWQGu9P5Gq5ijnwlRlBQirW/76s6IejG0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a81:9148:0:b0:4fd:417b:7b8a with SMTP id
 i69-20020a819148000000b004fd417b7b8amr2939691ywg.404.1674689760727; Wed, 25
 Jan 2023 15:36:00 -0800 (PST)
Date: Wed, 25 Jan 2023 15:35:48 -0800
In-Reply-To: <20230125233554.153109-1-surenb@google.com>
Mime-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125233554.153109-2-surenb@google.com>
Subject: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
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
Cc: michel@lespinasse.org, joelaf@google.com, songliubraving@fb.com, mhocko@suse.com, leewalsh@google.com, david@redhat.com, peterz@infradead.org, bigeasy@linutronix.de, peterx@redhat.com, dhowells@redhat.com, linux-mm@kvack.org, edumazet@google.com, jglisse@google.com, punit.agrawal@bytedance.com, will@kernel.org, arjunroy@google.com, dave@stgolabs.net, minchan@google.com, x86@kernel.org, hughd@google.com, willy@infradead.org, gurua@google.com, mingo@redhat.com, linux-arm-kernel@lists.infradead.org, rientjes@google.com, axelrasmussen@google.com, kernel-team@android.com, soheil@google.com, paulmck@kernel.org, jannh@google.com, liam.howlett@oracle.com, shakeelb@google.com, luto@kernel.org, gthelen@google.com, ldufour@linux.ibm.com, surenb@google.com, vbabka@suse.cz, posk@google.com, lstoakes@gmail.com, peterjung1337@gmail.com, linuxppc-dev@lists.ozlabs.org, kent.overstreet@linux.dev, hughlynch@google.com, linux-kernel@vger.kernel.org, hannes@cmpxchg.org, tatashin@google.com, mgorman@t
 echsingularity.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
errors when we add a const modifier to vma->vm_flags.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 6683c1b0f460..a531901859d9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		 * orig->shared.rb may be modified concurrently, but the clone
 		 * will be reinitialized.
 		 */
-		*new = data_race(*orig);
+		memcpy(new, orig, sizeof(*new));
 		INIT_LIST_HEAD(&new->anon_vma_chain);
 		dup_anon_vma_name(orig, new);
 	}
-- 
2.39.1

