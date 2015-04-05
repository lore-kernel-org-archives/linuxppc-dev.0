Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A9DA1A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Apr 2015 21:46:44 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 9/9] sound/ppc/snd_ps3.c: fix error return code
Date: Sun,  5 Apr 2015 13:38:33 +0200
Message-Id: <1428233914-4503-9-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1428233914-4503-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: cbe-oss-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Initialize ret before returning on failure, as done elsewhere in the
function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}

// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/ppc/snd_ps3.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/ppc/snd_ps3.c b/sound/ppc/snd_ps3.c
index 1aa52ef..9b18b52 100644
--- a/sound/ppc/snd_ps3.c
+++ b/sound/ppc/snd_ps3.c
@@ -1040,6 +1040,7 @@ static int __devinit snd_ps3_driver_probe(struct ps3_system_bus_device *dev)
 				   GFP_KERNEL);
 	if (!the_card.null_buffer_start_vaddr) {
 		pr_info("%s: nullbuffer alloc failed\n", __func__);
+		ret = -ENOMEM;
 		goto clean_preallocate;
 	}
 	pr_debug("%s: null vaddr=%p dma=%#llx\n", __func__,
