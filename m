Return-Path: <linuxppc-dev+bounces-24010-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59147C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 12:53:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxWwR5Kxbz2yS4;
	Fri, 10 Jul 2026 22:53:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783688007;
	cv=none; b=eh3UjSIosvCRY6DtsvMiUg8U0b0gfOzoP9sHhFHS5G7tyEeXebFlvBRQPGN7PEAo923tBYy2NagzuUvJr0RSm54uU1fsHNGnbCHpBGP3iithkyC2h3mPFX9U5rgTDzxDCztmqf6xEo/r+xABnZ7rwHgNq9qIrQAxEE5ygciClGfNAV0MxoytpT7IBpQJviXXclok/pxQZMrWW77gYAP+6o9qugV44DbqVf44g4I9pMYnDQlDXkVFJ6Bm4QClZpVPkTlJ5FIfXmX8j+JSBcgPO4hitPIvzPEsg372J1NrSiJJfNmd8BlTbC3zFtbYmDzBOtXq160OkM8S3vXEQiYV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783688007; c=relaxed/relaxed;
	bh=XTxMckJ71iKdcnC625lbZ9WJQgTp+gyXuVTaxsSZYeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TMdF40rcoYdYc5db7j3lqqQBBmgR0WH1Qg+d3PFSxYRf4gAIH9dJKBwen2oZzRRkiJ9O3AOu9WZIPUKfGqwyCXXn57iGn78X6kfAr5mSQyfQcVaUOQaXx1SnIl0auk8ONh4q+v9I4E630Lh+7YG+eFTw5bv5+lhzJrXEVJfN01zaFk+PEdTkgMJFBH7Juyh73QGSx3YzeUQYUDb11kwwVCzi2W9trOguGjlDy/hBsWPeSD1j1nuyYJzzMjr+9NBNN8c9Ly9vtOuBj4/A6IrtV9jsJzc7usHsiB54q1R5lkziZ/Ve4b/bKHkdWBrGUDO3CGcb6mc7q0i52J8EXSKhag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKQziX13; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKQziX13; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKQziX13;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XKQziX13;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxWwQ2rHPz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 22:53:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783688001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxMckJ71iKdcnC625lbZ9WJQgTp+gyXuVTaxsSZYeA=;
	b=XKQziX13RDyDukQUQLyX/POZiS12S6mMS3QOOR0PNC1tOptHfBq/MAnq4Z0CBNetS4GQ1F
	ykC4zpjUNDP4szF0W3yfGBY/TznNwcql84JRpKdZdedQT/pcPSEY+W8O8G3UszPhL2fToA
	ll845x30fQTu0OUgYXxyhZPv6kesA4M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783688001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTxMckJ71iKdcnC625lbZ9WJQgTp+gyXuVTaxsSZYeA=;
	b=XKQziX13RDyDukQUQLyX/POZiS12S6mMS3QOOR0PNC1tOptHfBq/MAnq4Z0CBNetS4GQ1F
	ykC4zpjUNDP4szF0W3yfGBY/TznNwcql84JRpKdZdedQT/pcPSEY+W8O8G3UszPhL2fToA
	ll845x30fQTu0OUgYXxyhZPv6kesA4M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-duefXCb_NOaqJcpTJsNlCw-1; Fri,
 10 Jul 2026 08:53:17 -0400
X-MC-Unique: duefXCb_NOaqJcpTJsNlCw-1
X-Mimecast-MFC-AGG-ID: duefXCb_NOaqJcpTJsNlCw_1783687991
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAE061801379;
	Fri, 10 Jul 2026 12:53:07 +0000 (UTC)
Received: from fedora (unknown [10.44.49.164])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8AEF2180029C;
	Fri, 10 Jul 2026 12:52:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 10 Jul 2026 14:53:07 +0200 (CEST)
Date: Fri, 10 Jul 2026 14:52:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
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
Message-ID: <alDrGBMdTuoLcVyy@redhat.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.338083894@kernel.org>
 <ak5ySpil83TNWxeq@kunlun.suse.cz>
 <87se5tqkyp.ffs@fw13>
 <alDQ7isUKJFl8Va4@kunlun.suse.cz>
 <alDaOw8t-e3rxIPm@redhat.com>
 <alDmTcgzMlKiio9H@kunlun.suse.cz>
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
In-Reply-To: <alDmTcgzMlKiio9H@kunlun.suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: tCLGXPPJp2XWs7A8LNr_RoAX5zU9LDEWnXo4LXWCb-E_1783687991
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 07/10, Michal Suchánek wrote:
>
> On Fri, Jul 10, 2026 at 01:40:43PM +0200, Oleg Nesterov wrote:
> >
> > I can only say that ptrace users do want to skip the syscall and set the
> > return value on entry.
> >
> > See
> > 	[PATCH v5 1/2] ptrace: add PTRACE_SET_SYSCALL_INFO syscall skipping support
> > 	https://lore.kernel.org/all/20260709100949.94345-2-renzo@cs.unibo.it/
> >
> > The changelog explains that currently this doesn't work because
> > among the arches which define HAVE_ARCH_TRACEHOOK (at least) arch/mips is
> > broken in this regard.
>
> Or it could be documented that setting the return value has to be done
> in the exit trace, and that would than work on any architecture AFAICT.

Well, ptrace users know the problem. And this what they have to do
currently.

> With ppc and s390 using the same register for the syscall number and
> syscall return value it's very much impossible to poke the return value
> on entry into a register using the generic register access function. As
> of now there is no place to store the value ot of the return value
> outside of the registers, either.

I know nothing about ppc and s390. Can't comment right now.

> And the current PTRACE_SET_SYSCALL_INFO indeed sets the syscall nr and
> arguments on entry and the syscall return value on exit, that
> disctincion is implemented.
>
> Not sure how the patchset you point out is relevant, it only adds
> changes in the exit case.

No. It allows to skip-and-set-retval on PTRACE_EVENT_SECCOMP.

But ENTRY -> EXIT transition is not yet allowed due to the problems
above.

Oleg.


