Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C74DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 05:52:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EF920702
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC4U6ZGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EF920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1BRV2vSyzDqcS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 15:52:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aC4U6ZGs; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1BPm1J54zDqW8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 15:51:06 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id x8so15404290plm.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2020 22:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=2kPoQO29du6cgYs8wxDy3HydqPoXeUts+rFxoRwvPJ4=;
 b=aC4U6ZGsZUqBz0cWyJxxDDtTiTOjiRRceLssFNvfZVaY6XZ4ahnmh/PWv+zNuf1rG1
 RuIW6sAQLqwYBuidcRZ1HWNwtIt//yvHT15YUMJpu4ViYxTnmxvQJ6mnOnmbbQL0NRKB
 HLVOe98Qp4XwhEu8ZC1qCi2LiON8RrdPy+Me0RZTNidr7XSUy9lpi1ZtkNjxT7JLr2+r
 WYtLfjsdu2giWHeh0UvzEKJBqulTCwDXRXu0aATOoILRBWWLa2Kw+VSzQiWx6gk5S8XS
 nWgnfWl0+w0uiXWBBA+87l+1KIB6YneN+kBCLEn7yAHRoDucikloxmlP6NuDEkiiPVB3
 WCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=2kPoQO29du6cgYs8wxDy3HydqPoXeUts+rFxoRwvPJ4=;
 b=rpRYn85EGbrZq8xqY69HOTUlGZCB6wi3gwrK60LLHv0VYASxwnPmBto/lT4j2Pzpm3
 tX+dOF7fj11NmNSSWIzt7i/edokqkIgUiU7Bg6FTH1jVf1NskOzUxjfHaSW560u5Yckg
 EbwqwW6poJnsfT1paAXQFz4W7bKnYiiadycPou7pCIhE0qne+fdU+XYG1T/XhAJkICMc
 OckLzB6D1jQ/aGdRnRdhZUVJ+8Tf9sro5vH5qBtnj1ihVrp03aTaaBUp5AXms0H54x8I
 vlYPi7z+Ar+Tz0pEIgxucTUOrGVOH0TlO77neca87KebiZ64QjpqV6E9FiUCwdyp6Jpl
 Qqiw==
X-Gm-Message-State: AOAM531UIgzxX5CC53XhGHb5yvYi4dGCqqbT/Z4u56HZ7qkS3CuoAM/d
 /862gxDz9Mm2dvd2UjtaJ5w=
X-Google-Smtp-Source: ABdhPJx5sV3WSX9SPDMPLTTp0JD9NeJpZpmsKSEOC5s58MfiKeX/NZr+y8YbdNnAg4Rw+uGx8QDvFQ==
X-Received: by 2002:a17:902:8546:: with SMTP id
 d6mr44592437plo.220.1594101063222; 
 Mon, 06 Jul 2020 22:51:03 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
 by smtp.gmail.com with ESMTPSA id c14sm20858247pfj.82.2020.07.06.22.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 22:51:02 -0700 (PDT)
Date: Tue, 07 Jul 2020 15:50:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20200706021822.1515189-1-npiggin@gmail.com>
 <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
In-Reply-To: <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1594098302.nadnq2txti.astroid@bobo.none>
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
Cc: linux-arch@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of July 6, 2020 7:53 pm:
>=20
>=20
> Le 06/07/2020 =C3=A0 04:18, Nicholas Piggin a =C3=A9crit=C2=A0:
>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/inc=
lude/asm/exception-64s.h
>> index 47bd4ea0837d..b88cb3a989b6 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -68,6 +68,10 @@
>>    *
>>    * The nop instructions allow us to insert one or more instructions to=
 flush the
>>    * L1-D cache when returning to userspace or a guest.
>> + *
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SY=
NC_CORE
>> + * without additional additional synchronisation instructions.
>=20
> This file is dedicated to BOOK3S/64. What about other ones ?
>=20
> On 32 bits, this is also valid as 'rfi' is also context synchronising,=20
> but then why just add some comment in exception-64s.h and only there ?

Yeah you're right, I basically wanted to keep a note there just in case,
because it's possible we would get a less synchronising return (maybe
unlikely with meltdown) or even return from a kernel interrupt using a
something faster (e.g., bctar if we don't use tar register in the kernel
anywhere).

So I wonder where to add the note, entry_32.S and 64e.h as well?

I should actually change the comment for 64-bit because soft masked=20
interrupt replay is an interesting case. I thought it was okay (because=20
the IPI would cause a hard interrupt which does do the rfi) but that=20
should at least be written. The context synchronisation happens before
the Linux IPI function is called, but for the purpose of membarrier I=20
think that is okay (the membarrier just needs to have caused a memory
barrier + context synchronistaion by the time it has done).

Thanks,
Nick
