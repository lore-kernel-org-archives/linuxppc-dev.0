Return-Path: <linuxppc-dev+bounces-18316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E254FD875E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 13:20:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZsz41RWlz2yjV;
	Wed, 18 Mar 2026 00:20:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773753648;
	cv=none; b=DFcJ9dqZOeRaGxxPnXsXDzpQzdaNBQBwSqBlkc+iuuZdccBkkfbmHhWYIIgOQea8KTUQR7T+I+SkibtJH3vRy9Q6eUcWLy/zjwP5ZDVFZ80+RMfJXXvWfpBBhaAoIM2q6aU/pTX8QqjjLH+IBU3EYOq2GURvAor9RPcEWVBK/TNT1s9JyX7YHBEUkGfONMzxZjK9J3+qH21deporu+AhzuJd4AftUTnOlqSbCEheLNDyozdOsIsEgrp9cX+7SNPWTfq9D/YrSOgSqu0Ccy9OuVObR8zoYNOM4s60zcVnE7XZ2wPmLiXwLWIBdHLXlLlKk9K6vksXbwYeeyJK38zCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773753648; c=relaxed/relaxed;
	bh=TjpfVxjcr+NMQLZx4OdK5lf1pCwYZzZGvbDIy4rSp4w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=N/sOfm7t0qYSAvdeBFTmZhxMd7uWe4LcjWvZdE7B98TnQ1C58qTZZmsvf8bh5gL75EIVCgQKZT7yRKmwOzAhI+6JZOkmcLiZokXh24HubGSohjK1bXa3ieyQPn4mjes2+4UxgngnBoXmAL1+uY02lnfilf4bZ/kl7TTFPMos1IZx9LxqMI++TZ8GpegnUXfxfbmJlF7K10VxzP6BEmp/azVupPobPiuboAZtBdp845CLrVQ4UhZEZoIQWXHqg37Y32d114lkKW0yaqvZ3/k+5//MOHNdgumoPOWGyefefIbIum+EydQ3BtFOBuqNo6SOzTJB4rD5Tdg1hY8HDvop6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EhKiVbjw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EhKiVbjw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZsz21qSfz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 00:20:45 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso2978595a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773753644; x=1774358444; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjpfVxjcr+NMQLZx4OdK5lf1pCwYZzZGvbDIy4rSp4w=;
        b=EhKiVbjw+QUuf2k+jwyOg5ZBXScCPsgSTosVtwU98ZhSrQpO/SHv5NMcz+yw0dqakk
         o4z6ZakTi/njSsDXvu3DPKaz1lOvzYgxnmAr39OYZ2ejhHystw03lsfdtBZGpHisUfhf
         nlELq8HJyI6/1QI4odj0lf3S+GMbtjgbZqsYJiJyIvfJMvRsCkjDe3YvIJakIFZJuTd4
         9qcixjjH1zs5lEVtftxDGXfkYTm+jwhE4k7C5vZ2Pz3zc8jAA6bzS04asR723QkqpIrz
         bFuBeoFl827KHNWoP/Irsr4H4BCCzveFguCGbUpMj4WVnxEFyJYWuJK7czplhWM70CiY
         OCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773753644; x=1774358444;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TjpfVxjcr+NMQLZx4OdK5lf1pCwYZzZGvbDIy4rSp4w=;
        b=Zb0a+Eyb/cjBG3c6dJY2CkLzotvOlp+GfqAb3nSB+Z0bHNYoWAZZBejyC3agBVmxi2
         O1JiV5hYWs6tfySHgA8g66sjG5mc6nd45I7RcWNeHu08s3Mm2UB5hlUTyEHlae+fb6zv
         ToY5Sr5kK4A3UaUY+k+PneB98F9GnarBwRzFLx+xCZ5XxxaTSgxHzKmV1cJxWKFkfdz9
         K4As3VcrlXXexV2dMO1ygdULfa5gsDAkAhh6s0ui2xB4CRemreufuhgdSXbBr8JSTBOf
         0n4b4BHBd9vGUveurlu39eoZXPtYklWcjcySRX5rWWMvRnTindLaf17BJpPJJoJSbJqc
         79Og==
