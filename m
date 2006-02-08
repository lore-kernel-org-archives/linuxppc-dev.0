Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C65F568A90
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 15:03:41 +1100 (EST)
Subject: [PATCH] powerpc: Fix sound driver use of i2c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 15:04:18 +1100
Message-Id: <1139371458.8187.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PowerMac sound drivers used to rely on a "bug" of the i2c-keywest
driver that implemented I2C_SMBUS_BLOCK_DATA incorrectly, that is it did
what I2C_SMBUS_I2C_BLOCK_DATA should have done. The new i2c-powermac
driver that replaces keywest has this bug fixed, thus the sound drivers
must be fixed too.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/sound/ppc/tumbler.c
===================================================================
--- linux-work.orig/sound/ppc/tumbler.c	2006-01-11 12:56:34.000000000 +1100
+++ linux-work/sound/ppc/tumbler.c	2006-01-11 13:39:24.000000000 +1100
@@ -239,8 +239,8 @@
 	block[4] = (right_vol >> 8)  & 0xff;
 	block[5] = (right_vol >> 0)  & 0xff;
   
-	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_VOL,
-				       6, block) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, TAS_REG_VOL, 6,
+					   block) < 0) {
 		snd_printk("failed to set volume \n");
 		return -EINVAL;
 	}
@@ -345,8 +345,8 @@
 		val[1] = 0;
 	}
 
-	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_DRC,
-				       2, val) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, TAS_REG_DRC,
+					   2, val) < 0) {
 		snd_printk("failed to set DRC\n");
 		return -EINVAL;
 	}
@@ -381,8 +381,8 @@
 	val[4] = 0x60;
 	val[5] = 0xa0;
 
-	if (i2c_smbus_write_block_data(mix->i2c.client, TAS_REG_DRC,
-				       6, val) < 0) {
+	if (i2c_smbus_write_i2c_block_data(mix->i2c.client, TAS_REG_DRC,
+					   6, val) < 0) {
 		snd_printk("failed to set DRC\n");
 		return -EINVAL;
 	}
@@ -492,8 +492,8 @@
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
@@ -625,7 +625,8 @@
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
--- linux-work.orig/sound/ppc/pmac.c	2006-01-11 12:56:34.000000000 +1100
+++ linux-work/sound/ppc/pmac.c	2006-01-11 13:39:24.000000000 +1100
@@ -66,7 +66,7 @@
 
 static void snd_pmac_dbdma_free(struct snd_pmac *chip, struct pmac_dbdma *rec)
 {
-	if (rec) {
+	if (rec->space) {
 		unsigned int rsize = sizeof(struct dbdma_cmd) * (rec->size + 1);
 
 		dma_free_coherent(&chip->pdev->dev, rsize, rec->space, rec->dma_base);
@@ -881,6 +881,7 @@
 	chip->can_capture = 1;
 	chip->num_freqs = ARRAY_SIZE(awacs_freqs);
 	chip->freq_table = awacs_freqs;
+	chip->pdev = NULL;
 
 	chip->control_mask = MASK_IEPC | MASK_IEE | 0x11; /* default */
 
Index: linux-work/sound/oss/dmasound/tas_common.h
===================================================================
--- linux-work.orig/sound/oss/dmasound/tas_common.h	2005-12-24 10:07:43.000000000 +1100
+++ linux-work/sound/oss/dmasound/tas_common.h	2006-01-11 13:39:24.000000000 +1100
@@ -178,10 +178,10 @@
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
@@ -199,10 +199,10 @@
 
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
