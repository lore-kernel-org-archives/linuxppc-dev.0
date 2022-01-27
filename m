Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FF9C433EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jan 2022 14:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jl3YK17LHz3cT7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jan 2022 01:55:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Jl3Xp3xYRz30Qt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jan 2022 01:55:04 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F19D81063;
 Thu, 27 Jan 2022 06:55:00 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.14.34])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6F8B3F766;
 Thu, 27 Jan 2022 06:54:59 -0800 (PST)
Date: Thu, 27 Jan 2022 14:54:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <YfKyNwYl/pkmVmDm@FVFF77S0Q05N>
References: <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N> <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
 <CAMj1kXHgpr0KYx5PYO_SpqaN8Ar2kfmc9Pb-d26uaYDpjwTz9w@mail.gmail.com>
 <YfKOENgR6sLnHQmA@FVFF77S0Q05N>
 <CAMj1kXGsmK9pBmgwmMEr302eCHtL=cqs4jqM_jOiK-bLO2gQog@mail.gmail.com>
 <YfKXM0wBfTh0V8+L@FVFF77S0Q05N>
 <CAMj1kXF3Fg2O=5prQnUWeNFeCqojP1z2zDXMwxFdcNtWLfL7Vg@mail.gmail.com>
 <YfKc8MDwenS1iXqQ@FVFF77S0Q05N>
 <CAMj1kXHnQcHmxRrTBQmj0Z2JJ6iWvNCQqSjvPqG_oedWpikfSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHnQcHmxRrTBQmj0Z2JJ6iWvNCQqSjvPqG_oedWpikfSA@mail.gmail.com>
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
Cc: Kees Cook <keescook@chromium.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sachin Sant <sachinp@linux.ibm.com>,
 Yinan Liu <yinan@linux.alibaba.com>,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 27, 2022 at 02:59:31PM +0100, Ard Biesheuvel wrote:
> On Thu, 27 Jan 2022 at 14:24, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Jan 27, 2022 at 02:07:03PM +0100, Ard Biesheuvel wrote:
> > > I suppose that on arm64, we can work around this by passing
> > > --apply-dynamic-relocs to the linker, so that all R_AARCH64_RELATIVE
> > > targets are prepopulated with the link time value of the respective
> > > addresses. It does cause some bloat, which is why we disable that
> > > today, but we could make that dependent on ftrace being enabled.
> >
> > We'd also need to teach the build-time sort to update the relocations, unless
> > you mean to also change the boot-time reloc code to RMW with the offset?
> 
> Why would that be necessary? Every RELA entry has the same effect on
> its target address, as it just adds a fixed offset.

Currently in relocate_kernel() we generate the absolute address from the
relocation alone, with the core of the relocation logic being as follows, with
x9 being the pointer to a RELA entry, and x23 being the offset relative to the
default load address:

	ldp     x12, x13, [x9], #24
	ldr	x14, [x9, #-8]

	add     x14, x14, x23                   // relocate
	str     x14, [x12, x23]

... and (as per another reply), a sample RELA entry currently contains:

	0xffff8000090b1ab0	// default load VA of pointer to update
	0x0000000000000403	// R_AARCH64_RELATIVE
	0xffff8000090b6000	// default load VA of addr to write

So either:

* That code stays as-is, and we must update the relocs to correspond to their
  new sorted locations, or we'll blat the sorted values with the original
  relocs as we do today.

* The code needs to change to RMW: read the existing value, add the offset
  (ignoring the content of the RELA entry's addend field), and write it back.
  This is what I meant when I said "change the boot-time reloc code to RMW with
  the offset".

Does that make sense, or have I misunderstood?

Thanks,
Mark.
