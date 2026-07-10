Return-Path: <linuxppc-dev+bounces-24009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4C9C44506
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 12:32:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxWS42nnXz2yS4;
	Fri, 10 Jul 2026 22:32:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783686740;
	cv=none; b=Ar/rjSCrsY27oUxPms693njvdkiYGatNmGyVYXHn4Mh6kMSsik7I4zJixcTIGGynJvVU6xDS/5YWfI0vlr4mAFNrfoJ3r3RVM81VH4C2Sk3MXkD5eDiQOQ/XVlu8obt0qv342etR4/rv8IFj6jDfE81NhEjEbImqMzTCetbNlmdP2h8dOL6CMot9xTUIBh4/tRPnFFr+4Q4/IhdZqg8V94rPdInrqnJOuxbYJs4zmDaANmB2O9G2lZ5G4L5+ZKEZQIer7K8E7FktzOoCrwPdHVHDDagd3J3mGWZ156oBhK8jIAe/z/iP5JGnXVi2JdVAWT+ZcWbZSXP3wMlVbWoKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783686740; c=relaxed/relaxed;
	bh=j9bD4IBhpI6kl/IPv0de4kYBAwFRAIX3LOAgLp+ZkGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab3jcnqMp7mgSC6+wWSkP+y6FljrOjizp3XjGQQ7dE7inhZUrAlSvnWEYql8jYe5bxAP80z0W3sFaE0hyD+AM5QX7CAz2TC8nGPZPeYZ0UOuu2fH/yuueX2jaKFzH2aRDKYkyPMgy1nRWUoWOxFLau+w2bbZ0p/L26G3+rsYqX+/uHC59eauXw5BnWN3+sbicjjNSwWejtt/u7K4zuYH3nAsURnFvJ/0ZSJ2xzjMDASMo3d01HSjbJBHVRpztyo6LJcq6Q381hFF6o2AY9HLeJKCEYRCA5C9UPZgVw6EKLkqdl8Ji7uB/DSWhH8xNvi7X4ptLu2lSPs/fG3ILmb6JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxWS322Vpz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 22:32:18 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE9AB764C1;
	Fri, 10 Jul 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Fri, 10 Jul 2026 14:32:13 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [patch 13/18] entry: Make trace_syscall_enter() return type bool
Message-ID: <alDmTcgzMlKiio9H@kunlun.suse.cz>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <alDaOw8t-e3rxIPm@redhat.com>
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
In-Reply-To: <alDaOw8t-e3rxIPm@redhat.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLrpyf51xp5ujasy9bitsaikab)]
X-Rspamd-Queue-Id: AE9AB764C1
X-Rspamd-Action: no action

On Fri, Jul 10, 2026 at 01:40:43PM +0200, Oleg Nesterov wrote:
> On 07/10, Michal Suchánek wrote:
> >
> > On Wed, Jul 08, 2026 at 10:34:38PM +0200, Thomas Gleixner wrote:
> > >
> > >   1) The set in stone rule is that if the entry code returns -1L as the
> > >      syscall number then the architecture code has to skip the syscall
> > >      invocation _and_ is not supposed to change the return value.
> >
> > Which stone?
> >
> > Pics or it did not happen.
> >
> > >
> > >   2) There is no guarantee and never has been that any of the involved
> > >      mechanisms (ptrace, seccomp, tracing) will change the return value
> > >      when it sets the syscall number to -1L.
> >
> > For ptrace to correctly emulate a syscall it needs to set the syscall nr
> > to an invalid value on entry, and the desired result if the syscall on
> > exit AFAICT.
> 
> I can only say that ptrace users do want to skip the syscall and set the
> return value on entry.
> 
> See
> 	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
> 	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/
> 
> The changelog explains that currently this doesn't work because
> among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
> broken in this regard.

Or it could be documented that setting the return value has to be done
in the exit trace, and that would than work on any architecture AFAICT.

With ppc and s390 using the same register for the syscall number and
syscall return value it's very much impossible to poke the return value
on entry into a register using the generic register access function. As
of now there is no place to store the value ot of the return value
outside of the registers, either.

And the current PTRACE_SET_SYSCALL_INFO indeed sets the syscall nr and
arguments on entry and the syscall return value on exit, that
disctincion is implemented.

Not sure how the patchset you point out is relevant, it only adds
changes in the exit case.

Thanks

Michal

