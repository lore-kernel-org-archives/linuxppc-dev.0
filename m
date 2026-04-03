Return-Path: <linuxppc-dev+bounces-19267-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4582CE7E358
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 09:45:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnDNg6zyDz2yVP;
	Fri, 03 Apr 2026 20:45:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775209523;
	cv=none; b=XiM478F/7+jlhLRFBAh5m4q130/lUaWfw3ftqYzz/FO+NwOF8AeUNBUnaHSoZWJStMQ4CQpPGKTCSvD+zo9KZFec0ldEuCAPzs6auCw3yauDTzb7G8dlyKGJpq3NHRlpm07p0GEFd8MqlcYFA+l5tDwuw/h5UImxRNcXY8HcC+G8kmPwyEfzbO+fSzFyg7gNqNjj6qJw43bWh56sV3vyJU3YRxN4YgPqfic6yFukVis6GMRin+1YhNiFuFlQosgkEHBxPoqnfD3/tNdQsBXRbZVz/AemaPRvoJxiZAoWQe8+0SHaPW5ez0A+74e5ZyG262QxYGMwrcmFdi+kjphzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775209523; c=relaxed/relaxed;
	bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eYBiVNZhvD6dpeFsXQVKR8FBCWZIlT0509yR47qoYvV5RmJEpG+hZ2n9PqkMKa7MLU8Y2INKoTGuBMG8zo/itbuGIll/h0bAGQq0JeYusqKsiHYiOKil4hAzWrSjb5Ptg4KVuXEpL6j6zSnm4gzQKhsuBt6xO5zU9PysIEglUKsjGuwsIvURHrqa1xTIgcXX+A8xmukCGhy1gduKJnlfgaiZXKyP8gXAGa7xqB+8TfEM9Xu6Ujv6l2Z6qMerpRYaA3kvgGaH9Y0rBD+FLxe5YCXVO8ypT0/mMLtQOk6355ySlyo729mcYzv//LAXRMIHpA/vqOKcX1jztnt0TFKsPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L26UcBJa; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L26UcBJa; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L26UcBJa;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L26UcBJa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnDNf6y0Kz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 20:45:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775209519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=;
	b=L26UcBJahTYdEPvtdGgDj+Nenz/AX9z6icHuHq18kVUqBfNJrtYr2XHbE6j03MR7lm9aGt
	Ld7FHAYG2HgbL5piDa8kDBXAmv3a7/C/KlEI6HEYHGyhPOthBQ8b4DQ9n35BJ8MjXpePFT
	l+9/kxODymFX8uIg+Nl7K1F7AoMM17U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775209519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=;
	b=L26UcBJahTYdEPvtdGgDj+Nenz/AX9z6icHuHq18kVUqBfNJrtYr2XHbE6j03MR7lm9aGt
	Ld7FHAYG2HgbL5piDa8kDBXAmv3a7/C/KlEI6HEYHGyhPOthBQ8b4DQ9n35BJ8MjXpePFT
	l+9/kxODymFX8uIg+Nl7K1F7AoMM17U=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-bEQM5u-mMByuCEDyCwmBWA-1; Fri, 03 Apr 2026 05:45:18 -0400
X-MC-Unique: bEQM5u-mMByuCEDyCwmBWA-1
X-Mimecast-MFC-AGG-ID: bEQM5u-mMByuCEDyCwmBWA_1775209517
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70dd30025fso2812046a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775209517; x=1775814317;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH9+LliZTB5HpO6CFpEOH4jpCgMrdVel5twiQSolHR0=;
        b=p+CdMoa8NyG1dvzI/Qregv11AiK7/ooXWpQyGQxFem990yoU1Wzbg4EXUogmAW7i+F
         isQ8BGBXg9ZYS/rNUjsRYh4w7gQrB+DGnJdI6aWRkIPLx8G8vL1IWXJtLdIZHGu27Ejj
         W7EL0AIjh3JanMO6/u+upDkfxpOR4McaURjfjkLEMeYHurA53O+jLMgbEQ+EJR2aABDR
         mDko/qndNwJTAyV+fRCA6cKxRKRRU0bUAyvIve06U9X5oKyySflO7cgAIV05hmdlNzwa
         kfLhTcEQfxsZMIHMukQwMQKDvdDxLKslHtNGvfEJutSjzTrvHy/zrLaP2SPxEKZTGTmo
         8pog==
