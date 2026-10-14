Return-Path: <linuxppc-dev+bounces-29473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDABCC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:07:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4T1Z22Kxz2yYY;
	Wed, 14 Oct 2026 22:07:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791976034;
	cv=none; b=VeC6suCHt7A7uXmBH5Hct/p3N0tNuWlgoJlgjxu72H05dtqdMCRVjZ0LDuu79Kkn29Zlcp+90YnrmAWEIeEdBp2b4Xzfuud9dnw9EAkGGjG13joQtUfverCUPF8C8wP6GhLuGK2RK59cD6DbwSLyC6pGVr3aeybls/FUS0301JhzKCWwiYOxwrtBfqW/uZyVlLk+NYl42Aed49JJFTHt/k5NSTFH54H71iZNRkwfAz9rYn1p69UWhe7A2OIvylxAc2lnYMX0hOhugQx7rdTEQhV+WrmNAVNI6PWOWFAFNM7FklW3eP1PqMGTYxTbCb/amuDhICuvdXYLWianvZw+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791976034; c=relaxed/relaxed;
	bh=Fqfz4FqHmPjKmiOvV09BQEfUVBjllfgMzInJL9+6UX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD8VMXQ+E0esue/Q5Uzjn500SloXWDnd/vmcbvLXNJwwYMzwNAXrQNC0MEKIGI0a2D59Ng4NL6dBtcpkbeKNMkuMmUotcdIGrlVX6zeas36EtwegzCctePI4mMHY0qCu9WDntOWzSEBFDBZT5gITQ0MucQhYYbo37UqafymBqytggrhiDX3G2i6PnEpWTcpur//hwdo9BABq7+/hE/t/a4grCsRYuyCCk+1tR+eF0lxfugxg+DVk6KKx+qFzHsAGcu7bBlW8qg8+HYn7iI2wlMCQWVd4Jim34xioFX3hhMcus77UkYwEgHKn2oXKP2+WGxeNOuBQCXaqQOmqLTUeMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=udOVM874; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fvFqMrOQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nL2WqkNc; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FJkUKVDU; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=udOVM874;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=fvFqMrOQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nL2WqkNc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FJkUKVDU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4T1Y1XkSz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 22:07:12 +1100 (AEDT)
Received: from tenko.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::11d2])
	by smtp-out2.suse.de (Postfix) with ESMTP id D26051FAC2;
	Wed, 14 Oct 2026 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791976030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqfz4FqHmPjKmiOvV09BQEfUVBjllfgMzInJL9+6UX4=;
	b=udOVM874v1t9TOBUPLEk5+rt+zEYaB8bqdn3+Ew6r0WLafKVFLtPB9o1MhTYLGtp3lA14c
	727Tpb2NyZKgThqNvCAzfwWwtH7JJBvyr8XnyI9xBqhvq5A2tYIGSJuS1Uu2DItcXsDxO9
	WGHqdVknqWrIuKzPcVBhSYrgl0XEXuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791976030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqfz4FqHmPjKmiOvV09BQEfUVBjllfgMzInJL9+6UX4=;
	b=fvFqMrOQ5p/Vv9iBL3ksla8SQjYRI0SwFighAq2K2BIsMG9NejBQ3AEfSEVvHhbnO5PQM2
	QA5HikOcS5s+ZfDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nL2WqkNc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FJkUKVDU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791976029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqfz4FqHmPjKmiOvV09BQEfUVBjllfgMzInJL9+6UX4=;
	b=nL2WqkNcIytGwg144n9+Kdg6jKn6uokr2y2P7MJtNrxcIOB+812EHCIfjk19CAJkpWt/2P
	fs1jHNzjDvkOi24Z8AvpP1zrlqiKSI6ODXlfrYvhf9gNeAZOBNPMnf16U4gP3RWKjgHzCb
	GgJBwYGJMfDSFxImfd+kmlmsUliNefg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791976029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fqfz4FqHmPjKmiOvV09BQEfUVBjllfgMzInJL9+6UX4=;
	b=FJkUKVDUO3gIdeUjMBmOqF/iL7rDxvfdmhfD29NcH1RCfT688ce5jo3pTgz6yS/IvfTguS
	ps36cqrsP6wpF1Dw==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	"Bernhard M. Wiedemann" <bwiedemann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc: Remove unused thread info flags
Date: Wed, 14 Oct 2026 13:06:52 +0200
Message-ID: <f6c831c95f1171e0b82353e611485231482f3deb.1791975972.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
References: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [17.19 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(3.00)[1.000];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[tenko.suse.cz];
	RDNS_NONE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[tenko.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DIRECT_TO_MX(0.00)[git-send-email 2.51.0];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::11d2:from];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amacapital.net,chromium.org,vger.kernel.org];
	R_RATELIMIT(0.00)[to_ip_from(RLjgs4cuidjxpabfgup3qhaian)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: +++++++++++++++++
X-Rspamd-Queue-Id: D26051FAC2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam: Yes

These are no longer used with the generic entry code

Fixes: 6ed60999d33d4 ("powerpc: Remove unused functions")
Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/thread_info.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 31a7a157bc902..f05975a658a63 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -96,22 +96,17 @@ void arch_setup_new_exec(void);
 /*
  * thread information flag bit numbers
  */
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
-#define TIF_SYSCALL_EMU		4	/* syscall emulation active */
 #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
 #define TIF_PATCH_PENDING	6	/* pending live patching update */
-#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
-#define TIF_SECCOMP		10	/* secure computing */
 #define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
 #define TIF_NOERROR		12	/* Force successful syscall return */
 #define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
 #define TIF_UPROBE		14	/* breakpointed or single-stepping */
-#define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
 #define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
 						for stack store? */
 #define TIF_MEMDIE		17	/* is terminating due to OOM killer */
@@ -123,7 +118,6 @@ void arch_setup_new_exec(void);
 #define TIF_SYSCALL_RET		21	/* syscall error value set */
 
 /* as above, but as bit values */
-#define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
@@ -132,16 +126,12 @@ void arch_setup_new_exec(void);
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
 #define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
-#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
-#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
-#define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
-#define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
-- 
2.51.0


