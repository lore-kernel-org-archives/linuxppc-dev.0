Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFE760A2600
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGZO0XI4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUpUsyZN;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGZO0XI4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jB70R3v2xz2yDr;
	Sat, 24 Oct 2026 02:55:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792770951;
	cv=none; b=EllchMS/lAgBPXrj05RdlfzlMmEPW5Ejuj/54XlKIhM289BvxvHMfyLaGwkAx9KFQN8rfxgCUzP2tgrJkYnkmDnmNdak5VR8nQvP8fUUDLgXixRumTVDr/E2CBRWd24y7PHi0gFM8l8UXjuRW3TKp8Bvxi6OGykeBeXSh1HTpoWhdjPgpstXq3OU1BXs94LR/1qSRdIPE3c3EQP8cIjp5gqvLNvS0s/srVDdknfRuyxdw094THYh7zFn6lergTf14t8XPi7+LFIcigEi8Agy2nAW3wsCEOXmvMxuJUIISWkY6djk6Nh7Qa+hfcAy8TttdbLrDFwRGzMI6GUkRvcUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792770951; c=relaxed/relaxed;
	bh=ynnFsRlov1ettI6tdNTmf0TbH0h7G/oa8q2L/bW+DQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=VWyOFFqGqMhNehvnVkFYfkwcate/juX1ZGOdZVROwnr6wqwA/x9mBe8n5lfkE82bpxWbUVEAWBnS6/Ic0iPBFryDhrFD9w+bwYYVI/Nqypfk/lbOO4FCQLhPajAPOvoP3y7XTxyR6TBTZIHIVTxA27rVw9d0k3bb0vn+01Nuz3X/blq8XO8nCUmUnssPzVgohtIvqi/WDuB+iDtbwIiy1W1mK9Yuiouhc2aYZVwxrugofR5A9HTiT8I9dWPd/8c9iYcMI3NzZ7DdXmxBdAH9ykfm32r7eWHVOzFFTk/6x8rfwCzg9MZdrPR7KMBHH8tqGb/Vd8NZrzFTuPA8ChCjCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGZO0XI4; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUpUsyZN; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGZO0XI4; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGZO0XI4;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UUpUsyZN;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GGZO0XI4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jmarchan@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jB70Q1KqWz2yDc
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 02:55:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792770943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ynnFsRlov1ettI6tdNTmf0TbH0h7G/oa8q2L/bW+DQ8=;
	b=GGZO0XI4Z2e4a3vHHQ9kqvvC+kU0JbjR0z0bzezIH3wj2iXIS4ej2wDn30qJ+ig66gdyQa
	dljqUtcri91gkuUuFFLiVs89bfVajn1alYD9Xf+TpSwv0EQrTVR4yVN4+90Zrv9VJmKjVq
	isUVv8pJraPoOaLHV3TjFeS8ODE9UkM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792770944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ynnFsRlov1ettI6tdNTmf0TbH0h7G/oa8q2L/bW+DQ8=;
	b=UUpUsyZNj4IY0L1nMcjcXSZkI1qUSJX4sAgb0Ro59P0VkpML7uktQxYv6wUtOSKRCROrnh
	kU7zTFv8leKngXQFfJz6DoVhIB/YLGC3U2cxlUNsFAE5DQ9RxjXCrOQOpaLCe008zjnroh
	iXJJ4lv3mNtym0lLzH3qjggAuEysEhw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792770943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ynnFsRlov1ettI6tdNTmf0TbH0h7G/oa8q2L/bW+DQ8=;
	b=GGZO0XI4Z2e4a3vHHQ9kqvvC+kU0JbjR0z0bzezIH3wj2iXIS4ej2wDn30qJ+ig66gdyQa
	dljqUtcri91gkuUuFFLiVs89bfVajn1alYD9Xf+TpSwv0EQrTVR4yVN4+90Zrv9VJmKjVq
	isUVv8pJraPoOaLHV3TjFeS8ODE9UkM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-BgUftQijMgmoYf_ioMrlPQ-1; Fri,
 23 Oct 2026 11:55:37 -0400
