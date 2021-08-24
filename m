Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BE3C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 13:47:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D4161262
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 13:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4D4161262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gv9R30G07z2yKS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 23:47:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=DuQ7IwRZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lwn.net
 (client-ip=45.79.88.28; helo=ms.lwn.net; envelope-from=corbet@lwn.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=DuQ7IwRZ; dkim-atps=neutral
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gv9QF6ZLNz2xgP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 23:47:00 +1000 (AEST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id 787651C3F;
 Tue, 24 Aug 2021 13:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 787651C3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1629812816; bh=2Hlb19nSuaGuonU77eD1y1qzVeXYu1pmsQQQNUuOQEA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DuQ7IwRZF6ja24opBUrL4vz7kneiieODc7+CSOQshjEpfVlff7nj94oSfySlRGYLn
 W1Af5pGXCcJVBG8Hc1kJ7gre+jSJHYGeXrSvL6iHxo0ebbJZAAke9Rg7teGR/DjIQ3
 ZN3RekO3/6AJW43jjs/i253B6r7pcAsxQ/r/vYQpPheia8JuWv7UUD+/Vz/tHqyrJ9
 0EjpHEEbTZeKt5eDgokSZt8Jhps14iosu6jtpD6VTPSFIoKrEbpRw+md7/rOQLEeqk
 utgNYEXS9S5il/ONzoLOesBoBooVtkqHsBHGEs3h/hVrNkl3SBlfiI2stE+BBe8x5B
 o1Dzn/9nzmd3Q==
From: Jonathan Corbet <corbet@lwn.net>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build warning after merge of the powerpc tree
In-Reply-To: <87v93ve7yg.fsf@linux.ibm.com>
References: <20210823195540.4d7363ed@canb.auug.org.au>
 <20210823204803.7cb76778@canb.auug.org.au> <87v93ve7yg.fsf@linux.ibm.com>
Date: Tue, 24 Aug 2021 07:46:55 -0600
Message-ID: <877dgbneeo.fsf@meer.lwn.net>
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:


> Thanks for looking into this. I guess we also need to format the below table?
>
>   | 0    8   40
> --|------------
>   |
> 0 | 10   20  80
>   |
> 8 | 20   10  160
>   |
> 40| 80   160  10
>
>
> I don't know how to represent that in the documentation file. A table is
> probably not the right one?

The cheap way out is to put it in a literal block, of course.  Sphinx
makes tables pretty easy, though:

  https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#tables

jon
