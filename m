Return-Path: <linuxppc-dev+bounces-25636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B62FC55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 05:27:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH8f44Gdqz2xd2;
	Sat, 08 Aug 2026 15:27:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786166828;
	cv=none; b=PU4IbPqgScn+VFRvZaHUo7vzawvz5yLIAFBJKRulwJiMO4h8y5aJOb95iQpj+1SOnTBrzFI34FPeP7AaYPX9h+yBxgqG0/d7hD1+Z/Uwv5T3mZIu54UqXlJvGl+br11yhfK6X1sEYqifJkheZBc5f+vABqr0LVGRJy+OktjyFDR8MjmCbYGCNDpvYGMj5+lNNJ6ezEcqc4qvWsQQtFX6PHmvURDLoxz/JWiZeQiZjQ3Cr7ASi79RxsjBSgMS9D59+0ixOupXE5UEne9FzmDCJALW2PTjbD7kFbSd8ChXaVNYu34gkkPKpuJ7NSv6L4EqGXP/D0LYqPMXlE6xVtwlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786166828; c=relaxed/relaxed;
	bh=Ot261G4LpTjM91viBCbOoO5lpndaR46o1VaOefSI5t8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=EhH9Rm2MpN/gc7KypwX3aILUmEKBiEGvWn8m0x8xz3oAghkr0rup0PR8KzAd/OaY/AClhlNAODxIXE1L9x6iPCNIp2ZRWVjx9Qq0UlsIxdxZN4VLCXJWowYO7bLJi65EoaGJo/Xpi4p+vuggorh+qBh6lfNscNXsMWY2lRNplisLnY1Vw+0TmYTKsRb11/40LEIcV89NKaJWMqb+BJlbm5LeKazJcUTIepduVVkk0MNrToh3QK6/9ac+bPE9HzFZrQVhYQNw5V4duXUkCm8FQzIFHvIrdGB3HKHF+/XYcps8Ny+Sw+3IH8uIj3pW5Ls3nQid3F3XFjcK6msuMwvoFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TnJX0Edy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TnJX0Edy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH8f25fy4z2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 15:27:05 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-38e347638adso236140a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 22:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786166818; x=1786771618; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ot261G4LpTjM91viBCbOoO5lpndaR46o1VaOefSI5t8=;
        b=TnJX0EdyxWDJ6fQvsE8Ok9XErwQMYEF6HgUaXKjRKU62KxPgHFmjfmnj2XrtSnOwyd
         W8bqB/Fqj5gfQ9QvzsJjpKXWipo9nt6G/t1rFL5j/UHpR2N3FzIQE1i/Oa0TXkQPwNaE
         i34cSEIFUPTAdpZv98/wvCVuVeG//G/dvBMAnfl40rjMeRw15YbzQ4b85DE9eb4hkQCt
         jPoFaGxt6hHxEMjx2v2LpejXVc7V6KXgCxbhvlqnBOkf6kX+aPQmIgiDr+FAKEkBDOgx
         A7WRpbY05kjEU2eahz8xkotGIhdzPbAvv2hx4k5BFwKOAncUITRrIzlKlP/OgIPG3ywf
         JxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786166818; x=1786771618;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ot261G4LpTjM91viBCbOoO5lpndaR46o1VaOefSI5t8=;
        b=PJRhNgzhaq4LPmBniEl0V3oHlNilZ/4yXBps98qSzOIjoNTdrmeGTyS6ZwL/VKK6R6
         D+VRnwP5u70VtWWwdoxPOAfQ48W4UxQiOvHL9YMNKms3HUOXVs5LiiUViO5Fi8sbraa4
         NRTIInFYE/N9czrMsAQ6fnj5mIUMe58phM+zpINCNoBy5SZ2yqVcdFvBQVso0QEiqxGT
         piHJR+PDPBdTEWdC1fbOEPVa5bLDb+aXAQIFhSmqDqAQw27qBe2kIDMHMvFh1qaSEhtY
         RJSeDE/mgg8Q/TQSjQQmHt62Kz6X+6YZa3fYNQLCcXl2SMUgMS+euefhfs0xhFfj5jp6
         J7kw==
X-Gm-Message-State: AOJu0YwMl0/AuBgp7TWP+/J12nhuL7DBuBFwax6iSmkKBuccfPlyHpBQ
	wjtXC0Sh/gz3orfta1n2w9xwWjy1hMu1gjcpCmFssfXyvdRWUtVBXLCE
