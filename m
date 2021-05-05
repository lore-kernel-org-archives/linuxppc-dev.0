Return-Path: <SRS0=ixLW=KA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46D7C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 22:29:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB41D613B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 22:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB41D613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FbBGd2js6z3bPL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 May 2021 08:29:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20161025 header.b=dP4d1XGC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::102a;
 helo=mail-pj1-x102a.google.com; envelope-from=seanjc@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=dP4d1XGC; dkim-atps=neutral
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fb1S274hxz2yxl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 May 2021 01:52:16 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id
 t2-20020a17090a0242b0290155433387beso1040839pje.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 May 2021 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fWu6RproSO3vhb8FFKdjOsNB26PtX2CgGoLpKJMkcZw=;
 b=dP4d1XGCVm58MZKh9tsvJLb4Si+Kcg4C0fRJSYNgI2AKkoDfsxnrTnesNUgLsPZAkn
 1XASzlm4f+ZoY70g7IizU8IwaIVMNMYgmjgEmMDHOhR1JdUml+F78Ev5iOIfVp/rTycF
 QTQX4a1jEg2olMfZ4M/CzhoW0fPaDCjhNbLLvfZg/gSQuHlnrxUNjUS+14Rtapq3Y7Y9
 IvTY6B8QWNbqkTugNkDTxqiVmqIU70IIZAUzuCiAX+jp51pL8aGQ5SgulkKLB2ayCtwQ
 kAILENZEsLLaAW80Cds2aMk4DHtH1VuLuvanm2/EfpAW8AN8uLvPAsWs2/xsCLIy0PgE
 Lg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fWu6RproSO3vhb8FFKdjOsNB26PtX2CgGoLpKJMkcZw=;
 b=uKx6Eg8cDWCTyZb+vuvAvUqzqXHDuW4OPYQ5MmmJiUHi5i+RiqEBkGDRDAF7srxNzM
 BhYUKc+Yg1FAzvzb7DBDXDSw0+0Ew5cE4cbcttt4GrfPCLPJPkRF/B0k4sZYimVl4df0
 587AtSr8DUvogQ73EzCm1TYOB0RrLJY02NI949Zp4hcUpZZ9Mk1gSe/ZlHmzjjQHJU+D
 R2xARLanbpJxcNpxWI31COlJ486+W7kt8ceFQ50gQRAg0tWGgRQDjcn/IMfYMXyq+v3F
 NW6eJPUx/22DhOeIgoeRybtProvuuqPWjbzAIXuMpzwoKQ25h0DXBsBeIPZN/iAVHon5
 ZI9w==
X-Gm-Message-State: AOAM531FAOoXs1Lrl+UKdm5nI2FOhuce5dVqNpn6luGMpJ+sGwNpsKVZ
 rPJHFkCVJTIpjNjmu28w5hyGzg==
X-Google-Smtp-Source: ABdhPJwM38lKwE/g3ivwr6B32LLXTSqABMeye1jvL0UfKxvx1FlpoVNpsfmJhOTmB1Grke5kcamWNg==
X-Received: by 2002:a17:90a:f2cf:: with SMTP id
 gt15mr12025100pjb.64.1620229932814; 
 Wed, 05 May 2021 08:52:12 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com.
 [35.247.111.240])
 by smtp.gmail.com with ESMTPSA id r32sm6730235pgm.49.2021.05.05.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 May 2021 08:52:12 -0700 (PDT)
Date: Wed, 5 May 2021 15:52:08 +0000
From: Sean Christopherson <seanjc@google.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix conversion to gfn-based MMU
 notifier callbacks
Message-ID: <YJK/KDCV5CvTNhoo@google.com>
References: <20210505121509.1470207-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505121509.1470207-1-npiggin@gmail.com>
X-Mailman-Approved-At: Thu, 06 May 2021 08:29:19 +1000
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
Cc: kvm@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 05, 2021, Nicholas Piggin wrote:
> Commit b1c5356e873c ("KVM: PPC: Convert to the gfn-based MMU notifier
> callbacks") causes unmap_gfn_range and age_gfn callbacks to only work
> on the first gfn in the range. It also makes the aging callbacks call
> into both radix and hash aging functions for radix guests. Fix this.

Ugh, the rest of kvm_handle_hva_range() was so similar to the x86 code that I
glossed right over the for-loop.  My apologies :-/

> Add warnings for the single-gfn calls that have been converted to range
> callbacks, in case they ever receieve ranges greater than 1.
> 
> Fixes: b1c5356e873c ("KVM: PPC: Convert to the gfn-based MMU notifier callbacks")
> Reported-by: Bharata B Rao <bharata@linux.ibm.com>
> Tested-by: Bharata B Rao <bharata@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> The e500 change in that commit also looks suspicious, why is it okay
> to remove kvm_flush_remote_tlbs() there? Also is the the change from
> returning false to true intended?

The common code interprets a return of "true" as "do kvm_flush_remote_tlbs()".
There is technically a functional change, as the deferring the flush to common
code will batch flushes if the invalidation spans multiple memslots.  But the
mmu_lock is held the entire time, so batching is a good thing unless e500 has
wildly different MMU semantics.
