Return-Path: <SRS0=8RrW=6O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F87C83000
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 00:40:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD6520757
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 00:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NyNna0Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD6520757
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49CGl83zQKzDrCt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 10:40:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49CGj757pHzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2020 10:39:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=NyNna0Zv; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49CGj65CVnz9sSd;
 Thu, 30 Apr 2020 10:39:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1588207147; bh=y4JtUAJ8Ue+PyqhDe/YJdZEJXF8hPB3fN+8u+IK5GOI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=NyNna0ZviNC4hBOQotDYnK9EKhPTFrGdFbm1pi9DrEIW0Kwt5DdBW9n2z4Vb1sBoP
 8M4cjLfqCLJSabjB1NHwR78ho42RIrfMCezY+r4WoQHOiRZFoFKrN9pm/W5Nx0JfUf
 IuDs3qRBSAO91Re3YjzHQvpVmtc+as1/QQ1B4GH1mYJ+8q8eD1gJ2f1Atqe4Klc/Pd
 hL3u6+rTmMRGy18B7NCQIkhz++NH/0AilMsNyNuy0obBYNVKrcUh7kOzBiasC2ax8l
 AEKx1fWutT4MWAjlZTO5qMyXOtrJGnATTCOkaDNae8N15uT2c/8sFb7VLGuQZcqXM6
 4uTcgFUEa1WCw==
Message-ID: <9c629b09cf25d143c7787548516c1f276bd09aa5.camel@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc/spufs: stop using access_ok
From: Jeremy Kerr <jk@ozlabs.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 30 Apr 2020 08:39:00 +0800
In-Reply-To: <ebc47890-649e-71c7-02b1-179db964db37@c-s.fr>
References: <20200429070303.17599-1-jk@ozlabs.org>
 <20200429070303.17599-2-jk@ozlabs.org>
 <ebc47890-649e-71c7-02b1-179db964db37@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
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
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

> > Just use the proper non __-prefixed get/put_user variants where
> > that is not done yet.
> 
> But it means you are doing the access_ok() check everytime, which is 
> what is to be avoided by doing the access_ok() once then using the 
> __-prefixed variant.

5 out of 8 of these are just a access_ok(); simple_read_from_buffer().

For the cases where it's multiple __put/get_user()s, the max will be 5.
(for the mbox access). Is that worth optimising the access_ok() checks?

Cheers,


Jeremy

