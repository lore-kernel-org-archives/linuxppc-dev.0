Return-Path: <linuxppc-dev+bounces-18172-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836EA105F7A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 13:24:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXQDb4F1Kz3cJk;
	Sat, 14 Mar 2026 00:23:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773408239;
	cv=none; b=WGYkh6PoZKvbZr9U+yjIjdHE+h0/UbwjSQwnQj35Y47Yw7r7b7FjVW5Ldc9OM4j7+v4tu8QrMRW8P1doWmDKTd61KtCuKFb60OjHrA5BhMlTlV2NBigGAu4fZp5YFU5JFt6VoUubhe28fVPn14OeeW7sK2S7wm9wBqPOmipDSNcZbqUrSHuPhBal/bAwfPux7wkIKKHXYp/DbrHZ/IiDMU4E5Qze2Vb0ntCqMSlEhROhH0Q3pOaUhAEJTVJPVtCrf/+f90SRskhzNjO5jHc2BvmmbY0wd+ae45oeDNqYXgJmEbWEvfkaU4oFmsxeCaYpccQyrj/Z53+JwzdPJ9p/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773408239; c=relaxed/relaxed;
	bh=344RBguoCHgkWzFlzd84v6Ck8EzpeG4f4qAq/bpCvLY=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=jI8r/lf5EhZrn94l16/sYHGWL4Z6nPcfbUrnvOHNuN/4rjDE+nIvmKu+DIZsNuYAd+O2kah0MH9yhRW3mKUbvIgsQsWvbaBAcOgvygMij332RUanR0kCfFaj6r+S08tcUqAPRvoWRJMxTAjgX9gcMMvA5WBnFLZogf6IRwuJkYB53EmmNbe1TfNRX3iQHwUcRI5sJUljBMT2Td5N7W1X+Qehit0ts3qKsZaAfyla2luHjgz8RYKEEkQsmCTHt1PbS02jSDGV8nOWRQMRlsYTXCJudfal3c9EqmZs2x+EgQHj83LUeXWB+j+w5SmzJOhWTlU3mwyDtlgPPUuf4gDhZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXQDZ14PRz3cDg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 00:23:56 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 0882DD4;
	Fri, 13 Mar 2026 14:23:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 0882DD4
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id 3E22D17A006;
	Fri, 13 Mar 2026 14:23:51 +0100 (CET)
Date: Fri, 13 Mar 2026 14:23:51 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: linuxppc-dev@lists.ozlabs.org
Cc: amd-gfx@lists.freedesktop.org
Subject: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
Message-Id: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
with the following in the log

...
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
...

After some hints from Alex and bisecting and other investigation I have
found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
is the culprit and reverting it makes amdgpu load (and work) again.

for the record, I have originally opened https://gitlab.freedesktop.org/drm/amd/-/issues/5039


	With regards,

		Dan

