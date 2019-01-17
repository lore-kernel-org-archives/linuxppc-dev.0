Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:25:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9EF820657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 12:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EF820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gNZW51sSzDqsW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 23:25:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gNV22ZfgzDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:21:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43gNV14BkNz8tRJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 23:21:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43gNV11YbLz9sCh; Thu, 17 Jan 2019 23:21:29 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.193; helo=mail-qk1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43gNV00GP9z9sCX
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2019 23:21:27 +1100 (AEDT)
Received: by mail-qk1-f193.google.com with SMTP id o125so5863138qkf.3
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2019 04:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=80agVxjR4CvOXAJM2KNjQt5dr6dUiuAf3JQQOyweS8k=;
 b=M7M26DPYk3lNmHDBrKSZS1PmZK3h0o3KF7XE4/uASw8JNtCRdrXjxJne5S2iEXcGNR
 AMVUWPQoM/wOOVgeYsEveIyGmG1O2dJzeh6hPT6ENNILaKsSIQScer8MoDV95oR/QCMM
 76R9Uk99csSkLae+ZaZ7LcYigfa6eKic3TSpn2wdIs/DNHibDuDG7iJlBJuHueHu2rqS
 yGuiFQDwaFpwwSKIzHW/0Eq/pMPgYFQM8jY3+eX91s7fT6nzpKhEbTpKyXpelrkAXsq3
 8KQM47+XYoK5bNzvz70cDem3MtMqxc1zSPvupXyJH8Nh5OpchaQFTgZs1SeEluSEDTvp
 1BHw==
X-Gm-Message-State: AJcUukfmWVgH0OPcPZS656FmSIUAZax01Ho+pcI780PK4KiRchiAGa4R
 KuwGVngnImqg6wvYeiJ4ly4QH8Fym9EB7JgJeKo=
X-Google-Smtp-Source: ALg8bN6lcMEvam2dOChXO67m6IS3sEXQj79ms8czR9WmzGvMD6O+vf5b2elnwkx0gglmmyatp7NibIs9jo8iTDCVvT0=
X-Received: by 2002:a37:324a:: with SMTP id y71mr10713728qky.291.1547727685844; 
 Thu, 17 Jan 2019 04:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20190116132714.20094-1-mpe@ellerman.id.au>
 <20190116132714.20094-5-mpe@ellerman.id.au>
 <CAK8P3a2EmiT+hEmj40i1ihZM1ecK2Q42zknWNLRbgYeuOyJgrg@mail.gmail.com>
 <87r2db4lns.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2db4lns.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Jan 2019 13:21:09 +0100
Message-ID: <CAK8P3a0tZT3kr-fwAAm-7CzsNJ6m0dUWzLYS3pYPMWfiG3_HEA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] powerpc/syscalls: Allow none instead of
 sys_ni_syscall
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 11:35 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wed, Jan 16, 2019 at 2:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>
> >> sys_ni_syscall is the "not-implemented" syscall syscall, which just
> >> returns -ENOSYS.
> >>
> >> But unless you know that it's not obvious what it does, and even if
> >> you do know what it means it doesn't stand out that well from other
> >> real syscalls.
> >>
> >> So teach the scripts to treat "none" as a synonym for
> >> "sys_ni_syscall". This makes the table more readable.
> >
> > Hmm, this actually breaks the proposed script to find bugs
> > in the compat handling, i.e. detecting those that have no
> > compat handler but only a native one.
>
> I don't understand how? It just makes none an alias for sys_ni_syscall,
> so surely the worse case is that script will need to do the reverse
> transformation?

I mean it's broken to have a common script when architectures do it
differently. It would be fine if you changed all architectures at the same
time though.

> > For break, i.e. a syscall number without any implementation,
> > we use a different syntax on x86 (leaving out the sys_* entirely),
> > and on s390 (using '-', which is visually better than 'none' IMHO).
>
> Except a blank compat syscall doesn't mean the syscall doesn't exist for
> compat tasks, it means they get the non-compat entry point. So blank or
> '-' are not explicit enough IMO because the script might have some
> default logic which you can't see by looking at the table.
>
> "none" is pretty explicit I thought. Possibly better is a literal
> "ENOSYS", which stands out well and should be obvious to new comers.

