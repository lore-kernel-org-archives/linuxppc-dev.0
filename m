Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8917C76188
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 10:31:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E51221849
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="JAjsDhcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E51221849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qnP21LCMzDqsD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 20:31:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=brauner.io
 (client-ip=2a00:1450:4864:20::343; helo=mail-wm1-x343.google.com;
 envelope-from=christian@brauner.io; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=brauner.io header.i=@brauner.io header.b="JAjsDhcT"; 
 dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qnLm5JMnzDqqW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 20:29:52 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id 207so28297242wma.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/54Z+i2NAAKKYqTyaHCknB2yONX433P+mrrcxDIdMKQ=;
 b=JAjsDhcTKFikvYch2sdYf3M1YIU4lD8gtr6ULD+m66RVXVuqlNpAWJ5aCmwhzsJqfu
 NYMs/ngfnZnIR8qK+5gnlfw/LTN1DoKaojW4kG3ixmkDG7tw9PX3Gi1H6Z3rJyqaYFRY
 gtdhUxjOR3aQahCtFDINrBG/OSP8pnsgZFupRZsDuzUdLCVJo0FcPvznY5c5cU461qY8
 z6fVQ/+Mbzs3h37QWljm/AYaqqO87pyj8pyd6RorqrMiW7iIeyvakf6A7A7GAM2bH4rw
 cbSgv5bCTz5aSE0toZ8ZOUCkVQ0c1BjSzCzQ1F1IbaB+eNv/4FBgS3Np35nlQBPDWp48
 Qe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/54Z+i2NAAKKYqTyaHCknB2yONX433P+mrrcxDIdMKQ=;
 b=FsVbhMb+CABZXhG5FV89Dr113fLHg8+fB7VzQVq4mMAXM2Bu/eEpoxcUV/bC7KZ2qs
 dy2ThO/pbR6NnfsVd1jE651qhizEXOVlwECHzYjePYUUb+iwiHGbqH8rknBYJdy1Z3lN
 eQ3hxNd2NJy8/uWfRcS2M8VXUbNCXoWzF/4nZgfwTFdwvnzJo6DjUAmxTAU9lRRg8m8I
 lHMf99+d5vltKLunnjZo3EmOGK/hcUKBizF2CymxHkpQ0xPhkMOVCXyvnklJTARPNUb7
 7r0rbgRg6FlErY7agdnFqFytTEOfdzcb9jwem9YKoy33Dsu0yUUrJ+/9THns0FfRWKDa
 imww==
X-Gm-Message-State: APjAAAX+5cQ0TaIlCnYlO/dRdRSzLZ7bKVAjSLjsaVP+3ibQLAyJyMCY
 nJbHqHEC1hutzuAGVydKWpE=
X-Google-Smtp-Source: APXvYqynzSxRaiMvY03x+MCUOq/ut+wmSYg6CTggvreuOHjcm6imyyhYbJGXSWZ87v9KsAJECqBb6Q==
X-Received: by 2002:a1c:c145:: with SMTP id r66mr47654238wmf.139.1563532189209; 
 Fri, 19 Jul 2019 03:29:49 -0700 (PDT)
Received: from brauner.io ([81.92.17.140])
 by smtp.gmail.com with ESMTPSA id v4sm25167633wmg.22.2019.07.19.03.29.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 03:29:49 -0700 (PDT)
Date: Fri, 19 Jul 2019 12:29:41 +0200
From: Christian Brauner <christian@brauner.io>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190719102932.274pvmxnrbjcc6gu@brauner.io>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
 <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
 <20190718161231.xcno272nvqpln3wj@yavin>
 <CAK8P3a3MiYK4bJiA3G_m5H-TpfN5__--b+=szsJBhG7_it+NQg@mail.gmail.com>
 <20190719021218.GB18022@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190719021218.GB18022@altlinux.org>
User-Agent: NeoMutt/20180716
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
 Alexei Starovoitov <ast@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 David Howells <dhowells@redhat.com>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Aleksa Sarai <asarai@suse.de>, linux-mips@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, David Drysdale <drysdale@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "J. Bruce Fields" <bfields@fieldses.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux API <linux-api@vger.kernel.org>, Chanho Min <chanho.min@lge.com>,
 Jeff Layton <jlayton@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, alpha <linux-alpha@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 containers@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jul 19, 2019 at 05:12:18AM +0300, Dmitry V. Levin wrote:
> On Thu, Jul 18, 2019 at 11:29:50PM +0200, Arnd Bergmann wrote:
> [...]
> > 5. you get the same problem with seccomp and strace that
> >    clone3() has -- these and others only track the register
> >    arguments by default.
> 
> Just for the record, this is definitely not the case for strace:
> it decodes arrays, structures, netlink messages, and so on by default.

There sure is value in trying to design syscalls that can be handled
nicely by seccomp but that shouldn't become a burden on designing
extensible syscalls.
I suggested a session for Ksummit where we can discuss if and how we can
make seccomp more compatible with pointer-args in syscalls.

Christian
