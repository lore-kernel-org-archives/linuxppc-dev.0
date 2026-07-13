Return-Path: <linuxppc-dev+bounces-24124-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154E9C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 17:00:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzTGQ2Kr7z2xwN;
	Tue, 14 Jul 2026 03:00:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783962046;
	cv=none; b=bpzYz/RHaUIsYkTjtFG5+7faBC7qQOv2NpNfFWFtE2uAGSIO0rDWOb4Eug8drVy89dr3us0gCwfMWODtf/XZePkyuCUoRjR8BcrUkldEKu5Hvl915gURB3ywmgg/iKNWYKjEMcycee0rLhz+EVJtGFUux4k+V36twbOMf0INx3ToJUaz3fJjP1uQKw8dvdLpg8+VhWS4HcgdgGqO4yG0CAFz7leiraiEmHL9bhsOyffGvstVosT/PwFpIpNDQHhJg+frmOdMvTcOd+GXM6EgqENiUpcsFofX/YXM/iyMP+Ehz9SASr5iXRqu4r1cBoejq9UzvXrZJK6tmcZriT+Nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783962046; c=relaxed/relaxed;
	bh=LMin0ELA0S/qDIAUfN3e2MLbd1C3d6yAWrkFWIFj3NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC+TEfxkG3AezWf7TK0bNPfGbhejNh6X2NTLhsiNRxbySMvoqRhg8+OIsEa4v8kuCb+lcOupReggiW1MnAUeOe87zSm1Cy+FQTNbX/aNETGnQgH8Tqposzvl3tCS8zqCy67STzaCrIvlfolERBim7Wpz6xPVBQ0FEbzD/TyMka6msjuNOvkq/Am7SoRDeNjdKGzHmaRX2grmIOLmDrhJ/8vPMQsRMakRV4msDZWitUv0Z8mEjHzd+vjbVmaKk2qgFQPnvRNX4FxS5jezGme0ktZ+WQilxRCiU0bWunjhBdKwm/Ln1efP3OBoahodiQaU/vNcnmQ/n8dXrTkZIkbCLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k38U9VGp; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MxosFHDV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k38U9VGp; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MxosFHDV; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k38U9VGp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MxosFHDV;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=k38U9VGp;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MxosFHDV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzTGN4fbKz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 03:00:44 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4259676096;
	Mon, 13 Jul 2026 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783962040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMin0ELA0S/qDIAUfN3e2MLbd1C3d6yAWrkFWIFj3NM=;
	b=k38U9VGpm3QZqwrMgrGYZhudou4TosLelMu1WbunbvSqmO5dksCD5c26659+zHqwJbyw5B
	OnaRta1F0bmNDqlN3+ON9Uxo2d7b049PRrpYzcOh97KfrWO12qACQkUqugBnPgNSWNxXQI
	3mihV17Sf95o+W95SmBDGgfrGizSPG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783962040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMin0ELA0S/qDIAUfN3e2MLbd1C3d6yAWrkFWIFj3NM=;
	b=MxosFHDVPDEv59mXM8XmLBMD+Iwc2VP3NSHMdXmxpSw/bQ0Sq1kGSda3TOcu5V9qfpd2Si
	8X9qIT6NRCoVcFDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k38U9VGp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MxosFHDV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783962040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMin0ELA0S/qDIAUfN3e2MLbd1C3d6yAWrkFWIFj3NM=;
	b=k38U9VGpm3QZqwrMgrGYZhudou4TosLelMu1WbunbvSqmO5dksCD5c26659+zHqwJbyw5B
	OnaRta1F0bmNDqlN3+ON9Uxo2d7b049PRrpYzcOh97KfrWO12qACQkUqugBnPgNSWNxXQI
	3mihV17Sf95o+W95SmBDGgfrGizSPG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783962040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMin0ELA0S/qDIAUfN3e2MLbd1C3d6yAWrkFWIFj3NM=;
	b=MxosFHDVPDEv59mXM8XmLBMD+Iwc2VP3NSHMdXmxpSw/bQ0Sq1kGSda3TOcu5V9qfpd2Si
	8X9qIT6NRCoVcFDA==
Date: Mon, 13 Jul 2026 19:00:39 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
Message-ID: <alUZt76QncJ_fbxr@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org>
 <alSlg72c8xmjaj48@kunlun.suse.cz>
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
In-Reply-To: <alSlg72c8xmjaj48@kunlun.suse.cz>
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 4259676096
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_DN_SOME(0.00)[]

On Mon, Jul 13, 2026 at 10:44:51AM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
> > The return values of syscall_enter_from_user_mode[_work]() are
> > non-intuitive. Both functions return the syscall number which should be
> > invoked by the architecture specific syscall entry code. The returned
> > number can be:
> > 
> >   - the unmodified syscall number which was handed in by the caller
> > 
> >   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> > 
> > That has an additional twist. If the return value is -1L then the caller is
> > not allowed to modify the return value as that indicates that the modifying
> > entity requests to abort the syscall and set the return value already. That
> > can obviously not be differentiated from a syscall which handed in -1 as
> > syscall number.
> > 
> > The most trivial way to deal with that is:
> > 
> >     set_return_value(regs, -ENOSYS);
> >     nr = syscall_enter_from_user_mode(regs, nr);
> >     if (valid(nr))
> >     	handle_syscall(regs, nr);
> > 
> > That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> > preset the return value, so when user space hands in -1 and there is
> > nothing setting the return value in the entry work code, then the syscall
> > is skipped but the return value is whatever random data has been in the
> > return value register.
> 
> The reason why PowerPC and S390 do not preset the return value is that
> the return value uses the same register as the syscall number. There are
> apparently other architectures on which the return value overlaps with
> the arguments which also do not preset the return value for that reason.
> If they would use the generic entry the same problem would arise.
> 
> > Change the return values of syscall_enter_from_user_mode[_work]() to
> > boolean and return false, when either ptrace or seccomp request to skip the
> 
> There is a difference between seccomp and ptrace.
> 
> When seccomp indicates to skip the syscall it has also set the syscall
> return value.
> 
> However, when the syscall number is -1 and the return value is not
> preset that does not indicate anything.
> 
> The return value can still hold garbage. ptrace does not have the
> ability to indicate that a syscall is to be skipped, at least on the
> entry trace. It needs to be skipped based on the syscall number being
> invalid.

To be very clear here: When seccomp_permit_syscall() returns false based
on filter result (other than trace filter) it guarantees that the return
value has been set, and then the syscall processing can be skipped, and
it has to be skipped on ppc because the syscall number has been
overwritten by the return value.

ptrace, on the other hand, does not ever provide such guarantee. It does
something unspecified to the registers. Even in the case that the syscall
number is set to -1 nothing is known about the return value.

While on x86 it is preset to -ENOSYS this is an architectural quirk that
the code cannot rely on in general. On ppc the syscall has to be
processed so that the invalid syscall processing sets the return value
to -ENOSYS after syscall_enter_from_user_mode() is done.

ptrace_report_syscall_permit_entry() breaks that by indicating to
skip the syscall processing, resulting in the return value of -1 instead
of -ENOSYS for the -1 syscall.

Thanks

Michal

