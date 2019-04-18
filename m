Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1616C10F0B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 06:40:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C13214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 06:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="qPeJj8KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C13214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44l8cn5BsRzDqR2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 16:40:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="qPeJj8KN"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44l8Zx1QNJzDqNn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 16:39:03 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id d31so715473pgl.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=nY+EP2R9METKYDuku3g6nVrECtlVH8EVx2p8MKZ118k=;
 b=qPeJj8KNRZcPDLVMnDM575b8I8uxbwGFOuzY1O3nklzeCIIQBISrbzJ1N2wdOOVj+/
 I2IJoL0wlUjVDUzGjZyXUMsftii3pT3o2enK8JGO4UOPTEQsNXyaxFXIXnFoUE+/hCXC
 czjEDUc/+Pf6wCKACtzH7LS3kSMb4SIBPrxSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=nY+EP2R9METKYDuku3g6nVrECtlVH8EVx2p8MKZ118k=;
 b=tZc0D3kKQuH5xgvWkedqbloa1spMrlOL/qyq0vC0QCa95wHETHusJooWZhJwxJP+1u
 PeuHhXDdd2+aEYy9SSAZnmebvC9aUbrTzV0xgnYRTh0PbCYnySXc4GPjjnZP5zkReEFa
 6n8kw0kjX1w030Wyjuh08oBfRllRp/5ySWr0Jwy9LpY2wssMgiv64efSUdhlFf52/Jik
 tJWVlcwb5NxG159MQyqCnIm2ryxPA9ouxWCMPHjYGrw2+cmhjXsjYYqtgbbNZGxf6xcY
 AHQbPqiDQj8sTnN7ww9p9dWF0bDCi4AG6euecQ2pnUg32+LoRt4ic2xsAHxEr0E80A0T
 ogAQ==
X-Gm-Message-State: APjAAAVVTOfGMqW7kxaclBygmyE/kd+r0Ve4SiFait9Z6QCNBcmPQUoX
 5aqWLC3IAD+umryjzNtDlLDy5w==
X-Google-Smtp-Source: APXvYqxZQNAupenw4ViEZhxPwMbqUfoM1c99inLaaEY0blftbhWIrmuvbI2M9nVCeRWQyuAGrPHrpw==
X-Received: by 2002:a63:3857:: with SMTP id h23mr85072995pgn.305.1555569540173; 
 Wed, 17 Apr 2019 23:39:00 -0700 (PDT)
Received: from localhost (124-171-99-108.dyn.iinet.net.au. [124.171.99.108])
 by smtp.gmail.com with ESMTPSA id o81sm1603642pfa.156.2019.04.17.23.38.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Apr 2019 23:38:59 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Matthew Garrett <matthewgarrett@google.com>, jmorris@namei.org
Subject: Re: [PATCH V32 01/27] Add the ability to lock down access to the
 running kernel image
In-Reply-To: <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
References: <20190404003249.14356-1-matthewgarrett@google.com>
 <20190404003249.14356-2-matthewgarrett@google.com>
 <059c523e-926c-24ee-0935-198031712145@au1.ibm.com>
Date: Thu, 18 Apr 2019 16:38:54 +1000
Message-ID: <87zhonyg01.fsf@dja-thinkpad.axtens.net>
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
Cc: linux-api@vger.kernel.org, cmr <cmr@informatik.wtf>,
 linux-kernel@vger.kernel.org, dhowells@redhat.com,
 linux-security-module@vger.kernel.org, luto@kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Andrew,

>> +		If CONFIG_LOCK_DOWN_KERNEL is enabled, the kernel can be
>> +		moved to a more locked down state at runtime by writing to
>> +		this attribute. Valid values are:
>> +
>> +		integrity:
>> +			The kernel will disable functionality that allows
>> +			userland to modify the running kernel image, other
>> +			than through the loading or execution of appropriately
>> +			signed objects.
>> +
>> +		confidentiality:
>> +			The kernel will disable all functionality disabled by
>> +			the integrity mode, but additionally will disable
>> +			features that potentially permit userland to obtain
>> +			confidential information stored within the kernel.
>
> [+ linuxppc, mpe, dja, cmr]
>
> I'm thinking about whether we should lock down the powerpc xmon debug 
> monitor - intuitively, I think the answer is yes if for no other reason 
> than Least Astonishment, when lockdown is enabled you probably don't 
> expect xmon to keep letting you access kernel memory.
>
> Semantically though, xmon is not a userspace process - it's in kernel 
> and reads debug commands/outputs debug data directly from/to the 
> console. Is that a threat vector that this series cares about?

I guess there are 2 ways you could think about lockdown:

 - It adds a security boundary between the kernel and UID 0, so that
   userland cannot compromise the integrity/confidentiality of the
   locked down kernel.

 - It is a bundle of related security boundaries so that the
   integrity/confidentiality of a running, locked down kernel cannot be
   compromised, even by a privileged, physically present user.

You're right that techincally xmon is in the kernel and on the console
rather than in userland, so it doesn't fall within the first concept of
lockdown. But I think usecases for lockdown tend to expect something
more like the second concept.

IOW, lockdown is a trapdoor - once you've locked down a kernel, you
can't get out of lockdown (except by rebooting). xmon would allow you to
get out of the trapdoor, so I think it should be restricted by lockdown.

Regards,
Daniel

>
>
> -- 
> Andrew Donnellan              OzLabs, ADL Canberra
> andrew.donnellan@au1.ibm.com  IBM Australia Limited
