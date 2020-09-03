Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4128C433E9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:40:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38AD206EB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1ysAq3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38AD206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bj3PF0KzRzDr40
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 00:40:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+0324f78733eae8ed4bec+6220+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=H1ysAq3n; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bj31V6293zDr3h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2020 00:22:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Nmt3gQrXHRpJsq5nosMrsljZettvm0yOX7zhocjtN3o=; b=H1ysAq3n3J6+FAOCcSXFaaRG8D
 fuHtZL4njNSPBAI3AAdu+2NhFbCA0M/aFer+STq20lof8lzzLkcHwR+4mUTX+D0OnGGRKirmYoTjG
 EdnkecbKc4QL1WDsCKuG9gjFRHY4W+kA3NaiFvzHmE7krKfzPxtpP//6nMpTok5F3qQKEfpKv2Wk+
 B/I87rPNxRr3SGs9cjQH2lP62Am3AmAkrgJHUCDx6nxKWYJ9IGmyL8OPQ/S5+kXwOaGOIk6OHjy+D
 vtZSYF0uJln0Jn1YMjj1NEYT4k/z9t438BC2mqYo5NUFChlAdhDU8L6mp+Ue0DSSntfuCiP05e1qW
 Ddh3SSAg==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDq8R-0004a3-Rf; Thu, 03 Sep 2020 14:22:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Michael Ellerman <mpe@ellerman.id.au>,
 x86@kernel.org
Subject: remove the last set_fs() in common code,
 and remove it for x86 and powerpc v3
Date: Thu,  3 Sep 2020 16:22:28 +0200
Message-Id: <20200903142242.925828-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexey Dobriyan <adobriyan@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

this series removes the last set_fs() used to force a kernel address
space for the uaccess code in the kernel read/write/splice code, and then
stops implementing the address space overrides entirely for x86 and
powerpc.

[Note to Linus: I'd like to get this into linux-next rather earlier
than later.  Do you think it is ok to add this tree to linux-next?]

The file system part has been posted a few times, and the read/write side
has been pretty much unchanced.  For splice this series drops the
conversion of the seq_file and sysctl code to the iter ops, and thus loses
the splice support for them.  The reasons for that is that it caused a lot
of churn for not much use - splice for these small files really isn't much
of a win, even if existing userspace uses it.  All callers I found do the
proper fallback, but if this turns out to be an issue the conversion can
be resurrected.

Besides x86 and powerpc I plan to eventually convert all other
architectures, although this will be a slow process, starting with the
easier ones once the infrastructure is merged.  The process to convert
architectures is roughtly:

 (1) ensure there is no set_fs(KERNEL_DS) left in arch specific code
 (2) implement __get_kernel_nofault and __put_kernel_nofault
 (3) remove the arch specific address limitation functionality

Changes since v2:
 - add back the patch to support splice through read_iter/write iter
   on /proc/sys/*
 - entirely remove the tests that depend on set_fs.  Note that for
   lkdtm the maintainer (Kees) disagrees with this request from Linus
 - fix a wrong check in the powerpc access_ok, and drop a few spurious
   cleanups there

Changes since v1:
 - drop the patch to remove the non-iter ops for /dev/zero and
   /dev/null as they caused a performance regression
 - don't enable user access in __get_kernel on powerpc
 - xfail the set_fs() based lkdtm tests

Diffstat:
