Return-Path: <SRS0=1NAR=C5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241CC43463
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 18:44:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C865B207BB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2020 18:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C865B207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bvc1d2bGtzDqQY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2020 04:44:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=2002:c35c:fd02::1;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bvbym5VYXzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2020 04:42:08 +1000 (AEST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kK4Hd-002cE4-T4; Sun, 20 Sep 2020 18:41:58 +0000
Date: Sun, 20 Sep 2020 19:41:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-ID: <20200920184157.GP3421308@ZenIV.linux.org.uk>
References: <20200918124533.3487701-1-hch@lst.de>
 <20200918124533.3487701-2-hch@lst.de>
 <20200920151510.GS32101@casper.infradead.org>
 <20200920180742.GN3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920180742.GN3421308@ZenIV.linux.org.uk>
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
 Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
 io-uring@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jens Axboe <axboe@kernel.dk>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Sep 20, 2020 at 07:07:42PM +0100, Al Viro wrote:

> /proc/bus/input/devices (fucked bitmap-to-text representation)

To illustrate the, er, beauty of that stuff:

; cat32 /proc/bus/input/devices >/tmp/a
; cat /proc/bus/input/devices >/tmp/b
; diff -u /tmp/a /tmp/b|grep '^[-+]'
--- /tmp/a      2020-09-20 14:28:43.442560691 -0400
+++ /tmp/b      2020-09-20 14:28:49.018543230 -0400
-B: KEY=1100f 2902000 8380307c f910f001 feffffdf ffefffff ffffffff fffffffe
+B: KEY=1100f02902000 8380307cf910f001 feffffdfffefffff fffffffffffffffe
-B: KEY=70000 0 0 0 0 0 0 0 0
+B: KEY=70000 0 0 0 0
-B: KEY=420 0 70000 0 0 0 0 0 0 0 0
+B: KEY=420 70000 0 0 0 0
-B: KEY=100000 0 0 0
+B: KEY=10000000000000 0
-B: KEY=4000 0 0 0 0
+B: KEY=4000 0 0
-B: KEY=8000 0 0 0 0 0 1100b 800 2 200000 0 0 0 0
+B: KEY=800000000000 0 0 1100b00000800 200200000 0 0
-B: KEY=3e000b 0 0 0 0 0 0 0
+B: KEY=3e000b00000000 0 0 0
-B: KEY=ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff fffffffe
+B: KEY=ffffffffffffffff ffffffffffffffff ffffffffffffffff fffffffffffffffe
; 
(cat32 being a 32bit binary of cat)
All the differences are due to homegrown bitmap-to-text conversion.

Note that feeding that into a pipe leaves the recepient with a lovely problem -
you can't go by the width of words (they are not zero-padded) and you can't
go by the number of words either - it varies from device to device.

And there's nothing we can do with that - it's a userland ABI, can't be
changed without breaking stuff.  I would prefer to avoid additional examples
like that, TYVM...
