Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8699FC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:18:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8EC206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6+V+Feq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8EC206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GchP6Th0zDrNJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 04:18:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S6+V+Feq";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh+dt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="S6+V+Feq"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GcdP18RxzDrCC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 04:15:53 +1100 (AEDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3EA09206DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 17:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544807752;
 bh=gDpPysTvFPjH+Q3xE4MMncwVDJ4s/xk7nl6RXCUksk0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=S6+V+Feqji6koRTtMNQTTmqqq43ZR1mi4QsIHGL4AiZRWL5q+ADJAj0jR9+W7Y2Dk
 esbNUUYg8FEYdhxWTr2FtLErVJu1deVlpiVIyaz/UA/KIt8Cw4pI4G05rzcLYA9idB
 n0keO+TtTIYMt0tFGVJJ6AKtDDlSZI1eVJL11a2c=
Received: by mail-qt1-f180.google.com with SMTP id l11so7022029qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 09:15:50 -0800 (PST)
X-Gm-Message-State: AA+aEWYqodvfKHGVoH8jAPQdjdGL4t3bXrcdC2Xe0V9erpyJs4FlM4k1
 G0k+gLwgFG3wQJc7t7++zdtnV0LInQAueg4ZYw==
X-Google-Smtp-Source: AFSGD/WYhUHUP53KWHx9190PGZy4WJhKePrWgXj1D0nJN97TknAB5/8G51IgTPytgGfwZz/DVDrx/2lddjbG0d3SM0M=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr3589069qtd.257.1544807749457; 
 Fri, 14 Dec 2018 09:15:49 -0800 (PST)
MIME-Version: 1.0
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 14 Dec 2018 11:15:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
Message-ID: <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
To: Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: devicetree@vger.kernel.org, tlfalcon@linux.vnet.ibm.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 mwb@linux.vnet.ibm.com, minkim@us.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> The phandle cache contains struct device_node pointers.  The refcount
> of the pointers was not incremented while in the cache, allowing use
> after free error after kfree() of the node.  Add the proper increment
> and decrement of the use count.

Since we pre-populate the cache at boot, all the nodes will have a ref
count and will never be freed unless we happen to repopulate the whole
cache. That doesn't seem ideal. The node pointer is not "in use" just
because it is in the cache.

Rob