X-MC-Unique: BgUftQijMgmoYf_ioMrlPQ-1
X-Mimecast-MFC-AGG-ID: BgUftQijMgmoYf_ioMrlPQ_1792770936
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F21A818005B1;
	Fri, 23 Oct 2026 15:55:34 +0000 (UTC)
Received: from jmarchan-thinkpadx1carbongen9.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 632451956089;
	Fri, 23 Oct 2026 15:55:31 +0000 (UTC)
From: Jerome Marchand <jmarchan@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH] powerpc: Use raw_local_irq_pmu_save/restore() in local_t functions
Date: Fri, 23 Oct 2026 17:55:29 +0200
Message-ID: <20261023155529.3895393-1-jmarchan@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: 8Dk3ihKvcAkM50ScDDJtdZkYYDYlGbXPWyCGbrY1AxY_1792770936
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On ppc64 with CONFIG_TRACE_IRQFLAGS enabled, the ring buffer code can
enter in an infinite recursion loop.

The problem occurs because some PowerPC's local_t operations
(local_inc/dec in particular) use powerpc_local_irq_pmu_save/restore()
which call trace_hardirqs_on/off() to generate trace events. This
creates a recursion loop:

  ring_buffer_unlock_commit()
    rb_commit()
      local_inc(&cpu_buffer->entries)
        powerpc_local_irq_pmu_save()
          trace_hardirqs_off()
            trace event => ring_buffer_unlock_commit()
              [INFINITE RECURSION]

Use raw_local_irq_pmu_save/restore() instead of their
powerpc_local_* counterparts.

Fixes: 6cd74d2b61749 ("powerpc/64s: Implement local_t using irq soft masking")
Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 arch/powerpc/include/asm/local.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index ec6ced6d7cedf..4c033526bfb0d 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -32,9 +32,9 @@ static __inline__ void local_##op(long i, local_t *l)			\
 {									\
 	unsigned long flags;						\
 									\
-	powerpc_local_irq_pmu_save(flags);				\
-	l->v c_op i;						\
-	powerpc_local_irq_pmu_restore(flags);				\
+	raw_local_irq_pmu_save(flags);					\
+	l->v c_op i;							\
+	raw_local_irq_pmu_restore(flags);				\
 }
 
 #define LOCAL_OP_RETURN(op, c_op)					\
@@ -43,9 +43,9 @@ static __inline__ long local_##op##_return(long a, local_t *l)		\
 	long t;								\
 	unsigned long flags;						\
 									\
-	powerpc_local_irq_pmu_save(flags);				\
+	raw_local_irq_pmu_save(flags);					\
 	t = (l->v c_op a);						\
-	powerpc_local_irq_pmu_restore(flags);				\
+	raw_local_irq_pmu_restore(flags);				\
 									\
 	return t;							\
 }
@@ -81,11 +81,11 @@ static __inline__ long local_cmpxchg(local_t *l, long o, long n)
 	long t;
 	unsigned long flags;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_local_irq_pmu_save(flags);
 	t = l->v;
 	if (t == o)
 		l->v = n;
-	powerpc_local_irq_pmu_restore(flags);
+	raw_local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -106,10 +106,10 @@ static __inline__ long local_xchg(local_t *l, long n)
 	long t;
 	unsigned long flags;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_local_irq_pmu_save(flags);
 	t = l->v;
 	l->v = n;
-	powerpc_local_irq_pmu_restore(flags);
+	raw_local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -128,12 +128,12 @@ static __inline__ bool local_add_unless(local_t *l, long a, long u)
 	unsigned long flags;
 	bool ret = false;
 
-	powerpc_local_irq_pmu_save(flags);
+	raw_local_irq_pmu_save(flags);
 	if (l->v != u) {
 		l->v += a;
 		ret = true;
 	}
-	powerpc_local_irq_pmu_restore(flags);
+	raw_local_irq_pmu_restore(flags);
 
 	return ret;
 }
-- 
2.56.0


