Return-Path: <linuxppc-dev+bounces-26017-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C004DC5DF88
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 10:53:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQgJb1XhXz2xW5;
	Thu, 20 Aug 2026 20:53:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787223183;
	cv=none; b=lpooF1X6iWj8LDcMw1dN+0ArNeM7Da9wr+cmEiX/0F9lX/hr404Avhcpd/yH2uzVfReQW4WesB1XzihyvaOmfe2FH0i8ayld7XctGt9ItIhl+OOPxkobX6kZ0+a2p+bApFwgVwODiSz80Lv1LK872BvT00++CXXCRevM26oB5Cv4Yz/NIZZeoeRyYeR6zxeE8h/5OxRIKUj/Yk7irGpDSIGMZvnT8louTld0Yb4dVUiBQjPHZbUoT+vTSot7OgnoonuPfx9ECn3pXnrCORFG0i6YnrNcHWiJp/poVeFKcuQBvPCzq7caHjdVEnv/sOJwnOois6rbvHDdMPWDdCUtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787223183; c=relaxed/relaxed;
	bh=eBG80TE8O7koV0M/Wd/+svOF4P4mOtCGkWlnllaV+RA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oBkeLH7GsHqOW/NEOvmOZRTilVSv7JVA91bVGnwPG563zokGV1vJHhzGpubyCApAA75HiLexpnOfTNSIAKBhtzw+BQNLFna9MVbUlUu57z3joXkv0jnWCUqihRS8KvgeyAu0ilvX7/LqQKQuwgS8GEUuW3DPxFJ+vm1pFDasDAZlpkeLqUPFe5/m0uqnBNKDmSunI9/GmNGZGLPnOA0Gbxl9r1dXoJIgDhnOIlBFJlel6ewXdWnn7aJnq7ZTJnAa72av+sZishJG1HbZ55t96IOrDtpUxXtX4rxe//CLOtrj/6Th63UC2kZExqvjbMKqljd+8LaNPIs4tNXgs9OWlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ag9bfg6R; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3h9ygagkkdlypwnqjowdqckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=ag9bfg6R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3h9ygagkkdlypwnqjowdqckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x645.google.com (mail-ej1-x645.google.com [IPv6:2a00:1450:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQgJY4GDnz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 20:53:00 +1000 (AEST)
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c15ceb17a28so159527366b.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787223176; x=1787827976; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eBG80TE8O7koV0M/Wd/+svOF4P4mOtCGkWlnllaV+RA=;
        b=ag9bfg6RSddZKkhYtP1UnPWVpR9yFMZqP2ZGZUaf7QSii3hP3SbSUDR8nkWFhkqePY
         pyFVFNCrpSty2nmY4oUHggYzOtdRXAHYhdqNIQA6cPvjTvw8JtHewDd13ngp0vqb4RPU
         gIjTSMXDXcRtDK4F6iHb/w/w1fyI1GrZO2+juXNqv4qaZXOx9tGU9VQwuPGLzk213Q6y
         ijPDsD5MXKH9vmWF5olJH+7mC3QriaqBrSTpjro6Y7KuJVSVzCw9qt1wm5rbHRlwIZRW
         yLUSje+tozLiFADdal8SONcBD7iYjRkLAggKRhmjU7Zqe5hWAbLD5MYS3VWG54Oqlfgr
         2+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787223176; x=1787827976;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eBG80TE8O7koV0M/Wd/+svOF4P4mOtCGkWlnllaV+RA=;
        b=YUZTCJgFsPveNbEdBC3RDDL3ADOIYVkKZOVCb9LXE/hAX4lndKxFTlPodD1P+Oq6WC
         bMjK7snd0iSzXOhvXrP2Nj2+OPJJe+j5bVrvGN7BNVqE3dEVfUZ5N6MyU9Ym9qLh9rVr
         KW7p/D/AISHmjFJxQDuzjr4QP5WKcVHLk7VTerCUEXQQadf3zGCTLsqgugiHdlhvQIek
         rU6u9Ve5pu1249blhSIQVZS8b3May1AQMI7/stv9f2kHW7zsfvZBYapleFjkJn+TKpS9
         4te6m0M7f20YS/IfWwH0dAPDW78CoGxZqwv99Z4mEkcPH0eDcNupErCI71vdn2TE95Jm
         yQqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoE99MnGDf6CCLoNWeKVnc/bPnWR5RD2UsTlWcOx+5wymfxc9hN2g0USq605OzHHbfX5Ni0SLM+R3urHuE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy38lYcY9RT1r7JVmTr/jkRQJ+1b+1Dz0xYNhSIaRs1iSBqF8pM
	4Q0iPrzLcylAOl3zJp9OLo0pP8B7VhDL93TM7SZOx5Q5H0qrJweFe8entyVxURB0Se2NxXM6ZpP
	eLeemCLYYr+WcUgMBSg==
