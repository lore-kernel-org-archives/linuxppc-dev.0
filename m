Return-Path: <linuxppc-dev+bounces-23127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C21CC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:26:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpx8W35PXz2xPL;
	Tue, 30 Jun 2026 05:26:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782761163;
	cv=none; b=BwYktZ7yzg8yDoU0mtkyRN+crTpn5o0m1pwr35qIfoDwMioUV4iHOEO1npgqfEDfYj/3f/oQM+CREQzfV5+5BT8WdOoV7h+I7RBFC1J33mYnH6YvpUC8MM6AfYpycLg7q7bEI+S+43dhS6y1JWUSNQhszeS50LY2qnPeXhZLKGH5KdH6t7wks5yjM3w4LY6N044u4sFKMfwM8ClssnEXM9W6F+Vg7jjhTJRhbHupS46/wDcZ4wE+plN+fVY1PhhqxLrEP8WduVcYDCbPDwM84yyhPkeoALpeN537c23bOQX9Y/q/qiSIu9ZFKEzNRLqL1tkQDZrHkLTpGv0bTNYjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782761163; c=relaxed/relaxed;
	bh=RyicGxsSOzJTaoBcRQGH27oUytYBKCYLUF6jDOpzH7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcdbtVY0S+ydKmBaBez+sMO+RNgDzmHU+JySVhRuq89g8LH8LdElCnErcWoCzMMOBKdleIDWvfj72JrXNFIwarYv3oqb5R2NHasdm94CLdlGcKXGe21wlzvidN2djiBejzcFrstEztSTkxW49Iq/N75k+Ihfr+qMOgnpKVIzC3YH0bz3mTRcBrYwrdY2/+U7Ska0AzRNqRm4PREv/cvpHWW2cQyXdU0pKj09j4gK0YRGNHGh/95ro9695jCKP99t+a1u0U4gSq7Y2RMcHi7KI/SR/PDd8Ram1+1GwHVSsSKP3ZJlT4B4IHVgptYp6y+BAB0zU2zrayMhoVjQwkpyFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5KeyFTe; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a5KeyFTe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpx8V10rmz2yf5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 05:26:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F8DE600AA;
	Mon, 29 Jun 2026 19:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564721F000E9;
	Mon, 29 Jun 2026 19:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782761159;
	bh=RyicGxsSOzJTaoBcRQGH27oUytYBKCYLUF6jDOpzH7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5KeyFTeJjh7TJORUpSdmde4WrAK8BTgTPTho1LlZNtgrXh/Yqn9mD6/L1E9zfs8r
	 e8za/mcjsoGeYfC+55PxZM0hLi0ZRJB+0Gbcm0U2F6Fn97SZIJM1N8XKGpsR2xQKrI
	 yYMjTnXxd/YQ9zzdgYLIPjHCFJPa2KKvIAraY8mhyi19FlYp5ghqePfdzpdkTUseC1
	 had3a1qZv4Z9B8qbb5LsCMcPsRJ2m5HWJRYLpaEMWR5rYHXsAk6QucmLYIa0UzO6lQ
	 Pqa24H5c5iEEZidrzYUke9zV+idmE8KbclhOGbVFF/6WTC2VNdnFmcT1ViYuCVE/mn
	 cARBGEsTONhTA==
From: Lorenzo Stoakes <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lucas Stach <l.stach@pengutronix.de>,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Helge Deller <deller@gmx.de>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Hugh Dickins <hughd@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kees Cook <kees@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 01/13] mm: introduce vma_flags_can_grow() and vma_can_grow()
Date: Mon, 29 Jun 2026 20:25:24 +0100
Message-ID: <f2e8c32515d328db62279cc8bab8398ea278d74f.1782760670.git.ljs@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782760670.git.ljs@kernel.org>
References: <cover.1782760670.git.ljs@kernel.org>
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
Content-Transfer-Encoding: 8bit

These test whether the VMA has stack sematics, i.e. is able to grow upwards
or downwards depending on the architecture.

In order to account for arches which do not support upward-growing stacks,
introduce VMA_GROWSUP whose definition depends on the architecture
supporting it, and use vma_flags_test_single_mask() in vma_flags_can_grow()
to account for this.

Update the VMA userland tests to reflect the changes

No functional change intended.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mm.h              | 21 ++++++++++++++++++---
 tools/testing/vma/include/dup.h |  4 ++++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 868b2334bff3..cf7df1569052 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -472,6 +472,7 @@ enum {
 #define VM_SAO		INIT_VM_FLAG(SAO)
 #elif defined(CONFIG_PARISC)
 #define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
+#define VMA_GROWSUP	mk_vma_flags(VMA_GROWSUP_BIT)
 #elif defined(CONFIG_SPARC64)
 #define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
 #define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
@@ -483,6 +484,7 @@ enum {
 #endif
 #ifndef VM_GROWSUP
 #define VM_GROWSUP	VM_NONE
+#define VMA_GROWSUP	EMPTY_VMA_FLAGS
 #endif
 #ifdef CONFIG_ARM64_MTE
 #define VM_MTE		INIT_VM_FLAG(MTE)
@@ -1563,11 +1565,24 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
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
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 5d7d0afd7765..6f5bcd7fbcd8 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -245,8 +245,10 @@ enum {
 #define VM_STACK	INIT_VM_FLAG(STACK)
 #ifdef CONFIG_STACK_GROWS_UP
 #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
+#define VMA_STACK_EARLY mk_vma_flags(VMA_STACK_EARLY_BIT)
 #else
 #define VM_STACK_EARLY	VM_NONE
+#define VMA_STACK_EARLY EMPTY_VMA_FLAGS
 #endif
 #ifdef CONFIG_ARCH_HAS_PKEYS
 #define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
@@ -315,6 +317,8 @@ enum {
 
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
+#define VMA_STACK_INCOMPLETE_SETUP append_vma_flags(		\
+	VMA_STACK_EARLY, VMA_RAND_READ_BIT, VMA_SEQ_READ_BIT)
 
 #define TASK_EXEC_BIT ((current->personality & READ_IMPLIES_EXEC) ? \
 		       VM_EXEC_BIT : VM_READ_BIT)
-- 
2.54.0


