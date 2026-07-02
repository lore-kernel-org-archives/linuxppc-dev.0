Return-Path: <linuxppc-dev+bounces-23391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596ADC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:13:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grbQC6M4Qz2yYq;
	Thu, 02 Jul 2026 22:13:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782994419;
	cv=none; b=cD5Mb6KGeRJJ1gBGyT5t9ndNXWAjRap0NqOvQHFGFILqEem4fG+0WcscN+5aEC8FAmfPzBLA7ZluU9UmqmpPcvFDd0GHs+nbBLyJZXauxPye8phDM6aSwTLIklI0fFeA7cTlGkyVj7X1fIfs5m16fQ+UmueRPuzejHRP0jmYn3vEsNLrmmPfzL6GMYSxeRHWo2C1o/JYjdUJQ1ISWTGWY8c6XNYieCEPFJk1u9EKT8PMBga7ybfIm3zyoe2TucvaxUNVxLX5uaZGbD3uFoYUJmddFKAux3y+klw6i/KhCXwfOjfSMhPfu7i11vAwmv6RrjIYBkNdffUAQxo8xwnsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782994419; c=relaxed/relaxed;
	bh=pG91nP4Qi8D32QeUd4BsitFSNWDgLGqTgIw8xUNh8+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCHQQNJg9yMEttCm6MFGsS9lSGFfUqG80vsha/Tzx+k+wXTXnj4fMae9C+ag1HeN8wZKh/WARYTJMH3itRqnNfyf+CdHYHSLAVqhKD+A/N4mfj+yYXYX5xAhHS/47fFpGyXkWrA/BNxq8eIAeaCkzcltHvrBMnBd+pNuaMaypVhnPGR2ouIbPP6DtmskEIcjqV2rP1Ob48H5l/cTIcdSiK9z6+s2qw4DCwBoADATR1LgLzovGEy4+ZHCWC1R8NN6q/R14RPX5HzdkiBURp/g4ThC5P/au1+C+khGM58veUBmlZwveXi1unFNjbkaSW0empcDM/Bs+sSNNaQEg15HcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jr565Sgc; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/WOwDBpZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jr565Sgc; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/WOwDBpZ; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jr565Sgc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/WOwDBpZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=jr565Sgc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/WOwDBpZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grbQB74WDz2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:13:38 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F0D9E760CD;
	Thu,  2 Jul 2026 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782994416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG91nP4Qi8D32QeUd4BsitFSNWDgLGqTgIw8xUNh8+A=;
	b=jr565SgcttfGFJ57yj5mW/Caf6TLN9+Lx6mq64PxA+O9ATWQUkPkG0RxXNcrg1a93uYcSk
	5zgmkUirTTGYfY4obUtbHl6tDLZUi/BiqNPNDbagEgDg/HZEIrATKmtx601l1BjmgZhO3w
	bVm0WF4IJ/zBK2LKchVEPi87ayF4k5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782994416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG91nP4Qi8D32QeUd4BsitFSNWDgLGqTgIw8xUNh8+A=;
	b=/WOwDBpZkW/kZJAISaF6tFoIBWgRZQ8bt0TWva7XM2NIT68dvWn8p8bB5zOLrjpDr24bSX
	dzqh10mmIkHj/TDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jr565Sgc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/WOwDBpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782994416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG91nP4Qi8D32QeUd4BsitFSNWDgLGqTgIw8xUNh8+A=;
	b=jr565SgcttfGFJ57yj5mW/Caf6TLN9+Lx6mq64PxA+O9ATWQUkPkG0RxXNcrg1a93uYcSk
	5zgmkUirTTGYfY4obUtbHl6tDLZUi/BiqNPNDbagEgDg/HZEIrATKmtx601l1BjmgZhO3w
	bVm0WF4IJ/zBK2LKchVEPi87ayF4k5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782994416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pG91nP4Qi8D32QeUd4BsitFSNWDgLGqTgIw8xUNh8+A=;
	b=/WOwDBpZkW/kZJAISaF6tFoIBWgRZQ8bt0TWva7XM2NIT68dvWn8p8bB5zOLrjpDr24bSX
	dzqh10mmIkHj/TDA==
Date: Thu, 2 Jul 2026 14:13:34 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Sven Schnelle <svens@linux.ibm.com>
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
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <akZV7kjVh37z63Nz@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <yt9dechlbyj0.fsf@linux.ibm.com>
 <akYreY_BHuRbxSsO@kunlun.suse.cz>
 <yt9d5x2xbny9.fsf@linux.ibm.com>
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
In-Reply-To: <yt9d5x2xbny9.fsf@linux.ibm.com>
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [16.56 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.87)[0.958];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	R_RATELIMIT(0.00)[to_ip_from(RL5ct4uf71gj8hk4gmisc87btw)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,lwn.net,linuxfoundation.org,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,donnellan.id.au,arm.com,arndb.de,flygoat.com,sifive.com,linutronix.de,rivosinc.com,cispa.de,bytedance.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.infradead.org];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from]
X-Spamd-Bar: ++++++++++++++++
X-Rspamd-Queue-Id: F0D9E760CD
X-Spam: Yes

On Thu, Jul 02, 2026 at 02:01:02PM +0200, Sven Schnelle wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> 
> > On Thu, Jul 02, 2026 at 10:12:35AM +0200, Sven Schnelle wrote:
> >> Michal Suchánek <msuchanek@suse.de> writes:
> >> 
> >> > The return value of syscall_enter_from_user_mode is used both for the
> >> > adjusted syscall number and the indicator that a syscall should be
> >> > skipped.
> >> >
> >> > As seccomp can be invoked on any syscall, including invalid ones this
> >> > somewhat undermines seccomp.
> >> >
> >> > While the seccomp variants that terminate the process do not need to
> >> > care about this for the filter that sets the syscall return value this
> >> > disctinction is required.
> >> >
> >> > Pass the syscall number as a pointer to the inline entry functions, and
> >> > use the return value exclusively for the indication that the syscall is
> >> > already handled.
> >> >
> >> > This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is the
> >> > workaround for exactly this deficiency.
> >> 
> >> I'm not sure whether PIF_SYSCALL_RET_SET can be removed - the syscall
> >> return might still get set by PTRACE_SET_SYSCALL_INFO when the tracee is
> >> stopped. This might be a positive number which can't be distinguished
> >> from a syscall number. But maybe i'm missing something? It's been quite
> >> a while since I touched all that ptrace stuff.
> >
> > When the syscall return value is set (in the registers) the return value
> > which is also the modified syscall number is set to -1 indicating the
> > syscall was handled. At least that's how the API is described.
> >
> > So yes, if the syscall number range is restricted or the syscall number
> > is returned through a path different from the function return value the
> > flag should not be needed in the entry path because the case can be
> > detected through the return value alone.
> 
> I'm still failing to see how this would work without an additional
> flag. Assume a program (the tracee) is stopped because of a syscall
> entry. The tracer then decides to skip the syscall and changes
> regs->gpr2 (which contains either the syscall number or return value)
> to contain 42. When the tracer than restarts the syscall, how does
> do_syscall() know that gpr2 is now a return value and not a syscall number?

Because then the return value from the syscall_enter_from_user_mode
machinery would be -1 indicating the syscall should be skipped. That is
how the return value of syscall_enter_from_user_mode is documented, I
did not verify that it actually works that way for the tracing case on
s390.

So long as it is clarified that -1 is not a syscall number or the
syscall number is retuned elsewhere there is no doubt, the -1 indicates
already handled syscall without the need for an additional flag.

Thanks

Michal

