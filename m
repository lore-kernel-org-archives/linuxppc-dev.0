Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1545BC47257
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 10:15:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9D5208CA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 10:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="miPMYgFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9D5208CA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JR6y2WzszDqym
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 20:15:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JR4d0652zDqyP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2020 20:13:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=miPMYgFo; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49JR4b4g6Nz9sRf;
 Fri,  8 May 2020 20:13:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1588932832; bh=eCsSRJac38GrK7EJdAunFBqxque6vOn9w3DPcafz3R8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=miPMYgFoekg62ODTyI9JNEJp2uOCmzjkR6ys1sNheups67c8l+BE5tDou9TYtUQwb
 zflbxzwtf1iZtSD4CE9+TrrctGVqWas4ktFTzeUn/exEfXyVHHGmEVKYyD4FJAIkUo
 U2TaxLMUn2zxY7i8wzoiFs3DAa4QM3deWqrKYS1p/x/jenOqF2xtR7MXHFh1xOOO7Y
 Q584B/BxsxF83t4Akn57ebL5U2nt5FCV9EIEJrkWFKJaIfbexZmX2exIy0SKnSvElt
 arDPDzKYi1feq4f7XshEXweejBRMYXthElqi3MjnSIrmxueO9Zog7UJUOQtpnPlrxx
 xT6JgawC4/qWQ==
Message-ID: <4c9cc9184213ded65489cb95050046c8904ddad8.camel@ozlabs.org>
Subject: Re: [PATCH] powerpc/spufs: adjust list element pointer type
From: Jeremy Kerr <jk@ozlabs.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Date: Fri, 08 May 2020 18:13:46 +0800
In-Reply-To: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
References: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr>
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
Cc: Nic Volanschi <eugene.volanschi@inria.fr>, Arnd Bergmann <arnd@arndb.de>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Julia,

> Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
> that the list elements have type spu_context, not spu as used here.  Change
> the type of tmp accordingly.

Looks good to me; we could even use ctx there, rather than the separate
tmp variable.

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

