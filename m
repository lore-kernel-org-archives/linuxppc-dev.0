Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E87DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 02:28:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5291F2145D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 02:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oc7DcWOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5291F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43061w5XLlzF3ct
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 13:28:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oc7DcWOs";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=out4-smtp.messagingengine.com (client-ip=66.111.4.28;
 helo=out4-smtp.messagingengine.com; envelope-from=ruscur@russell.cc;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="Oc7DcWOs"; dkim-atps=neutral
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4305zP4fpGzF3cM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 13:26:08 +1100 (AEDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id E073223B84;
 Tue, 20 Nov 2018 21:26:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 20 Nov 2018 21:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=eRmxTPvL3p8bGpZXnEkS6ElrKPbc7irnS7FF8SRQ+
 zo=; b=Oc7DcWOszmtW4tv/EXK3tWBgUiViKx36y91DZm6zVNMP/u4CFAkz4cHWt
 AFjbH7OBmFBxqT92JL3+7tQyljcrIjh1YlqF1WK+YKE+N0s9Ma9zuLnhn/6qVA9F
 JhPopZjYbmjKsars7xRL1k59U6SOEsnLQ48rCxmMfwNdyCpe0vlMXDBNYJjvBb8k
 AmzIx8mu9wGau4pLokz3tboOfS7I1PKBphUEWVOEM2OGtt1ER5iGZB2Ay+mjM7EG
 8TrNtSKWF6nEsggnrwvkNlZ58+e/WzZkF5tp048Ou79Y0/udpVa7dAGSn2s0mpkc
 b2s7nv+RXfJ9MP8rA42TaWfKD5jZg==
X-ME-Sender: <xms:O8L0W-ioQD5idJX3RLsV0ADoS1KZjjPj_M-YPEdmnxV_E68evrjjgQ>
X-ME-Proxy: <xmx:PML0W367hx2aJYs814hntLg0jdLLZRTaeZjzj-DDk5KDxtshKBqqog>
 <xmx:PML0W8JAHMbl9d3Lc5GBYACXG73_PD1vhLNvWCt_BBWq3qDoAvCY8w>
 <xmx:PML0WxTTbMUs-2jcvdqYLSaSlsSJEKSVJ5di3rhUqMmSkenCc2-PWA>
 <xmx:PML0W_quO0ClX4ktTNAxzAZPnmvCNkDyq_nOyMBdl1URkBnEQiDZ7Q>
 <xmx:PML0W_ZkYkaGTaRV4imEQKQMUW3Hu7TR44AUOjJSb0neEv3EOyYT5g>
 <xmx:PcL0W8e9yn1AiHGZ0b939_IZffIpiwfmW-EHKyBotc36CKVqvZeriQ>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id C7DD0E451A;
 Tue, 20 Nov 2018 21:26:01 -0500 (EST)
Message-ID: <d5aa6ff391c0438371cae507e0b82a96eec4e979.camel@russell.cc>
Subject: Re: [RFC PATCH v1 5/6] powerpc/mm: Add a framework for Kernel
 Userspace Access Protection
From: Russell Currey <ruscur@russell.cc>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Wed, 21 Nov 2018 13:26:30 +1100
In-Reply-To: <a8df3cd2be841ff5dd7b8d3fd357f40f9935f5a4.1541568128.git.christophe.leroy@c-s.fr>
References: <ab8fcb458e1a6ad86382767b3ce7f7cc0d5b7121.1541568127.git.christophe.leroy@c-s.fr>
 <a8df3cd2be841ff5dd7b8d3fd357f40f9935f5a4.1541568128.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-07 at 16:56 +0000, Christophe Leroy wrote:
> This patch implements a framework for Kernel Userspace Access
> Protection.
> 
> Then subarches will have to possibility to provide their own
> implementation
> by providing setup_kuap(), and lock/unlock_user_rd/wr_access
> 
> We separate read and write accesses because some subarches like
> book3s32 might only support write access protection.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Separating read and writes does have a performance impact, I'm doing
some benchmarking to find out exactly how much - but at least for radix
it means we have to do a RMW instead of just a write.  It does add some
amount of security, though.

The other issue I have is that you're just locking everything here
(like I was), and not doing anything different for just reads or
writes.  In theory, wouldn't someone assume that they could (for
example) unlock reads, lock writes, then attempt to read?  At which
point the read would fail, because the lock actually locks both.

I would think we either need to bundle read/write locking/unlocking
together, or only implement this on platforms that can do one at a
time, unless there's a cleaner way to handle this.  Glancing at the
values you use for 8xx, this doesn't seem possible there, and it's a
definite performance hit for radix.

At the same time, as you say, it would suck for book3s32 that can only
do writes, but maybe just doing both at the same time and if
implemented for that platform it could just have a warning that it only
applies to writes on init?

Curious for people's thoughts on this.

- Russell 

