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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B9BC3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Aug 2019 14:06:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E040D2070B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Aug 2019 14:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g03zkfsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E040D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46GcQ45LgyzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Aug 2019 00:06:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="g03zkfsq"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46GbTx5tjBzDqfc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2019 23:25:09 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id u17so8740661pgi.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2019 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NnHjdka8q9MM1nbcRBaxfkCGVCCjsDG70zM+YYdNV3E=;
 b=g03zkfsq+c6M14xC3btV7g6IPmWaG8X+9s5nY7dD43zw7K8+Dl6zmdV/meLJmfcsMD
 /XzawISKOMxF9+tzCwu74cViPpHxmr/GarsoBsTn/ENQVJNySASP3aLxbeDN7HAHeP7x
 5AqjpbMw/SWUexnfZkPSUIB379U8mtrc4sNHcxkuWU4mRUZg6at+EX63IeNV5JvMSKsP
 dwxVFHi7nznxJzkCv1jujm1jXMieR9Eb+5viooHTscZhT58A5U5DAPY7JJfRziAsgBjm
 JRivX+QMRW56PFrMRP81NpX/zHCaOTF8BBRZ+789DiMV5Tbs37PC1YPOlEkouAyarn5N
 J2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NnHjdka8q9MM1nbcRBaxfkCGVCCjsDG70zM+YYdNV3E=;
 b=ZnbxWeAnPCu9s+LCUrVe8Zc5V/CoKptRwukRKcVf6viqxcqGPfxNqM/PjR3g5Vjvym
 w/OcUuq6jOOfvaDCKt8cobhCaJ/cu2R4jWibRCSwpBGgLMQMB/dY9ZQHg94rj3Waht52
 AJkbxIEdYaHpq6aoXDTsfkXMyr7t04VlvyMESJnjowHfyeK7pe9lOCM1nXefQAHo+Wp2
 vh1eEC8Mvva5cKh5t66nugNqQh7AF5M0eVqBTcluWbHZJK+IWgFBTwRmhaTsNmBKR94v
 S9yuDET1Xw3WLWtyTjuZTrXwXMA+og61Df8PRliHg0qJh4VgAd/9Z+Q4ND7+NSELWOAO
 +xVw==
X-Gm-Message-State: APjAAAU+qA/oT0tAI7UwPoTNSTIzxSu3sBcusiVJN1Deeowelxkr70AM
 qiCyx4OWKAEhOWTdpHYI5nM=
X-Google-Smtp-Source: APXvYqyz1vAktHcdxrCebWGWWISA04KQUpd77awztbV1MU/g3rutrKQ4McqGMrzQW2zfpUUXANHC4Q==
X-Received: by 2002:aa7:97aa:: with SMTP id d10mr15293204pfq.176.1566739506119; 
 Sun, 25 Aug 2019 06:25:06 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
 by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2019 06:25:05 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 10/11] ftrace: add doc for new option record-funcproto
Date: Sun, 25 Aug 2019 21:23:29 +0800
Message-Id: <20190825132330.5015-11-changbin.du@gmail.com>
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

Just add the doc for our new feature.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/trace/ftrace.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index f60079259669..c68fbbedb8bd 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -988,6 +988,7 @@ To see what is available, simply cat the file::
 	nolatency-format
 	record-cmd
 	norecord-tgid
+	norecord-funcproto
 	overwrite
 	nodisable_on_free
 	irq-info
@@ -1131,6 +1132,11 @@ Here are the available options:
 	mapped Thread Group IDs (TGID) mapping to pids. See
 	"saved_tgids".
 
+  record-funcproto
+	Record function parameters and return value. This option
+	is only supported by function_graph tracer on x86_64
+	platform by now.
+
   overwrite
 	This controls what happens when the trace buffer is
 	full. If "1" (default), the oldest events are
-- 
2.20.1

