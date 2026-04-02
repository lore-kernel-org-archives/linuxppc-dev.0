Return-Path: <linuxppc-dev+bounces-19183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4D9111224F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 01:50:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmPvB2yLWz2yfl;
	Thu, 02 Apr 2026 12:50:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775094630;
	cv=none; b=dmPL3BLhJ+GHEmVwhTUhZi9HCYmeFpZK4UZwCxz0bhn8JkwLI9Xel85ZlutwUN0l6ONlraNf2+8m2RjqaCUJqeXhnQQ2NiF9QmkKMIdDiH1a9COaBtESsMjGDUhMxNg5Ywui5CympHkFnhJ3kDnnH12vPkVf1MsFD8f/ugukn/2CF6uUZey2jlnZK6rA+LwUosV06+kRY91zx3gixxakdekLt1mvLq2qXdoTjNWhFdd8CKFGxpcG12ZhgOWxYtvVE0cULLaSVY6fGnVisd4T2X3xkCM2US3/YHRqmRSXyQBM7h1AIgrfCwheGSyU7PA1TSH4IbLUl1lzAQdZjK5saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775094630; c=relaxed/relaxed;
	bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M18HqDNyuVAh3iIHCokG9R5+ENrDO4ykNDndx3c/SD+kquJ97GaDG5pdx3/gWkTWlRi72fKm4T0tsk/it5bMJlgqlrQYFjDHHGhGc3i0ZBd5+vhpKfMuN3sAo7m9pe+vMT5XYk908ElLeMqZIZNvdNJLpk7UOvz8zFgAcGbhBjdtFM0uB3zIG5B2J7dWjZYZ9OU8TXud1uIYR3eQvR8SckvlncSc9vDKWKI92HfGhXc4tLAdFADG+ZGLWCt8Jp+IdzHW0IWL3ncMlGJX0kLCb7mF/SuYCMWWdIzOBrL1a0iEAuPVtlUMj37Yo/1nAKa2IELaqKWnJaAeiatXNRX2Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SmDFjP0r; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SmDFjP0r; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SmDFjP0r;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SmDFjP0r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=coxu@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmPv92hCCz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 12:50:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775094625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=;
	b=SmDFjP0rVsSDuPF+F3/9huaZWU13Y5ISrQL2Y+sZ3TLIfCAoJtxrGkCce3a/Io6vMChf0q
	j/QXwUhZwxHFuHUNEwdzG4+hG8tFz0ZClHy9r4Nwe6/M0fKfZ8r3umzVz7rOnf6+2/vBgq
	cqVJClS7oJDFd6YoQ/5c4VgP4Dli4j8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775094625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=;
	b=SmDFjP0rVsSDuPF+F3/9huaZWU13Y5ISrQL2Y+sZ3TLIfCAoJtxrGkCce3a/Io6vMChf0q
	j/QXwUhZwxHFuHUNEwdzG4+hG8tFz0ZClHy9r4Nwe6/M0fKfZ8r3umzVz7rOnf6+2/vBgq
	cqVJClS7oJDFd6YoQ/5c4VgP4Dli4j8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9s87MQQBOQO3bysFbRgIdQ-1; Wed, 01 Apr 2026 21:50:21 -0400
X-MC-Unique: 9s87MQQBOQO3bysFbRgIdQ-1
X-Mimecast-MFC-AGG-ID: 9s87MQQBOQO3bysFbRgIdQ_1775094620
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0b57e192bso2346935ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 18:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094620; x=1775699420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=;
        b=Yg423Hp3fGR7zOm4Fci3buh/C1Ux3sVx+tJiQVO1zu2m6ms5HD2eMAUCZTXyhcsgjC
         hVVsedgZRvmjXCknCYlyw5zZegW/ksLLfwgVThPhCBMrnTA5XNtNdb6nA18SuzRUH0h6
         kmk6SFwWc/Bz2aFrHDdJnEM7KSQW6581oVIPjBByROQzVqsSJIx0eAOgBbl+Ix0zhgvp
         /PiVmkLfjKyHzi0k+FMX7hs9bEnjZej8K59x1IhB0MC2x15TIopYhaJvXVm8C5IJMUjn
         LjLKHvCysIe8ETscXzCMXUU/Ytn2b9SEXoVCiKPy5VeOoqOh9YKHsmQBtPJecVON5r1z
         JDMg==
X-Forwarded-Encrypted: i=1; AJvYcCVmo/x911tKOI0so7VOeaZaU504UGOl/C3MhFM/Wx4o/cE4SMZAjtiIeQmW6fUdrFZg9J8QXhvc1wFyLck=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxOEnYGSzag5C7/VzaeNDr7a9BuROc4AFdfRFH1q4VGwxQvaTYy
	BqdwO6rY3zbbDb7Zy7rAzDT7sSX3iLTSITwPsWwU8ZED8hvTFfwYA7xkH1gORI6vfmjidaOcACN
	4ANXp8HOCVzBwGTK93225MPQsm8/nZoqpP6Zw8G08koU2mz/6aEAgiBGCg5DjT7oDw3U=
X-Gm-Gg: ATEYQzy9w8y2yfAMQZ1vpu4aggwVGct6vsJ/3lZJn5mSYuaKEZ1DLM2lNqqfWbkUeiH
	0zIGrlPpa9gmJCvU7nBz6kBjYTR/QA312B1eAuP7VCGZULfNRAqSKwGCMPyC4FQxkfXE468neyQ
	G2poV2NpBj23y9kN479E7RO58R+bd+TdLHPUgf74MVLhSwiwkwWaLehrYvF0HD05GdPWmG//ZxL
	FN95a0A7M/a2zVuYq2qlOmkdSnCuujVyktZ07ptt0hrD/AA7U6gM5mEC0NmTk623oqnPOxyltCV
	TCspWkdYo9lA3XbylqYj77yRoKwpit6nhymJuTDbyZk8lK7I0WIGRJiZBASYDpChxWGD4p0hHiZ
	Rwcsi+LWHrQ==
X-Received: by 2002:a17:903:2282:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b269caa786mr54155395ad.39.1775094620326;
        Wed, 01 Apr 2026 18:50:20 -0700 (PDT)
X-Received: by 2002:a17:903:2282:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b269caa786mr54155025ad.39.1775094619683;
        Wed, 01 Apr 2026 18:50:19 -0700 (PDT)
Received: from localhost ([49.65.225.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd9fsm9680585ad.75.2026.04.01.18.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:50:19 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:46:37 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] crash_dump/dm-crypt: Don't print in arch-specific
 code
Message-ID: <ac3J_pWwyUNOy034@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-2-coxu@redhat.com>
 <actzxO1p6OlmK2gp@fedora>
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
In-Reply-To: <actzxO1p6OlmK2gp@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xP_t3eDC7GNZig9IYDioV38qck5IJKtwn4EWqNkTXDo_1775094620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Mar 31, 2026 at 03:12:04PM +0800, Baoquan He wrote:
>On 02/25/26 at 02:03pm, Coiby Xu wrote:
>> When the vmcore dumping target is not a LUKS-encrypted target, it's
>> expected that there is no dm-crypt key thus no need to return -ENOENT.
>> Also print more logs in crash_load_dm_crypt_keys. The benefit is
>> arch-specific code can be more succinct.
>>
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 6 +-----
>>  kernel/crash_dump_dm_crypt.c      | 7 +++++--
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>
>Acked-by: Baoquan He <bhe@redhat.com>

Thank Baoquan for ack'ing the kexec/kdump part of this patch set!

-- 
Best regards,
Coiby


