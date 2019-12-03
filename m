Return-Path: <SRS0=x21H=ZZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB63C432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 10:14:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0251F206E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 10:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwECi3FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0251F206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47RyWk2cvDzDqWY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2019 21:14:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="EwECi3FP"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47RyTG5Bv3zDqV9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2019 21:12:18 +1100 (AEDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD68A206DF;
 Tue,  3 Dec 2019 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575367935;
 bh=njEa6+IrLjuvJPILzHBnWSOeMyzbeQ4z6Q3+166H/eE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EwECi3FPLB/gvnYoP5ns47k1Roo8LLto0gKhd1RbDt8bHESwF/OS5NpOW/mDzvbBU
 aNAi2vigGNx3RvjT6bsRLY06FdN/918p4dNXEvOAMkx+FqMjBl+PWB3UrR7P1cM92U
 sGuAtpf5TUSO3fHv9ZfheiDtJ8l0aAS48yG5iCLU=
Date: Tue, 3 Dec 2019 10:12:03 +0000
From: Will Deacon <will@kernel.org>
To: Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191203101202.GA6815@willie-the-truck>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
 <20191129102421.GA28322@willie-the-truck>
 <CACi5LpNQPw41kGsW+d0PyZaC7gSrbgwT2VxwyO5r3j83h-mkEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACi5LpNQPw41kGsW+d0PyZaC7gSrbgwT2VxwyO5r3j83h-mkEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 kexec mailing list <kexec@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
 Boris Petkov <bp@alien8.de>, Dave Anderson <anderson@redhat.com>,
 James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bhupesh SHARMA <bhupesh.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Steve Capper <steve.capper@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 30, 2019 at 01:35:36AM +0530, Bhupesh Sharma wrote:
> On Fri, Nov 29, 2019 at 3:54 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> > > Changes since v4:
> > > ----------------
> > > - v4 can be seen here:
> > >   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> > > - Addressed comments from Dave and added patches for documenting
> > >   new variables appended to vmcoreinfo documentation.
> > > - Added testing report shared by Akashi for PATCH 2/5.
> >
> > Please can you fix your mail setup? The last two times you've sent this
> > series it seems to get split into two threads, which is really hard to
> > track in my inbox:
> >
> > First thread:
> >
> > https://lore.kernel.org/lkml/1574972621-25750-1-git-send-email-bhsharma@redhat.com/
> >
> > Second thread:
> >
> > https://lore.kernel.org/lkml/1574972716-25858-1-git-send-email-bhsharma@redhat.com/
> 
> There seems to be some issue with my server's msmtp settings. I have
> tried resending the v5 (see
> <http://lists.infradead.org/pipermail/linux-arm-kernel/2019-November/696833.html>).
> 
> I hope the threading is ok this time.

Much better now, thanks for sorting it out.

Will
