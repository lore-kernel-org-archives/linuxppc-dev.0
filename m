Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF2C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 16:37:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB15861359
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 16:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB15861359
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4rTD5x5Kz3c1R
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jun 2021 02:37:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=EKjRJP/D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=EKjRJP/D; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4rSg4FhLz2yXK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jun 2021 02:37:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=amXA5DbpjsK6z6OozTNT4JwawEseuiTE2IRGyEgfxc0=; b=EKjRJP/D6AtT/jvfxesq/zn+X0
 vdbEnOW9ybPOfoUgQaR6zJxTCL8EOJkYLJV1sB40Juy5qU6yLPh3wginXJUR7eYprXEffSSc31C8j
 8JAunLJz18MTOR+D9Fy+z+m/S/BNxWdAhyxlkHVREbKfMV7pbG3jCkovKM+Um46sySoUmDEkhvN4Z
 hikVR5mTZNwHlNZwxflAHGLtQiwWG6FzPqAsZHi0vSpS8T8wDaLPOtXDd2sOfy2c6jG3q6JW8SbWi
 w4+RiTxmktkrIjSyNdYYnFLc/4KFmH9cUXcyHX/dH6lygLf3H64BkQ9mrZ2KpOFBaXepkvfjGxC5M
 mDm/cEyA==;
Received: from c-73-223-233-156.hsd1.ca.comcast.net ([73.223.233.156]
 helo=[10.193.95.42])
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltYX7-008MFA-6K; Wed, 16 Jun 2021 16:37:00 +0000
Subject: Re: [PATCH 11/18] ps3disk: use memcpy_{from,to}_bvec
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-12-hch@lst.de>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <e15447e1-753a-ba0b-d016-8b8ab2302fd1@infradead.org>
Date: Wed, 16 Jun 2021 09:36:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615132456.753241-12-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Mike Snitzer <snitzer@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, Dongsheng Yang <dongsheng.yang@easystack.cn>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 dm-devel@redhat.com, Geert Uytterhoeven <geert@linux-m68k.org>,
 Ilya Dryomov <idryomov@gmail.com>, Ira Weiny <ira.weiny@intel.com>,
 ceph-devel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christoph,

On 6/15/21 6:24 AM, Christoph Hellwig wrote:
> Use the bvec helpers instead of open coding the copy.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/ps3disk.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)

I tested your patch set applied to v5.13-rc6 on PS3 and it seemed to be
working OK.

I did some rsync's, some dd's, some fsck's, etc.  If you have anything
you could suggest that you think would exercise your changes I could
try that also.

Tested-by: Geoff Levand <geoff@infradead.org>
