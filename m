Return-Path: <julia@diku.dk>
From: Julia Lawall <julia@diku.dk>
To: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2/2] sound/soc/fsl/mpc8610_hpcd.c: add missing of_node_put
Date: Sat, 20 Aug 2011 09:02:01 +0200
Message-Id: <1313823721-16930-2-git-send-email-julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	devicetree-discuss@lists.ozlabs.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
	Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

The first change is to add an of_node_put, since codec_np has previously
been allocated.  The rest of the patch reorganizes the error handling code
so the only code executed is that which is needed.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
identifier x;
expression E1!=0,E2,E3,E4;
statement S;
iterator I;
@@

(
if (...) { ... when != of_node_put(x)
               when != x = E3
               when != E3 = x
*  return ...;
 }
... when != x = E2
    when != I(...,x,...) S
if (...) { ... when != x = E4
 of_node_put(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/soc/fsl/mpc8610_hpcd.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index a192979..358f0ba 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -345,8 +345,10 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	}
 
 	machine_data = kzalloc(sizeof(struct mpc8610_hpcd_data), GFP_KERNEL);
-	if (!machine_data)
-		return -ENOMEM;
+	if (!machine_data) {
+		ret = -ENOMEM;
+		goto error_alloc;
+	}
 
 	machine_data->dai[0].cpu_dai_name = dev_name(&ssi_pdev->dev);
 	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
@@ -494,7 +496,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	ret = platform_device_add(sound_device);
 	if (ret) {
 		dev_err(&pdev->dev, "platform device add failed\n");
-		goto error;
+		goto error_sound;
 	}
 	dev_set_drvdata(&pdev->dev, sound_device);
 
@@ -502,14 +504,12 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 
 	return 0;
 
+error_sound:
+	platform_device_unregister(sound_device);
 error:
-	of_node_put(codec_np);
-
-	if (sound_device)
-		platform_device_unregister(sound_device);
-
 	kfree(machine_data);
-
+error_alloc:
+	of_node_put(codec_np);
 	return ret;
 }
 
