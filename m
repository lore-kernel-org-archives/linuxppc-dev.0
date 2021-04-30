Return-Path: <SRS0=0xlf=J3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44978C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 16:06:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F867613C5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 16:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F867613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWy0s5Rlvz30FQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 May 2021 02:06:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=E6nwfFAI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2a;
 helo=mail-qv1-xf2a.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=E6nwfFAI; dkim-atps=neutral
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWy0N2MS0z2yR6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 May 2021 02:06:09 +1000 (AEST)
Received: by mail-qv1-xf2a.google.com with SMTP id u1so3021420qvg.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=8hYtxi64V1mhi8QsQ5htTW8jmecZVLPmLCwquHL22Tw=;
 b=E6nwfFAI3gwoxb+PvQ/8U+QW42DZNzp+xZ1z2HZG17eqf/r6cFwnnBU2lTtuncVyQ+
 lUHe8yMRb1MPusGrB4c3WdeuPxTzZpvdecnC1HYW4jEfcC6g+BcXbZU6oWHqWpk5n1ps
 Mu3bx+9JCD+6mt9T5omedGO4RVKVlM2C8w855tfp9IWY5/tE6ZzNY5XTsnLogB9fHej6
 0alH6W5QSSxFbeTuoTajz7wvgoDFSYgfI9Mi8joltxM0SquHI7+/PV1pIwJ3aROw+sy4
 V4xnTHqQwkJX4vTBWM6o+87VISGAEazEc9u2WRDxvFDwM6HbkpEahjh1X0rBx2JkUDqJ
 KIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=8hYtxi64V1mhi8QsQ5htTW8jmecZVLPmLCwquHL22Tw=;
 b=VTw6ifRC5YK7DfTwlLXY60nTg7OT1hYVpERBwWCZBxyP0GCo+F7JGRW1qYG+xMoKC+
 rTGRyU+KLLpCcM1eL00btXfXnNIWxy0Z3dyM5kTvlMvAwDqCvyPLanfem+hY/eCQ3V11
 1PAyus72ZenzJSM1unUVLuPbfsQm7j/6qKdBwNGXrvaj0igwdyJaNRwvzosRsh2tqAVF
 sKgEOVkhsSWEdFt2NkJVNHkZMMf4ouAI9ByeX1e7Q9Ck/OlHFRxTtXxpowCqTRHG+2O4
 AGmKxM3oHPVRKtgjJDmBEP+j9YUyjs0ml3vNHSgpZoNzn8kOTu4Pzp0UVNgOnMC7aVKB
 iglQ==
X-Gm-Message-State: AOAM531KScvt5hj/4XDcIQxPVfiFN5hxRC9tG4Vhc64OHnF1pS51Vizb
 L8/l/nT7oGkKaisKFrbN5PVIEjI5/Po=
X-Google-Smtp-Source: ABdhPJxHSs8owWgK8zrhVpSlxpYzoLYqNVvITNk1JUZpDh85XHpvYAfflo+pnnsij29Aifc8MwFheA==
X-Received: by 2002:ad4:4c49:: with SMTP id cs9mr6018203qvb.43.1619798766073; 
 Fri, 30 Apr 2021 09:06:06 -0700 (PDT)
Received: from li-908e0a4c-2250-11b2-a85c-f027e903211b.ibm.com
 ([2804:14c:482:7b04::1001])
 by smtp.gmail.com with ESMTPSA id e28sm2672882qtg.24.2021.04.30.09.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Apr 2021 09:06:05 -0700 (PDT)
Message-ID: <63235a71f8bf8f3a44815b7bb6241d3a822e1be7.camel@gmail.com>
Subject: Re: [PATCH v3 06/11] powerpc/pseries/iommu: Add
 ddw_property_create() and refactor enable_ddw()
From: Leonardo Bras <leobras.c@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>, 
 Christophe Leroy <christophe.leroy@c-s.fr>, Nicolin Chen
 <nicoleotsuka@gmail.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Date: Fri, 30 Apr 2021 13:05:59 -0300
In-Reply-To: <e214f457-fcf0-c9ff-4574-93ed20298119@ozlabs.ru>
References: <20210422070721.463912-1-leobras.c@gmail.com>
 <20210422070721.463912-7-leobras.c@gmail.com>
 <e214f457-fcf0-c9ff-4574-93ed20298119@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2021-04-23 at 19:04 +1000, Alexey Kardashevskiy wrote:
> 
> > +	win64->name = kstrdup(propname, GFP_KERNEL);
> > +	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
> > +	win64->value = ddwprop;
> > +	win64->length = sizeof(*ddwprop);
> > +	if (!win64->name || !win64->value) {
> > +		kfree(win64);
> > +		kfree(win64->name);
> > +		kfree(win64->value);
> 
> 
> Wrong order.
> 

Right! Sorry about that. 
Changed for next version!

> > 
> > 
> > +out_del_win:
> 
> 
> (I would not bother but since I am commenting on the patch)
> 
> nit: the new name is not that much better than the old 
> "out_clear_window:" ("out_remove_win" would be a bit better) and it does 
> make reviewing a little bit harder. Thanks,

Replaced by out_remove_win
Thanks!




