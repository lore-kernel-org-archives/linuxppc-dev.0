Return-Path: <linuxppc-dev+bounces-23906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D528AC44503
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 07:17:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwmWS3bwgz3c9k;
	Thu, 09 Jul 2026 17:17:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783581460;
	cv=none; b=M9qtFTMm1uHXr3w0CyN+ObLyZOo8ERAwfGlThExpWS6xQmacBegmkhiidTTF2ZyfSMVHntNklKDUJ1TNNYLSmSYJcAysnc/uuXYoSYEPWn0fvnGUgvZUITBdHtJjPWdwL1WjdstIunXnDAGuxH9CpVJ/DrAjc4Vh95k7Ipa2bB6kcSCsnaDAksrF9Rf3YyApOvSeZNeF+nRyK+wZlUVnLBfM4cOGn763GKhEffrc8BY0Kv3CihdHQt7d4KUhNJUeihKHao7gIhWJRmjvb1nicckIap4aIYHU07SZUt8l0/OI+i6zioxAasgVQuSUUzaa467k2FQELeeuasbCpKpP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783581460; c=relaxed/relaxed;
	bh=F9SKBxLhUcVP1yEBFgHPNey4vuoMv6f7r4rXayVZwUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AU+LC2K6VwMGt6nJbZSAgX2ZIIJcKqnWksPEkbv3LDHCQOPP3KgVfRGlytta6tzkkPJXMRy8rWRzrZfrAr9izBpEfeKhGbU/SL9OS1h90PiIrPGg8YDLlNXae1k1sS/TNlbQvGqnmHIHJYGjiuibLwzLDoUM9ELcFhFKX3RP1t75vc6t5zwuHZ9cSsowqGffavR9sY/dKkKaq8ajOcmtGBapkQ3bh9EuCs71gyDEmuXn2kkPBzwCwkkAgachgAfzs7wDj4qbIaZSHNov4gf/XtJUwXHyRGNMJ/iDoCK2iywBuXJ+JQaQJzgf+bFO24RdqoslGoHwGVZHi/e8S32SpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PtIuOfMn; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kRB50jqQ; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=PtIuOfMn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=kRB50jqQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwmWQ6fzDz3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 17:17:38 +1000 (AEST)
Date: Thu, 9 Jul 2026 09:17:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783581454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9SKBxLhUcVP1yEBFgHPNey4vuoMv6f7r4rXayVZwUY=;
	b=PtIuOfMnH+4L6RK5zWDYM9QxZ7qFIDDANU9HKLo3euM2pysXCVMwAa7n0WM9qlO40a3voh
	DuJIKMU8fzWSzXZ9l491Z4XBQ0KTIpmeIuhHSzlg0CK5YvnKbZ7s/RIGLP21o2M9L0o7Rj
	zSwnXdwJoMA72KBAhb8rJmxHHKXCqXO6C0wmhoPJoAi3VMyrmMFTka6l8meEuom7fPLR+m
	ZKJ+2UBpVHoAgJDHaBFHf2d85mBPBBieEtIIpIP4KHv9WbVlPQOC6fsZp4ZIgta2kndNxF
	O5hotz+4KOFHBJCxuyk1T/BLRhXpjFxIvYbJmL/KCdibPRgi80mtnrAOWqSnIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783581454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9SKBxLhUcVP1yEBFgHPNey4vuoMv6f7r4rXayVZwUY=;
	b=kRB50jqQviKOML8rg86X/o/Q3HTiZaVrhqXPi05nX1mZw5SlYEe6ldifyk1fa0K1jn//2f
	uWSs1Y9MUuicx9Bg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	geert@linux-m68k.org, tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, luto@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	peterz@infradead.org, wad@chromium.org, thuth@redhat.com, mark.rutland@arm.com, 
	ada.coupriediaz@arm.com, kevin.brodsky@arm.com, linusw@kernel.org, yeoreum.yun@arm.com, 
	song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com, 
	broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com, 
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com, 
	austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de, sohil.mehta@intel.com, 
	andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-csky@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 18/18] arm64: vdso: Expose sigreturn address on vdso
 to the kernel
Message-ID: <20260709090525-b1e5ae06-1fb4-454e-919c-6503dcf3d073@linutronix.de>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-19-ruanjinjie@huawei.com>
 <20260630172619-6c78c2e2-c2d3-44be-88e6-6c82de12baf4@linutronix.de>
 <21875fb4-434b-480d-b68b-e2ffd5fff5ae@huawei.com>
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
In-Reply-To: <21875fb4-434b-480d-b68b-e2ffd5fff5ae@huawei.com>

On Thu, Jul 09, 2026 at 02:37:05PM +0800, Jinjie Ruan wrote:
> On 6/30/2026 11:32 PM, Thomas Weißschuh wrote:
> > On Mon, Jun 29, 2026 at 09:06:16PM +0800, Jinjie Ruan wrote:
(..)

> >> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> >> index 592dd8668de4..5a0314a3c26e 100644
> >> --- a/arch/arm64/kernel/vdso.c
> >> +++ b/arch/arm64/kernel/vdso.c
> >> @@ -343,3 +343,19 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
> >>  
> >>  	return ret;
> >>  }
> >> +
> >> +bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
> >> +{
> >> +	unsigned long sigtramp;
> >> +
> >> +#ifdef CONFIG_COMPAT
> >> +	if (is_compat_task()) {
> >> +		unsigned long sigpage = (unsigned long)current->mm->context.sigpage;
> >> +
> >> +		return regs->pc >= sigpage && regs->pc < (sigpage + PAGE_SIZE);
> >> +	}
> >> +#endif
> >> +	sigtramp = (unsigned long)VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> >> +
> >> +	return regs->pc == (sigtramp + 8);
> > 
> > Instead of hardcoding 'sigtramp + 8' you could add a new label to the 'svc #0'
> > instruction and use that with VDSO_SYMBOL().
> 
> It seems that the modification of __kernel_rt_sigreturn() is not recommended

For the changes to the object code of the function this is obvious and
well explained in the comments.

Such a label however would not change the object code of the function.
In fact it would not change any bit whatsoever in the final vDSO,
save for a new build ID.


Thomas

