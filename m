Return-Path: <SRS0=enMn=3D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2156EC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 11:13:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C704B206D5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 11:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir7BQFCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47xnrT4wt0zDqK6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jan 2020 22:13:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=timur@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=Ir7BQFCv; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47xnnK2q6rzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2020 22:10:45 +1100 (AEDT)
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6617724673;
 Tue, 14 Jan 2020 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578999715;
 bh=bsQv07J7goT8B8tNy/0YY5L1jTwvJjvjYE5v0S351xY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ir7BQFCvG0L1pyGOwADnDsid85YPNY+mlccr3OUlELs/N0Bp6j2nL5XxuhDhRWTYw
 YL6cnNuTYBuq1uygaQQ51szsIxDSEYLfoYbQQMFgxsPxsoaHFlod/kmRs4Ja5ryqKi
 2vVbZS4TEPOam/hEgsT8IfVViLHvdZlra7V7IF5Y=
Subject: Re: [PATCH] evh_bytechan: fix out of bounds accesses
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jslaby@suse.com>, Scott Wood <swood@redhat.com>, York Sun
 <york.sun@nxp.com>, "b08248@gmail.com" <b08248@gmail.com>
References: <20200109183912.5fcb52aa@canb.auug.org.au>
 <8736cj8rvr.fsf@mpe.ellerman.id.au>
 <5f17b997-8a6c-841e-8868-c0877750e598@kernel.org>
 <47d31d84-78ed-fd90-f3d9-8ce968126497@nxp.com>
 <87tv4yalmm.fsf@mpe.ellerman.id.au>
 <50f587a7-ce2d-08e1-3b28-15afb04b6463@nxp.com>
From: Timur Tabi <timur@kernel.org>
Message-ID: <66c49e54-1b1a-ab7c-07de-3ef6de63aa87@kernel.org>
Date: Tue, 14 Jan 2020 05:01:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <50f587a7-ce2d-08e1-3b28-15afb04b6463@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/14/20 3:18 AM, Laurentiu Tudor wrote:
> I can offer myself. I'll send a MAINTAINERS patch if nobody is against it.

Yes, please do.  I'm always available if you have any questions on the code.
