Date: Wed, 24 Apr 2002 13:25:57 -0700
From: andrew may <acmay@acmay.homeip.net>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] IBM ocp add code for iic_scan
Message-ID: <20020424132557.C22212@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UFHRwCdBEJvubb2X"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii

Here is another patch, works well enough for me.

--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i2c-scan.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.968   -> 1.969
#	drivers/i2c/i2c-algo-ibm_ocp.c	1.3     -> 1.4
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/24	amay@infosec-server.infosec	1.969
# added code to do I2C bus scan
# turned it on by default
# --------------------------------------------
#
diff -Nru a/drivers/i2c/i2c-algo-ibm_ocp.c b/drivers/i2c/i2c-algo-ibm_ocp.c
--- a/drivers/i2c/i2c-algo-ibm_ocp.c	Wed Apr 24 13:21:11 2002
+++ b/drivers/i2c/i2c-algo-ibm_ocp.c	Wed Apr 24 13:21:11 2002
@@ -101,7 +101,7 @@
 /* module parameters:
  */
 static int i2c_debug=0;
-static int iic_scan=0;	/* have a look at what's hanging 'round		*/
+static int iic_scan=1;	/* have a look at what's hanging 'round		*/

 /* --- setting states on the bus with the right timing: ---------------	*/

@@ -1100,11 +1100,44 @@
 	iic_init(iic_adap);
 	i2c_add_adapter(adap);

-	/* scan bus */
-	/* By default scanning the bus is turned off. */
+	/* scan the I2C bus for valid 7 bit addresses
+         * (ie things that ACK on 1byte read)
+         * if i2c_debug is off we print everything on one line.
+         * if i2c_debug is on we do a newline per print so we don't
+         * clash too much with printk's in the other functions.
+         * TODO: check for 10-bit mode and never run as a slave.
+         */
 	if (iic_scan) {
-		printk(KERN_INFO " i2c-algo-iic.o: scanning bus %s.\n",
+                int found=0;
+                int i;
+		printk(KERN_INFO " i2c-algo-iic.o: scanning bus %s. Found ",
 		       adap->name);
+                if( i2c_debug )
+                        printk("\n" );
+                for(i=0; i < 0x7f; i++){
+                        int ret;
+                        struct i2c_msg msg;
+                        char data[1];
+                        msg.addr = i;
+                        msg.buf = data;
+                        msg.len = 1;
+                        msg.flags = I2C_M_RD;
+                        if( (ret=iic_xfer(adap, &msg, 1)) == 1 ){
+                                if( i2c_debug )
+                                        printk( "I2C Found 0x%02x ret %d Data 0x%02x\n", i, ret, data[0] );
+                                else
+                                        printk( "0x%02x ", i );
+                                found++;
+                        }
+                }
+                if( i2c_debug ){
+                        if( !found ) printk( "I2C Found Nothing\n" );
+                }else{
+                        if( found )
+                                printk( "\n" );
+                        else
+                                printk( "Nothing\n" );
+                }
 	}
 	return 0;
 }

--UFHRwCdBEJvubb2X--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
