Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DE606A320
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV2cv2fFBz2xSl;
	Thu, 19 Nov 2026 00:34:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795008847;
	cv=none; b=JSci1lWAhUP9Cnt5rH7+sWK3yWtHOoY/+wG9CTsktvO/JxMipdLQ2sr8jgaR5WlQABOA/t91A5t7KybrQgn8u9S+hHQjSW1HfdytOqAD282ZborEJIMovaLPmAqUPpPdUSqrtt27nHiZyV1Gq3tHuVgj30iG7OctsaBdAN1Cpdn7+vf5ONtaB/2V3SF5m6K+4URnmaI0pNUZlHVkgu2EnudUGXcY8FsXGhgz2sNHsqELXPiaiGpPudUNyWXprqtesJGsEhwyoTZ7YVNXvbV178K/XoPu6U36MIUtb7UZqdLRziW5aXpzM5GiyKJBHLySNHVxZZNOOHY+MKQSEtGcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795008847; c=relaxed/relaxed;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPiDN7wEBcCm4/Y7wNfi6d6b3or+CFVAuTSCX0id0GbNcZwUYv5/uW3srZJ3AmJjs8cMQbNts7h3PmPjSWuSF9FZ/PlP5UGouCRqdGzifQ0viIscmAiUI8Gct0XL5eKQXQQZbgVV2OQC29Z0hpGZmSdC9g0W8uxSK+fVuwYJDNc6bpj/kfRQJgdI209I6ol2FNwhpGKpLlDU85LISCSzZc667Igz9aHLBFD+1xVuil7H4+GegW+WZj+Yh0OIBojK8w4OmRLeRiorUX5pFcNxYdEzg+yaohVhlTW/tt0/7HRvDjG7aDSXQhmo1FARRTMp4SVCPhH/N8xMBrPSCSd3Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JDx/rGU0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TEdd3r0n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV2cs6rMSz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 00:34:05 +1100 (AEDT)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D37C1F76B;
	Wed, 18 Nov 2026 13:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795008837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=JDx/rGU0HCc6Ed7gNE8IdTlpVzFAkXIp6dQOuhaLkI4aMqIeZLdi9NuqD6TWvANeQ2yCKK
	B8dN8XDfVBaOzO/CRhgJtQwBigE5LoTdDj+YGomQSUFoJ2iqej0avIAAIiMIPndkaqXi57
	cWNqwc0h27kfVcYcK/V1MDi2E7amH4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795008837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=TEdd3r0nHiekiQs2TDHnWWl2Ub5x6e0ph8fykDPRx0Bc83uNWG+VbMJmhVD/RluGPR4cOH
	8xCFIYgDT7aEtHAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="JDx/rGU0";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TEdd3r0n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795008837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=JDx/rGU0HCc6Ed7gNE8IdTlpVzFAkXIp6dQOuhaLkI4aMqIeZLdi9NuqD6TWvANeQ2yCKK
	B8dN8XDfVBaOzO/CRhgJtQwBigE5LoTdDj+YGomQSUFoJ2iqej0avIAAIiMIPndkaqXi57
	cWNqwc0h27kfVcYcK/V1MDi2E7amH4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795008837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3kW6IHZ/0RLy2LARDOC9HiEbdlANu6Ii4B8shzCZQU=;
	b=TEdd3r0nHiekiQs2TDHnWWl2Ub5x6e0ph8fykDPRx0Bc83uNWG+VbMJmhVD/RluGPR4cOH
	8xCFIYgDT7aEtHAg==
Date: Wed, 18 Nov 2026 14:33:56 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Thomas Gleixner <tglx@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, "Dmitry V . Levin" <ldv@strace.io>,
	Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Davide Berardi <berardi.dav@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org, strace-devel@lists.strace.io
Subject: Re: [PATCH v11 0/3] PTRACE_SET_SYSCALL_INFO: add support for seccomp
 syscall skipping
Message-ID: <av2pRG1JT9te8IiM@kunlun.suse.cz>
References: <20261114181923.370930-1-renzo@cs.unibo.it>
 <av2PKIf8YsEPro8O@kunlun.suse.cz>
 <av2i9kbZyMRJE9D6@cs.unibo.it>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av2i9kbZyMRJE9D6@cs.unibo.it>
X-Spamd-Result: default: False [-6.00 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	RDNS_NONE(1.00)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.958];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,amacapital.net,chromium.org,linux-foundation.org,strace.io,gmail.com,alpha.franken.de,linux.ibm.com,lists.ozlabs.org,lists.strace.io];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 2D37C1F76B
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 02:07:02PM +0100, Renzo Davoli wrote:
> On Wed, Nov 18, 2026 at 12:42:32PM +0100, Michal Suchánek wrote:
> > from a user point of view it is not clear to me why this would be done
> > at the seccomp event when seccomp is not used.
>  
> Hi Michal,
>  
> thank you for the review.
>  
> You are right, and the cover letter does not explain it (only patch 2
> does, briefly). The series is limited to the PTRACE_EVENT_SECCOMP stop
> because that is the only stop where a syscall can currently be skipped
> with a preset return value in an architecture independent way: the
> tracer's request goes through the same path as SECCOMP_RET_ERRNO,
> which every architecture already handles.
> 
> At the syscall entry stop this depends on the architecture's entry
> code. On some architectures (e.g. MIPS) the entry path overwrites the
> return value with -ENOSYS when the syscall is skipped, so the value set
> by the tracer is lost. A tracer that does not otherwise use seccomp
> has to install a SECCOMP_RET_TRACE filter to use this feature.
> 
> > On s390 the removal of such architecture-specific flag is proposed here:
> > [...]
> > While that shows a way to address this problem not all affected
> > architectures implement it.
> 
> Thanks for the pointer. With 05c033db7e9a ("entry, treewide: Make
> syscall_enter_from_user_mode[_work]() indicate syscall execution") and
> Heiko's s390 fix, the architectures using the generic entry code
> preset -ENOSYS and leave the return value alone when the syscall is
> skipped, so skipping at the entry stop could be supported there. As
> in patch 1, a per-task flag checked right after the ptrace entry
> report could be used, so that it does not depend on the syscall
> number.

As I understand it the new s390 code resolves the problem by storing the
syscall number outside of the registers. Then the return value can be
set directly. It does not depend on using the generic entry but on the
architecture adding storage for the syscall number in struct pt_regs,
and implementing the code to determine where to get/set the syscall
value depending on the syscall stage.

However, it seems that extending struct pt_regs breaks userspace ABI
(probably because kernel refuses to transfer partial pt_regs to/fom
userspace) which makes it unclear how the int_code that is used by this
new code could be added to the s390 struct pt_regs in the first place.

Thanks

Michal

