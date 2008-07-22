Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 09C3CDDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 09:53:53 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1952798ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 16:53:52 -0700 (PDT)
From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH 2/2] Allow a custom ASOC machine driver with soc-of-simple
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
Date: Tue, 22 Jul 2008 19:53:51 -0400
Message-ID: <20080722235351.11648.56387.stgit@terra>
In-Reply-To: <20080722235349.11648.90112.stgit@terra>
References: <20080722235349.11648.90112.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Allow a custom ASOC machine driver with soc-of-simple

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---

 include/sound/soc-of-simple.h |    2 ++
 sound/soc/fsl/soc-of-simple.c |   26 +++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
index 696fc51..1e83f2f 100644
--- a/include/sound/soc-of-simple.h
+++ b/include/sound/soc-of-simple.h
@@ -18,4 +18,6 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 				 struct device_node *node,
 				 struct snd_soc_dai *cpu_dai);
 
+void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops);
+
 #endif /* _INCLUDE_SOC_OF_H_ */
diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
index 0382fda..dd2fa23 100644
--- a/sound/soc/fsl/soc-of-simple.c
+++ b/sound/soc/fsl/soc-of-simple.c
@@ -38,8 +38,8 @@ struct of_snd_soc_device {
 	struct device_node *codec_node;
 };
 
-static struct snd_soc_ops of_snd_soc_ops = {
-};
+static struct snd_soc_ops *machine_ops = NULL;
+static char *machine_name = NULL;
 
 static struct of_snd_soc_device *
 of_snd_soc_get_device(struct device_node *codec_node)
@@ -61,7 +61,7 @@ of_snd_soc_get_device(struct device_node *codec_node)
 	of_soc->machine.dai_link = &of_soc->dai_link;
 	of_soc->machine.num_links = 1;
 	of_soc->device.machine = &of_soc->machine;
-	of_soc->dai_link.ops = &of_snd_soc_ops;
+	of_soc->dai_link.ops = machine_ops;
 	list_add(&of_soc->list, &of_snd_soc_device_list);
 
 	return of_soc;
@@ -74,7 +74,7 @@ static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
 
 	/* Only register the device if both the codec and platform have
 	 * been registered */
-	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
+	if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
 		return;
 
 	pr_info("platform<-->codec match achieved; registering machine\n");
@@ -159,7 +159,7 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 	of_soc->platform_node = node;
 	of_soc->dai_link.cpu_dai = cpu_dai;
 	of_soc->device.platform = platform;
-	of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
+	of_soc->machine.name = machine_name;
 
 	/* Now try to register the SoC device */
 	of_snd_soc_register_device(of_soc);
@@ -169,3 +169,19 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(of_snd_soc_register_platform);
+
+void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops)
+{
+	struct of_snd_soc_device *of_soc;
+	
+	machine_name = name;
+	machine_ops = ops;
+	
+	list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
+		of_soc->dai_link.ops = machine_ops;
+		of_soc->machine.name = machine_name;
+		of_snd_soc_register_device(of_soc);
+	}
+
+}
+EXPORT_SYMBOL_GPL(of_snd_soc_register_machine);
