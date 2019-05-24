Return-Path: <SRS0=LfN0=TY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2B7C282E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 23:52:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F055921848
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 May 2019 23:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="SSXTBiyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F055921848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 459jqD5W1VzDqYj
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 May 2019 09:52:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=joelfernandes.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=joel@joelfernandes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=joelfernandes.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org
 header.b="SSXTBiyM"; dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 459jln1rDbzDqTp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 May 2019 09:49:55 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id z26so6194911pfg.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2019 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=joelfernandes.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bXWjSqu/FFDZjQmYhe/qCEvEUInVu4DGSKgcOvRdwjk=;
 b=SSXTBiyMSX/oc9HkyPWBiENbVB5RnisYOqxhJCIZctnnw4EmW8cl8FzFFjAH+4NrfU
 ycGfsE5BYbGlQVqUDXG2lz9tDP3wyv961R0l1Ds9cgmFUTBciKFz4usoD8uCV/iZ1yXu
 0zf3fcT+r3UfqasFzvYgNdH1NARFxk7hru+xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bXWjSqu/FFDZjQmYhe/qCEvEUInVu4DGSKgcOvRdwjk=;
 b=Y+1rG9AokUebhWeojdWgFHSDdqs2Wilt9Bh9BggPbF0VlZ3t73z6aVtMs1Fmb6htqh
 d/zy4LAm9sa+NfM8WaDEJoyOsMBUy3cqmTGy69b7GaAIERfLafpjDDQPP5xIeCSFT1Vl
 dv/5nXOiLgkZmWrsJoVBMdx34uqjyPEkBhssDnb5l8Fq84FnwpG1ep8POos11idOQ3S0
 yrohDlVwPP36ZjpmWL4u8NnHYAhpZng9EUc2Iks8NMBHY7HlPfilw6VUJT7cXoMPeXUC
 3Q6YjoLdkwY8wCWutbIlqc/WOnLj4oUTC4He9UiNXkIJwEaJVVR9ws2J9OYFVe0gIfy8
 E+QQ==
X-Gm-Message-State: APjAAAXWcMw3irj43GggNwye4uIePivTrCgvde1YCQyBoPwlPeh39kKV
 4PWvpKfXwvPnaM80skJnI0Lk/Q==
X-Google-Smtp-Source: APXvYqwYPAfpLOZID2qY5FFKB8wspcViNi7JQIMMdziXW7MOAadx9VfLL1DAMlFCYOxsbuu8c0vHmg==
X-Received: by 2002:a62:7d10:: with SMTP id
 y16mr116480258pfc.116.1558741792000; 
 Fri, 24 May 2019 16:49:52 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
 by smtp.gmail.com with ESMTPSA id q4sm3297595pgb.39.2019.05.24.16.49.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 24 May 2019 16:49:50 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/5] Remove some notrace RCU APIs
Date: Fri, 24 May 2019 19:49:28 -0400
Message-Id: <20190524234933.5133-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
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
Cc: rcu@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
 Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
 "Paul E. McKenney" <paulmck@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The series removes users of the following APIs, and the APIs themselves, since
the regular non - _notrace variants don't do any tracing anyway.
 * hlist_for_each_entry_rcu_notrace
 * rcu_dereference_raw_notrace

Joel Fernandes (Google) (5):
powerpc: Use regular rcu_dereference_raw API
trace: Use regular rcu_dereference_raw API
hashtable: Use the regular hlist_for_each_entry_rcu API
rculist: Remove hlist_for_each_entry_rcu_notrace since no users
rcu: Remove rcu_dereference_raw_notrace since no users

.clang-format                                 |  1 -
.../RCU/Design/Requirements/Requirements.html |  6 +++---
arch/powerpc/include/asm/kvm_book3s_64.h      |  2 +-
include/linux/hashtable.h                     |  2 +-
include/linux/rculist.h                       | 20 -------------------
include/linux/rcupdate.h                      |  9 ---------
kernel/trace/ftrace.c                         |  4 ++--
kernel/trace/ftrace_internal.h                |  8 ++++----
kernel/trace/trace.c                          |  4 ++--
9 files changed, 13 insertions(+), 43 deletions(-)

--
2.22.0.rc1.257.g3120a18244-goog

