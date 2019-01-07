Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71688C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA4E206BB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA4E206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YFZ21LRTzDqF1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 23:48:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.193; helo=mail-qt1-f193.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YFSz5QsRzDqDL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 23:44:19 +1100 (AEDT)
Received: by mail-qt1-f193.google.com with SMTP id i7so217948qtj.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 04:44:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UgJXc/62LXjsU9gSyrR5a3lyuQNTU1rOW5cV9ZmyAG8=;
 b=GCunI+ZvFyWexoHCqx7exefl7ynPtB4NFkKxt39LITiJg4svAUIaEacL31PCFgluCq
 w33C+bNQH/UWVeOuCuSw1B4UaqrwLXTgV1m4DkXvuurK064hbXajAAwtuLOriEP7kceT
 Fbfgmrk7hSRLizSAmMKPTFkWAaE0mRIrKT0qG4DPxOmwGIql+b0mQ0X8EmdZY/1+V7db
 zAggwutUxtdfWKDf2JvcBbQO4O6eNtwl7l/miGv4Jt1Fe6Ps13kEUtoFD06MaAJwGu0U
 kqYVzJl1vaklj3yVtLQuJLnozqLWlkql4Bq2xqKAGH8IZCq0Ge6MSkYCdVSFO+MiIWOt
 597w==
X-Gm-Message-State: AJcUukdYt6PWvZm+BKNeRPY7psrTP16sbngX8KP9TAJHvLMIcnr/7kvS
 DC8m2Vb+BaJn/DobW4fyhoAZm7U2
X-Google-Smtp-Source: ALg8bN6qcBj45d7VsOumKTSU4iKTGeHWjyKXC7m7gHZsqsypfNBegfKvaMefNRPdo6qtJRXd6EfzBA==
X-Received: by 2002:a0c:a045:: with SMTP id b63mr60775853qva.164.1546865056994; 
 Mon, 07 Jan 2019 04:44:16 -0800 (PST)
Received: from [10.0.0.8] ([189.29.25.55])
 by smtp.gmail.com with ESMTPSA id w184sm34250677qkw.90.2019.01.07.04.44.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jan 2019 04:44:16 -0800 (PST)
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
To: LEROY Christophe <christophe.leroy@c-s.fr>
References: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
From: Breno Leitao <leitao@debian.org>
Message-ID: <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
Date: Mon, 7 Jan 2019 10:44:12 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Christophe,

On 1/3/19 3:19 PM, LEROY Christophe wrote:
> Breno Leitao <leitao@debian.org> a écrit :
> 
>> This patch simply adds definitions for the MSR bits and some macros to
>> test for MSR TM bits.
>>
>> This was copied from arch/powerpc/include/asm/reg.h generic MSR part.
> 
> Can't we find a way to avoid duplicating such defines ?

I think there are three possible ways, but none of them respect the premises
we are used too. These are the possible ways I can think of:

1) Including arch/powerpc/include/asm as part of the selftest compilation
process.
   Problem: This might break the selftest independence of the kbuild system.

2) Generate a temporary header file inside selftests/include which contains
these macros at compilation time.
   Problem: The problem as above.

3) Define MSR fields at userspace headers (/usr/include).
   Problem: I am not sure userspace should have MSR bits information.

Do you suggest me to investigate any other way?
