Return-Path: <linuxppc-dev+bounces-23379-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E738C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 09:30:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grWnv36KYz2xPb;
	Thu, 02 Jul 2026 19:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782984627;
	cv=none; b=SDWcmOMhDxYj/nKGkOsgOOaFjQ6N/xk49RZ/We9ctIC/2OOeBJ6Yw5T5LgBYBsE5iUNL1mBLBo3i0wPXAiH56+NJ1wm4QAEd9XGtaquG9Nbd/HF9ksEyftaSuI6ZqQ9AsE9TDzV8mplOG6NaMQ8TjhAh4sB2pdHtQRrcliaScPaAxSJbx0Nfk2sXFpQOFSHGqHEVhjsDEsTEssTWIkIRqpVXz6LNDK1flkDoh7Bqs0TyoXt7lHRQQwskrajl1PoC8OeR7j4qrie/B/0F9BorJNz+RL6Cl+ruywE79QVt8IqH7OB0z73zYPpVhZS8eeU8EtvhUH/dbzBDTLufKaSb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782984627; c=relaxed/relaxed;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncB+I3WLAQtvh5Cd0CU5XnEir/RwFNRRkdZpka1vuGDqon7Mp96pwRzdGtRPipqflVNjzl95wpVymRVBKxSUvIZLefS1uHhPAALSHhFaRagCNtQAkGtkKfF0/Qbc25WqUM9o3/xPKDIPgOWydH1qcUS+Q0fAJSsxAos2Ou9Th7hd58ryjmPihZhVf33NuudhTmRiZD4a4uXhBYK4vxAPJuhvsZBCe1/Zcnh9QZa2ljrotIYAamQLw87QwaPEfGUzZdXU8rsqrdxDdMB3KS6zRjl4aPYaYkLHUEd/zBVJjzEA4rEVa1dGI4ClP5bExmdCftSmwbBFySEnGwDm6kAIdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VwZTL9J3; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zHrAXApM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VwZTL9J3; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zHrAXApM; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VwZTL9J3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zHrAXApM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VwZTL9J3;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zHrAXApM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grWnt24FYz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 19:30:25 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07598740EC;
	Thu,  2 Jul 2026 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782984622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=VwZTL9J3aRvgi4LbvLAOQMkkVyhoxiDEySmxo6GgsLDYxnemwlOu9Z3DvdzwWlYueEsntf
	R/zYQ6fBSA9nhFH+F4DQqTYGy+Ti8qQcoiL6Dteg50eC6DxRtj+o8KMfgTGLhrHySCpfiq
	HYRAFTETZ70HCm0FYZOp7BiH/sXFQ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782984622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=zHrAXApMECnqKbUH+JL7S7nVqoe6kzJ9OwVhYbDJIsfVlj+nEWi+3Wco6HCWABTCBRZMGY
	tNSSriZ3TujLsoDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VwZTL9J3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zHrAXApM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782984622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=VwZTL9J3aRvgi4LbvLAOQMkkVyhoxiDEySmxo6GgsLDYxnemwlOu9Z3DvdzwWlYueEsntf
	R/zYQ6fBSA9nhFH+F4DQqTYGy+Ti8qQcoiL6Dteg50eC6DxRtj+o8KMfgTGLhrHySCpfiq
	HYRAFTETZ70HCm0FYZOp7BiH/sXFQ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782984622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lWylP9b9cdUhMWrvdJZr9qFySJU8pT1hzR7f9NrXow=;
	b=zHrAXApMECnqKbUH+JL7S7nVqoe6kzJ9OwVhYbDJIsfVlj+nEWi+3Wco6HCWABTCBRZMGY
	tNSSriZ3TujLsoDA==
Date: Thu, 2 Jul 2026 11:30:20 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Zong Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>,
	Deepak Gupta <debug@rivosinc.com>,
	Lukas Gerlach <lukas.gerlach@cispa.de>,
	Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
Message-ID: <akYvrFoMaw4tLuSd@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	RCPT_COUNT_TWELVE(0.00)[45];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	R_RATELIMIT(0.00)[to_ip_from(RLobzcqrzrz177ynxu4a61bckj)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:helo,kunlun.suse.cz:mid,suse.de:email,suse.de:dkim]
X-Spamd-Bar: +++
X-Rspamd-Queue-Id: 07598740EC

