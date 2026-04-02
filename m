Return-Path: <linuxppc-dev+bounces-19182-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CE7111224B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 01:50:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmPv95VNBz2ySb;
	Thu, 02 Apr 2026 12:50:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775094629;
	cv=none; b=aP/nLtjDbIJ/oJjjLkDOZFIZFOCnXqHzxhFuwjDfyEne7szFOYiXdxNm+JkI/dGJ8RuyJJvAW4Nfd6bn8P9COVsmSLd4OLGEE57fXu9Fp0XqYh2v513MRsSwZDfiUczq9EYG1vVbdhzwBpx9w6QLLF3vUrwyW/O034J6qmPkErHasHzoeL8KFnbMkA/DtkbSIBTZj6EcnIw826LyKjoA1ROPduABTqxMYGGB9kDCGbg+ZR8CYEwMyrqkSSjDKj9108BGSRjEEf8OIcKigs0xPVh73GFVs9ztg7Gnp8v2X5DWo3NW2o+8c0mXb3j3Yo/f7IAYejpzeiSx2Y2CmIeVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775094629; c=relaxed/relaxed;
	bh=4rWHn8ZLLaNhlcOKvyDiXP9A00oZt/Dbtw9Zn8GCrdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ny6FgihzN+eJS3ocGJek1Ji9tTxkjNcXDyBD8MwaF+VbRBx8mvR6oTbYp4P/Y3QINH4xNohwDVlPi51zbipfWtqTWZy0bRig/QeRAXChOMPMhYzUki4ZFxBTXc3kUe0mF7m/mB3uDnmlffnFFb9uUYJvmbfhPDcX3W1dC3TrTRDQgONtQjtMJ4hpqYSbCe/jJ1lm5nFU6LaWVCq67A4j1C5DrTomguRe2gFJpQd7phSzOju60JgI0v8A/ybWNY+J9ri2H35cLw+ABP9MBQa4TK/mN4UbzHYVCehXPfOwdeNdCqepM8rJddYJ8mznNaONemEr2QtHaexSbtncD3FZyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QRYuD1Pj; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMHqiqmZ; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QRYuD1Pj;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMHqiqmZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmPv76FJJz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 12:50:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775094619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rWHn8ZLLaNhlcOKvyDiXP9A00oZt/Dbtw9Zn8GCrdY=;
	b=QRYuD1PjaTGfm1RgxgNF3yncJKd7G9fjQMcHzZ3mhWWsRKqCGnOet8KvmN1ugfiUIVcDwn
	mV1IfflBrnGeQTVVMASWKIt5fyTqXqqcjNi0y8gBEKXA5GZngh4TYiGGRp/0HKvewn9Yix
	HfyMc5UbfcIrO/lAVx2mp7SAVz/CLug=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775094620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rWHn8ZLLaNhlcOKvyDiXP9A00oZt/Dbtw9Zn8GCrdY=;
	b=VMHqiqmZPLGRJOPaOAMev85GvtEfvzNCEltxnNPILZrDs5VeD9R3JiYDZ3tP/CnBU1WaZY
	0eAf7lQX+6CuB3LeCIMN+mw9t1J1eJyxaXnGr24Kotv4a/UhmGZd35gq8flYk8YD5Zt5ky
	KBKKcImOuLSaL2o2QDZO6dKGLUC+VG0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-5uMSud7rOQSzijfhIexbmw-1; Wed, 01 Apr 2026 21:50:18 -0400
X-MC-Unique: 5uMSud7rOQSzijfhIexbmw-1
X-Mimecast-MFC-AGG-ID: 5uMSud7rOQSzijfhIexbmw_1775094617
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3595485abbbso299090a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 18:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094617; x=1775699417;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rWHn8ZLLaNhlcOKvyDiXP9A00oZt/Dbtw9Zn8GCrdY=;
        b=ruxODRF6F0n7WWAOFQSZtYSFLA/4FD2o6QhcHodxr7KtzecetE8x4TW+0t32OBKsUf
         fKYxXFcqWrWLlvQOyR5dj1/13qNNJmZnvvm4e+DoDk7Ry0tDvmBTcBVS2znpCtS93+Gd
         QnjGkeceKLvn6Z7KKhEvdBX9iCvBBGPMogSC1ittf1FQBtv0adPZGLIgDgfSncLmeY7q
         C1rADrAaCA28HvOXORWNGu6TwvGx+5fEPmO47sWLU3NUJ8QE8n61GZNd3WpKUVjQPSSd
         zkV8MHXJsLOv5JVHq8OdG9J7nKkUFyJMbW1wm3XGm0Ex7h3nxfL8Q2MARgpgLh10fCbg
         cWwA==
