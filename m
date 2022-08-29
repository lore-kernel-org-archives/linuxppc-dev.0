Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7A6ECAAD4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Aug 2022 22:12:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MGl6P21p0z3fSG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Aug 2022 08:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=cVg/tOxX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--surenb.bounces.google.com (client-ip=2607:f8b0:4864:20::449; helo=mail-pf1-x449.google.com; envelope-from=38c4nywykdketvsfochpphmf.dpnmjovyqqd-efwmjtut.pambct.psh@flex--surenb.bounces.google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=cVg/tOxX;
	dkim-atps=neutral
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MGk5G02pXz3byL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2022 07:26:09 +1000 (AEST)
Received: by mail-pf1-x449.google.com with SMTP id z36-20020a056a001da400b005386b23cf15so876273pfw.9
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2022 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=MrRcKlTR7zCSrJMQg2Z93mfggQWMfDwWeAi691n34gQ=;
        b=cVg/tOxX8sxsAXVi/E7ByEF0x14KVPhZxGLvuX25A7I6HfsUpP9Yw5fhBx8ozeM60j
         nuDrEi09QA9+LTKC8GajK7CQiyi7gN9srLPx+SGJoGK9+OesuSLiR+9oEBujQJz23p/X
         P3t9ZdRyZDRuaF1wtpM+xaufjpbccFTUx81s4naxMNNB/ygFAADiWbtKwBK4coZj6Khw
         l+lkYHWl+iss5qkPjBxcVIZuDHxj8lggM4wnCJgOdoiaVpSSSGOBOp9823YRpnW7UBz5
         1Wlgpr7ZzU0IbMK3CpPADXeW2X4v/4Fep7gHMya9NlwRNw5kCRaApBpvKmaw4X2L8jbG
         4C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=MrRcKlTR7zCSrJMQg2Z93mfggQWMfDwWeAi691n34gQ=;
        b=nvOdCycVyFSOeBc+CgasfAU64oAavv+X4Mfkl9knoDWl7T3+/w+F2IMOulSISgGrwj
         8z/cdJC++H9n2+33NSwrrgPt0nIG0dlyoB+perdAWQTKfeMz40EyTkwtKsI2PYaxtmdK
         isX+B7cXx+xZofJbkRTztZuEXR++owBFyprGHRov4vtsuZea29IywURHYOy19u0Jn0nD
         hmuHR2KtiryvpBgTHrn1xvQTWcZsArq8Mct9TA6AYVgNwhj+QTfOOgv1xY0VRqTUFrlu
         oeQq8CJXXxw3Tp3Was4Q5mJPyaWnrh2JLHI7MptRjIgYehQgu3xBdQuFW7bZiqGgscR6
         noOg==
X-Gm-Message-State: ACgBeo1wJ8kc1nrAX2f+4jmLjhg+AVlP/hvC+ehSXMf0BOnWy0rDqAta
	eRMPKREfYCIFbf8MO5m9hTlNufaypDs=
X-Google-Smtp-Source: AA6agR6U/5CcVqFo3qhw78HCsOiNZ4QUVwqc0LtUdoOd4ifUOM6ozQmoAsAgpNZOBFg7UV9Y6fDIpWBGaXE=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:aa7:8742:0:b0:537:ee75:601a with SMTP id
 g2-20020aa78742000000b00537ee75601amr12578569pfo.37.1661808368234; Mon, 29
 Aug 2022 14:26:08 -0700 (PDT)
Date: Mon, 29 Aug 2022 21:25:21 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-19-surenb@google.com>
Subject: [RFC PATCH 18/28] mm: add FAULT_FLAG_VMA_LOCK flag
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 30 Aug 2022 08:01:45 +1000
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
Cc: michel@lespinasse.org, joelaf@google.com, songliubraving@fb.com, mhocko@suse.com, david@redhat.com, peterz@infradead.org, bigeasy@linutronix.de, peterx@redhat.com, dhowells@redhat.com, linux-mm@kvack.org, jglisse@google.com, dave@stgolabs.net, minchan@google.com, x86@kernel.org, hughd@google.com, willy@infradead.org, laurent.dufour@fr.ibm.com, linux-arm-kernel@lists.infradead.org, rientjes@google.com, axelrasmussen@google.com, kernel-team@android.com, paulmck@kernel.org, riel@surriel.com, liam.howlett@oracle.com, luto@kernel.org, ldufour@linux.ibm.com, surenb@google.com, vbabka@suse.cz, linuxppc-dev@lists.ozlabs.org, kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mgorman@techsingularity.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add a new flag to distinguish page faults handled under protection of
per-vma lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 3 ++-
 include/linux/mm_types.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0d9c1563c354..7c3190eaabd7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -466,7 +466,8 @@ static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 	{ FAULT_FLAG_USER,		"USER" }, \
 	{ FAULT_FLAG_REMOTE,		"REMOTE" }, \
 	{ FAULT_FLAG_INSTRUCTION,	"INSTRUCTION" }, \
-	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
+	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }, \
+	{ FAULT_FLAG_VMA_LOCK,		"VMA_LOCK" }
 
 /*
  * vm_fault is filled by the pagefault handler and passed to the vma's
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6a03f59c1e78..36562e702baf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -886,6 +886,7 @@ enum fault_flag {
 	FAULT_FLAG_INTERRUPTIBLE =	1 << 9,
 	FAULT_FLAG_UNSHARE =		1 << 10,
 	FAULT_FLAG_ORIG_PTE_VALID =	1 << 11,
+	FAULT_FLAG_VMA_LOCK =		1 << 12,
 };
 
 typedef unsigned int __bitwise zap_flags_t;
-- 
2.37.2.672.g94769d06f0-goog

