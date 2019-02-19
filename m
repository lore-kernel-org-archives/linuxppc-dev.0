Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EEC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:15:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB52921773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3W4zqCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB52921773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443S836dr2zDqHF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 15:15:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="t3W4zqCi"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443S6K0620zDqDC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 15:14:00 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id b2so3716736pgl.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 20:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=ucv8Ayku5k5FPd2Wqij9WS+MNDGakyvBTPjgv2DTnuQ=;
 b=t3W4zqCiakOL0DGQxIk2uG94uYsf5JUEwOxt3cVsRQZn5dqg+XLFQYQiNAPgDKjXNg
 gef2/PwGH/3zRIX+Ty7rtvCzfY8c9xA6dX4Q/5i0tiNhq0xFEgDsr42lqJ/tlDz7gRID
 iA7jgG6hVF5nZqJQWRcP0NH0vkIzZ1QhLoIA2GMusF8QKpYskUV5rLdUkGVxT2+FnZRh
 kM90K3B8nGCfhFm3FPB1zqwRUpMiq2pvwuYhYHNhmVmAOVirtvYVWusqX8ByzXUxOrrI
 zC3jdslt27N2gHcVRWq+pEHkqvk2Ou8E/ROeddUwaJ+eY2BhtwAMAUKVQn2AEBuSaXoz
 TUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=ucv8Ayku5k5FPd2Wqij9WS+MNDGakyvBTPjgv2DTnuQ=;
 b=P4eoDLKQ1itH52baCx7j3tqId4c1ukz5/7jLnOn1tXFeozmFHM1Xn8paIpT1LI09xK
 1WJzmjWpeiv9KWzlPGghQ+ccwImngzkNHKDhF4TAI7tuL9xJY3LxJNJu794ftDpuXzep
 +/ScSY94+M5vARGXE4hTDiJFw4sy5yC4kWrfRGYME1VpEBD4rJB3OW9kq6xvEGtpq/Wl
 fjDMOOK94yxIUhfCKq55noqTkTSNiz9Oaa9uGcXSWz91cemjYVvowbwZwqi9GIblg1P/
 vgWmMnPNVU0z0XogLPzyuGwfojFhM3slzwbBywB5yWcyjTRT2nxapzcS2k4n+wq4EvxT
 /Nzg==
X-Gm-Message-State: AHQUAuYU+Ii2pngU8dW1w1bPykCDPDSNArdSAd2iuXd2orqK9n1dmn45
 76uRxc3TcqHUj3DX8T3KrzA=
X-Google-Smtp-Source: AHgI3IZwXwW5mIeZZeia7EYrm/hNt9AuPP7UqkpHNPHJtWOaHny5M6WVCOylP/y8ymwi+OTpQYONNg==
X-Received: by 2002:a63:a5b:: with SMTP id z27mr21645512pgk.78.1550549638896; 
 Mon, 18 Feb 2019 20:13:58 -0800 (PST)
Received: from localhost ([61.69.157.156])
 by smtp.gmail.com with ESMTPSA id n25sm23148123pfi.173.2019.02.18.20.13.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 20:13:58 -0800 (PST)
Date: Tue, 19 Feb 2019 14:13:51 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6] powerpc/64s: reimplement book3s idle code in C
To: Paul Mackerras <paulus@ozlabs.org>
References: <20181013120409.1993-1-npiggin@gmail.com>
 <20190217230640.GA922@blackberry>
In-Reply-To: <20190217230640.GA922@blackberry>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1550549470.22tqiqz5em.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Paul Mackerras's on February 18, 2019 9:06 am:
> On Sat, Oct 13, 2018 at 10:04:09PM +1000, Nicholas Piggin wrote:
>> Reimplement Book3S idle code in C, moving POWER7/8/9 implementation
>> speific HV idle code to the powernv platform code.
>>=20
>=20
> [...]
>=20
>> @@ -2760,21 +2744,47 @@ BEGIN_FTR_SECTION
>>  	li	r4, LPCR_PECE_HVEE@higher
>>  	sldi	r4, r4, 32
>>  	or	r5, r5, r4
>> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>> +FTR_SECTION_ELSE
>> +	li	r3, PNV_THREAD_NAP
>> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>>  	mtspr	SPRN_LPCR,r5
>>  	isync
>> -	li	r0, 0
>> -	std	r0, HSTATE_SCRATCH0(r13)
>> -	ptesync
>> -	ld	r0, HSTATE_SCRATCH0(r13)
>> -1:	cmpd	r0, r0
>> -	bne	1b
>> +
>> +	mr	r0, r1
>> +	ld	r1, PACAEMERGSP(r13)
>> +	subi	r1, r1, STACK_FRAME_OVERHEAD
>> +	std	r0, 0(r1)
>> +	ld	r0, PACAR1(r13)
>> +	std	r0, 8(r1)
>=20
> This bit seems wrong to me.  If this is a secondary thread on POWER8,
> we were already on the emergency stack, and now we've reset r1 back to
> the top of the emergency stack and we're overwriting it.

I'll have to find some time to take another look at this stuff. The KVM
stuff was a bit hasty.

> I wonder why you didn't see secondary threads going off into lala land
> in your tests?

It must have been because I wasn't testing the guest SMT properly=20
because I did get it to break trivially sometime after posting this=20
patch out. So we were on the emergency stack here, that should make
things easier, that may be what's wrong.

Thanks,
Nick

=
