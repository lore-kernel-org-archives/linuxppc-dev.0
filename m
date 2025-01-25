Return-Path: <linuxppc-dev+bounces-5562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE7EC0218C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jan 2025 21:25:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgSQ460ngz2xs7;
	Sun, 26 Jan 2025 08:25:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.107.17.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737840316;
	cv=none; b=jwbUUYXgsJ0UVJ3lPk26W1Vbsaxo8/XAM8GlDj8inGvuANPY3JKhmu/c+W+MdufSx/g/NuoGeIvZaXaPLx3zDdTNWOE854srq6XuBZvsZaat6SOmOstJRpoWUOW/AvaR/0HGPE52Js0XGGtZsIlpaCDSqwfgTTW4GqtYCmL2YOd0+oWMmDzeDp4Q8Sb1Q/hLNHaPprMvDbJJbAuDf6e8euH6arM4iagw6v1mitAmpL/LNMIvQ/+1BeOheJjIYhxeLvl/sOERlRq6X/9UfYh/PuTw6RP6fj8tiyg1l/nxRSAY+cnNWKjEIGQt2krRl4v4W4AFv7HWAm94oFL4Cj787w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737840316; c=relaxed/relaxed;
	bh=t1kEq0KOCVjJvG3xXbDw7oWiiTQ0fYN0gRX3h+WR+D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZS08GL3zjBO1eNM7RditHNSFNeaMRfxUvZl/pRKqVX3VfQEHvA4hpvzP6xzHYppZk9zudedh6qcT5zum17EgnZLqyM+PCB3iJxU4ARDHbs1OAOWsCxjAebUdB2ICo4+QGIbPG1bNkmxEx/UronWyXoP2gEDbRvLBEJfHEAcOYY1vGZCspmslZEqZmzPD8/a0WRPczpvsOtlJ2aDDu+r5w28QYodRUtbK+b5rNN5z+enKZ7BdevgqqSyzCM0q56aVqpPLEtM6Vu22P/Tv+0Frl9+qDxRso3wwWXag+dpfOubkyWBAOG7s4v0X8amWcm3rHn/a+NmKnbYVjvB2HbLZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass (client-ip=194.107.17.57; helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org; receiver=lists.ozlabs.org) smtp.mailfrom=altlinux.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=altlinux.org (client-ip=194.107.17.57; helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org; receiver=lists.ozlabs.org)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YgSQ33g2Qz2xrC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jan 2025 08:25:15 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id DB0A772C8CC;
	Sun, 26 Jan 2025 00:25:13 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id CFE447CCB3A; Sat, 25 Jan 2025 23:25:13 +0200 (IST)
Date: Sat, 25 Jan 2025 23:25:13 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexey Gladkov <legion@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] powerpc: properly negate error in
 syscall_set_return_value()
Message-ID: <20250125212513.GB12624@strace.io>
References: <20250113171054.GA589@strace.io>
 <6558110c-c2cb-4aa3-9472-b3496f71ebb8@csgroup.eu>
 <20250114170400.GB11820@strace.io>
 <d249e9e2-511a-46af-bd6e-397812b67058@csgroup.eu>
 <20250123182815.GA20994@strace.io>
 <87lduzjdee.fsf@mpe.ellerman.id.au>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lduzjdee.fsf@mpe.ellerman.id.au>

On Sat, Jan 25, 2025 at 11:17:45PM +1100, Michael Ellerman wrote:
> "Dmitry V. Levin" <ldv@strace.io> writes:
[...]
> > The only case where I see some intersection is do_seccomp() where the
> > tracer would be able to see -ENOSYS in gpr[3].  However, the seccomp stop
> > is not the place where the tracer *reads* the system call exit status,
> > so whatever was written in gpr[3] before __secure_computing() is not
> > really relevant, consequently, selftests/seccomp/seccomp_bpf passes with
> > this patch applied as well as without it.
>  
> IIRC it is important for a tracer that blocks the syscall but doesn't
> explicitly set the return value. But it's only important that the
> default return value is syscall failure (ie. ENOSYS/-ENOSYS), the actual
> sign of the r3 value should be irrelevant to the tracer.
> 
> If the selftest still passes then that's probably sufficient.

Yes, I failed to explain this properly, thanks for correcting me.
With the current implementation, both -ENOSYS and ENOSYS/cr0.SO semantics
of the error code at __secure_computing() stage lead to the same result,
this is the reason why seccomp_bpf selftest passes regardless of the patch.

At any point where the tracer is entitled to interpret gpr[3] as a syscall
return value, the semantics of gpr[3] is well-defined (-ERRORCODE/cr0.SO
in non-scv case) and is a part of the ABI.

However, since we have to provide backwards compatibility with the current
inconsistent implementation, in the non-scv case we have to continue
supporting both -ENOSYS and ENOSYS/cr0.SO semantics of the syscall return
value set by the tracer at __secure_computing() stage.


-- 
ldv

