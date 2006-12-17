Return-Path: <michael@ellerman.id.au>
Subject: Re: fix dmasound compile error for tas300x
From: Michael Ellerman <michael@ellerman.id.au>
To: marvin <marvin24@gmx.de>
In-Reply-To: <200612171438.23435.marvin24@gmx.de>
References: <200612171438.23435.marvin24@gmx.de>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 10:58:45 +1100
Message-Id: <1166399925.9607.4.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-sound@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-12-17 at 14:38 +0100, marvin wrote:
> hi,
> 
> I need the attached patch to compile the awacs/dmasound driver. There is still 
> some warning, but I don't know how to fix it. Only build tested because I'm 
> using alsa ...

Al Viro already posted a patch which has slightly more chance of
working. I'm not sure who's supposed to merge it, it seems to have
fallen through the cracks.

http://lkml.org/lkml/2006/12/8/34

cheers

a987c6e8f3fd76d1b123fc0215777ea0b91f04a4
diff --git a/sound/oss/dmasound/tas3001c.c b/sound/oss/dmasound/tas3001c.c
index f227c9f..2f21a3c 100644
--- a/sound/oss/dmasound/tas3001c.c
+++ b/sound/oss/dmasound/tas3001c.c
@@ -50,6 +50,7 @@ struct tas3001c_data_t {
 	int output_id;
 	int speaker_id;
 	struct tas_drce_t drce_state;
+	struct work_struct change;
 };
 
 
@@ -667,14 +668,13 @@ tas3001c_update_device_parameters(struct
 }
 
 static void
-tas3001c_device_change_handler(void *self)
+tas3001c_device_change_handler(struct work_struct *work)
 {
-	if (self)
-		tas3001c_update_device_parameters(self);
+	struct tas3001c_data_t *self;
+	self = container_of(work, struct tas3001c_data_t, change);
+	tas3001c_update_device_parameters(self);
 }
 
-static struct work_struct device_change;
-
 static int
 tas3001c_output_device_change(	struct tas3001c_data_t *self,
 				int device_id,
@@ -685,7 +685,7 @@ tas3001c_output_device_change(	struct ta
 	self->output_id=output_id;
 	self->speaker_id=speaker_id;
 
-	schedule_work(&device_change);
+	schedule_work(&self->change);
 	return 0;
 }
 
@@ -823,7 +823,7 @@ tas3001c_init(struct i2c_client *client)
 			tas3001c_write_biquad_shadow(self, i, j,
 				&tas3001c_eq_unity);
 
-	INIT_WORK(&device_change, tas3001c_device_change_handler, self);
+	INIT_WORK(&self->change, tas3001c_device_change_handler);
 	return 0;
 }
 
diff --git a/sound/oss/dmasound/tas3004.c b/sound/oss/dmasound/tas3004.c
index 82eaaca..af34fb3 100644
--- a/sound/oss/dmasound/tas3004.c
+++ b/sound/oss/dmasound/tas3004.c
@@ -48,6 +48,7 @@ struct tas3004_data_t {
 	int output_id;
 	int speaker_id;
 	struct tas_drce_t drce_state;
+	struct work_struct change;
 };
 
 #define MAKE_TIME(sec,usec) (((sec)<<12) + (50000+(usec/10)*(1<<12))/100000)
@@ -914,15 +915,13 @@ tas3004_update_device_parameters(struct 
 }
 
 static void
-tas3004_device_change_handler(void *self)
+tas3004_device_change_handler(struct work_struct *work)
 {
-	if (!self) return;
-
-	tas3004_update_device_parameters((struct tas3004_data_t *)self);
+	struct tas3004_data_t *self;
+	self = container_of(work, struct tas3004_data_t, change);
+	tas3004_update_device_parameters(self);
 }
 
-static struct work_struct device_change;
-
 static int
 tas3004_output_device_change(	struct tas3004_data_t *self,
 				int device_id,
@@ -933,7 +932,7 @@ tas3004_output_device_change(	struct tas
 	self->output_id=output_id;
 	self->speaker_id=speaker_id;
 
-	schedule_work(&device_change);
+	schedule_work(&self->change);
 
 	return 0;
 }
@@ -1112,7 +1111,7 @@ tas3004_init(struct i2c_client *client)
 	tas3004_write_register(self, TAS3004_REG_MCR2, &mcr2, WRITE_SHADOW);
 	tas3004_write_register(self, TAS3004_REG_DRC, drce_init, WRITE_SHADOW);
 
-	INIT_WORK(&device_change, tas3004_device_change_handler, self);
+	INIT_WORK(&self->change, tas3004_device_change_handler);
 	return 0;
 }
 
