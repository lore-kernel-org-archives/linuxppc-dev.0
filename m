Return-Path: <linuxppc-dev+bounces-23830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1BBC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:34:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwMZd15s6z2xpn;
	Thu, 09 Jul 2026 01:34:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783524841;
	cv=none; b=htv634stMJFBhjtPh4af5yYMX9xBgpUuL2QLxJWtxhwNPKJqiQssSyzECDsyN+EBXuyH36pGMJVDTVVCrjRYVfB7Wh+cmVfJCSyzj3wvTj2SgfWCNODE7V7DHjNJUm23OYY2YOlMS1q76j7ZPMdYvP/vtMsvZNMnilWZUkTQzKgpk6A0UlN0ZkJoXhQ05HSuVsPmKwUepo9YG7l2UmjkYLeQIegLnB5NheUyGO3Z2wuQQc4Fi/LiLiS1ry5JM+4Mc1n2Q1I34bLnc2/OoI7HEySuLVx7m1wVeh8ZnptNcoqDmoWSl0O/IMZFDFOrQHjy04/vt31ws6V//EP+vrO4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783524841; c=relaxed/relaxed;
	bh=XDL9stQ6rVAcSA7/i4i+07LdgRqlKw4+pd+ABKQXEmc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NPlNOZBlyp3buq4kt25jkfITXCMgo7v12A6FwpHu4e+IrYsjvlSv/luev1ITSKcMBALKgwKJXaRG6ZoSAPLcTnShpHIre587Bflk3ujbI90PxjyIDX7oJw3dqDxFLtcty1N7NKv3VsrqKr3lDTGrngjFOPki7ush+J3unW+Ksqd/olsjMX13uV8A5GJM6Hm8NXZ9z6pgzXnKOQPuOoDFOHGABWiK3ZjbcegoVTE0CGoOW+1ESiW7LTKVPme8y/MIOhXe6YgqSWHF4eaFAN2wo+Mpo3xAfd0wLVyY/+wJ+F3x59JHnzLbjm2OOfM1KR+bzio0pCkbegRQ7BtLu6/QRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mpd0XPNx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mpd0XPNx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwMZc0SH8z2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 01:33:59 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-381018b9375so927899a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524837; x=1784129637; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XDL9stQ6rVAcSA7/i4i+07LdgRqlKw4+pd+ABKQXEmc=;
        b=Mpd0XPNxqrhnCP1tYekUBzHYLnvNvSlKic/Q93vgRr3ZFUv2BKfVuw0ZgYIpcesyRf
         i8aUJ3hMys5CSjJSbeQP/Y0uRZiK75RSZm+94If6syzjDMOsVbC9uCeueW3kpPJBADif
         4zz3uO8zYlSwg2Paq1cQxltIzp28EiItdwqD820XTTh0yJ3eblyIcSnXir/eR49jttkQ
         gknWUJgphkzWUDuVYUEmcyIydFNwZ8ac1FvzOtHzLb8Fi2d/TY2AWYHNQJJtmhda7T1e
         f01RNqFKszA2Nkrq7PA6zV5zwR/Q5iOTAcr/cwZ4VY3ZQbup6JtBhiHU+ZlSob89VVfX
         Chkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524837; x=1784129637;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDL9stQ6rVAcSA7/i4i+07LdgRqlKw4+pd+ABKQXEmc=;
        b=DrqIFMlsF7GlDNZEdpTSpgeXdKuDu95IEyOTqPh70TgRQ/ebAEkgvZnXSO2supQU+y
         fjnXNLrX1Yytazc3a1GVHYmMHwJwJHwSLAKIptPm/w5DJ5XtnialTw6pD7YybrNl1UqL
         p2qI6AKnkXB7cO/rhes0lDLZO9B1kG4VVyzhW5aDvC563aHNs1uxC54wm5QLiCwq1KXq
         fEsaaZxr0h6KCuFNd+F4gwrZUoym1ndArSJzZHburhazOiomKTX8h46FAOFXj4g8NHXe
         w06SEGMiDn9BVQsY7BwOcAJpthh9hitLtK8BPY9KCnMrBg3qwS1qNFiVS6pkam5ck3m3
         21cg==
X-Forwarded-Encrypted: i=1; AHgh+Rra3yfB731GDnyN3Ou9ZqGY4g31M96MGYVjcRvTNoUbDTqZ3iMZ5Bdr08QiHfvuASEkaf9kiG0gg7xliaI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzut8Ms0QdnADNz9RkfEZRloNGMK+N06e09GdVhlEXZx+mUd2oz
	vM1nEIXnq8I5QcWk90s01j1neuoAVpkkeVdaA4RhNdX72k53eCDFIeKb
