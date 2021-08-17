Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E1C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 06:00:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AAB60E52
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 06:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29AAB60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpgPF3Ldqz3ccJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 16:00:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=UMSwr/jg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032;
 helo=mail-pj1-x1032.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=UMSwr/jg; dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpgND0LLSz3bYW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 15:59:39 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 mq2-20020a17090b3802b0290178911d298bso4588998pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Aug 2021 22:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=wSxKZQAi3G0dpipOjdzpiHXbsLIYP3+eubhWW8vvEdU=;
 b=UMSwr/jgE8uNQQb6W9xRhU3K8FvkwEX9rU343Jo3Po1OXS66dId1mJKOrJyUfMAsCo
 w/1OISmsv7YfDm/Zt79MNCb39fWTL001RHhHVq+Znh0a7pyHKuItlgm6zUWM23yqSOeW
 HcrqernMj0Vzm3H6Q4IoEZg+V4c4mtdjkWMI6aYWPRP1Jmi6INQRmsnxKMNb7CqVyX/B
 81+LwVxbOUSNGqy+kFAoGdeOzOEsPv+XHO7a0/FrRCiDCDPkQjLZG7mvMR5T7qVrJcOP
 GNxz6n6okqaXsRivjFx1kHxswNGxV4HxAJi6JIf+2AehBZHFkC5luoOJSfDQLB2RJ2qX
 3QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=wSxKZQAi3G0dpipOjdzpiHXbsLIYP3+eubhWW8vvEdU=;
 b=h/uPJdvUSjy0jew6Jk9RES3yJ6bIfbsLa90CoIIduqgQFY9tzPCfmRJPSY2cAr3RZl
 N/zra/gqD61rAdAFvcYzTY6h+KG+/c8b/H1AB1kBsK5oVGnYt+qJGQyQ5UbqFV0tLlxk
 NTAtjYV8X70coRSGQUgP9TPV+s+QMZnu78HcTwYPutJvkuRtnLgihzJjDZeDdNAF838M
 dqRKjLTfqEMbGgRRASxYTw/26RnzVqUh3gbtXuykjqx5436Kxh4mVwv/+VohG40s3caM
 esAqGIhEEcTBPIOuOEe4HzXW0rncluuSGks6KfKoy6+EXTlXRxWHyyjy3BUAzwQurK0h
 zPgA==
X-Gm-Message-State: AOAM532g2kfLiPlIEXXtGVA7JCMEeEXoZnNE2yaaZ6bqvpnqs9LTlfIP
 yHExcR3sW5mJrvDhS6/abKw=
X-Google-Smtp-Source: ABdhPJz5wFZEFnG7hZXkQxTM+hWBUgm4kqFMwuenpuZH5dqkbpXWn1XRCUyXuW6rrWb62B3al4JF9A==
X-Received: by 2002:a65:6111:: with SMTP id z17mr1914798pgu.335.1629179976615; 
 Mon, 16 Aug 2021 22:59:36 -0700 (PDT)
Received: from ?IPv6:2804:431:c7f0:30b2:5c9e:50:88f3:269a?
 ([2804:431:c7f0:30b2:5c9e:50:88f3:269a])
 by smtp.gmail.com with ESMTPSA id v25sm1041397pfm.202.2021.08.16.22.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 22:59:36 -0700 (PDT)
Message-ID: <98c4a744901d35dba9225af741da52afad9eb622.camel@gmail.com>
Subject: Re: [PATCH v5 10/11] powerpc/pseries/iommu: Make use of DDW for
 indirect mapping
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Frederic Barrat
 <fbarrat@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>, kernel test
 robot <lkp@intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 17 Aug 2021 02:59:38 -0300
In-Reply-To: <8dfb28d5-b654-746c-03d8-aeee3d438240@ozlabs.ru>
References: <20210716082755.428187-1-leobras.c@gmail.com>
 <20210716082755.428187-11-leobras.c@gmail.com>
 <b98f696a-ed64-4c9e-ccb6-549ae8bc7fd6@linux.ibm.com>
 <8dfb28d5-b654-746c-03d8-aeee3d438240@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello Alexey, Fred. Thanks for reviewing!


On Wed, 2021-07-21 at 13:32 +1000, Alexey Kardashevskiy wrote:
> > >     spin_lock(&direct_window_list_lock);
> > 
> > 
> > 
> > 
> > Somewhere around here, we have:
> > 
> > out_remove_win:
> >      remove_ddw(pdn, true, DIRECT64_PROPNAME);
> > 
> > We should replace with:
> >      remove_ddw(pdn, true, win_name);
> 
> 
> True. Good spotting. Or rework remove_dma_window() to take just a
> liobn. 
> Thanks,

Fred,
Good catch! On rebasing the last changes I did miss this one.

Due to reworking v5 06/11, I ended up with a solution that takes a
liobn instead of a win name (as suggested by Alexey), and this one is
no more :)


> 
> > 
> > 
> >    Fred
> > 
> > 
> > 
> > > 
> 

Thanks!