X-Forwarded-Encrypted: i=1; AJvYcCXhlfgJZKyabh4u1JqCfYWXoM2glmRu6usyYHP44NT9rqH5D0gcQEU8PddnJ3+fQGiezi83ngeolikzKdY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBhoAwNEvRjScGFxEtF/zmfeFMZJvtIoew2uatz6M9thCGdpuJ
	rlRKaETN1alFYpbX1AUJBAqMcAEH5NnG+YtZNCm67/FajtTwaTcsT4/lyCgXAPC973y9mbE2+gD
	PR1QJCjZNzvJiRClKApAsBIfwux9e2TI53snzqi4cuo5JFKFgr1pm2kgPo66yxlTfAC4=
X-Gm-Gg: AeBDieuxZiYMb3uVzt0/MyBShWHgAZ1foBpESxSAXsEfoTNKdEbI3S7KHrgDdhVtYuu
	udwNQVK7oNHyFtuj+7rLhRgFvVc4kc9WnMgamX/w9jKI8RgRSe+stxqsswTtM1but//sMKvBYHU
	JCpUn7C6RpJW+9737YeLLPI1eFyCrWlsuMiJASUK9nBSPB5XKubbFYFwzZYFOJLuJeQYGUJl67c
	gn8JWBi/+4Qz+73ttjtCpktr39ssDMWqVbq7p5eryBCoEXLg2NdxXDpTp06lYlOGqShiYga7+bt
	6DW2hIZ4oleYrmJ+Q4N1aqQ2i9PlnMOJ8tcNm+fXNSeSnp9M3SWhcORypTNwcN1wnnJRncfLQKA
	M0UQ9b9OPGcgx
X-Received: by 2002:a05:6a00:3027:b0:81f:52d4:a5ec with SMTP id d2e1a72fcca58-82d0dba9c6fmr2625452b3a.43.1775209516628;
        Fri, 03 Apr 2026 02:45:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3027:b0:81f:52d4:a5ec with SMTP id d2e1a72fcca58-82d0dba9c6fmr2625387b3a.43.1775209515832;
        Fri, 03 Apr 2026 02:45:15 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbf6sm5915263b3a.52.2026.04.03.02.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 02:45:15 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:40:52 +0800
From: Coiby Xu <coxu@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Staudt <tstaudt@de.ibm.com>, Will Deacon <will@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Saravana Kannan <saravanak@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-ID: <ac-KKklNrB5eQFvG@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-4-coxu@redhat.com>
 <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
 <20260402233118.08ea88a6836bd10f01031cce@linux-foundation.org>
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
In-Reply-To: <20260402233118.08ea88a6836bd10f01031cce@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yOAwEd4u0LEsewWL3WLksu_aKeM-XfSn_0DVtBoOAM8_1775209517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 02, 2026 at 11:31:18PM -0700, Andrew Morton wrote:
>On Thu, 2 Apr 2026 16:24:14 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>
>> But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
>> double free at the address pointed by `keys_header`:
>>
>> In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
>>      snip...
>>
>>      kbuf.buffer = keys_header;
>>
>>      snip....
>>
>>      r = kexec_add_buffer(&kbuf);
>>      if (r) {
>>          pr_err("Failed to call kexec_add_buffer, ret=%d\n", r);
>>          kvfree((void *)kbuf.buffer);                           <---
>> First Free
>>          return r;
>>      }
>>
>> Since `keys_header` is not reset, the next call to build_keys_header()
>> will cause a double free at `keys_header`.
>>
>> static int build_keys_header(void)
>> {
>>
>>      snip...
>>
>>      if (keys_header != NULL)
>>          kvfree(keys_header);
>>
>>      snip...
>> }
>>
>> What do you think?
>
>It looks that way to me.

Thanks for confirming it! I'll send a patch after finishing the testing.

-- 
Best regards,
Coiby


