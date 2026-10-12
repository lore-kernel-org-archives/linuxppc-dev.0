Return-Path: <linuxppc-dev+bounces-29276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4BCC6B02
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 17:38:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3PpG5Nz0z3brc;
	Tue, 13 Oct 2026 04:38:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791826726;
	cv=none; b=WGJDTmTdf86wd3y//eTS+N2jF6rWJBC8ChlGMD5sTwBgd/g+RSXJR2vCpMynSMNCNKe8M9eqGCqPaEcJq6GKQS98wq1rEThJS4q7lBXDsNunJka1XXwhIBgRm3sylnSbDXw7IMBurEFp7N9F9KC71gs5WGsIcsBsFLnkq83HmM235lu+MNmNMDWIAGktog8x1mxhBPpmt5+R8RgS/3YWk0/Q4/u5i5j+R0Y35YR3340KwC8ulJoy/YZXO2je41HxuCDt/bKRXoe3lWdZgXx4SETYEbyn2TXlgt+Qdv29tPl+SNCvf1Os2b36zz6v3jSaDWPppBDCWRyL9ZumyGwAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791826726; c=relaxed/relaxed;
	bh=h357NitoRH0zuiUywkFzsYaKadkXBUUrN/FvXhuqWY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvT2BOhMnVUclaf/S/aKSx9ci/DgHzXB5b3jhWoXPPqXVAJ8cRXs+90ipbJ+Vq4WkZ2zWlMoS7FDjDTDADXxoxnFW8GpP7DwYZ2/5Gh1xSorrsaFlD5pNnVv4NVjmo26KcGd0yV65pZ1XHM0602Mcg8tErOQ9ghDcQzYv+03MlN7g4VbaPkSzGiQYnJ0CrcNEVT8cO+N2SBy2Y+2WeBMQ7itogYgDun8p7d0PiNO54HH7LHBfWN3TI2P7L8IkAzasVczuT9QnsrMYYAY3RRqzVABi2WC0qywblugRrTDy7f5qBGewW7M2VrptCzo5xH8dw0ESzjyyWxDC2Hd0YsP/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qKO3uZ82; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xhPDN8OE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qKO3uZ82; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xhPDN8OE; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qKO3uZ82;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xhPDN8OE;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qKO3uZ82;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xhPDN8OE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3PpF6n1Gz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 04:38:45 +1100 (AEDT)
Received: from tenko.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::11d2])
	by smtp-out1.suse.de (Postfix) with ESMTP id CE83B21EB3;
	Mon, 12 Oct 2026 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791826722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h357NitoRH0zuiUywkFzsYaKadkXBUUrN/FvXhuqWY8=;
	b=qKO3uZ82WLR3OlgKr0k6LTF/5dFMdglQneTO7tZzo6YpBzyMSiD+zT3uUYfHlKoZ+Dq8Px
	mWOzahuTaWosVWlKd0iXFI67kRxe6E8M9clwO63qlxGlp2XthAjNdlgZ5TLM0B3FnhSHUl
	I/j0ayU/nxEF+38j9zUNM99qRMf0mqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791826722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h357NitoRH0zuiUywkFzsYaKadkXBUUrN/FvXhuqWY8=;
	b=xhPDN8OEuVgzq5FsZvVj4TqSK+u/QQep9b72EpHdNtMX93IiUBs0F8Zl/fmJK/lE0f7NHw
	D3kMbt6zyOOdE/Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qKO3uZ82;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xhPDN8OE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791826722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h357NitoRH0zuiUywkFzsYaKadkXBUUrN/FvXhuqWY8=;
	b=qKO3uZ82WLR3OlgKr0k6LTF/5dFMdglQneTO7tZzo6YpBzyMSiD+zT3uUYfHlKoZ+Dq8Px
	mWOzahuTaWosVWlKd0iXFI67kRxe6E8M9clwO63qlxGlp2XthAjNdlgZ5TLM0B3FnhSHUl
	I/j0ayU/nxEF+38j9zUNM99qRMf0mqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791826722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h357NitoRH0zuiUywkFzsYaKadkXBUUrN/FvXhuqWY8=;
	b=xhPDN8OEuVgzq5FsZvVj4TqSK+u/QQep9b72EpHdNtMX93IiUBs0F8Zl/fmJK/lE0f7NHw
	D3kMbt6zyOOdE/Dw==
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
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	"Bernhard M. Wiedemann" <bwiedemann@suse.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: Remove unused thread info flags
Date: Mon, 12 Oct 2026 19:38:29 +0200
Message-ID: <dcbd135c06fcf013b8aa902fbea8f6b1827d06c2.1791826411.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
References: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
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
X-Spamd-Bar: ++++
X-Rspamd-Queue-Id: CE83B21EB3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[tenko.suse.cz];
	RDNS_NONE(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[tenko.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DIRECT_TO_MX(0.00)[git-send-email 2.51.0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amacapital.net,chromium.org,arm.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::11d2:from];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	R_RATELIMIT(0.00)[to_ip_from(RLjgs4cuidjxpabfgup3qhaian)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

These are no longer used with the generic entry code

Fixes: 6ed60999d33d4 ("powerpc: Remove unused functions")
Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/thread_info.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 0e8dc71c8d3fe..4b7ec1db30349 100644
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


