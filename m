Return-Path: <SRS0=1bSx=7A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCC7C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 23:42:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94877207D4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2020 23:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip33ZZH/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94877207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49QwYK49xZzDqfG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2020 09:42:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::832;
 helo=mail-qt1-x832.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ip33ZZH/; dkim-atps=neutral
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49QwWK25qpzDqd0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2020 09:40:59 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id i68so9712783qtb.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2020 16:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :organization:user-agent:mime-version:content-transfer-encoding;
 bh=zMf1ol6Clx/k/hSOSDJAbQyv0BhYSmliFHitxb6ckWM=;
 b=ip33ZZH/9/QhByuelU3lGSogSNC2h0LADRIuYH4izAW+MhNrwXIYtncF7oikbjInbX
 1thxu4Ut2GVlcTbeXJtFtiIoTPOGDBAPTNGfYEq9h4azrNyCUrejLuHLdNpBp4a/A6bG
 RsdECybopTCzcVmi+JoerOS4ExMJlDRCLqs0gjm9t3H/R/yC3WiudsVnNhtsU/1E+QlI
 RM+ibluYndMZPhVoKOulcQiUz9V2sgWwIgU4DoWNU29inBXKY02RUCO7cgS49aaanVTV
 fIM+cgTxlAu2DBOM7uk+0BTprAbKO1bcvEx5adhBTOljUBKsQkBZp1iPCpfVDYkvsaHa
 LW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=zMf1ol6Clx/k/hSOSDJAbQyv0BhYSmliFHitxb6ckWM=;
 b=eoEL76xNB10h5gIfKqNRslo8fR/MnxtbwSF4ZfU/4ib/VmFb14qC/zRg9KqgpyHKd5
 6cbpDtEmdJ2q6Qtgi1Ba8jyTbGwQN/6N53/SxZnsJvNf8wk8t+CHrulSuZqy9OqP+8Ed
 BxAPpGSgwCI5P3KIBERlHYf3ZY6MatM6U9002qagTxVKM/mGv+QOKGs9GV/n6zCxya1b
 Nry1QJvb57WKso5gZ3oV36ykWxPK0n3N2hB3l5FWUY5qUTV7e2aTLXuVrQkE4fAjFcoa
 VDbOnprND6i1X78iVqmCtE+jsUBW0xBzHiwrTy+vcK+dED1jPdVsKp/FTkfi7HAMwMrq
 uuyg==
X-Gm-Message-State: AOAM533Kj5UY9piDiA4sGNqm3zQeaU0cUN+qo0ymJEsfTFiIHkIn1Se1
 Me9jMW2ahBoLiZl02DP452k=
X-Google-Smtp-Source: ABdhPJyltryGJ6c3kimgdcUgCfpPCrfF2NxTlErvLk3Xgbc3+ac2FewlFOGHQ4w+J9/R/oj5a3hFrg==
X-Received: by 2002:ac8:6f28:: with SMTP id i8mr9669126qtv.163.1589845255162; 
 Mon, 18 May 2020 16:40:55 -0700 (PDT)
Received: from LeoBras (177-131-65-239.dynamic.desktop.com.br.
 [177.131.65.239])
 by smtp.gmail.com with ESMTPSA id l15sm10630241qti.83.2020.05.18.16.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 16:40:54 -0700 (PDT)
Message-ID: <2ccc819dba70152bc57cf375a8f792a28a3c433f.camel@gmail.com>
Subject: Re: [PATCH v5 2/2] powerpc/rtas: Implement reentrant rtas call
From: Leonardo Bras <leobras.c@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, Allison Randal
 <allison@lohutok.net>,  Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,  Daniel Axtens
 <dja@axtens.net>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nadav
 Amit <namit@vmware.com>, Nathan Lynch <nathanl@linux.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 18 May 2020 20:40:34 -0300
In-Reply-To: <1589614523.yfijifo1n6.astroid@bobo.none>
References: <20200516052137.175881-1-leobras.c@gmail.com>
 <20200516052137.175881-3-leobras.c@gmail.com>
 <1589614523.yfijifo1n6.astroid@bobo.none>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
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

On Sat, 2020-05-16 at 17:36 +1000, Nicholas Piggin wrote:
> Good, I think this should work as you want now. Can you allocate it like 
> lppacas? Put it under PSERIES (and in the paca) and check for !HV?

Sure, I will do that. 

> Oh and while there, could you prefix the name with rtas_?

Sure, replacing reentrant_args with rtas_args_reentrant.

>
> Thanks,
> Nick

Thank you for the feedback!
Leonardo Bras

