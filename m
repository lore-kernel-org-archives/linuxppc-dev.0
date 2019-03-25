Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9F0C10F03
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:56:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF8720896
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXA+Xt4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF8720896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Sf5Q6mVzzDqKS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 02:56:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=larry.finger@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXA+Xt4z"; 
 dkim-atps=neutral
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Sf2t5VXYzDqCY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 02:54:30 +1100 (AEDT)
Received: by mail-oi1-x243.google.com with SMTP id y84so7325769oia.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=g6xGLodDDgms6w7FgUnf63b+SEV7be9PLO7OpdSc9co=;
 b=QXA+Xt4zS98QAT1iMWr0PB2q+bd0QqoeGt1UUMGWoYbJA5qaZAfXrlLGGIvExFKzbs
 Cp+ZapzS+BaJgRHxiGW/Ih16kqVbjO6amuh8nHSDzqiz3I+ObBYQD1bHyMjRg30c+Pp7
 ab4h/4+rrODUKF9zjy4HKOGeUx7bzfZdDwAIbInpUcl3r2FyRc/waGWZzlQjRsxBStje
 JMY5J5+2YTmpvvvFoQGbMc6t3buIfHw159vlqlHYVf20cwgPDmqyfg8AU13wB3WXJiVU
 9zUYk/IcOgOG4pQkuv8bBxHv8JJoh3v2Cf/ZWfB4dTNK5ThU48Zg2HRR9Gu51LW7Zxvx
 l0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g6xGLodDDgms6w7FgUnf63b+SEV7be9PLO7OpdSc9co=;
 b=OL0dbujWx4JRa0WPtv2ri1i/9SQxRhBhJV+fHZYoOBWc5FucVfZDTy6ofAW8prJC/z
 iLRhEt69f/2x3BQR9Lntp9iF90JF4XQFgXoHV8k7KVmr/i0Cy6OGJllgy1TK/pNQwl9n
 tVsONR84IRV+2wsbxm45sDK/AcTQ4kIcRPQmrc3qkl/i2I4A6lNF0KTdV3D1GDa1nwRG
 O2sNEOvlYawVLghp161wCovrOlyGVRrzxiVgBtg7+k2so1K37iSHM9hDbjAPRI9l6IXj
 FXvtz3rKabDBt01yt5hTdwbt86/4yRc9rZgKfkqWBGmAvn6NJDk8KFW96Lq8POskFsi9
 ZnLQ==
X-Gm-Message-State: APjAAAVkUEQ8QjVfUQQzrf/2FrOubjLGLls3h29nNAgVyDMgpQvH4bv7
 0rF3lKw286XAu8d/Aq7igC8=
X-Google-Smtp-Source: APXvYqzrdVbP1vJ2P/zA6tb6UGnKD8dVr9GhxVKzHData6Qvx63d3nkS0N7itSMP/NMgim1CWDEnqg==
X-Received: by 2002:aca:34d6:: with SMTP id b205mr1045966oia.14.1553529267224; 
 Mon, 25 Mar 2019 08:54:27 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com.
 [24.31.245.230])
 by smtp.gmail.com with ESMTPSA id s73sm6743279oie.53.2019.03.25.08.54.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Mar 2019 08:54:26 -0700 (PDT)
Subject: Re: Regression in 5.1.0-rc2: PowerBook G4 Aluminum fails to boot -
 bisected to commit 0df977eafc792
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <acc2d5a5-2fd4-4367-c8ef-497da951c208@lwfinger.net>
 <ee247f37-8889-934c-571c-01c43fc31071@c-s.fr>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <af5603cb-5726-213a-adba-164c635d1a66@lwfinger.net>
Date: Mon, 25 Mar 2019 10:54:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <ee247f37-8889-934c-571c-01c43fc31071@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/25/19 1:53 AM, Christophe Leroy wrote:
> 
> 
> Le 25/03/2019 à 01:49, Larry Finger a écrit :
>> A build of kernel 5.1.0-rc2 resulted in a failure to boot on my PowerBook G4 
>> Aluminum. The bootstrap loads the initial kernel and issues the appropriate 
>> start, but the machine hangs at that point.
> 
> Can you please be more explicit ? What do you mean by "issues the appropriate 
> start" ? What is "that point" ? Any messages on the console ?

Sorry to be unclear. The bootstrap code prints a line saying "Booting Linux via 
__start() @ 0x00c00000" and then hangs.

Your idea of confusion between physical and virtual address sounds right. I am 
building a kernel with that patch applied now. As it seems to be going quickly, 
I should have the answer fairly quickly.

Thanks,

Larry


