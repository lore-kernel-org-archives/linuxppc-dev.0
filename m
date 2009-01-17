Return-Path: <roel.kluin@gmail.com>
Message-ID: <4972456C.1050301@gmail.com>
Date: Sat, 17 Jan 2009 21:54:04 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: geoffrey.levand@am.sony.com
Subject: [PATCH] PS3 ps3av_set_video_mode() make id signed
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

vi drivers/video/ps3fb.c +618
static int ps3fb_set_par(struct fb_info *info)
{
        struct ps3fb_par *par = info->par;
... [ and at line 660 ] ...
	if (ps3av_set_video_mode(par->new_mode_id))

now new_mode_id is an int

vi drivers/video/ps3fb.c +132
struct ps3fb_par {
...
        int new_mode_id;
...
};

vi drivers/ps3/ps3av.c +844
int ps3av_set_video_mode(u32 id)

-------------------------^^^

{
...
	if (... || id < 0) {

--------------------^^^

		dev_dbg(&ps3av->dev->core, "%s: error id :%d\n", __func__, id);
                return -EINVAL;
        }
...
		id = ps3av_auto_videomode(&ps3av->av_hw_conf);
                if (id < 1) {
---------------------^^^
                        printk(KERN_ERR "%s: invalid id :%d\n", __func__, id);
                        return -EINVAL;
                }
...
	ps3av->ps3av_mode = id;

vi drivers/ps3/ps3av.c +763
static int ps3av_auto_videomode()

-------^^^

+42
static struct ps3av {
...
        int ps3av_mode;
...
};

--------------------->8---------------8<-------------------
make id signed so a negative id will get noticed

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 5324978..7aa6d41 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -838,7 +838,7 @@ static int ps3av_get_hw_conf(struct ps3av *ps3av)
 }
 
 /* set mode using id */
-int ps3av_set_video_mode(u32 id)
+int ps3av_set_video_mode(int id)
 {
 	int size;
 	u32 option;
