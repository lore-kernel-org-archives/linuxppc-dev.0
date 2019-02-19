Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE9C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 00:16:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFB021479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 00:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="WX9vhgf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFB021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443Lqt47W3zDqHr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 11:16:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="WX9vhgf3"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443Lnt5RvSzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 11:14:25 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id p8so9491016plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 16:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=S/zqRsCoBHbsUCsNuTx/yqhmB85uqMX3CK0FxZ0OPM0=;
 b=WX9vhgf3KhLiljUSjPWJul4GepFUTj/XA3f14HsuSAzg6dabRd10Yt5efQxPclaanP
 NGmM82rHQLVoLeP2YjrkfIDLk/yWrtJZMraTEQZz0bE+mRwsZsH3OV0FpppnxFlObVNn
 3gS7+H0RpE03/2cm8FNc0Y2lfG+DI+VLoizRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=S/zqRsCoBHbsUCsNuTx/yqhmB85uqMX3CK0FxZ0OPM0=;
 b=t2GIQ+ZYUt8XPnYKO4HzegO54itRa8OghKXSL+mClahV4PpXCT+1GtQ+oOmm2SxGei
 9QRAd1h/kC4+QVPvYa2LICJUHd4kpw6EgtXPkgjGEKr3mDk16BKM77dsErDBX3/X7jy0
 GOod+IfQ16bHiikF5+gx2xyEJNKE9Mh0es7w4VfSNI0wNZAwI5HdwnB2pfUAv1SrqilP
 3FUfoNiwrBlas1OcCqKnPbSrxwelYV1s+uZ89a4SUcwahknSIycfIdEs4X8XDCTbrPhm
 31jN8oU0NXvnswnEyShbHNaR6or2aAEjIaIG9GoMeLemDqMX4NFgaf01QUkdxrOSUqo+
 pKMQ==
X-Gm-Message-State: AHQUAua4CQeCXl65RwJGvHuNIICPfyzGWoqiBamGXKM4CHMwq3vwkPAk
 0VBhRUXuc82lk60VoYAXTSNfCw==
X-Google-Smtp-Source: AHgI3IZ4oBowPV1geGIlJpKoM8ZbKOxLRpU6iRwmW1ImeOJJSAXxk0t3W7TKBHMBzjUbyWnT69qDXw==
X-Received: by 2002:a17:902:7d83:: with SMTP id
 a3mr18827291plm.83.1550535263460; 
 Mon, 18 Feb 2019 16:14:23 -0800 (PST)
Received: from localhost (ppp121-45-196-25.bras1.cbr1.internode.on.net.
 [121.45.196.25])
 by smtp.gmail.com with ESMTPSA id e63sm8218320pfa.116.2019.02.18.16.14.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 16:14:22 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, aneesh.kumar@linux.ibm.com,
 bsingharora@gmail.com
Subject: Re: [RFC PATCH 5/5] powerpc: KASAN for 64bit Book3E
In-Reply-To: <e0373aa9-5035-3d32-2422-a08e52d2a4fb@c-s.fr>
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-6-dja@axtens.net>
 <e0373aa9-5035-3d32-2422-a08e52d2a4fb@c-s.fr>
Date: Tue, 19 Feb 2019 11:14:18 +1100
Message-ID: <87wolw3a91.fsf@dja-thinkpad.axtens.net>
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
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

>> diff --git a/arch/powerpc/mm/kasan/kasan_init_book3e_64.c b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
>> new file mode 100644
>> index 000000000000..93b9afcf1020
>> --- /dev/null
>> +++ b/arch/powerpc/mm/kasan/kasan_init_book3e_64.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define DISABLE_BRANCH_PROFILING
>> +
>> +#include <linux/kasan.h>
>> +#include <linux/printk.h>
>> +#include <linux/memblock.h>
>> +#include <linux/sched/task.h>
>> +#include <asm/pgalloc.h>
>> +
>> +DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
>> +EXPORT_SYMBOL(powerpc_kasan_enabled_key);
>
> Why does this symbol need to be exported ?

I suppose it probably doesn't! I copied Balbir's code without much
thought as it seemed a lot smarter than my random global variable code.

Regards,
Daniel

>
> Christophe
