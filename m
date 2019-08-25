Return-Path: <SRS0=uTVD=WV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C9CC3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Aug 2019 13:45:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07FD2080C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Aug 2019 13:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHDg4LdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07FD2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Gbwp3HJWzDqM7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Aug 2019 23:44:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="sHDg4LdF"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46GbT53D9JzDqfc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2019 23:24:25 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id n190so8764070pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2019 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZBMOYzu8UIu95lP7jXMjUUnVweWqbQKsr6KxrGRBejY=;
 b=sHDg4LdFrZLoGW/ZYspHbC6si5YKDLezCKJyEjDpI/sdIE9awBNr91t8Vhfot9Jkv/
 eY42rNW+4SWG7yComJVhrM6XBby3bfRflTU3gZKNvI3LyaamRH5OjwxcYHOm09dbfmNI
 t1ix14MoqSf120rnu5QbAzkF79vwWQKxhqXPBnXMc0lOXCWJtyvXsI0kTP/MMPNK1JUo
 cLZ9SKjeQoOaWjCl1i2knVrN+R/+widRkHLHIBuvg3Dms/8DumzuWQnRndvA3vlc2ra+
 VjSjvDvL9QH/d9g3AYDaj60J1P/SBbs+EHTE1BskRsNLdUgHaE7p93H+uAyK0UdkBANy
 EYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZBMOYzu8UIu95lP7jXMjUUnVweWqbQKsr6KxrGRBejY=;
 b=agbyjGkYEcA8IzRaHlETGdiM+q2nI2sOv7KVaB3coIi68grFq3Dgkp6pPZ36R8EiTh
 bWE0ehvskw+MAkH9WefQQAOqHDfljOFrI9QcWc+9ZsArVjU2XHTMR7cvcXhS/BpE3Hko
 +ln5IyW5Wej3QMX6SL8679jKhS+aLpzRwzMQFKEb8D640It1KZtP8hMKAcpyL5aIF6ru
 ar0r1I9mTpkEgiQXGyYt74D2i5m4G0Q4TRdVXo+3jE6/YOEHMmfLpCDThr2zpN8DdgkX
 wImmFmHWQiQd6oxO9Qkgi4nxAnvJmUuLSW7eTywxxyEgF/7Sh9/N808kXn7CXQWPdzn+
 shZw==
X-Gm-Message-State: APjAAAU3AVKPL2KjDZ9DzWlwLn0QEh01Wu03d0Xnb7Y5ZOC6vL1LlyJS
 95c8SBWipjjlQ8S9cSW0+CU=
X-Google-Smtp-Source: APXvYqxpYPr/pKADhj70YxFWPqP5/wYXfBY0LpRYX2aLllbJNw9nnJFrJ+KG+/AqWzkmIcaviruEwA==
X-Received: by 2002:aa7:93aa:: with SMTP id x10mr15472120pff.83.1566739459240; 
 Sun, 25 Aug 2019 06:24:19 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
 by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 06:24:18 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 04/11] ftrace/hash: add private data field
Date: Sun, 25 Aug 2019 21:23:23 +0800
Message-Id: <20190825132330.5015-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, sparclinux@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We will reuse ftrace_hash to lookup function prototype information. So
we need an additional field to bind ftrace_func_entry to prototype
information.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 kernel/trace/ftrace.c | 17 +++++++----------
 kernel/trace/trace.h  |  6 ++++++
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eca34503f178..a314f0768b2c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1017,11 +1017,6 @@ static bool update_all_ops;
 # error Dynamic ftrace depends on MCOUNT_RECORD
 #endif
 
-struct ftrace_func_entry {
-	struct hlist_node hlist;
-	unsigned long ip;
-};
-
 struct ftrace_func_probe {
 	struct ftrace_probe_ops	*probe_ops;
 	struct ftrace_ops	ops;
@@ -1169,7 +1164,8 @@ static void __add_hash_entry(struct ftrace_hash *hash,
 	hash->count++;
 }
 
-static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
+static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip,
+			  void *priv)
 {
 	struct ftrace_func_entry *entry;
 
@@ -1178,6 +1174,7 @@ static int add_hash_entry(struct ftrace_hash *hash, unsigned long ip)
 		return -ENOMEM;
 
 	entry->ip = ip;
+	entry->priv = priv;
 	__add_hash_entry(hash, entry);
 
 	return 0;
@@ -1346,7 +1343,7 @@ alloc_and_copy_ftrace_hash(int size_bits, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			ret = add_hash_entry(new_hash, entry->ip);
+			ret = add_hash_entry(new_hash, entry->ip, NULL);
 			if (ret < 0)
 				goto free_hash;
 		}
@@ -3694,7 +3691,7 @@ enter_record(struct ftrace_hash *hash, struct dyn_ftrace *rec, int clear_filter)
 		if (entry)
 			return 0;
 
-		ret = add_hash_entry(hash, rec->ip);
+		ret = add_hash_entry(hash, rec->ip, NULL);
 	}
 	return ret;
 }
@@ -4700,7 +4697,7 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 		return 0;
 	}
 
-	return add_hash_entry(hash, ip);
+	return add_hash_entry(hash, ip, NULL);
 }
 
 static int
@@ -5380,7 +5377,7 @@ ftrace_graph_set_hash(struct ftrace_hash *hash, char *buffer)
 
 				if (entry)
 					continue;
-				if (add_hash_entry(hash, rec->ip) < 0)
+				if (add_hash_entry(hash, rec->ip, NULL) < 0)
 					goto out;
 			} else {
 				if (entry) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 005f08629b8b..ad619c73a505 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -882,6 +882,12 @@ struct ftrace_hash {
 	struct rcu_head		rcu;
 };
 
+struct ftrace_func_entry {
+	struct hlist_node hlist;
+	unsigned long ip;
+	void *priv;
+};
+
 struct ftrace_func_entry *
 ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip);
 
-- 
2.20.1

