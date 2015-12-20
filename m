Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB26C1A1A0C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Dec 2015 22:28:37 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-s390@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: [PATCH 0/4] add NULL test
Date: Sun, 20 Dec 2015 12:15:49 +0100
Message-Id: <1450610153-7746-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add NULL tests on various calls to kzalloc and devm_kzalloc.

The semantic match that finds these problems is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,y;
identifier fld;
@@

(
x = \(vmalloc\|kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|krealloc\|
        kmemdup\|kstrdup\|
	devm_kzalloc\|devm_kmalloc\|devm_kcalloc\|devm_kasprintf\|
	kmalloc_array\)(...,<+... __GFP_NOFAIL ...+>,...);
|
* x = \(vmalloc\|kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|krealloc\|
        kmemdup\|kstrdup\|
	devm_kzalloc\|devm_kmalloc\|devm_kcalloc\|devm_kasprintf\|
	kmalloc_array\)(...);
)
  ... when != (x) == NULL
      when != (x) != NULL
      when != (x) == 0
      when != (x) != 0
      when != x = y
(
  x->fld
|
  *x
|
  x[...]
)
// </smpl>

---

 drivers/s390/char/con3215.c                 |    2 ++
 drivers/s390/char/raw3270.c                 |    2 ++
 sound/soc/fsl/imx-pcm-dma.c                 |    2 ++
 sound/soc/intel/baytrail/sst-baytrail-pcm.c |    2 ++
 sound/soc/omap/omap-hdmi-audio.c            |    2 ++
 5 files changed, 10 insertions(+)