X-Received: from ejel3.prod.google.com ([2002:a17:906:2a83:b0:c16:11e4:9d9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:928c:b0:c16:26c7:6ba8 with SMTP id a640c23a62f3a-c23f92c3376mr791823566b.6.1787223175489;
 Thu, 20 Aug 2026 03:52:55 -0700 (PDT)
Date: Thu, 20 Aug 2026 10:52:46 +0000
In-Reply-To: <20260814220652.GA101268@bhelgaas>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
References: <20260814220652.GA101268@bhelgaas> :q
Message-ID: <9huzik55kqrl.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 2/3] firmware/edd: use kobject_put() on
 edd_device_register() failure
From: tarunsahu@google.com
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dmatlack@google.com, Nicholas Piggin <npiggin@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sourabhjain@linux.ibm.com, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Russell King <linux@armlinux.org.uk>, radheys@amd.com, skhawaja@google.com, 
	djeffery@redhat.com, Geoff Levand <geoff@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	linux-arm-kernel@lists.infradead.org, souravsgl@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Fri, Aug 14, 2026 at 09:00:56PM +0000, Tarun Sahu wrote:
>> As per koject_init_and_add() function kernel document, even if this
>> function returns error kobject_put must be used instead of kfree.
>
> Thanks for adding this specific pointer.  I wouldn't repost just for
> these nits, and wait at least a few days before reposting for any
> reason.  But if you do repost:
>
> s/koject_init_and_add/kobject_init_and_add/
>
> Might also add "()" after function names consistently (kobject_put and
> kfree above, edd_release below).  Also applies to the other patches.
>
> The current subject lines basically restate the C code; you might
> consider more of a focus on the problem.  I ran this through gemini
> and I think it did a decent job:
>
>   firmware: edd: Fix kobject reference leak on registration failure
>
>   Per kobject_init_and_add() kernel-doc, calling kfree() directly on
>   error bypasses reference counting and skips the kobject's release
>   callback, leaking the reference.
>
>   Use kobject_put() instead of kfree() on registration failure to fix
>   this.

Thanks Bjron for reviewing. I will take care of them.

~Tarun
>
>> When edd_device_register() fails after initializing the kobject with
>> kobject_init_and_add(), calling kfree(edev) directly bypasses the
>> kobject release callback (edd_release) and leaks the allocated kobject
>> resources.
>> 
>> Fix this by replacing direct kfree(edev) with kobject_put(&edev->kobj) on
>> registration failure.
>> 
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>  drivers/firmware/edd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
>> index f980c5b56858..763e7b16d517 100644
>> --- a/drivers/firmware/edd.c
>> +++ b/drivers/firmware/edd.c
>> @@ -748,7 +748,7 @@ edd_init(void)
>>  
>>  		rc = edd_device_register(edev, i);
>>  		if (rc) {
>> -			kfree(edev);
>> +			kobject_put(&edev->kobj);
>>  			goto out;
>>  		}
>>  		edd_devices[i] = edev;
>> -- 
>> 2.55.0.691.gc56d675ccc-goog
>> 

