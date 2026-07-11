Return-Path: <linuxppc-dev+bounces-24054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041FBC44501
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 18:46:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyHht6hG2z2yFK;
	Sun, 12 Jul 2026 04:46:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783795566;
	cv=none; b=ORpd/czUHeyzWSM6tg0XofXtb8HOdw/6aDGAjvc2v+0QxKqL3la1LuJih7r5pZwV6tA26KYFDfvrLUwZC9S8/30WSHn9FiSqf//SPp1NCIaJ/OUBnmBiXgxJZeYrnvB55IUFeozBWH5LweuwRc2riq6+ocbPZS+o0W4XxfFVIQjfg6FZUzpL1YsJ9Ee3V2YE31l0CaY2M+I7cehWPFCq3JzqEWNC08RNuWLrB1NWUOg7MiBtT6vRg+n9VBpq6BmG/8hli1Cez9giH53m7zm8n9TvP4ze4vpAuHso1DQdHXG/pgP4XlaJCm7mU9sDM2tGS1gSaKdQjnSxlMUGueDAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783795566; c=relaxed/relaxed;
	bh=4X8Clz3fd1owNiO9Pv6vUhPn41dQXdJma9VDgzp5GpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+FXZn8qHE5gEfeHbRvqLoQp7TjoaD4BoddvCo8SXB+40wdGCtCR+Q6mUE1JoCRkE9MOkH9DKbpe1cU+BGfd4AnR9Rv5yYFAY74Xd3mQfmsCfoWG2cAfFg1jkUPzfPNUJ+5Fnx8LI5AFm+NHI8YBOdUc2p5xM8+t7ZXTTXonlmSItUr4X5gfwThSS+blon6EdGQCMCVYiX3zJDwoxHDgtF4QNBbGJp5jd9IRaMVEHlAhdBwcxWHUw7/RVLovuKKQorbuWTMwaL8QmrLzTv/+PcH0Qw26cB8jp4hjz88dSwjSkAsaSMB63uoy86N5T1jql81hlXcjPfO+/LiAHOIGBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3IJ5UKX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3IJ5UKX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyHht1BVKz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 04:46:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EA6E6601D9;
	Sat, 11 Jul 2026 18:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2428F1F00A3A;
	Sat, 11 Jul 2026 18:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783795563;
	bh=4X8Clz3fd1owNiO9Pv6vUhPn41dQXdJma9VDgzp5GpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b3IJ5UKXJWHdstaNE7y5ot+/3k3QKa6AhRc7Wffa4hfZ305PVpEvaJKNGHLJ3wiys
	 kqVIiX25qZVXJaTT+Qgjr5ODbLIA55N49hux0vbRs0et3au9LBQKwrVwghVFXrLl7E
	 817VHGE33QrB50d5C1LscqS/7pNneUD0nYGcnWDai8gQyjsw4TcvH+fgmF1OwsvnN9
	 2pvaWR1/mhz3yp4qVYs3qwET2uh7D30e/8XDBnKYPp1TnRGR39oxh4CFkY52uJlQ/8
	 VseCL2NAhZF2r9D5qvydoKSBQPUnQ2/tkYhPSxvwJKQj0iFEdbJlYmSDUW8OLt0N5o
	 c+59QXF0t/z1Q==
From: Lorenzo Stoakes <ljs@kernel.org>
Date: Sat, 11 Jul 2026 19:44:58 +0100
Subject: [PATCH v2 01/13] mm: introduce vma_flags_can_grow() and
 vma_can_grow()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-b4-vma-flags-mm-v2-1-0fa2357d5431@kernel.org>
References: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
In-Reply-To: <20260711-b4-vma-flags-mm-v2-0-0fa2357d5431@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>, 
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Helge Deller <deller@gmx.de>, Kees Cook <kees@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
 linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177; i=ljs@kernel.org;
 h=from:subject:message-id; bh=oSsuzEZdPIZ+otSvvS1qpHgk2++YqmMZy2jJkjlchbs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKC+i1DpYuvr35hfGA9T/DrI/smfbvJXDzdl/eEd9+FF
 xnT800OdZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiZhoM/6xY7sV0KDJr3XKY
 uPtiX7X4ZaX5Xemv3hiY8c63tfCt1WL4xXQgV6XZa8a6lMQPuqVRFwM4zMVNbzY+TJao67/8NWA
 vKwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

These test whether the VMA has stack semantics, i.e. is able to grow
upwards or downwards depending on the architecture.

In order to account for arches which do not support upward-growing stacks,
introduce VMA_GROWSUP whose definition depends on the architecture
supporting it, and use vma_flags_test_single_mask() in vma_flags_can_grow()
to account for this.

No functional change intended.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mm.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 32bb723ffbb9..7a7f559b3df0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -474,6 +474,7 @@ enum {
 #define VM_SAO		INIT_VM_FLAG(SAO)
 #elif defined(CONFIG_PARISC)
 #define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
+#define VMA_GROWSUP	mk_vma_flags(VMA_GROWSUP_BIT)
 #elif defined(CONFIG_SPARC64)
 #define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
 #define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
@@ -485,6 +486,7 @@ enum {
 #endif
 #ifndef VM_GROWSUP
 #define VM_GROWSUP	VM_NONE
+#define VMA_GROWSUP	EMPTY_VMA_FLAGS
 #endif
 #ifdef CONFIG_ARM64_MTE
 #define VM_MTE		INIT_VM_FLAG(MTE)
@@ -1578,11 +1580,24 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
 		vma->vm_end >= vma->vm_mm->start_stack;
 }
 
-static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
+static inline bool vma_flags_can_grow(const vma_flags_t *flags)
 {
-	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
+	if (vma_flags_test_single_mask(flags, VMA_GROWSUP))
+		return true;
+	if (vma_flags_test(flags, VMA_GROWSDOWN_BIT))
+		return true;
+
+	return false;
+}
 
-	if (!maybe_stack)
+static inline bool vma_can_grow(const struct vm_area_struct *vma)
+{
+	return vma_flags_can_grow(&vma->flags);
+}
+
+static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
+{
+	if (!vma_can_grow(vma))
 		return false;
 
 	if ((vma->vm_flags & VM_STACK_INCOMPLETE_SETUP) ==

-- 
2.55.0


