Return-Path: <linuxppc-dev+bounces-22853-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9265CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2026 11:13:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjpbt5Gz1z2xQD;
	Sun, 21 Jun 2026 21:13:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782034676;
	cv=none; b=SNa71HF4uhJ61pEIa3ySplTrBb8d6JQNUebtt9ELLsR+3/oslFUCZJRR+D3aIxh+qAXtkDuk1DtbIYPhNGXVCbQvYPTdTSWj+At0y/48E8WeXvp8o80D8bsFhy4xkFz1bqN77FmoDeCQd0DuS7ljCbi9dVa5Q1C6blumgTyA39Sz5Y3FyjcMqK2aZO9xWllhXADfoFfSOjfhxqWg78BuLRo6qvW97IIkTEbZBq8zMOzhGCrOHuL21vdj1r6m2RRApl5dutgEpHJaYku8/KRp36qFLNvvsWj+AYClBLEJTyomH+4S78M5pZYYNvQP6RFQulpZ3tFkuV9RXOLCe6YoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782034676; c=relaxed/relaxed;
	bh=eq4Jiz0A0s0y1CCaKrigK8iMCmKO2KO/DMw+O1PS1ZY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WYoPj5lIw7XUOi9Y4jm2GiY+26afggCyT0HBKJtoPznUE194A406yUc9g49gX8HptaYUMiA+VYdovpt2CwmT694q7zb2ClEU1KBBr0HPPS13rbxhprJ1bsP/dq9ZTfIiVP+q6Wq4WH3QvmOnkZXZctA/9osQmmO0t/a12iJvDKHVndt07MhDMvXxo8vYVyF+G/toFaGlVhq3s00otIxHqGbTZ/SuFUhwcFHxKKSCb1+eCaUi0Z/FwRCByU2b35xGJTVYd2PGeAesFAW2pt3mniA1DLgvsLdbnP9TyFd0yjB5I6vbX8x/LsrjEFxK5LGAHSXgr/KYVr6XSB4VLRU/2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHYbAcsD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kHYbAcsD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rostedt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjmTb54vHz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 19:37:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BA1C8600AF;
	Sun, 21 Jun 2026 09:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4931F00A3A;
	Sun, 21 Jun 2026 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782034672;
	bh=eq4Jiz0A0s0y1CCaKrigK8iMCmKO2KO/DMw+O1PS1ZY=;
	h=Date:From:To:Cc:Subject:References;
	b=kHYbAcsD3riuZyE8yw/zGyX4OGv8E29ntBrV/psMay3TNT67fA5gNBpeHGFBeZ/12
	 2Ay7PRmR+s6HdarptXq0OjoszuRK4hDjuFDr5zqy5M5pwo3OOG5Rfwzz1hG/+dQ1n8
	 CM2zwSeAYz4lQYZRNadhemupSTJhYAVEj8Z/JGBsC+uxY4TS20hXDjW9EjrTZX/Dl+
	 vMXqPLpJ/wkow6elNFJjsfNE/3ih99IbbRotQdZuC4nu/UA/y3tJKjSTogiiW5YYf5
	 87SMm3+n4xuUToS7j7SvNUKsWt0yz2IfUnDNb9wlqNTm+yoVD5272meD4iMEV5O7Pw
	 ZebFVZP2gqGBg==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wbEd1-00000001qU9-0cPr;
	Sun, 21 Jun 2026 05:38:11 -0400
Message-ID: <20260621093811.007634476@kernel.org>
User-Agent: quilt/0.69
Date: Sun, 21 Jun 2026 05:34:31 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org,
 linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org,
 kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] tracing: Move non-trace_printk prototypes back to kernel.h
References: <20260621093430.264983361@kernel.org>
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
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In order to remove the include to trace_printk.h from kernel.h the tracing
control prototypes need to be moved back into kernel.h. That's because
they are used in other common header files like rcu.h. There's no point in
removing trace_printk.h from kernel.h if it just gets added back to other
common headers.

Prototypes are very cheap for the compiler and should not be an issue.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/kernel.h       | 18 ++++++++++++++++++
 include/linux/trace_printk.h | 17 -----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e5570a16cbb1..c3c68128827c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -194,4 +194,22 @@ extern enum system_states system_state;
 # define REBUILD_DUE_TO_DYNAMIC_FTRACE
 #endif
 
+#ifdef CONFIG_TRACING
+void tracing_on(void);
+void tracing_off(void);
+int tracing_is_on(void);
+void tracing_snapshot(void);
+void tracing_snapshot_alloc(void);
+void tracing_start(void);
+void tracing_stop(void);
+#else
+static inline void tracing_start(void) { }
+static inline void tracing_stop(void) { }
+static inline void tracing_on(void) { }
+static inline void tracing_off(void) { }
+static inline int tracing_is_on(void) { return 0; }
+static inline void tracing_snapshot(void) { }
+static inline void tracing_snapshot_alloc(void) { }
+#endif
+
 #endif
diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 3d54f440dccf..879fed0805fd 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -35,15 +35,6 @@ enum ftrace_dump_mode {
 };
 
 #ifdef CONFIG_TRACING
-void tracing_on(void);
-void tracing_off(void);
-int tracing_is_on(void);
-void tracing_snapshot(void);
-void tracing_snapshot_alloc(void);
-
-extern void tracing_start(void);
-extern void tracing_stop(void);
-
 static inline __printf(1, 2)
 void ____trace_printk_check_format(const char *fmt, ...)
 {
@@ -176,16 +167,8 @@ __ftrace_vprintk(unsigned long ip, const char *fmt, va_list ap);
 
 extern void ftrace_dump(enum ftrace_dump_mode oops_dump_mode);
 #else
-static inline void tracing_start(void) { }
-static inline void tracing_stop(void) { }
 static inline void trace_dump_stack(int skip) { }
 
-static inline void tracing_on(void) { }
-static inline void tracing_off(void) { }
-static inline int tracing_is_on(void) { return 0; }
-static inline void tracing_snapshot(void) { }
-static inline void tracing_snapshot_alloc(void) { }
-
 static inline __printf(1, 2)
 int trace_printk(const char *fmt, ...)
 {
-- 
2.53.0



