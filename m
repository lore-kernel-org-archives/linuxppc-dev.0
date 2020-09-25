Return-Path: <SRS0=vHfa=DC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977E5C4363D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 05:03:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DDB208B6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 05:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k9BJO212"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DDB208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ByKYg61fszDqnx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 15:03:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+158bd042e2069d5d3a43+6242+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=k9BJO212; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ByKJr1zkZzDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2020 14:52:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=A+T/x3ppYi6QNsP2t+QiJ1AjmOgx9xWo2H6NAG0/aPM=; b=k9BJO212aIGjTM67lCOkTpCrht
 B20Wf2zjNYR87uLFP2BRrzt5cCrEk0KFpOMk3+io62CblpW7Y77IqzHPhNFZqwDnVNpJgjcOWkhrs
 Z8GRxpu7FjGxV+hNEbHeKyL912gkvTLvP4DBne8Te3c43Bttle2gfOVWfy6MwqIsof1MCTX4rxO24
 Kx+lnKnrKhrsYvG/2XpbtSvE8DYXDyXxSwaM81JHTOVvJu9V5Jarcs/1LeXw6G549Mxci7m54zzCp
 f1etRanliNQK8rGzJ9PmD1VPBy0Rci2ZVjpscKDGnzDGoBasw11g0MfksMIslOR+W3JyKfkaf/KsM
 BhKY/8wQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLfi0-0002pf-1s; Fri, 25 Sep 2020 04:51:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Subject: let import_iovec deal with compat_iovecs as well v4
Date: Fri, 25 Sep 2020 06:51:37 +0200
Message-Id: <20200925045146.1283714-1-hch@lst.de>
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
Cc: linux-aio@kvack.org, linux-mips@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 keyrings@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Al,

this series changes import_iovec to transparently deal with compat iovec
structures, and then cleanups up a lot of code dupliation.

Changes since v3:
 - fix up changed prototypes in compat.h as well

Changes since v2:
 - revert the switch of the access process vm sysclls to iov_iter
 - refactor the import_iovec internals differently
 - switch aio to use __import_iovec

Changes since v1:
 - improve a commit message
 - drop a pointless unlikely
 - drop the PF_FORCE_COMPAT flag
 - add a few more cleanups (including two from David Laight)

Diffstat:
 arch/arm64/include/asm/unistd32.h                  |   10 
 arch/mips/kernel/syscalls/syscall_n32.tbl          |   10 
 arch/mips/kernel/syscalls/syscall_o32.tbl          |   10 
 arch/parisc/kernel/syscalls/syscall.tbl            |   10 
 arch/powerpc/kernel/syscalls/syscall.tbl           |   10 
 arch/s390/kernel/syscalls/syscall.tbl              |   10 
 arch/sparc/kernel/syscalls/syscall.tbl             |   10 
 arch/x86/entry/syscall_x32.c                       |    5 
 arch/x86/entry/syscalls/syscall_32.tbl             |   10 
 arch/x86/entry/syscalls/syscall_64.tbl             |   10 
 block/scsi_ioctl.c                                 |   12 
 drivers/scsi/sg.c                                  |    9 
 fs/aio.c                                           |   38 --
 fs/io_uring.c                                      |   20 -
 fs/read_write.c                                    |  362 +--------------------
 fs/splice.c                                        |   57 ---
 include/linux/compat.h                             |   24 -
 include/linux/fs.h                                 |   11 
 include/linux/uio.h                                |   10 
 include/uapi/asm-generic/unistd.h                  |   12 
 lib/iov_iter.c                                     |  161 +++++++--
 mm/process_vm_access.c                             |   85 ----
 net/compat.c                                       |    4 
 security/keys/compat.c                             |   37 --
 security/keys/internal.h                           |    5 
 security/keys/keyctl.c                             |    2 
 tools/include/uapi/asm-generic/unistd.h            |   12 
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   10 
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   10 
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   10 
 30 files changed, 280 insertions(+), 706 deletions(-)
