Return-Path: <julia@diku.dk>
From: Julia Lawall <julia@diku.dk>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/4] sound/aoa/fabrics/layout.c: remove unneeded kfree
Date: Sat, 20 Aug 2011 08:12:41 +0200
Message-Id: <1313820761-12042-4-git-send-email-julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

The label outnodev is only used when kzalloc has not yet taken place or has
failed, so there is no need for the call for kfree under this label.

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
if (...) { ... when != kfree(x)
               when != x = E3
               when != E3 = x
*  return ...;
 }
... when != x = E2
    when != I(...,x,...) S
if (...) { ... when != x = E4
 kfree(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/aoa/fabrics/layout.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 3fd1a7e..552b97a 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1073,10 +1073,10 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 	sdev->pcmid = -1;
 	list_del(&ldev->list);
 	layouts_list_items--;
+	kfree(ldev);
  outnodev:
  	of_node_put(sound);
  	layout_device = NULL;
- 	kfree(ldev);
 	return -ENODEV;
 }
 