X-Forwarded-Encrypted: i=1; AJvYcCXRvbnuZfwaM7quKC37vE0et5FD4ZqcM7rV5lHaHHNOAr8lqF/YUC+svIHJ+KECYLC/KTkXIAR6Q6DvhBk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZaUWKrJvxaqmC6uE4W87q1HJ8OMMEAQTkkd/rzEDpXbDmXXEC
	rALDL+kwfT0kanK4QLgjkSJBT+v3njT7yvYrYNkpKSuG0CcfWhRir8IaadhdnvXVLPcq3jsD3SS
	q/2Tc2tvLdpi3+QEonbpbumcjp9ZoJnMlJXtaKF/0AHpfnONh6coceqKyWuqrj9zC/es=
X-Gm-Gg: ATEYQzwqysg8feecz8/wsJ9rE51AuzrhSxjn1JOmFIRrRs0Sd8pBdAlL+ncF32nOixi
	tUHNCOQXPljuxvMik0MCfu1OtwEBS11WFyU8IiF2tGuAvZb3Fyd0f9eUhkqWQBRfroYulIlJs3J
	stzWSBVPf4uu9mIZI05r8S5n3nqcUWKGZRaNnFrVAlJwQzuP91jboizoJl7isEcj90Bq69v1UkS
	Rm0Q1fRpLhca8bk6tjC2U2UegN35Y3jTwBD0/IfjmvcnORdbX58Tdi35bKqnqha1fJTH5S67InG
	+czhX9pOb1S8pX1g4y+e3onYUe+DAtpwJKthdPjp8ZCwIiSmBFVh72kUngyujMuRcKhirWGQotO
	wpIEmuiWKVA==
X-Received: by 2002:a17:90a:d406:b0:35d:a843:6b1f with SMTP id 98e67ed59e1d1-35dc6e5f016mr5377528a91.11.1775094616920;
        Wed, 01 Apr 2026 18:50:16 -0700 (PDT)
X-Received: by 2002:a17:90a:d406:b0:35d:a843:6b1f with SMTP id 98e67ed59e1d1-35dc6e5f016mr5377491a91.11.1775094616366;
        Wed, 01 Apr 2026 18:50:16 -0700 (PDT)
Received: from localhost ([49.65.225.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe95abc3sm6806610a91.15.2026.04.01.18.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:50:15 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:44:21 +0800
From: Coiby Xu <coxu@redhat.com>
To: Rob Herring <robh@kernel.org>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Saravana Kannan <saravanak@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <ac3Hac2RmY2Jahxt@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-4-coxu@redhat.com>
 <CAL_Jsq+0w2hGN=Loy=ucHbZcdnn+ty3x9qS4WVX0Vj+g19tfpg@mail.gmail.com>
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
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+0w2hGN=Loy=ucHbZcdnn+ty3x9qS4WVX0Vj+g19tfpg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XUqfSQX0B8mTlNXppzzgqtqeSahzyjqmvKBmGYNXqAY_1775094617
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Mar 30, 2026 at 06:44:15AM -0500, Rob Herring wrote:
>On Wed, Feb 25, 2026 at 12:04 AM Coiby Xu <coxu@redhat.com> wrote:
>>
>> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
>> device dump target by addressing two challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>> To also enable this feature for ARM64 and PowerPC, the missing piece is
>> to let the kdump kernel know where to find the dm-crypt keys which are
>> randomly stored in memory reserved for kdump. Introduce a new device
>> tree property dmcryptkeys [2] as similar to elfcorehdr to pass the
>> memory address of the stored info of dm-crypt keys to the kdump kernel.
>> Since this property is only needed by the kdump kernel, it won't be
>> exposed to user space.
>>
>> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>> [2] https://github.com/devicetree-org/dt-schema/pull/181
>>
>> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Kairui Song <ryncsn@gmail.com>
>> Cc: Pingfan Liu <kernelfans@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Thomas Staudt <tstaudt@de.ibm.com>
>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/arm64/kernel/machine_kexec_file.c |  4 ++++
>>  arch/powerpc/kexec/elf_64.c            |  4 ++++
>>  drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>>  drivers/of/kexec.c                     | 19 +++++++++++++++++++
>>  4 files changed, 48 insertions(+)
>
>Acked-by: Rob Herring (Arm) <robh@kernel.org>

Hi Rob,

Thanks for acknowledging this device tree patch and also merging the
dt-schema PR!

-- 
Best regards,
Coiby