ENOSYS is fine with me as well, but most importantly please don't make
powerpc different from the other ones for a matter of personal preference.
Whatever you want to change it to, please make the patch change all
syscall.tbl files at once, and explain in the patch why we should do this
across all architectures, then see if anyone objects.

> > We might also just remove those entirely across all architectures.
> > Some have already done this, and some have done it partially.
> > I can only see a couple of syscalls that got removed in the entire
> > git history (set_zone_reclaim, nfsservctl, vm86, timerfd), any other
> > ones are now literally pre-historic, and presumably nobody would
> > miss the macros when building a program that has no chance to
> > run on any kernel since at least 2.6.12.
>
> I don't see the benefit, a single missing #define could be a build break
> for some random pieces of software out there.

It certainly could, the question is whether that is a bad thing or not.

Once again, I think it's most important to be consistent across
architectures, and either define them everywhere or nowhere so we
don't end up with applications that are only broken on less common
architectures but work on fine on others.

Most of these only still exist in a few architectures anyway:

$ git grep sys_ni_syscall arch/{*/,}*/*/syscall*.tbl | grep -v
'\<\(osf\|available\|reserved\|unused\)' | awk '{ print $3; }' | sort
| uniq -c
      7 afs_syscall
      3 break
      8 create_module
      1 dipc
      1 exec_with_loader
      1 fadvise64_64
      3 ftime
      8 get_kernel_syms
      1 get_mempolicy
      7 getpmsg
      3 getrlimit
      1 get_thread_area
      3 gtty
      3 idle
      3 ioperm
      3 iopl
      1 ipc
      1 kern_features
      1 kexec_load
      3 lock
      1 mbind
      1 migrate_pages
      3 modify_ldt
      3 mpx
      1 multiplexer
     11 nfsservctl
      1 ni_syscall
      3 oldfstat
      3 oldlstat
      3 oldolduname
      3 oldstat
      3 olduname
      3 prof
      3 profil
      7 putpmsg
      8 query_module
      3 readdir
      4 select
      1 set_mempolicy
      1 set_thread_area
      3 sigaction
      1 sigaltstack
      1 signal
      2 sigpending
      2 sigprocmask
      3 sigreturn
      3 sigsuspend
      1 spill
      3 stty
      1 swapcontext
      2 switch_endian
      3 sys_debug_setcontext
      5 timerfd
      2 tuxcall
      3 ulimit
      2 umount
      1 uselib
      4 vm86
      2 vm86old
      6 vserver
      1 xtensa

I would guess that there are enough syscall names here that are more likely to
cause problems if the macro is defined then when it is missing, e.g. a common
method in glibc is to check for the older symbol first:

int
__renameat (int oldfd, const char *old, int newfd, const char *new)
{
#ifdef __NR_renameat
  return INLINE_SYSCALL_CALL (renameat, oldfd, old, newfd, new);
#else
  return INLINE_SYSCALL_CALL (renameat2, oldfd, old, newfd, new, 0);
#endif
}

and this breaks if __NR_renameat is sys_ni_syscall. I could not find
any such example that is actually broken with glibc today (presumably
others have checked before me), but other software may do similar
things.

> > For 32-bit oldstat, I'd argue that this should actually get fixed by adding
> > the compat syscall logic. I think this was discussed when Firoz
> > first posted his patches. Something like this:
>
> I'm not clear why we would do that? If there were programs out there
> that wanted oldstat in compat mode surely we would have got a bug report
> by now.
>
> So this just wires up a syscall that no one will ever use?

compat mode is not always reliable, so it's entirely possible that
someone tried it and gave up when it didn't work right away.

My point is that we should always try to make compat mode behave
the exact same way as native mode, if there is a difference between
them, it's a bug of the emulation.

If you are sure that nothing ever enters those system calls, then
we should remove them from native 32-bit mode, otherwise we should
add them in compat mode.

      Arnd
