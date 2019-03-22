Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E663C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 17:15:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF9721900
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 17:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IuhoI3hZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF9721900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Qqzt54nRzDqRt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 04:15:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=2a00:1450:4864:20::143; helo=mail-lf1-x143.google.com;
 envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org
 header.b="IuhoI3hZ"; dkim-atps=neutral
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Qqy85BlNzDqRm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 04:14:06 +1100 (AEDT)
Received: by mail-lf1-x143.google.com with SMTP id d18so1909147lfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=syf5FC/PD4cN6FgIJM2ms3RJG343jtrhSP64Oe75Sac=;
 b=IuhoI3hZaIxE4YvOC0/zFIRPXbZPqr4mch9fB87bJI50v/CesoGw5jPm0Ymj36S+8D
 SIzDojt4m/q1uwaK9P5Is2rLt7NY0cQwo3oRCrDKYwFF22+ZwEkj5rWc3XCpMkx/lh21
 i/oyaRFuahvewUzvmGuDcKpmqMK2Pff6AsG6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=syf5FC/PD4cN6FgIJM2ms3RJG343jtrhSP64Oe75Sac=;
 b=c4i7w2m0n0Wl2xT508FoOqt3PHYMzb1/X+tMZa90/K/VDm9eyDZ11MkQWRJ7EUNVgI
 SlcEET/JarQxsuQeBc/0pzCT/Z3OifCU1sr6XZouTOB7bBe70+TiBJQYP1tTSEkBLavn
 CqKgetXrnYQBZ6n8N3VoBIV8tERebzJYStgm+nD7sM4ZLkqFRlCPjhgqV8vsNxF1pGni
 k2eP/+d4JkO4Ui1eVZQ5XYY1JVT3ZK41qHmR2FkINnXwYQgIHNYpTf/t2Srr0cSWuAG1
 C8t+gWsy7FDkekLjEbSjJ1mRGyFRicNt8oP1VHdtfgg/53mdpyfuctINXngc2Ksp/p9M
 qAYA==
X-Gm-Message-State: APjAAAVGH8Pxl43v6wopnR84tNh77MKiukWdemcTyWN1YySsU2/HelCD
 vffqHKutRFclIwXVxQ7olvTSWGUSgpA=
X-Google-Smtp-Source: APXvYqzmOHNZV0OC9gU5UFjGUUEpvCqZliepwfzun/J4VYF0UoKLY094SJRUSUoFk7H9rN9L1+AEIQ==
X-Received: by 2002:ac2:4115:: with SMTP id b21mr6096921lfi.54.1553274843189; 
 Fri, 22 Mar 2019 10:14:03 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id z65sm1939016lfa.90.2019.03.22.10.14.02
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Mar 2019 10:14:02 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id v13so2694352ljk.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 10:14:02 -0700 (PDT)
X-Received: by 2002:a2e:86ca:: with SMTP id n10mr5880284ljj.135.1553274524897; 
 Fri, 22 Mar 2019 10:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-4-longman@redhat.com>
In-Reply-To: <20190322143008.21313-4-longman@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2019 10:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Message-ID: <CAHk-=wi0wwmY-waC1-2SmBz4-XK-Eru2RTx6PrGzUK=P1nwexQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] locking/rwsem: Optimize down_read_trylock()
To: Waiman Long <longman@redhat.com>
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
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
 linux-parisc@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> Modify __down_read_trylock() to optimize for an unlocked rwsem and make
> it generate slightly better code.

Oh, that should teach me to read all patches in the series before
starting to comment on them.

So ignore my comment on #1.

                Linus
