Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46AA11A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 12:16:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5B58514017E
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 12:16:09 +1000 (EST)
Message-ID: <1409796948.25089.6.camel@pasglop>
Subject: Re: TTM placement & caching issue/questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
Date: Thu, 04 Sep 2014 12:15:48 +1000
In-Reply-To: <20140904015548.GB4835@gmail.com>
References: <1409789547.30640.136.camel@pasglop>
 <20140904015548.GB4835@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@ozlabs.org,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <michel.daenzer@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-03 at 21:55 -0400, Jerome Glisse wrote:
> So i think we need to get a platform flags and or set_pages_array_wc|uc
> needs to fail and this would fallback to cached mapping if the fallback
> code still works. So if your arch properly return and error for those
> cache changing function then you should be fine.
> 
> This also means that we need to fix ttm_tt_set_placement_caching so that
> when it returns an error it switches to cached mapping. Which will always
> work.

Can't I just filter the mem_type definitions in the mem_type_manager
with something along that totally untested patch ?

Or do I *also* need to make those set_page_array_* things fail ?

--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1308,6 +1308,24 @@ int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned 
 }
 EXPORT_SYMBOL(ttm_bo_evict_mm);
 
+static void ttm_bo_filter_mem_type(struct ttm_bo_device *bdev, unsigned type,
+                                  struct ttm_mem_type_manager *man)
+{
+       /*
+        * On some architectures/patforms, we cannot allow non-cachable
+        * mappings of system memory. This can be a problem with AGP on
+        * old G5 systems vs. TTM_PL_TT but we don't really have a choice
+        * at this point on ppc64 at least and the AGP on these never
+        * worked reliably anyway.
+        */
+#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
+       if (type == TTM_PL_SYSTEM || type == TTM_PL_TT) {
+               man->available_caching &= TTM_PL_FLAG_CACHED;
+               man->default_caching &= man->available_caching;
+       }
+#endif
+}
+
 int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
                        unsigned long p_size)
 {
@@ -1327,6 +1345,8 @@ int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned ty
                return ret;
        man->bdev = bdev;
 
+       ttm_bo_filter_mem_type(bdev, type, man);
+
        ret = 0;
        if (type != TTM_PL_SYSTEM) {
                ret = (*man->func->init)(man, p_size);
