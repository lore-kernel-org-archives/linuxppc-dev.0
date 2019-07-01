Return-Path: <SRS0=ROWL=U6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BACC0650E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jul 2019 15:43:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB32A20B7C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jul 2019 15:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB32A20B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45cs8K17CTzDqK1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jul 2019 01:42:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45cs6N52R3zDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2019 01:41:16 +1000 (AEST)
Received: by mail-qt1-f193.google.com with SMTP id m29so15146546qtu.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jul 2019 08:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QX/9XC0DeimGVTmEjV3E87RMFjV7Hn7tB/e6eJ8Xuyo=;
 b=HtFQncg2LWnI3miz2EgwOhkxH8Vm1zi+8iyxo9YsyP13Nled2rIw53lZUuLX4uM1SK
 4XpEddUmKq06A78kMARsz5YlFPPduK3OlsnhgsJZ57l3qHbTDbzCa18eeJ/1bOAIc+Mi
 PJ2nDt+mlF82ZrhouNIscAfj9sPcdtED43StPEENMD9HJ9ubRII1kEIjZVeHwk9OWXqJ
 ZrDMyrKEHJGufyCa5oJfDi6MiLqNwMzgTVn4pAlBF7NCoUMnoGxaepeeya56Y+G04MR7
 h+namZ1C+t6iT9jfv7dBV9xitEk9pyLLxGC7XucHmoVy1Yixq+zY2IsIH1w2pXKlNdz/
 7kgQ==
X-Gm-Message-State: APjAAAUFxq1Twctli9zsPSw3HVDAmiS+7U7Vvvy+U7DspoN2JoqOZUwk
 5OqhCCpykXUq49m0C1sbh4LTR4w+QJzy9doDFZs=
X-Google-Smtp-Source: APXvYqxGHBFa8P5vpjbVLPEama12INy2Pt2H83NHNiep+1vxl9TlwguBVZ4KnSLAGXloUkCXunz2yug6gKdinLc2iX0=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr20305367qtb.142.1561995673724; 
 Mon, 01 Jul 2019 08:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190624054728.30966-1-hch@lst.de>
 <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240922420.32342@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 1 Jul 2019 17:40:57 +0200
Message-ID: <CAK8P3a3YHstHAs9OsWNHTtXjHnWtQfqr=WUZTpK+bONLTWLj+w@mail.gmail.com>
Subject: Re: remove asm-generic/ptrace.h v3
To: Thomas Gleixner <tglx@linutronix.de>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jun 24, 2019 at 9:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 24 Jun 2019, Christoph Hellwig wrote:
> >
> > asm-generic/ptrace.h is a little weird in that it doesn't actually
> > implement any functionality, but it provided multiple layers of macros
> > that just implement trivial inline functions.  We implement those
> > directly in the few architectures and be off with a much simpler
> > design.
> >
> > I'm not sure which tree is the right place, but may this can go through
> > the asm-generic tree since it removes an asm-generic header?
>
> Makes sense.

Applied and pushed to asm-generic.git/master now, sorry for the delay.

     Arnd