X-Gm-Gg: AR+sD10Ow3qYkVfisUV21yS/6Q8UA3nCAZmUeUleHV7vVnpaCt0zniwHVwhjHEpm9Df
	tK/I2i78Ia0D0eVP5pttbHNPXL03OyALJbGAf//52aWv0Ewkhqil5xlvq7WC+OYGviG0L2ZqOfU
	56buE1iJQqV4eWWj7/KSbUoYwEAAMTt5zyhOl4wd+aGAkuaeAg5jMxcYhyzHwo3g3XOLubv4/F+
	+cPIpNZ47e0AwdYzIimMfkNs/ZZEKVHu3Tp4G39UQjPHU81oNBuJsCslHfbz+XTbzYIZLC0jcQe
	4IMq6RcN3zZBz9Zf6LpQLKZ6htXvaLhFNmO09ii2CN/j6n4Ug31/eQZ6tmDkdj71/mXwiccTRlz
	3qi+A2G02OtN377yJlVf/tk8P31Vzk1SagRFCLzd5G451Ia46s1oYWi1tm8pBI090rSvQf5ySnC
	ty0vUiHAMNpPp3pXLSTWgTzD1R+JZWCh5+yyDZuDqkgYasxSinJQsTLwADu/oM1ZlW2UckMw==
X-Received: by 2002:a17:90b:4a0f:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-392823340e5mr5196878a91.5.1786166818121;
        Fri, 07 Aug 2026 22:26:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8d60f4sm14797092eec.13.2026.08.07.22.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 22:26:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Gaurav Batra <gbatra@linux.ibm.com>
Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
In-Reply-To: <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com>
Date: Sat, 08 Aug 2026 10:39:24 +0530
Message-ID: <wlu1jj0b.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com> <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com>
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

Timothy Pearson <tpearson@raptorengineering.com> writes:

> ----- Original Message -----
>> From: "Ritesh Harjani" <ritesh.list@gmail.com>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
>> Cc: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra" <gbatra@linux.ibm.com>
>> Sent: Thursday, August 6, 2026 12:27:22 AM
>> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
>
>> Hi Timothy,
>> 
>> Timothy Pearson <tpearson@raptorengineering.com> writes:
>> 
>>> On Linux 6.18, and potentially earlier Linux versions, attempting to pass
>>> through any PCI device via VFIO that requires 32-bit DMA results in the
>>> following error in the guest VM:
>> 
>> Can you confirm if you see the same issue on upstream kernel also or is
>> it only till v6.18 kernel?
>
> I'll need to check, but I don't see why it would be limited to 6.18.  This used to work, but it's fairly obvious IBM hasn't been testing or fixing any of the VFIO or nested virtualization code for years now, especially on PowerNV.
>
>>>
>>> [   11.705413] cx23885 0000:00:02.0: Warning: IOMMU offset too big for device
>>> mask
>>> [   11.709245] cx23885 0000:00:02.0: mask: 0xffffffff, table offset:
>>> 0x800000000000000
>>>
>>> The same devices work correctly on the host kernel.  It appears that somehow
>>> 32-bit DMA is not available within a pSeries guest on a PowerNV host.
>> 
>> By any chance did you do kexec in the guest kernel? Is this issue only
>> hitting with kexec or even with normal boot up of guest kernel is also
>> showing up the same issue?
>
> Yes, we kexec().  This works on every other architecture, not sure why kexec() would break it?
>
> In any case, from where I sit at this point it's IBM's responsibility as the silicon vendor to ensure basic functionality works -- I don't see these issues on amd64 or arm64, and frankly on this end we're tired of the constant lack of QA from IBM causing every single kernel upgrade to be a game of Russian Roulette.  IBM should be able to spin up a test machine easily enough to reproduce, this isn't complex -- any card that needs 32-bit DMA is affected including inexpensive ASmedia USB 3 controllers.  Pass it through to QEMU via VFIO and watch it fail, it happens every time.
>

I was trying to help by asking for basic help from you. If you report a
problem upstream than we do expect such basic help e.g. is it only seen
with kexec, logs etc, so that we can all save some time here.

>> Could you please share the dmesg logs for both guest and host kernel?
>> That might give some more data about this issue.
>
> I don't have access to the setup at this point since it was already replaced with something else to restore functionality.

I think this patch [1] might have fixed the issue that you reported and
hence wanted to check if you only see the issue with kexec or also with
reboots? And if you could have given it a try.

[1]: https://lore.kernel.org/all/20260803224029.60538-1-gbatra@linux.ibm.com/

But anyways - I have already asked others on that thread (who are expert
of this area) to confirm if this patch could also fix the error you
reported with 32-bit DMA devices.

-ritesh


