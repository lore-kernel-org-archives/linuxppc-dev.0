Return-Path: <SRS0=vw+r=X4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1A0C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 04:58:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5ED222C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 04:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="k1fDAKE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5ED222C2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46kLP24fVKzDqXQ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 14:58:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46kLM8340QzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Oct 2019 14:56:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="k1fDAKE4"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 46kLM801skz9sP7; Thu,  3 Oct 2019 14:56:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46kLM73d8wz9sDB;
 Thu,  3 Oct 2019 14:56:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1570078595; bh=qhDUhDuCBFjKQcZU9feovNiFJNnMvJ9m84ZHR1oekWc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=k1fDAKE4KlC+fzWckfxTRD0v6B9hjHhiKJ0WuCvKvE5NvgMaLcPFioR5FHeijo5tC
 j/uYfNAymQhSD0taEfnQtIO2B9MyNTJKGLc2Jh7hC9tmAEoqHknLsjyB8yvBewzxMI
 kgz3EN6g/IS4I9TnEqsjfQYZN6ZgWVqLneykHuKHv2xBvWBJl+xYIaBwSW12NmqigJ
 QEVLOJxEpclq81qLgJmNRp/09/M+zBfVsu3uz/u2Z9quB5aWKad/+YXg9aiXiZVCgj
 MMjPFFhVtllEJBwcMrf4A7+Sl2CbRfMyIaI3NjG0skzNnXk3lTfOy6A/eAfurgX0VG
 Y5WRQFD3LZqEQ==
Message-ID: <049794f6a16f548bcb418d31fecf268cb4a335e5.camel@ozlabs.org>
Subject: Re: [PATCH] powerpc/powernv/prd: Validate whether address to be
 mapped is part of system RAM
From: Jeremy Kerr <jk@ozlabs.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Date: Thu, 03 Oct 2019 12:56:34 +0800
In-Reply-To: <0e8a4057-fbe7-9b1a-6613-ad500ebe8b67@linux.vnet.ibm.com>
References: <20191002074856.15014-1-hegdevasant@linux.vnet.ibm.com>
 <2bb75b409a1159d5524be2d661e548e32fed152e.camel@ozlabs.org>
 <0e8a4057-fbe7-9b1a-6613-ad500ebe8b67@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
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
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Vasant,

> Correct. We will have `ibm,prd-label` property. That's not the issue. 

It sure sounds like the issue - someone has represented a range that
should be mapped by HBRT, but isn't appropriate for mapping by HBRT.

> Here issueis HBRT is loaded into NVDIMM memory.

OK. How about we just don't do that?

It sounds like we're just trying to work around an invalid
representation of the mappings.

Cheers,


Jeremy


