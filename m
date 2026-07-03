Return-Path: <linuxppc-dev+bounces-23477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698C8C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:01:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs8Qm6jywz2xPb;
	Fri, 03 Jul 2026 20:01:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783072864;
	cv=none; b=nGp6xbCYtRM7vq46esX+cWH5ucaOg060MQ/TnjK3nIs4PfgxwxI6pWaaTUCXWr+ZrijYM/wm5mHbrFZi38jRI5jYW0sV/wHC1fxP61P1KsvUgTlzSFo0rWW7z+sPepgakl9xVzeGKuSRJTFyZhceAB2knwr2pdF6DmLDUJfr3f1UscS5+KdlT+WMYi7mtbWk4rh8ZH4ddBgS1/zoRpifEe02rsoDF40gP8MmoRHa+j8dXMdpRBv2VM5xXJ/wgmeY9mQcG6uQKH+XhtsXtxM9O3bNcedjxjyHC2TZauqnq84iEg31WelP1FvjsFuW4j9UYv2G/ASAkmmWjZ/uLIZL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783072864; c=relaxed/relaxed;
	bh=4eAaXEt312UQloawJo+yaYovtDfAeaYocuuY17b1XAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsiTN/7BcsjIUGm5CZhwRZRx4PM4Oft2UoHQRXsKiYcIJ9pffwMZgDGWKpB2cjRLaczTTHqP/pGBQdarIOfaUSP9rJnNZnygGMUJY1misb0vEwpD2MDztlrGXWjMHJg2VZznJIj/sM/5MYDo5NVlv2K7uz2CRFIbHFrD1bulqnmAFfqaJWQb8JcQh68TsWzOOcgHh6ea7XHFrqjwPAMyMRVMaNgppajijQs8LXyt7CvK8ofqA0pOkoNNY3iPjxQYjRNt5bSvSsPczk9/HUXowh7rnSPnW0sHP7zMFjTQgDyiwDvPi5qj2+rfQ7m3CV24Lpn3SmSl8ZzO0yO4bsFDrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S7QhjRah; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S7QhjRah;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs8Qj69pQz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:01:00 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B231FC4;
	Fri,  3 Jul 2026 03:00:23 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98773FAA1;
	Fri,  3 Jul 2026 03:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783072827; bh=aCTCeigzdW+DLmQcURYHBbc2LLCBHkNsbpfYvvGCiJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7QhjRah1ACbDsWq1fyjeQXt+EKdqlo9vLYGLe10grZ3du51t6ZFb4OLnHfKmugvC
	 xYIGBaOHJhM7/+St8RX1L1+kEfNfOXq3codPouX1rlw+gMBwRumJ3t0IzbR4AAn6ks
	 AEhSYO6Tc+ug7ijrNB2evf01wmU75WbW8DbnvJvM=
Date: Fri, 3 Jul 2026 11:00:11 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
	James.Bottomley@hansenpartnership.com, deller@gmx.de,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net,
	jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org,
	thuth@redhat.com, ada.coupriediaz@arm.com, kevin.brodsky@arm.com,
	linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
	james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
	liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
	yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
	mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
	arnd@arndb.de, thomas.weissschuh@linutronix.de,
	sohil.mehta@intel.com, andrew.cooper3@citrix.com, jgross@suse.com,
	kas@kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
Message-ID: <akeIK5TRCjlKbzbp@J2N7QTR9R3>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz>
 <87cxx4mmim.ffs@fw13>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxx4mmim.ffs@fw13>

On Fri, Jul 03, 2026 at 11:48:49AM +0200, Thomas Gleixner wrote:
> On Fri, Jul 03 2026 at 09:51, Michal Suchánek wrote:
> > On Mon, Jun 29, 2026 at 09:05:59PM +0800, Jinjie Ruan wrote:
> >> -	if (secure_computing())
> >> +	if (!secure_computing())
> >>  		return -1;
> >
> > Hello,
> >
> > I am not fond of this logic inversion. The boolean is meaningless in
> > itself.
> >
> > Previously -1 was used to indicate that the syscall was filtered but you
> > chose to invert the logic choosing true to mean syscall was not filtered.
> >
> > You could choose true to mean that syscall was fitered avoiding this
> > inversion.
> 
> That's just wrong. Boolean logic makes more sense with having
> (!condition()). Just because the old 0/-1 nonsense had it the other way
> round does not mean it has to stay that way.

100% agreed!

Bikeshedding below; sorry.

I think the bigger problem is just that secure_computing() is a terrible
name that does not express the intended semantic -- it's not clear
whether "secure computing" means "seccomp permit the syscall" or
"seccomp is enabled and some special rules now apply" or something else
entirely.

If we're changing the return type, it might be worth renaming the
function something like:

	seccomp_permits_syscall()

... so for the code quoted at the start of the mail, we'd have:

	if (!seccomp_permits_syscall())
		return -1;

... or for arm64, where we have NO_SYSCALL:

	 if (!seccomp_permits_syscall())
	 	return NO_SYSCALL.

Thomas, any thoughts on that?

It's also odd that seccomp aquires the syscall number itself via , rather
than than being passed down explicitly by the arch code. That completely
obscures what seccomp is doing, vs having:

	if (!seccomp_permis_syscall(syscall))
		...

... but I guess that saves some duplication in the ptrace code.

Mark.

