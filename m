Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C12C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 12:38:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0678E217D8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 12:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0678E217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JyHK6QS7zDqTv
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:38:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JyDw6lHwzDqSS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 23:36:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JyDw0sYVz9sC7;
 Tue, 18 Dec 2018 23:36:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Dmitry V. Levin" <ldv@altlinux.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@kernel.org>
Subject: powerpc syscall_set_return_value() is confused (was Re: [PATCH v6
 18/27] powerpc: define syscall_get_error())
In-Reply-To: <20181213172313.GR6024@altlinux.org>
References: <20181213171833.GA5240@altlinux.org>
 <20181213172313.GR6024@altlinux.org>
Date: Tue, 18 Dec 2018 23:36:09 +1100
Message-ID: <874lbbt3k6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, linuxppc-dev@lists.ozlabs.org,
 Eugene Syromyatnikov <esyr@redhat.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Dmitry,

"Dmitry V. Levin" <ldv@altlinux.org> writes:
> syscall_get_error() is required to be implemented on this
> architecture in addition to already implemented syscall_get_nr(),
> syscall_get_arguments(), syscall_get_return_value(), and
> syscall_get_arch() functions in order to extend the generic
> ptrace API with PTRACE_GET_SYSCALL_INFO request.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v6: unchanged
>     
>     v5:
>     This change has been tested with
>     tools/testing/selftests/ptrace/get_syscall_info.c and strace,
>     so it's correct from PTRACE_GET_SYSCALL_INFO point of view.
>     
>     This cast doubts on commit v4.3-rc1~86^2~81 that changed
>     syscall_set_return_value() in a way that doesn't quite match
>     syscall_get_error(), but syscall_set_return_value() is out
>     of scope of this series, so I'll just let you know my concerns.

Sorry I only just saw this comment.

It's going to take me a while to page this stuff back into my brain, but
I think you may have a point.

I think the way it's written now *works* but only because it's only used
by seccomp, and we rely on the fact that the syscall exit path will
negate the value before returning to userspace or calling ptrace etc.

eg. we do:

syscall_set_return_value()
	if (error) {
		regs->ccr |= 0x10000000L;
		regs->gpr[3] = error;

then the asm does:

	/* Return code is already in r3 thanks to do_syscall_trace_enter() */
	b	.Lsyscall_exit
	...

.Lsyscall_exit:
	std	r3,RESULT(r1)
	...

3:	cmpld	r3,r11
	ld	r5,_CCR(r1)
	bge-	.Lsyscall_error
	...

.Lsyscall_error:
	oris	r5,r5,0x1000	/* Set SO bit in CR */
	neg	r3,r3
	std	r5,_CCR(r1)

And we do the same before calling do_syscall_trace_leave().


Still it's a bit confused, because in the C code we're setting r3 and
CCR in the C code, but we're not negating the value in r3, and we're not
setting result at all.

I'll test a patch to fix it up.

cheers