X-Gm-Gg: AfdE7ck5pvyTh+zv6PQNRf5GUHPGmUXFwh9ABPNXxvDL/PMueRjmWXh+KE43MGdH+3z
	o4it2qaI48iLfaAIlTxa0nFu+2MBoIyoucSz87xqw+AXi9mLx3ToKjW9Cb9G7HSDaNFD2s4V6bD
	VG12jxirSemticDpimw8oc1mCgj91gk7li+4U4dZVFZT0/OCGeTntMr1XkLGi90duAtga+1TeF6
	V6ShOV3AmSM7ujOSwUo0LXhIK23TxrknUCm23v2M3fAE8/xVTOlBKlnbxCzYJjHGuOkkiJPU6iU
	Tfy6ngK/CnyC92PfhRf0Vr6ePdZTmAeyh04hxEFqETLljpbKV/JECIFR+TVMSDtj7HDzkBs7liE
	kcQnAXhly8EZrX6xdZYr9FeauuAObIKtaUECsm2EENeTq7swjoZhMUM5cGT0VqrKZKCO9PCCyWn
	eoznZXzF5B2Oo=
X-Received: by 2002:a05:6a20:158e:b0:3bf:ee42:195 with SMTP id adf61e73a8af0-3c0bc90146amr3718965637.11.1783524837094;
        Wed, 08 Jul 2026 08:33:57 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm20950984eec.22.2026.07.08.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:33:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, sbhat@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/eeh: Fix recursive locking on devices without EEH sensitive driver
In-Reply-To: <177725885065.13410.12259326756082237538.stgit@linux.ibm.com>
Date: Wed, 08 Jul 2026 20:36:55 +0530
Message-ID: <h5m9wmeo.ritesh.list@gmail.com>
References: <177725885065.13410.12259326756082237538.stgit@linux.ibm.com>
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

Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:

hey, sorry looks like this fall through the cracks.

> The commit 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug
> safe") refactored the EEH code such that the pci_rescan_remove_lock is
> held at the beginning of eeh_handle_normal_event() and the
> eeh_reset_device() is called with that lock being held. Looks like the
> commit missed to remove the existing lock/unlock inside eeh_rmv_device()
> which is no longer necessary. This is causing the eehd to hang on the
> lock which it actually holds when that code path is taken.
>
> [<0>] 0xc00000011c78f870
> [<0>] __switch_to+0xfc/0x1a0
> [<0>] pci_lock_rescan_remove+0x30/0x44
> [<0>] eeh_rmv_device+0x290/0x2e0
> [<0>] eeh_pe_dev_traverse+0x80/0x130
> [<0>] eeh_reset_device+0xcc/0x23c
> [<0>] eeh_handle_normal_event+0x830/0xa80
> [<0>] eeh_event_handler+0xf8/0x190
> [<0>] kthread+0x194/0x1b0
> [<0>] start_kernel_thread+0x14/0x18
>

yup. I see eeh_handle_normal_event(), already holds this lock,
pci_lock_rescan_remove().

And eeh_rmv_device() only ever gets called from

eeh_handle_normal_event()
  eeh_reset_device()
    eeh_pe_dev_traverse(pe, eeh_rmv_device,...)

OR

eeh_handle_normal_event()),
    eeh_pe_dev_traverse(pe, eeh_rmv_device,...)

In both the paths, eeh_handle_normal_event() holds this lock. Although I
am not an expert in eeh area - but looking at the relevant code paths,
the race looks real and this patch fixes that. So feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


I wonder whether clang context analyzer [1] could catch this. This is a
good candidate to try that out.

[1]: https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/


> The issue is seen for cases where the errors are detected on the PHB
> directly AND|OR for devices where the driver error_detected() returns
> PCI_ERS_RESULT_NEED_RESET, and driver being not EEH sensitive(i.e no
> error handlers like slot_reset(), resume() etc defined).
>

I am just wondering how did we catch this issue and whether we have some
ways to test eeh scenarios. Although the patch looks good to me.


> Fixes: 1010b4c012b0 ("powerpc/eeh: Make EEH driver device hotplug safe")

Cc: stable@vger.kernel.org 

Let's add the above tag so that this also goes to stable trees.  Since
it's been sometime since this was last posted - maybe we should rebase
and resend this with the above tag.

-ritesh

> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 028f69158532..d64cce17a4e0 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -533,9 +533,7 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
>  		if (rmv_data)
>  			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
>  	} else {
> -		pci_lock_rescan_remove();
>  		pci_stop_and_remove_bus_device(dev);
> -		pci_unlock_rescan_remove();
>  	}
>  }
>  

