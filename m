Return-Path: <linuxppc-dev+bounces-23471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B02AC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 09:26:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs7g25jzXz2xPb;
	Fri, 03 Jul 2026 19:26:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783070798;
	cv=none; b=I6nTkjtpnP3KLSi8RWqN7y+sF186d6zcyK8MRM8XbMhatBV0eVgKsvSu9gqZTpQTb1RVbQVzt0+h88q/PRAyN3OIaHdpq9GgklmLXaRNGw9XZL8uaojYK/WIAeE6H3alsaj8oinTabMdZPk+BVoAuttW9Kz5h/hWtZ1ux0J++CjroxqskuU7hX9+SayhiKq5OziTx7zuyaD46AftpvZ0wFlZU7gglDQrR/Uxpvz/2zBmuYKRtQA/sQS3BxdX2XKMpTlKx8WArp7sODmiJpUL3lqYx1YK/cp+5fAHuCu4dq5GdIMrYJ2zAspE/3F+7hc8fyKdPGpxK3Q8QIrOyVk9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783070798; c=relaxed/relaxed;
	bh=MPQJV7b7kJxx5txnyZHmL5S4FKlfiNVgVgnkVZMZ+6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkdrEAu9KGxG5/nb0XMIox0+8JO6JNV093ZD+3D3dCXXRWivFcQnX94g/ZW+BC51U92wfM1JPYs5MSSGQuHMS7ntkMqeBXpGscPDUCdZyyTYYkPv+U6BSuYMpNXSc4eO4GkH2z5ulpNovuwdp/WCh0PiRzZ1bveKEiWJ62JzVHyqKXjyMO7wBabVt9IMbKIuDzAjsEK6cDrbYWL+2F1Bb6NjnQ6QA5JqAnw7gOE7qn1+fCSVBCOZkPXjQUBi/C0KKFxC6S8zxidTejJ233WSu3cRZld8onDLK/o8jSdCTUpVyDseqea+xkt6Ck8Kt9USV0hLDok6XH0NfRdQSz0TWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jbJkBVOT; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=jbJkBVOT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs7fw3gz2z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:26:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MPQJV7b7kJxx5txnyZHmL5S4FKlfiNVgVgnkVZMZ+6g=; b=jbJkBVOT/shtiot9Fc2pimpU1C
	HwNC+VKHJMncmc41AF6pUNHHSHoEGiATR5ncPKDf0gGLbv+67XpsMWxpomqvnEWns2uuBP/NddLZt
	steywxZ4WKc2RcW1NM+uxAnQdAAw132ojGrke1r7Pofyl1JkngSK/ZT8m/vnNnUJ/rn4JTxBKp4i0
	U/ASGh0yXX0fXF6pY9FpYaAqDi7txgXPudLUNWL3sk5/nxO8P6rEIu7ZbmelZsUVKfX0VljoEPfZm
	Xs/7RlQubEXJnZR7hTst9g4bBclCh3APcrjBGKulmX625kzp3ZyHOw+tSbkdVvEtqZOW0J1c9UbOk
	HiJJGH8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfa9Z-0000000A4v3-364Y;
	Fri, 03 Jul 2026 09:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7451030035C; Fri, 03 Jul 2026 11:25:44 +0200 (CEST)
Date: Fri, 3 Jul 2026 11:25:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
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
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20260703092544.GB651302@noisy.programming.kicks-ass.net>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
 <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dwlvca8rn.fsf@linux.ibm.com>

On Fri, Jul 03, 2026 at 08:26:36AM +0200, Sven Schnelle wrote:

> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> used for both the syscall number and the syscall return value.
> That was a design mistake early in the begin about 25 years ago, but
> it's ABI now, so it cannot be changed.
> 
> When seccomp decides to skip a syscall, it write a return value into
> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> returns this number. If it's negative all is good - the 'if (likely(nr <
> NR_syscalls))' conditiion would just catch it and skip the syscall.

You do have regs->orig_gpr2; I didn't fully track its usage, but can't
you treat that as the syscall nr and always consider regs->gprs[2] as the
return value?

