Return-Path: <linuxppc-dev+bounces-28429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF68CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 02:01:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hv1d00W0bz30Vb;
	Tue, 29 Sep 2026 12:01:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790647300;
	cv=none; b=QshEWOxLlRUGLB/ZqzBCgnqBcVZktCf/w+hm/29CG5eIq6bCp6UYaHepnkVXIdgbdCMpwtxq7zDnfHWuUCThDjecSHV6IgXT7RHGLGUpC6DnE7NRKKG3cYnxIZf+6a24SrGP5RCrG6FxhfqlFspqIbaz55LilePi4M2sYFA1LBsk4J56LBFznucoBXPaqGZCgEE+Qrm2ifUtMo9M7RwhF597+IyZAZBYHUOOSWiwglcjo6ndcpraRXE11jUdSBqohaztWRdpZSIcu4C5OL30aqCj90ephFbnPM3++ZDk56c4TQbUQ225BGzDrYKDDjsXOdzN1Y+57zzHyMyWxqMZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790647300; c=relaxed/relaxed;
	bh=0g58I4h4nmwVw9ZB8EVoFTUYEfVp+7fY00zUlya+KGY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=l3Xb6rztjKGtdRFzVRv2mVkasK+KgcGMiG1qh+wDHy7vu/Rugs4cDll6f9s16V4F7+ekF4Xf9mmwRsMOsUW7V14nhNTl6offITG/k6RgmwZPxu/hF3lbN6MNKx5Ems98R1tEUuCWiTd9DvZzYnmvKbSaU3f026o3gxh7e7XQTvO1U4HCppwtYcAl8jTHGTOXjMTuyh/x/a5BdBQ3TBas0jbEhriWljm2xQ5b8xYxu979ajyknkl5QaGu+m9Nl+dL270DomdilkTamWo3BolPRcVShj9NDWQ9JhVDmGbHCvFrnu4PzUs98RXb6Mt4DLryXU0vd3kZUwdnDaiBC2XCpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GfeOBuTY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GfeOBuTY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::e; helo=mail-dy2-x0e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0e.google.com (mail-dy2-x0e.google.com [IPv6:2607:f8b0:4864:36::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv1cy5Lrhz30PJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 12:01:37 +1000 (AEST)
Received: by mail-dy2-x0e.google.com with SMTP id 5a478bee46e88-342773d94a7so2208825eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 19:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790647294; x=1791252094; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0g58I4h4nmwVw9ZB8EVoFTUYEfVp+7fY00zUlya+KGY=;
        b=GfeOBuTYeDw84e3UvpfQTZV2PeRHn4sDZrfMMY+ceghUigPmfUl9tVLKfN9SQ2R2Ol
         /qku4RkhC3AgenjvdZYfyN4UCRCmv6PuqO/s5YFOA+PxX8nzTkUYZ17uHioHoS+ELSo/
         SI/CPUf77TTwZNMJBF3cTVPy1VmU6aMSumDNc5ICpUAM5BuHQd/2FFw8Lieniqo/hseh
         aHn1MkCIlHCek+F/9zKZnFbfiH84UZQid7IULvhAqbimG4EUasMvsfidKs+Mn5QQoMA2
         jLf/8TycFTekWQeLdMlt+SewwzEATeuzDwT0gWCdDfEAaYps7IJ1PyFF30Y67Kw0XGR4
         lFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790647294; x=1791252094;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0g58I4h4nmwVw9ZB8EVoFTUYEfVp+7fY00zUlya+KGY=;
        b=R2UVd4anDpxIKQ1DKUGbxI7782XoE98050c7DDebo3qaFL8SRpAvTzF7zEvhJQm1RO
         nCtUQ4hUb6SrgVKXvrM4+RiqyJqJlCFca20rVssoJ8d+KSb4OLFm8cTfMm/d+pZ1P+ah
         4a15Y/dVu0rdN+6wsTL3MLbWWXr47p1xrn+o8t8WMRjzTrSCW8r9CBvD3nRlK7QdFaEz
         RZBa7i0CrmLVRT4SBk5HfLtrW54Xl40vYuQ2PYhpFvUI3yELXTYSUHTlnF0+J8Y4Ak4l
         78iZDW/dr4pz+1JSkz0vHeRPleM1JURNnyKAD26BbsUGcKk1y5lZD1fij422IDhFmzKY
         fMSw==
X-Forwarded-Encrypted: i=1; AKwUvBzIpsSc4gwFQMdlXzaQjr53qKOzw+arryBfFr0SAeSLEVQOR/r0FAnURH2/Fs73C3/Pygu4nUzzdSrP4tQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKqwAUroJWe7xap3EGtsXJXZ/P4Kitlsnvlq1tTu8u8aaS8TTRv
	M3TAyRK25ENa96HU6ZzzknqjbuIV/pekoDZDn03czDtbCeZyndmFWN6R
X-Gm-Gg: AYBFou0roZmXPbS+sgNzV/zPuGKHV9ugC9Gz2u3mlwfxl1iE/VJiaFiZQhtYA1Zg/xY
	pKuDaesk2x1dhdwj3uHHqWj6z7n25tQN7SQ4lESYFT6itoB1QS9wrNedCTfuwrFAY+XZUoCgn87
	bHdpr/EUEyOdVTE0y5tjDjKsw7aBPNoso8CQXL27HYjmws/bJ7PfZ9asGYpxCOYTINstibMIT2y
	uRAVYVbk8EYByGJiyNNXfc620zBLGBHy1FJugLD/2yeyGfLYyZEaekKm8o9Cf+l/iwkZ9Fryo0r
	il8NGpBi+qdooUpIdmrbkoF3jdAUaZOZ99H39fXXgLr8L1Z59fztseIrFiXMRBG7FtqOg1202N/
	OyC13zV+u/o2J0acbIQuZOD8Zx5ZDa8DwgDNRWgkp/ubD4c78FKt2SJEKymy8EP1W/Iw1mkn5oW
	kuzRq/C0R0pe+HLeTjludjuULsRIEYnpbPQVUf4VK+hL4jlXtJhGHfGqxX6iuly0QfFWNeaqMP2
	Yl65qMwFMVmD/3jA/rCDj9Pk/jng+TF2nhzX/laubR8ILDrXUQoSwlF3Ev5Kr3H
X-Received: by 2002:a05:7300:16a8:b0:342:4a2f:49eb with SMTP id 5a478bee46e88-34272b4bc8cmr11854243eec.38.1790647294257;
        Mon, 28 Sep 2026 19:01:34 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-342c9c245a7sm22818699eec.11.2026.09.28.19.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 19:01:32 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Muchun Song <songmuchun@bytedance.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] mm: Unify device DAX and HugeTLB vmemmap population paths
In-Reply-To: <655A7615-5885-4733-9E4E-3BDA1FE39362@linux.dev>
Date: Tue, 29 Sep 2026 07:27:09 +0530
Message-ID: <o6dgkefe.ritesh.list@gmail.com>
References: <20260924075259.2013039-1-songmuchun@bytedance.com> <607759bf-59f2-4ad6-b95b-e780ed2acba3@kernel.org> <8385F749-0F72-494E-9CA2-2E433A066712@linux.dev> <se2tjmpk.ritesh.list@gmail.com> <655A7615-5885-4733-9E4E-3BDA1FE39362@linux.dev>
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

Muchun Song <muchun.song@linux.dev> writes:

>> On Sep 29, 2026, at 01:43, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>> 
>> Muchun Song <muchun.song@linux.dev> writes:
>> 
>>> 
>>> If you're planning to review this series, I'd suggest waiting for my rebased
>>> version.
>>> 
>> 
>> Hello Muchun,
>
> Hi,
>
>> 
>> Thanks for taking care of powerpc side of the changes. Is it possible to
>> share your git/github tree somewhere? Sorry, but it's hard to follow
>> which series is based on which and the overall multi-series is based on
>> which upstream tree. If you could share your updated tree somewhere -
>> that would make my life simpler.
>
> Thanks. For now I'll follow David's suggestion and explicitly note which
> MM branch each series is based on. That should make things clearer early on.
>
> I'll also try to set up a tree later and share it once it's ready. Until
> then, let me know if a written summary of the branch/dependency order would
> help.
>

Written summary should be good too! Earlier I tried applying on few
trees, but I wasn't able to - hence checked for it. If you can share
which tree and/or tag/commit-id should I apply and the order of your
multi-series - that would help.

> Thanks for bearing with me while I get that sorted out.
>

Thanks a lot!

-ritesh


