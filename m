Return-Path: <SRS0=FKTu=AN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EBEC433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 10:27:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC17020747
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 10:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwrGZyQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC17020747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49yDnP6c0XzDqx0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 20:27:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::641;
 helo=mail-pl1-x641.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=fwrGZyQ5; dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49yDl51DJCzDqsH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2020 20:25:53 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id s14so11142240plq.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2020 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=2dEmOOaTKGF4Qlb49VhQf6A9PlFA3b36H9rV7z7cwEs=;
 b=fwrGZyQ5ZsT9XNpr3/IOWdRZ6ocaZNwfSU2kbuorYXlEEdLE5/x5p3TVpSz28QRp1G
 Rq97XWBtS9UIquZ9RJU/9RJJsvs3vSblV7P3bcy3AJKNZxupjf8CAIH6Vx5/rgUgktkk
 duzXAxjb/9SdEDlWvBSKLc74Js/6Hemi2omyXcEecBxTRXPd6QyrD+31gJzLltU6iW8n
 JF08jA85kpDrr4bA2nZyBfxoqXA5dQqxwaS7+++ll1ExbDrK2qXYBnMpcyDzOvT90egd
 caLSXaJhoRisXKEQ9uGYLW2o3jDa/MNsoH7QZe8RRqAZWZ+dpbslBRZd5PEW6CLytugN
 5Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=2dEmOOaTKGF4Qlb49VhQf6A9PlFA3b36H9rV7z7cwEs=;
 b=bqznCbtArAIwYuAWGgZ8KlriWqS0wI5NfeRIuKvNRKf812k1nbvz5N61P0Q+dCr9DV
 bii0u28/ccTYXlT9lEjN2MF3lrKbZvyDN6tQoB5VUrVd+8uh4fDi3hkSMCglE4wo+Aw2
 BD+SQOq+ndL4lmldYrS9UEgKZsxYMBECToRIYOI+BHmrZVZKka+5JgVYoX/G/JemHlfQ
 WaW1S5qOAO2fjF4/MpYvHQbKq/derToyrfqHyvoFIKR0KMzQ51W0CcAXt+UVH01ejymW
 I7wlCbbpIsf6h0U2vHxC8dF2woGNgFHh0tCkUz/BScM3ixyer7P2r38LKYcXZUpwAREd
 whjw==
X-Gm-Message-State: AOAM533wkV26sGuL+sCsxEImOeq9Qo64lyu2H1ZZ5dCCvaM5QqB9dyb0
 bCXbBCIqa+9XGXofuFrE8Q4=
X-Google-Smtp-Source: ABdhPJx/3IphE9S504xPgr16qEBAcS0ylg8qERwwjyz6fVgDCXDiKIqknM6KTZc4U4Q2EmZZ4gfQeA==
X-Received: by 2002:a17:90a:17ab:: with SMTP id
 q40mr29264299pja.152.1593685549611; 
 Thu, 02 Jul 2020 03:25:49 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id g18sm8571288pfk.40.2020.07.02.03.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:25:48 -0700 (PDT)
Date: Thu, 02 Jul 2020 20:25:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
To: Will Deacon <will@kernel.org>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-6-npiggin@gmail.com>
 <20200702080219.GB16113@willie-the-truck>
In-Reply-To: <20200702080219.GB16113@willie-the-truck>
MIME-Version: 1.0
Message-Id: <1593685459.r2tfxtfdp6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
> On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include=
/asm/qspinlock.h
>> new file mode 100644
>> index 000000000000..f84da77b6bb7
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/qspinlock.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>> +#define _ASM_POWERPC_QSPINLOCK_H
>> +
>> +#include <asm-generic/qspinlock_types.h>
>> +
>> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>> +
>> +#define smp_mb__after_spinlock()   smp_mb()
>> +
>> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock=
)
>> +{
>> +	smp_mb();
>> +	return atomic_read(&lock->val);
>> +}
>=20
> Why do you need the smp_mb() here?

A long and sad tale that ends here 51d7d5205d338

Should probably at least refer to that commit from here, since this one=20
is not going to git blame back there. I'll add something.

Thanks,
Nick
