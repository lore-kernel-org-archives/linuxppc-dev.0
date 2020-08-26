Return-Path: <SRS0=u8mG=CE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 12:00:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60AA20786
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 12:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WD366TFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60AA20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bc4Dd0SR7zDqWy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2020 22:00:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bc4BH6wnbzDq8v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2020 21:58:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WD366TFs; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bc4BH2Qjqz9sTR;
 Wed, 26 Aug 2020 21:58:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598443095;
 bh=MS+f0WHAHjfA6EqlylHw2U6qlVWZcTPnytdwjdmqqxo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WD366TFsG57J4YACK+ntB2t5tojZxsOSqUkCyu07896wqTOVYQ547sM8UmbagPOKM
 XzzLh5dbTmbQ+t++gRDzZpqdwA+u4zj7ZCbbx55t4Q514kgNpKKx249AIDe7/X0Ytv
 M2Rh9JyTqzfL+1snjI5sTN5Zk2suha2v6Z/Bq54/6tFDxQQyU8U4mASciteDL5h6da
 70/fBJoMRNzLO667ShF9IQWrDbPwe0O8XVmDwJchJKo1YNXxC/PM3XVBqjcv13sQwG
 WgZ8rJ6qagEOt999C8qf+2LU3CY3isJzxf6AYXI00kkxGk5IzjJ7Z6RFGp+v9k5riY
 3RqrjQRfC9TaQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: Please apply commit 0828137e8f16 ("powerpc/64s: Don't init
 FSCR_DSCR in __init_FSCR()") to v4.14.y, v4.19.y, v5.4.y, v5.7.y
In-Reply-To: <20200826102929.GA3356257@kroah.com>
References: <20200825224408.GB6060@mussarela>
 <20200826102929.GA3356257@kroah.com>
Date: Wed, 26 Aug 2020 21:58:11 +1000
Message-ID: <87o8mxhb58.fsf@mpe.ellerman.id.au>
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
Cc: sashal@kernel.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg KH <gregkh@linuxfoundation.org> writes:
> On Tue, Aug 25, 2020 at 07:44:08PM -0300, Thadeu Lima de Souza Cascardo wrote:
>> After commit 912c0a7f2b5daa3cbb2bc10f303981e493de73bd ("powerpc/64s: Save FSCR
>> to init_task.thread.fscr after feature init"), which has been applied to the
>> referred branches, when userspace sets the user DSCR MSR, it won't be inherited
>> or restored during context switch, because the facility unavailable interrupt
>> won't trigger.
>> 
>> Applying 0828137e8f16721842468e33df0460044a0c588b ("powerpc/64s: Don't init
>> FSCR_DSCR in __init_FSCR()") will fix it.

Oops, thanks for catching it.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


> Now queued up, thanks.

Thanks.

cheers
