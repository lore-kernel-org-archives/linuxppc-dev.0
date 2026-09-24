Return-Path: <linuxppc-dev+bounces-28123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E90C98324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:38:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrKJn1SJGz2y7Y;
	Fri, 25 Sep 2026 02:38:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790267897;
	cv=none; b=brW+OpdeChG5nyfnhP97lNVLFtDG7h7Z2813JRhvrHKkFOLKPL/lBocFdFSSauhzbvmaT1UYasdIeOsH8i8ssGsMs1S0HgBSFHvhx0fHmIogZk8Bnd1j6QFu9pBsonNrTctkf8oAcqire+uIKtQwj+wUek8aaneDDNpwanCdcGfGxif5VHwp/J7lA9uunKVenIWPp6XtrGFmYcllFfUAgFc3G9fktdCMh328inytEkg1o4ER5XzoFhZNtbtQ3+oWkvpk/j44vLieJtc4zcRjzpJ9FVB2aKnmvx3zJIC6hA7w4iDcYfckyV9eJ+k3pJaYjhN9eeU/aZtE3hJ+YfBfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790267897; c=relaxed/relaxed;
	bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyZI1zVFVoiziKSllD5xHoe/p1yRw60An7mfRHr3UVPYspEDvB6A8RUUgn/22C39hdhuhsZZ0XZNNGusN6gyVaGZWbWki02j66LIgedYF0sSLEUidPDIMHgLStKDWy2CcxYTs93tNLHhrT0YNqhh0Tdq1KAzkuk7J/jLViqeZKJ+ENiNMp8HF4ctx6VeqPm0vL3GMQVEP5sMIMgftmYNBRSrq9DJfZc+EcsIf2iZA+JOXZFujKpuqh7WV7NNNOsAe08cJ5h7e0MEqbfEZXwpGoE5cy3dqDM64z+0+XkaF3mTM5ObGIcp9AMpqnrD8g4o2x6Wd8cWavGCprZlBQGcAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NfuFeAv6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::d; helo=mail-qk2-x0d.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=NfuFeAv6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:34::d; helo=mail-qk2-x0d.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qk2-x0d.google.com (mail-qk2-x0d.google.com [IPv6:2607:f8b0:4864:34::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrKJl3X0Wz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 02:38:14 +1000 (AEST)
Received: by mail-qk2-x0d.google.com with SMTP id d75a77b69052e-532e91a3687so105051cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267891; x=1790872691; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=NfuFeAv6uaEY1ccABhmjbxOJPs5mJoeeUk5xpaOGEmIvQeWGE42ncSY8MXrKoRk6la
         lWJZptIOhlC0IApYr0e/0Pv6mVplVqB1OzjfzZWRE6fhvZ7XNdnGryNk0O7LnaRnZByC
         egIZvY7bky2WJfEb9fcffJLc8jRUIT5W7ueVt2gkvNt7+ZEFGD68cqJgnmunKYLASppa
         srih7r8X3SINbpW2VhJlHZsjpCfzZyU2008HjqgdrzkUibU5cKzVNYyWHBKNgIC8getB
         IWh6EhsiMV88IzUzWMSspDByZb+ZmBzqp6XV92cuUUKF/llAQ8GbszqI8S+OG+rFhlZG
         Azkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267891; x=1790872691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=u6Wn9l39wt5C+W4ZAzV88Z0PqIFpAvvXpiMdtDmBpENam7zUkFwh6FlnsTxkAkT/lH
         UnoQeae2i5/pADaI7mwNuKLgFdawnxb/VfHSVdl3qgn4wKqEw9J0bxWGclcQOyIL4Ck8
         TQiRKWvyjVsRu9nRf5CjOaAvJQ/EA+yaXlcTxVlR32aX3988mr90kiGOMGVZy/y/sodn
         pl1Hu/Tv+9oS2zBi05wATlgkgMGYifsl0/sinOAIAPpB1yTJOvdeVIwizEwg5qs+Srcx
         JUY6PL9cxVRYOESsJwFAiLtW5uX39iko5SHttsQw5XOJgoErMUPJAlFpsGcqhHNVP5Rp
         HkUg==
X-Forwarded-Encrypted: i=1; AKwUvBy/E0FNz34YqbfU7KThYUvfqPAWikpWg1S4CtSKaLX7q+HB2svsH5FVFIeECaqlaT9nZMzKEk/TJRedXVU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kz14p4uxzWB847BoHgST1aELxQPk8XbSqf0A63ZmjL/TKo4WAE
	zF37NPQcpMtdRvmeSJOefw1rri7BO7lD5aFqPdiHbKwcf8818mcNy3P/vYKOQIijm7w=
X-Gm-Gg: AYBFou0uZtB99cZQ6klbFTXJ0+2ScrfYdRKDX/0pA5SzwZJT1XJUZ8pPfRx0MEwrrsl
	66GveQVucXyvrRWfwYWZwJc/TxYsu+0mRNs0F5GMKUa5nKuRRyT8XdczjUI5Firk08hr/btXrlO
	5DySchoViNRN1iKKfohqgE3gOUxY4uYfDufeI6RHYYLY40RhSUSZKKn7N5DQoMMlQshoOfnlime
	s4ScW9PfZxvzifd99rVFjWg1ATQJiEVvszoKhCaNPHt0H2I/cd9yaYEzp14Hwj35SN5yT17qHG1
	Dghg9dIhUTGSuR81oP0k+Hvl7lSiVP/xILXLHkQctdGT8OccE0nBPLoMkww4kWVqH9tkAu3SrDk
	G0jTiplYlSbMEKYqGP02rj00WD95XnSDRmO4mMvnzMgFFDcY5KqFEWBZ0EGfguIzL/9F5HqXuUx
	mSbYfZGiE2zBtzmaylKEa3Ht71qQrsdeFyMmJxffYOVlVFzHxXHT58s7GO4p2VVMOCd2o5rF0DP
	4vCmi1smN2OS/UHwysHZZKaZl9Mnj89wYOfi+jMdtGpnWxNpml4WZY=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993;
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use
 vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>


