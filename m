Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEF1C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 12:34:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A52F60F45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 12:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A52F60F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Grh0h12Pcz3d8D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 22:34:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=mtQUVDWV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mtQUVDWV; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Grgzy2thZz306d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 22:34:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Grgzv3Qhxz9sWq;
 Fri, 20 Aug 2021 22:34:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629462845;
 bh=RvSoZj9qGbuGPBLusBDgZESowYHwhMMiBJyC8aIMk60=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=mtQUVDWVN21fl7CB8Gv+bXzF4FyNyW44mL2BYz7qsbt/eYeNT69e584cR6zMVbxqO
 ynl5XZWnLQ45izhHFGBbzG1riwSDXF5HxR7P6MYnAHHiOX2/bE53XIUnaRqRJMDFAm
 P8zAFSBs7KWapWa9nTnuKg/KNnO3bZ2mOUawCw+CDy+9UnJXlCv1wJXqDWlnNolPaB
 rXl1Ck3kKrE+EXgUNuoH0szMYFn4EqkJTs0hQNEXiHpEp16L82OBAnWkCq19clUSEG
 6/9GTOU9oqC5kGb9R5dOO/Mh4wDbKHUsiboA1eolxLil/INGfzViLXj4lvJnbxaRGw
 0qe92o3jgy8cw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Xianting Tian
 <xianting.tian@linux.alibaba.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de, osandov@fb.com
Subject: Re: [PATCH v8 2/3] tty: hvc: pass DMA capable memory to put_chars()
In-Reply-To: <87pmu8ehkk.fsf@linkitivity.dja.id.au>
References: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
 <20210818082122.166881-3-xianting.tian@linux.alibaba.com>
 <87pmu8ehkk.fsf@linkitivity.dja.id.au>
Date: Fri, 20 Aug 2021 22:34:02 +1000
Message-ID: <87pmu8cn2d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>,
 shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:
> Xianting Tian <xianting.tian@linux.alibaba.com> writes:
>
>> As well known, hvc backend driver(eg, virtio-console) can register its
>> operations to hvc framework. The operations can contain put_chars(),
>> get_chars() and so on.
>>
>> Some hvc backend may do dma in its operations. eg, put_chars() of
>> virtio-console. But in the code of hvc framework, it may pass DMA
>> incapable memory to put_chars() under a specific configuration, which
>> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
>
> We could also run into issues on powerpc where Andrew is working on
> adding vmap-stack but the opal hvc driver assumes that it is passed a
> buffer which is not in vmalloc space but in the linear mapping.

The right fix for that is our code that calls opal has to be careful
that it's not passing vmalloc addresses.

We have many cases where we pass stack variables to opal, they'll all
have to be fixed to pass the underlying phyiscal/linear map address. The
opal hvc code will just be one more case of that.

cheers
