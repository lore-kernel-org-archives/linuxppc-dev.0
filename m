Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD8FC4363A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 00:58:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B9D207BB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 00:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZWDgA8+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B9D207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CKtcH0l96zDqSh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 11:58:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.dk (client-ip=2607:f8b0:4864:20::d43;
 helo=mail-io1-xd43.google.com; envelope-from=axboe@kernel.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=ZWDgA8+y; dkim-atps=neutral
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CKsQD4q0XzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 11:04:34 +1100 (AEDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so13137536iod.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2020 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wqqvkA3oKUwkO5eXRPOBy8lXyQg0CiUtokie2wwagwI=;
 b=ZWDgA8+yUlKx2dZgiyZDe66Bv6aQYo4o4sBrgULvsJ7L1mqryuSoN/tRsTLtRNf5gl
 QA5GzgrsJ4IIXk6KefYiWNloPp5dTgRya5PAi5H2X1Ck5liCNMZ9plZFbXAFJkRhGENX
 zRADl3Fzwzqt5UTeMExAEl9+J6C00UJYGVeM9r+kQpMj10I4tNzbDp+KUhpG26z8ohQ5
 u9LGW1VxEtuEY5uYo6W0qmYrYYX9WPLdyfh3K/l7hHXtbXds+UPAtJe/6QdzpKUrKNEa
 IHnev7OPcOoKpcEMuZBXfSj3e5H/bPp0SHxbMGuGbkkGN2ORlWbNlGQCKJOUg6Ub1kcx
 WOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wqqvkA3oKUwkO5eXRPOBy8lXyQg0CiUtokie2wwagwI=;
 b=eORUnfMGPt2CSYiWBCVBQsaIOXIb4B0zvDmj+s5sKY8Q/vn6XrpeJx1PpfWtGq3Wd9
 S1W2a87aq8E3fnguNui/a0P20HN9K+p6Dwu+g54o4Bn2H1wFHhez6HPdDtpWecm8Q0bj
 69WPmUl0jzqM7V34V4sAgyOqYFMJ4YdJbkbrNCEZYQhnwv5fd48x+ZDLPs1bZi3q4u1e
 uNxpIuknXnx1smiUae/IA3slTsU3RZd1gPJfM4Rvd9x4wNrIzoKyOpAJmCd3Xk8THIWb
 MhL58qkTbGnYEUGpaCfq51+sxkyBKHujyKCqSavi1awpcJ4Ua4f5VQqT0zbQDb21nm+j
 xtCg==
X-Gm-Message-State: AOAM5337UaPCJ79HrrYnJFNTAMr48g5n1Nu5m6KBCw8+6GTZQEYFhk1B
 DXmGtJ1u8EMZ/ODrqu2j/mhG+pv0pTs79Q==
X-Google-Smtp-Source: ABdhPJzXWytxnG400Dp//klgHvFRu6jftuSrTTs7sW7oWyETnW8LM2mlLlQ2a53Jfzf5mLG9B/rX/w==
X-Received: by 2002:a63:5f42:: with SMTP id t63mr569296pgb.0.1603756574857;
 Mon, 26 Oct 2020 16:56:14 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id s38sm3637009pgm.62.2020.10.26.16.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 16:56:14 -0700 (PDT)
Subject: Re: [REGRESSION] mm: process_vm_readv testcase no longer works after
 compat_prcoess_vm_readv removed
To: Kyle Huey <me@kylehuey.com>, open list <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <70d5569e-4ad6-988a-e047-5d12d298684c@kernel.dk>
Date: Mon, 26 Oct 2020 17:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAP045Aqrsb=CXHDHx4nS-pgg+MUDj14r-kN8_Jcbn-NAUziVag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-aio@kvack.org, David Howells <dhowells@redhat.com>,
 linux-mm@kvack.org, keyrings@vger.kernel.org, sparclinux@vger.kernel.org,
 Robert O'Callahan <robert@ocallahan.org>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-block@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 io-uring@vger.kernel.org,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-security-module@vger.kernel.org,
 "open list:FILESYSTEMS \(VFS and infrastructure\)"
 <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/26/20 4:55 PM, Kyle Huey wrote:
> A test program from the rr[0] test suite, vm_readv_writev[1], no
> longer works on 5.10-rc1 when compiled as a 32 bit binary and executed
> on a 64 bit kernel. The first process_vm_readv call (on line 35) now
> fails with EFAULT. I have bisected this to
> c3973b401ef2b0b8005f8074a10e96e3ea093823.
> 
> It should be fairly straightforward to extract the test case from our
> repository into a standalone program.

Can you check with this applied?

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index fd12da80b6f2..05676722d9cd 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -273,7 +273,8 @@ static ssize_t process_vm_rw(pid_t pid,
 		return rc;
 	if (!iov_iter_count(&iter))
 		goto free_iov_l;
-	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r, false);
+	iov_r = iovec_from_user(rvec, riovcnt, UIO_FASTIOV, iovstack_r,
+				in_compat_syscall());
 	if (IS_ERR(iov_r)) {
 		rc = PTR_ERR(iov_r);
 		goto free_iov_l;

-- 
Jens Axboe

