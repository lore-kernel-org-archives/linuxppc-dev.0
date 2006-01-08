Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <1136701380.30123.46.camel@localhost.localdomain>
References: <1136695956.30123.44.camel@localhost.localdomain>
	<fe4d9bc576d696dfea0bc1b2a742307d@penguinppc.org>
	<1136701380.30123.46.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 10:37:56 +1100
Message-Id: <1136763476.30123.98.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Fix PowerMac sound i2c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here's another version that uses the proper wrapper in the i2c
layer, that was removed but is coming back...

Index: linux-work/sound/ppc/tumbler.c
===================================================================
--- linux-work.orig/sound/ppc/tumbler.c	2006-01-09 10:29:54.000000000 +1100
+++ linux-work/sound/ppc/tumbler.c	2006-01-09 10:30:14.000000000 +1100
@@ -137,7 +137,6 @@ static int send_init_client(pmac_keywest
 	return 0;
 }
 
-
 static int tumbler_init_client(pmac_keywest_t *i2c)
 {
 	static unsigned int regs[] = {
@@ -239,8 +238,8 @@ static int tumbler_set_master_volume(pma
 	block[4] = (right_vol >> 8)  & 0xff;
 	block[5] = (right_vol >> 0)  & 0xff;
   
-	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_VOL,
-				       6, block) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, TAS_REG_VOL, 6,
+					   block) < 0) {
 		snd_printk("failed to set volume \n");
 		return -EINVAL;
 	}
@@ -340,8 +339,8 @@ static int tumbler_set_drc(pmac_tumbler_
 		val[1] = 0;
 	}
 
-	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_DRC,
-				       2, val) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, TAS_REG_DRC,
+					   2, val) < 0) {
 		snd_printk("failed to set DRC\n");
 		return -EINVAL;
 	}
@@ -376,8 +375,8 @@ static int snapper_set_drc(pmac_tumbler_
 	val[4] = 0x60;
 	val[5] = 0xa0;
 
-	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_DRC,
-				       6, val) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, TAS_REG_DRC,
+					   6, val) < 0) {
 		snd_printk("failed to set DRC\n");
 		return -EINVAL;
 	}
@@ -481,8 +480,8 @@ static int tumbler_set_mono_volume(pmac_
 	vol = info->table[vol];
 	for (i = 0; i < info->bytes; i++)
 		block[i] = (vol >> ((info->bytes - i - 1) * 8)) & 0xff;
-	if (i2c_smbus_write_block_data(mix->i2c.client, info->reg,
-				       info->bytes, block) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, info->reg,
+					   info->bytes, block) < 0) {
 		snd_printk("failed to set mono volume %d\n", info->index);
 		return -EINVAL;
 	}
@@ -611,7 +610,8 @@ static int snapper_set_mix_vol1(pmac_tum
 		for (j = 0; j < 3; j++)
 			block[i * 3 + j] = (vol >> ((2 - j) * 8)) & 0xff;
 	}
-	if (i2c_smbus_write_block_data(mix->i2c.client, reg, 9, block) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, reg,
+					   9, block) < 0) {
 		snd_printk("failed to set mono volume %d\n", reg);
 		return -EINVAL;
 	}
Index: linux-work/sound/ppc/pmac.c
===================================================================
--- linux-work.orig/sound/ppc/pmac.c	2006-01-09 10:29:54.000000000 +1100
+++ linux-work/sound/ppc/pmac.c	2006-01-09 10:30:14.000000000 +1100
@@ -74,7 +74,7 @@ static int snd_pmac_dbdma_alloc(pmac_t *
 
 static void snd_pmac_dbdma_free(pmac_t *chip, pmac_dbdma_t *rec)
 {
-	if (rec) {
+	if (rec->space) {
 		unsigned int rsize = sizeof(struct dbdma_cmd) * (rec->size + 1);
 
 		dma_free_coherent(&chip->pdev->dev, rsize, rec->space, rec->dma_base);
@@ -895,6 +895,7 @@ static int __init snd_pmac_detect(pmac_t
 	chip->can_capture = 1;
 	chip->num_freqs = ARRAY_SIZE(awacs_freqs);
 	chip->freq_table = awacs_freqs;
+	chip->pdev = NULL;
 
 	chip->control_mask = MASK_IEPC | MASK_IEE | 0x11; /* default */
 
Index: linux-work/sound/oss/dmasound/tas_common.h
===================================================================
--- linux-work.orig/sound/oss/dmasound/tas_common.h	2006-01-09 10:29:54.000000000 +1100
+++ linux-work/sound/oss/dmasound/tas_common.h	2006-01-09 10:31:09.000000000 +1100
@@ -178,10 +178,10 @@ tas_write_register(	struct tas_data_t *s
 	if (write_mode & WRITE_SHADOW)
 		memcpy(self->shadow[reg_num],data,reg_width);
 	if (write_mode & WRITE_HW) {
-		rc=i2c_smbus_write_block_data(self->client,
-					      reg_num,
-					      reg_width,
-					      data);
+		rc=i2c_smbus_write_i2c_block_data(self->client,
+						  reg_num,
+						  reg_width,
+						  data);
 		if (rc < 0) {
 			printk("tas: I2C block write failed \n");  
 			return rc; 
@@ -199,10 +199,10 @@ tas_sync_register(	struct tas_data_t *se
 
 	if (reg_width==0 || self==NULL)
 		return -EINVAL;
-	rc=i2c_smbus_write_block_data(self->client,
-				      reg_num,
-				      reg_width,
-				      self->shadow[reg_num]);
+	rc=i2c_smbus_write_i2c_block_data(self->client,
+					  reg_num,
+					  reg_width,
+					  self->shadow[reg_num]);
 	if (rc < 0) {
 		printk("tas: I2C block write failed \n");
 		return rc;
