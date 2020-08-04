Return-Path: <SRS0=OkVA=BO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 20:03:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743D720842
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 20:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GflFL1WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743D720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLm0S4nWzzDqcV
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2020 06:03:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=brendanhiggins@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=GflFL1WY; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLlyL07BMzDqNV
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2020 06:01:45 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id r11so13335751pfl.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2020 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NGNEd3Lp8fYqN2xdgBLfWZRJYT3O7WzzWQnO9+HSxQk=;
 b=GflFL1WYfQVzQD4fL/T4jBZKh7JPXp0BjIk5sL7JE/3ZK5A3sV3xZbh/yfGVUE0qsP
 E8yzX9X+hsi/jPgMOXv5KyzdGbchiQfB+e6evv0M2SBqQeIpPvQCBY7+peu0nO4BLYGa
 rdDx5ycRqouMDJsTRzYND+Tolb/oVleKFhJtjOjIQORoJT/S/6+FUy7Kqq7ICEsZ9Bbl
 0OVwDgiwpMSYG30M2rS3A8VLQOVW8i0aLpgdwxcBGN+zSp9A98eH6F083YoTKVXDwSul
 ItGmc4NUog48QtQq1C+v7I7SDLF2999IlOerOmbpf1fsDJ45bAYCsHylk7gjqEPEQWPz
 rsTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NGNEd3Lp8fYqN2xdgBLfWZRJYT3O7WzzWQnO9+HSxQk=;
 b=ogveav32zZs8BvZRYDVBDB2PwSu48XBaKHjrxiHBzMUXwPoMFXPFSJf8iSQjvtUP0N
 sGdCEBk6rtapMlBGR+SRDpEmk6BjJ1EnuyegEKOUziUwUbuXs+ZrcAiR+0NyQOG2g7XV
 475UcQdhMf/JCr22Re6WTDG8OnsM5ym33YirOLhoO4KwYlivhizX2TbxSv4NQAInkcq6
 4EzNJYflMQY2czGvC+twt2kuDRtBGl5RXFRPERjqMxUKAvBF7LtxBY9hQX2WKyQD8hNp
 HLdKYEUon4Bz9UGYDwjJ2g7rjFNTK9/gUs3Kk+6d/0I//K0/lpZ0aR2DP/vIBDYfuz75
 qA9g==
X-Gm-Message-State: AOAM530JhUvG9uwVClR+p7Guo+vVbCUPkQBHc9POgvVoayZqK6ruOyXL
 N6Vrk3fc+jyQds8cutDmDjISIsVqaY3VQaHsvKd8Fw==
X-Google-Smtp-Source: ABdhPJxibV8WdZD4fajbOd68sN3rQCbVSctPTRSdThTAPzTdQ5zE6A2a16V/r2RcvRmnAUUEZc+Zdf2C7tegXZnxAGI=
X-Received: by 2002:a62:1d0e:: with SMTP id d14mr46991pfd.106.1596571302143;
 Tue, 04 Aug 2020 13:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <202006261442.5C245709@keescook>
In-Reply-To: <202006261442.5C245709@keescook>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 4 Aug 2020 13:01:30 -0700
Message-ID: <CAFd5g46auR=OgQ4j=P=KH7GDerW-SkB8aFGehuYkmgJ2Z+jGCA@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] kunit: create a centralized executor to dispatch
 all KUnit tests
To: Kees Cook <keescook@chromium.org>
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
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 catalin.marinas@arm.com, jcmvbkbc@gmail.com, will@kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-arch@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
 Iurii Zaikin <yzaikin@google.com>, linux-xtensa@linux-xtensa.org,
 Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
 linux-um <linux-um@lists.infradead.org>, linuxppc-dev@lists.ozlabs.org,
 David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 26, 2020 at 2:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jun 26, 2020 at 02:09:05PM -0700, Brendan Higgins wrote:
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.

Sorry it took so long to reply. I got sucked into some other stuff again.

> So, the new section looks fine to me (modulo the INIT_DATA change). The
> plumbing to start the tests, though, I think is redundant. Why not just
> add a sysctl that starts all known tests?

We already have that; however, we use debugfs to start the tests -
same difference. I just find it convenient to not have to build and
then maintain a userland for each architecture. It's also really nice
that KUnit "just works out of the box" - you don't have to download
anything other than the kernel source, and you don't need to do any
steps outside of just run "kuit.py run". That seems like a big
advantage to me.

> That way you don't need the plumbing into init/main.c, and you can have
> a mode where builtin tests can be started on a fully booted system too.
>
> i.e. boot with "sysctl.kernel.kunit=start" or when fully booted with
> "echo start > /proc/sys/kernel/kunit"
>
> And instead of the kunit-specific halt/reboot stuff, how about moving
> /proc/sysrq-trigger into /proc/sys instead? Then you (or anything) could
> do:
>
> sysctl.kernel.kunit=start sysctl.kernel.sysrq-trigger=b

I think it might be harder to make a case for the reboot stuff without
the stuff I am working on outside of this patchset. I think I will
probably drop that patch from this patchset and reintroduce it later.
