Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E977C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08C220675
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 09:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHmfth3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08C220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JGW857dtzDqlf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 20:46:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GHmfth3y";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="GHmfth3y"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JGSJ0j44zDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 20:43:43 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id v12so5877282iop.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 01:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9/Kd8y/P0hk6ES3J3FR7RngN1V+s6c2Jn0+hOSRipyw=;
 b=GHmfth3yJzP79N51mTgBjb8upAGBi4v4XpsuzYbaS16cKQ1XhcPTRWgXchvhLX3i/w
 B/uNoUPj/dmKJxQ3A9zm4rF90Xc258Z+CjaJQUENhy7GX2pUXHINwweVvCSFDek/Pgy2
 doZc2T4vyh+7CwxC8F6j3+gbNpbL6oErcQM8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9/Kd8y/P0hk6ES3J3FR7RngN1V+s6c2Jn0+hOSRipyw=;
 b=Uc7MdO7eMIx6go76koXEFwDsdaCNFkKyUPuuj7CQZ6DyGZWYNW7ymM0HQ9PBILKAiP
 QbOwi8qhDX665cWfFztH4vh1yqfK1sFBYfHq34oEAqL29JGEr3RUuG4yffZ9CyufF2In
 jgYYTFPX7lQNblgWwjdmyPgUDCUsZNJbaCuTIoZebsZywdf+1+kNYgLHgVzt49snvJxP
 YQh5B6rCfjxRRDk+AXZOT7age+TVQ3B9aC5DdsPgLQDQ0WvI6gVhQWI0+hayLENza/Vl
 843eW2Vq4vY6UMC18zuQn2TBLtASFA+g/L/UIkDMnh2sF/gmhT9sDq/JiAlo/JQQHpXa
 kIPQ==
X-Gm-Message-State: AA+aEWZzcYhu3Yxzic6CRxzPRAO+oNn11xOq3ARgTQ7F7ctmx8uG30CK
 3K9FLXQqfEhh4mC+DsFgZTfJOpoJdcQDRURfUn4PCQ==
X-Google-Smtp-Source: AFSGD/V9FQF+4pFGe7RsjlDHf0Q4kByV2n59iXUUZ+3t+8va8u5qOA56qf9fQgD09x0uaRBGHZDe3RnvoQ1kqRo7L9Q=
X-Received: by 2002:a6b:6919:: with SMTP id e25mr10157073ioc.119.1545039821297; 
 Mon, 17 Dec 2018 01:43:41 -0800 (PST)
MIME-Version: 1.0
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org>
 <20181217080846.GA28424@sathnaga86.in.ibm.com>
In-Reply-To: <20181217080846.GA28424@sathnaga86.in.ibm.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Mon, 17 Dec 2018 15:13:30 +0530
Message-ID: <CALxhOni8Gynxp-NgcuZk41Qx1GT_pAEQ0tjX2z2q2pJPd49o6A@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Ram Pai <linuxram@us.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Breno Leitao <leitao@debian.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Satheesh,

On Mon, 17 Dec 2018 at 13:39, Satheesh Rajendran
<sathnaga@linux.vnet.ibm.com> wrote:
>
> Hi Firoz,
>
> On Thu, Dec 13, 2018 at 02:32:45PM +0530, Firoz Khan wrote:
> Tried to apply on linus "master" and linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "merge" branch,
> both failed to apply series.
>
> # git am mbox
> Applying: powerpc: add __NR_syscalls along with NR_syscalls
> Applying: powerpc: move macro definition from asm/systbl.h
> Applying: powerpc: add system call table generation support
> Applying: powerpc: split compat syscall table out from native table
> Applying: powerpc: generate uapi header and system call table files
> error: patch failed: arch/powerpc/include/uapi/asm/Kbuild:1
> error: arch/powerpc/include/uapi/asm/Kbuild: patch does not apply
> Patch failed at 0005 powerpc: generate uapi header and system call table files
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Then, tried with linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "next" branch,
> patch got applied, compiled with ppc64le_defconfig and booted on IBM Power8 box.
>
> # uname -r
> 4.20.0-rc2-gdd2690d2c
>
> Looks like patch series needs a rebase against the latest kernel versions.

Thanks for the update.
Sure, I'll update the patch series and post asap.

Firoz
