Message-ID: <3EB01137.1070502@mvista.com>
Date: Wed, 30 Apr 2003 11:08:55 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: GT64260 IIC Driver Patch
Content-Type: multipart/mixed;
 boundary="------------040307060405070905050304"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040307060405070905050304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
   I've encountered a situation in the boot wrapper where the current
2_4_devel GT64260 IIC driver needed some changes. The hardware I'm using
(Force PowerPMC260) has a small SEEPROM  with only 256 bytes. The
previous driver always expected 2 bytes of offset whereas my device only
needs 1 byte. I've modified the driver to handle either type of device.
Also, the firmware on the board i"m using leaves the IIC hardware in a
funky state, so I added a reset/initilization sequence to correct for
that. I've tested this patch against the MCG HXEB100 as well as the
hardware I'm using and it works on both platforms. I also had a
duplicate definition problem when I included gt64260_tty.c to access the
GT64260's onboard serial ports so I made the gt64260_in_le32 and
gt64260_out_le32 definitions static to resolve it.

   I'd like to get this added if it's OK.


			Thanks,
			Randy Vinson

--------------040307060405070905050304
Content-Type: text/plain;
 name="gt64260_iic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gt64260_iic.patch"

diff -Nru a/arch/ppc/boot/simple/gt64260_iic.c b/arch/ppc/boot/simple/gt64260_iic.c
--- a/arch/ppc/boot/simple/gt64260_iic.c	Tue Apr 29 17:04:36 2003
+++ b/arch/ppc/boot/simple/gt64260_iic.c	Tue Apr 29 17:04:36 2003
@@ -22,7 +22,7 @@
 static u32	gt64260_base = CONFIG_GT64260_ORIG_REG_BASE;
 #endif

-inline unsigned
+static inline unsigned
 gt64260_in_le32(volatile unsigned *addr)
 {
 	unsigned ret;
@@ -32,7 +32,7 @@
 	return ret;
 }

-inline void
+static inline void
 gt64260_out_le32(volatile unsigned *addr, int val)
 {
 	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
@@ -97,7 +97,8 @@
 }

 int
-gt64260_iic_read(uint devaddr, u8 *buf, uint offset, uint count)
+gt64260_iic_read(uint devaddr, u8 *buf, uint offset, uint offset_size,
+		 uint count)
 {
 	int i;
 	int data;
@@ -105,6 +106,16 @@
 	int status;

 	/*
+	 * send reset
+	 */
+	WRITE_RESET(0);
+	WRITE_ADDR(0);
+	WRITE_EX_ADDR(0);
+	WRITE_BAUD_RATE((4 << 3) | 4);
+	if (iic_control(GT64260_I2C_ENABLE_BIT, GT64260_I2C_STATUS_IDLE) < 0)
+		return -1;
+
+	/*
 	 * send start
 	 */
 	control = GT64260_I2C_START_BIT|GT64260_I2C_ENABLE_BIT;
@@ -126,8 +137,10 @@
 	 */
 	control = GT64260_I2C_ENABLE_BIT;
 	status = GT64260_I2C_STATUS_WRITE_ACK;
-	if (iic_write_byte(offset >> 8, control, status) < 0)
-		return -1;
+	if (offset_size > 1) {
+		if (iic_write_byte(offset >> 8, control, status) < 0)
+			return -1;
+	}
 	if (iic_write_byte(offset, control, status) < 0)
 		return -1;

diff -Nru a/arch/ppc/boot/simple/misc-hxeb100.c b/arch/ppc/boot/simple/misc-hxeb100.c
--- a/arch/ppc/boot/simple/misc-hxeb100.c	Tue Apr 29 17:04:36 2003
+++ b/arch/ppc/boot/simple/misc-hxeb100.c	Tue Apr 29 17:04:36 2003
@@ -24,7 +24,8 @@
 static int found_cpu1;
 extern void hxeb100_cpu1_wait_for_kernel(void);

-extern int gt64260_iic_read(uint devaddr, u8 *buf, uint offset, uint count);
+extern int gt64260_iic_read(uint devaddr, u8 *buf, uint offset,
+			    uint offset_size, uint count);

 static bd_t board_info;

@@ -35,12 +36,12 @@
 	int dev = HXEB100_VPD_IIC_DEV;
 	bd_t *bi = &board_info;

-	gt64260_iic_read(dev, (char *)&moto, 0, sizeof(moto));
+	gt64260_iic_read(dev, (char *)&moto, 0, 2, sizeof(moto));
 	if (moto == 0x4D4F544F) {	/* 'MOTO' */
 	    	bi->bi_hxeb = HXEB100_BOARD_INFO_HXEB;		/* 'HXEB' */
-		gt64260_iic_read(dev, (u8 *)&bi->bi_busfreq, 80, 4);
-		gt64260_iic_read(dev, bi->bi_enetaddr[0],    94, 6);
-		gt64260_iic_read(dev, bi->bi_enetaddr[1],   103, 6);
+		gt64260_iic_read(dev, (u8 *)&bi->bi_busfreq, 80, 2, 4);
+		gt64260_iic_read(dev, bi->bi_enetaddr[0],    94, 2, 6);
+		gt64260_iic_read(dev, bi->bi_enetaddr[1],   103, 2, 6);
 	}
 }


--------------040307060405070905050304--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