On Wed, Jul 01, 2026 at 11:29:01AM -0700, H. Peter Anvin wrote:
> On July 1, 2026 10:42:08 AM PDT, "Michal Suchánek" <msuchanek@suse.de> wrote:
> >The return value of syscall_enter_from_user_mode is used both for the
> >adjusted syscall number and the indicator that a syscall should be
> >skipped.
> >
> >As seccomp can be invoked on any syscall, including invalid ones this
> >somewhat undermines seccomp.
> >
> >While the seccomp variants that terminate the process do not need to
> >care about this for the filter that sets the syscall return value this
> >disctinction is required.
> >
> >Pass the syscall number as a pointer to the inline entry functions, and
> >use the return value exclusively for the indication that the syscall is
> >already handled.
> >
> >This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is the
> >workaround for exactly this deficiency.
> >
> >If this is desirable the patch could be split into some series that
> >adjusts the code flow where needed so that the final change is mostly
> >mechanical.
> >
> >There is also another way to handle this problem.
> >
> >With x86 using bit 30 to denote compatibility syscall it sounds like
> >declaring syscall number a 30bit quantity would work.
> >
> >Then bit 31 could be used to denote an invalid syscall that can never be
> >executed, and the -1 returned from syscall_enter_from_user_mode would
> >then be inherently invalid.
> >
> >That is so long as no architectures use syscall numbers outside of this
> >range so far, and the limitation is considered fine.
> > 
> 
> Negative numbers most definitely not be assigned as valid system calls, not now, not ever. 

Negativity of a number is a matter of intepretation. Sometimes the
syscall number is decleared as int, sometimes long, sometimes unsigned
long.

Passing -1 to strtoul generates some bit pattern that can then be
compared to another bit pattern inside a seccomp filter program, for
example.

> Therein lies some serious madness.
> 
> I believe setting the syscall number to -1 to skip is an ABI already in e.g. ptrace, so I doubt we can just get rid of it anyway. 

Yes, and seccomp can set the syscall number to -1 indicating it was
handled already even if the number was -1 to start with. While -1 is not
a valid syscall number it can still be filtered, at least on some
architectures.

> I would say as follows:
> 
> Let's formally define that: 
> 
> - valid system call numbers are positive 32-bit numbers, using the appropriate ABI convention for "int".
> 
> - bits [30:n] for some value of n are reserved for architecture-specific flags/modes. MIPS uses an offset of 2000 decimal between its syscall ABIs, which would imply n ~ 11, although I personally think that is too restrictive (MIPS could in fact use such a flag to provide an escape into a larger number space if we ever need more than 2000 system calls.)
> 
> I would suggest n = 24, at least for now. It is easier to give up additional bits later than to claw them back when already used. 
> 
> Thus: 
> 
> 1. The type for a system call is int.
> 
> 2. A valid system call number is always going to be positive.
> 
> 3. Bits [30:24] are available for architecture ABI use. The "architecture independent" part of the system call number is therefore 24 bits wide.

Will that also work correctly with seccomp?

As I understand it the current situation is that on x86 the BPF code
passed to seccomp must filter the compat syscall bit in the PBF code,
and I do not see how restricting the syscall value to 24bit would happen
without changing the seccomp filter API.

See eg. https://lore.kernel.org/linuxppc-dev/akTExSO3ZT7iRtBa@kunlun.suse.cz/
for sample code.

> 
> 4. The exact ABI is platform-specific, obviously, but as a general guideline (especially for new platforms/ABIs) should follow the rules for a platform "int" if practical. Notably, when passing a value in a register larger than 32 bits, which side of the calling interface is responsible for sign-extending a value passed in a register. If caller side, the kernel should validate, if callee side the kernel should ignore the additional bits and do the extension.

Do we even want to play with sign-extend?

If the syscall number is >= 1<<n after masking off flags recognized by
the platfrom (if any) it's invalid.

> 5. A negative system call number is guaranteed to return -ENOSYS (unless intercepted by seccomp, ptrace, or another mechanism under user space control.)

Interception by seccomp is exactly the case that's wonky.

> 6. If the platform needs to algorithmically modify the system call number due to platform-specific concerns (say, the platform uses a 16-bit special purpose register for the syscall number, or it has multiple kernel entry points with different behavior), it should if at all possible transcode the system call number as necessary to match this convention in APIs that are exposed to general kernel code. 
> 
> For example, in the future I could very much see the IA32 code in the x86 kernel using bit 29 internally to indicate an ia32 system call, simplifying the is_compat implementation on x86. It should not mean that passing bit 29 to either the syscall instruction or int $0x80 will be accepted.

As I understand the code it uses bit 30 for that. Maybe I missed
something?

Thanks

Michal