X-Gm-Message-State: AOJu0YwcInnSbZm0gTfylDrKYRCFg7EGZzVdcEhxw1Eh25+lcZg6MK0V
	LfGpB+i49pXTpYopydgkzaqElSpzOO3FkxbVy5TT4n86CDSi3BT8GS2P
X-Gm-Gg: ATEYQzxrZh/pTD3pYjz8mY73OkWMAWLq9syfO1tIr/wZFHVN6YYx+FivHpMgoDOukiJ
	5erN3Eq136J/F/4X+L1+0mTcG5eU9A4Jn8n3rIXvHcDwdjpBzTG3nqJJx0YzW/j0Ega0L/kW/3C
	+fnozs+YPctLzHBO3x+FlQltt6Q9FjbTZbLR4AgpUkdHlRZkO5Iyooq9hIZJElt9xt1Is8sjWhs
	TubC9oVeIjOsP8eLgXaSQVB7i+RJrWdmMlN1ihji35e8rzSQTsfseTqlrQnBWYqpr2tAz4fTXj9
	UfXcjhto9c94C93Km1VNozR4u6bSzxKjEJd4AI50cTvfy4wn573r3crBJAOSCFFg2tUrhiRCWbP
	h7CqId21r3j0+dofghJQW+Z2hYk/Rk0cWjg+IZSXSj+RYgYJusVMIeP5CBvfuvCgJYDEj11H0vg
	KwG/gv71HFyCyAA9RTbmNvWQ==
X-Received: by 2002:a17:90b:2496:b0:35b:952c:43b9 with SMTP id 98e67ed59e1d1-35b952c450amr5243491a91.10.1773753643761;
        Tue, 17 Mar 2026 06:20:43 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bada5d18fsm2970098a91.7.2026.03.17.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:20:42 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, Gaurav Batra <gbatra@linux.ibm.com>, amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
Date: Tue, 17 Mar 2026 17:13:31 +0530
Message-ID: <ms06y93w.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz> <1phlu3bs.ritesh.list@gmail.com> <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dan Horák <dan@danny.cz> writes:

> Hi Ritesh,
>
> On Sun, 15 Mar 2026 09:55:11 +0530
> Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>
>> Dan Horák <dan@danny.cz> writes:
>> 
>> +cc Gaurav,
>> 
>> > Hi,
>> >
>> > starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
>> > initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
>> > with the following in the log
>> >
>> > ...
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
>> 
>>                   ^^^^
>> So looks like this is a PowerNV (Power9) machine.
>
> correct :-)
>  
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
>> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
>> > ...
>> >
>> > After some hints from Alex and bisecting and other investigation I have
>> > found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
>> > is the culprit and reverting it makes amdgpu load (and work) again.
>> 
>> Thanks for confirming this. Yes, this was recently added [1]
>> 
>> [1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 
>> 
>> 
>> @Gaurav,
>> 
>> I am not too familiar with the area, however looking at the logs shared
>> by Dan, it looks like we might be always going for dma direct allocation
>> path and maybe the device doesn't support this address limit. 
>> 
>>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
>
> a complete kernel log is at
> https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log
>
> Please let me know if you need more info.

Hi Dan,

Thanks for sharing the kernel log. Is it also possible to kindly share
your full kernel config with which you saw this issue.

I think Gaurav, is still looking into reported issue. However I was
interested in this kernel log output..

bře 05 08:35:34 talos.danny.cz kernel: radix-mmu: Mapped 0x00002007fad00000-0x00002007fcd00000 with 64.0 KiB pages

This shows that the system is using 64K pagesize. So I was interested in
knowing the kernel configs you have enabled. Donet has recently posted
64K pagesize support with amdgpu [1][2] on Power. However, I think, we
can still use it w/o Donet's changes if we have CONFIG_HSA_AMD_SVM
disabled.

So, can you kindly share the kernel configs and the AMD GPU HW details
attached to your Power9 baremetal system, if it's possible?

[1]: https://lore.kernel.org/amd-gfx/cover.1768223974.git.donettom@linux.ibm.com/#t     #merged
[2]: https://lore.kernel.org/amd-gfx/cover.1771656655.git.donettom@linux.ibm.com/       #in-review

-ritesh

